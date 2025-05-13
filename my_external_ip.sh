#!/bin/sh

# my_external_ip.sh: Retrieve public IP address using multiple methods
# Tries various DNS and HTTP-based services until one succeeds
# Outputs the first valid IP address found or exits with an error

# Function to validate IP address (IPv4 or IPv6)
is_valid_ip() {
    ip="$1"
    # IPv4: xxx.xxx.xxx.xxx
    if echo "$ip" | grep -E '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$' >/dev/null; then
        return 0
    # IPv6: more complex, but basic check for colon-separated hex
    elif echo "$ip" | grep -E '^[0-9a-fA-F:]+$' >/dev/null; then
        return 0
    fi
    return 1
}

# Function to try a command and return the first valid IP
try_method() {
    cmd="$1"
    result=$($cmd 2>/dev/null)
    for ip in $result; do
        if is_valid_ip "$ip"; then
            echo "$ip"
            exit 0
        fi
    done
}

# List of methods to try (DNS-based first, then HTTP-based)
# DNS methods
try_method "/usr/bin/dig +short myip.opendns.com @resolver1.opendns.com"
try_method "/usr/bin/dig +short myip.opendns.com @resolver2.opendns.com"
try_method "/usr/bin/dig +short whoami.akamai.net @ns1-1.akamaitech.net"
try_method "/usr/bin/dig TXT +short o-o.myaddr.l.google.com @ns1.google.com"
try_method "/usr/bin/dig +short whoami.cloudflare @1.1.1.1"
try_method "/usr/bin/dig +short whoami.cloudflare @1.0.0.1"
try_method "/usr/bin/nslookup -type=txt -timeout=5 whoami.ds.akahelp.net 2>&1 | grep 'text = ' | cut -d'\"' -f2"

# HTTP methods (require curl or wget)
if command -v curl >/dev/null; then
    try_method "curl -s ifconfig.me"
    try_method "curl -s https://api.ipify.org"
    try_method "curl -s https://ipinfo.io/ip"
    try_method "curl -s https://icanhazip.com"
elif command -v wget >/dev/null; then
    try_method "wget -qO- ifconfig.me"
    try_method "wget -qO- https://api.ipify.org"
    try_method "wget -qO- https://ipinfo.io/ip"
    try_method "wget -qO- https://icanhazip.com"
fi

# If all methods fail, exit with an error
echo "Error: Could not retrieve public IP address" >&2
exit 1
