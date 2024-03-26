get_current_directory() {
    current_file="${PWD}/${0}"
    echo "${current_file%/*}"
}
CWD=$(get_current_directory)
echo $CWD;

sh "$CWD/env-decode.sh";
sh "$CWD/env-encode.sh";
sh "$CWD/env-decode.sh";