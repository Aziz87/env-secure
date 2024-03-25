# env-secure
Distributing the .env file to GIT will be safe!


In order to safely store your secrets in Git, you can encrypt .env with each commit command and send the encrypted .env.secure to storage instead of the original .env, and decrypt it into the original with each pull read.
Encryption based on your private key from ~/.ssh/id_rsa
Everything is just like a baby's dream!



# INSTALL

in the your project folder
```
git clone https://github.com/Aziz87/env-secure/
sh env-secure/init.sh
```
