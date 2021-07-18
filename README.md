# dhak

[![Dhak CI](https://github.com/ippee/dhak/actions/workflows/main.yml/badge.svg)](https://github.com/ippee/dhak/actions/workflows/main.yml)

A password manager without storing passwords, in Dart/Flutter.

## What is dhak?

_dhak_ is a CUI/GUI application to manage your passwords.

_dhak_ combines your original passphrase with the name of the service that requires a password, hashes it, and uses the value as the new password.

In this way, you can manage your passwords without storing them anywhere.

The GUI edition is in progress.

## Installation

Coming soon...

## Usage

```
dhak [-h, --help] [-v, --version] <title> (<preset>) [option]
```

- -h, --help:
    - Display the help of dhak.
- -v, --version:
    - Display the version of dhak.
- title:
    - The name of the service.
- preset:
    - The pre-prepared setting for password generation (you can add a preset in ~/.dhakrc). If you omit this, the value will be "default".
- option:
    - Specify additional functions as needed. dhak will use the optional settings in preference to the preset ones.
        - -d, --display
            - Display the password in the terminal.
        - -f, --force
            - Generate a non-secure password forcibly, such as a password whose length is less than 8 or a password which has only lower-case.
        - --len=
            - Set a password length. If it is less than 8, you cannot generate the password basically.
        - --sym=
            - Set symbols used the password generation.
        - --algo=
            - Set an algorithm of BCrypt. You can use "2", "2a", "2y" and "2b (default)".
        - --cost=
        - Set a cost of BCrypt. It must be between 4 and 31. The actual rounds of stretching are 2^n.

## Why is it doing this?

The greatest strength of dhak is that **it is resistant to information leaks because it does not retain sensitive information.**

To begin with, the ultimate security measure is not to have anything that threatens one's own safety. Therefore, as primitive security measures, the most appropriate action is to try to reduce such things as much as possible.
However, if you try to do this, you will have to throw away everything, including the bank account where this month's salary has just been deposited as well as, in extreme cases, the sandwich you plan to eat for lunch today. This is putting the cart before the horse!

That's where the so-called _security measures_ come into play, such as hiding such sensitive information or things somewhere, or replace them with something that others cannot understand.

General password managers manage sensitive information by encrypting/decrypting passwords (i.e., replacing them with something that seems meaningless to others).  
However, it does not change the fact that they are still possessing sensitive information in any form, which means that you are taking the risk of information leakage in terms of fundamental security measures.

In order to minimize this risk, _dhak_ manages passwords by NOT storing such sensitive information, but **by generating them when needed**.
