# dhak

[![Dhak CI](https://github.com/ippee/dhak/actions/workflows/main.yml/badge.svg)](https://github.com/ippee/dhak/actions/workflows/main.yml)

A password manager without storing passwords, in Dart/Flutter.

## What is dhak?

_dhak_ is a CUI/GUI application to manage your passwords.

_dhak_ combines your original passphrase with the name of the service that requires a password, hashes it, and uses the value as the new password.

In this way, you can manage your passwords without storing them anywhere.

## Why is it doing this?

The greatest strength of dhak is that **it is resistant to information leaks because it does not retain sensitive information.**

To begin with, the ultimate security measure is not to have anything that threatens one's own safety. Therefore, as primitive security measures, the most appropriate action is to try to reduce such things as much as possible.
However, if you try to do this, you will have to throw away everything, including the bank account where this month's salary has just been deposited as well as, in extreme cases, the sandwich you plan to eat for lunch today. This is putting the cart before the horse!

That's where the so-called _security measures_ come into play, such as hiding such sensitive information or things somewhere, or replace them with something that others cannot understand.

General password managers manage sensitive information by encrypting/decrypting passwords (i.e., replacing them with something that seems meaningless to others).  
However, it does not change the fact that they are still possessing sensitive information in any form, which means that you are taking the risk of information leakage in terms of fundamental security measures.

In order to minimize this risk, _dhak_ manages passwords by NOT storing such sensitive information, but **by generating them when needed**.

Of course, there is no perfect security measure.  
There is a possibility that your password could be leaked from other servers even if it is not from this app.  
However, in password management, reducing the risk of information leakage is a powerful security measure.
