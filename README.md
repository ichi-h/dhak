# Dhak

[![Dhak CI](https://github.com/ippee/dhak/actions/workflows/main.yml/badge.svg)](https://github.com/ippee/dhak/actions/workflows/main.yml)

A password manager without storing passwords, in Dart/Flutter.

## What is Dhak?

_Dhak_ is a CUI/GUI application to manage your passwords.

Dhak combines your original passphrase with the name of the service that requires a password, hashes it, and uses the value as the new password.

In this way, you can manage your passwords without storing them anywhere.

## Installation

Coming soon...

## Usage

```
dhak [-h, --help] [-v, --version] <title> (<preset>) [options]
```

### Commands

- -h, --help:
    - Display the help of Dhak.
- -v, --version:
    - Display the version of Dhak.

### Title

The name of the service.

### Preset

The pre-prepared setting for password generation (you can add a preset in ~/.dhakrc).

### Options

Specify additional functions as needed.

Dhak will use the optional settings in preference to the preset ones.

The following values of the options means the default value in this app. If you omit an option, Dhak will use them.

- -d, --display
    - Display the password in the terminal.
- -f, --force (deprecated)
    - Forcibly generate a password which may be insecure, such as a password whose length is less than 12 or which has only lower-case.
    - <u><b>YOU SHOULD USE THIS OPTION AS LITTLE AS POSSIBLE.</b></u>
- --len=20
    - Set a password length.
    - If it is less than 12, you cannot generate the password basically.
- --sym=!\"#$%&‘()*+,-./:;<=>?@\[\\]^_`{|}~
    - Set symbols used the password generation.
    - You can use any symbols except lower-case, upper-case and numbers.
    - You will get passwords without symbols if you keep this empty like `--sym=""`.
- --algo=2b
    - Set an algorithm of BCrypt. You can use "2", "2a", "2y" and "2b ".
- --cost=10
    - Set a cost of BCrypt. It must be between 4 and 31.
    - The cost is an exponent, and the actual round of stretching is 2^n.
    - The higher the cost, the more secure the password will be generated, but also the higher the computational load.

## Dhak Policy

The greatest strength of Dhak is that **it does not keep any confidential information**.

To begin with, the ultimate security measure is not to have anything that threatens one's own safety. Therefore, as primitive security measures, the most appropriate action is to try to reduce such things as much as possible.

However, if you try to do this excessively, you will have to throw away everything, including the bank account where this month's salary has just been deposited as well as the sandwich you plan to eat for lunch today. This is putting the cart before the horse!

That's where the so-called _security measures_ come into play, such as hiding such confidential information or things somewhere, or replace them with something that others cannot understand.

General password managers manage confidential information by encrypting/decrypting passwords (i.e., replacing them with something that seems meaningless to others).  
However, it does not change the fact that they are still keeping confidential information in any form, which means that you are taking the risk of information leakage in terms of fundamental security measures.

In order to minimize this risk, Dhak manages passwords by NOT storing such confidential information, but **by generating them when needed**.
