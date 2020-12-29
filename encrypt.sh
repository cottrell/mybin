#!/bin/bash
# usage: prog input > output
# will ask for password
openssl enc -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -salt -in $1

