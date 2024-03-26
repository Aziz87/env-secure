#!/bin/sh

REPO_PATH="."

if [ ! -d "$REPO_PATH/.git" ]; then
  echo ".git dirrectory not found"
  exit 1
fi

PRE_COMMIT_SCRIPT_PATH="$REPO_PATH/.git/hooks/pre-commit"

cat > $PRE_COMMIT_SCRIPT_PATH << EOF
#!/bin/sh

sh ./env-secure/env-encode.sh

if [ \$? -ne 0 ]; then
  echo "Error \$?"
  exit 1
fi
EOF

chmod +x $PRE_COMMIT_SCRIPT_PATH

PASSWORD=$(<~/.ssh/id_rsa)


if [ -e "$REPO_PATH/.env*" ]; then
  for file in $REPO_PATH/.env*; do
      if [[ $file != *.s ]]; then
        tempPath="${file#./}"
        openssl enc -aes-256-cbc -a -A -md sha512 -pbkdf2 -iter 250000 -salt \
        -in "$file" -out "$REPO_PATH/$file.s" -pass pass:"$PASSWORD"
        git add "$REPO_PATH/$file.s";
      fi
  done
fi


if [ -e "$REPO_PATH/secret*" ]; then
  for file in $REPO_PATH/secret*; do
      if [[ $file != *.s ]]; then
        tempPath="${file#./}"
        openssl enc -aes-256-cbc -a -A -md sha512 -pbkdf2 -iter 250000 -salt \
        -in "$file" -out "$REPO_PATH/$file.s" -pass pass:"$PASSWORD"
        git add "$REPO_PATH/$file.s";
      fi
  done
fi;



