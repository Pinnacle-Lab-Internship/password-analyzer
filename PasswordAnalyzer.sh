#!/bin/bash

COMMON_PASSWORDS_FILE="/usr/share/wordlists/rockyou.txt"

print_usage() {
    echo "Usage: $0 [-f common_passwords_file]"
    echo "Options:"
    echo "  -f <file>      Specify the location of the common passwords file"
    echo "                 Default location is: $COMMON_PASSWORDS_FILE"
    echo "  -h / --help    Prints all the options with Uasge"
    exit 1
}

check_length() {
    local password="$1"
    local length="${#password}"
    if [ "$length" -lt 8 ]; then
        echo "Password length is less than 8 characters"
    fi
}

check_complexity() {
    local password="$1"
    if ! [[ "$password" =~ [[:alnum:]] ]]; then
        echo "Password does not contain alphanumeric characters"
    fi
    if ! [[ "$password" =~ [[:upper:]] ]]; then
        echo "Password does not contain uppercase letters"
    fi
    if ! [[ "$password" =~ [[:lower:]] ]]; then
        echo "Password does not contain lowercase letters"
    fi
    if ! [[ "$password" =~ [[:digit:]] ]]; then
        echo "Password does not contain digits"
    fi
}

check_common_passwords() {
    local password="$1"
    local common_passwords_file="$2"
    if grep -q -x "$password" "$common_passwords_file"; then
        echo "Password is too common, consider choosing a more unique one"
    else
        echo "Password is not common and clean"
    fi
}

evaluate_password() {
    local password="$1"
    local common_passwords_file="$2"
    check_length "$password"
    check_complexity "$password"
    check_common_passwords "$password" "$common_passwords_file"
}

main() {
    if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
        print_usage
    fi

    local common_passwords_file="$COMMON_PASSWORDS_FILE"
    while getopts "f:" opt; do
        case $opt in
            f) common_passwords_file="$OPTARG";;
            \?) echo "Invalid option: -$OPTARG" >&2; print_usage;;
        esac
    done
    shift $((OPTIND - 1))

    if [ $# -ne 0 ]; then
        print_usage
    fi

    echo "Enter a password to evaluate its strength:"
    read -r password
    evaluate_password "$password" "$common_passwords_file"
}

main "$@"
