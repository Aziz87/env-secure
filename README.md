# env-secure
Distributing the .env file to GIT will be safe!


In order to safely store your secrets in Git, you can encrypt .env with each commit command and send the encrypted .env.secure to storage instead of the original .env, and decrypt it into the original with each pull read.

Encryption based on your private key from ~/.ssh/id_rsa

Everything is just like a baby's dream!

To initialize you must run the scripts for the first time
```
sh env-encode.sh
sh env-decode.sh
```
