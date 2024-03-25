#!/bin/sh

REPO_PATH="."


if [ ! -d "$REPO_PATH/.git" ]; then
  echo "dirrectory .git not found"
  exit 1
fi

PRE_PULL_HOOK="$REPO_PATH/.git/hooks/pre-pull"

cat > $PRE_PULL_HOOK << EOF
#!/bin/sh

sh ./env-secure/env-encode.sh

if [ \$? -ne 0 ]; then
  echo "error \$?"
  exit 1
fi
EOF

chmod +x $PRE_PULL_HOOK

PASSWORD=$(<~/.ssh/id_rsa)





for file in $REPO_PATH/.*.s; do
      resultingFile="${file%.s}"
      openssl enc -aes-256-cbc -a -A -d -md sha512 -pbkdf2 -iter 250000 -salt -in "$file" -out "$resultingFile" -pass pass:"$PASSWORD"
done
