#!/bin/bash
# usage: prog input
# will ask for password and echo output
openssl aes-256-cbc -d -md sha512 -pbkdf2 -iter 100000 -salt -in $1

