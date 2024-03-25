#!/bin/sh

REPO_PATH="."

if [ ! -d "$REPO_PATH/.git" ]; then
  echo ".git dirrectory not found"
  exit 1
fi

PRE_COMMIT_SCRIPT_PATH="$REPO_PATH/.git/hooks/pre-commit"

cat > $PRE_COMMIT_SCRIPT_PATH << EOF
#!/bin/sh

sh ./env-encode.sh

if [ \$? -ne 0 ]; then
  echo "Error \$?"
  exit 1
fi
EOF

chmod +x $PRE_COMMIT_SCRIPT_PATH

echo "Pre-commit is set"

PASSWORD=$(<~/.ssh/id_rsa)

openssl enc -aes-256-cbc -a -A -md sha512 -pbkdf2 -iter 250000 -salt -in .env.prod -out .env.prod.secure  -pass pass:"$PASSWORD"
git add .env.prod.secure