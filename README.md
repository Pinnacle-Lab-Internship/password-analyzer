
# Password Analyzer

A Shell Script for Analyzing the Password
## Usage


```bash
  Usage: ./PasswordAnalyzer.sh [-f common_passwords_file]
```
## Options


```bash
  Options:
  -f <file>      Specify the location of the common passwords file
                 Default location is: /usr/share/wordlists/rockyou.txt
  -h / --help    Prints all the options/help menu

```
## Demo Usage

Common Password from list
```bash
./PasswordAnalyzer.sh
Enter a password to evaluate its strength:
121212
Password length is less than 8 characters
Password does not contain uppercase letters
Password does not contain lowercase letters
Password is too common, consider choosing a more unique one
```
Specifying the wordlists with good password strength
```bash
./PasswordAnalyzer.sh -f /usr/share/wordlists/rockyou.txt
Enter a password to evaluate its strength:
Hello@121212
Password is not common and clean
```