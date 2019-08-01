#!/bin/sh

set -e

# https://stackoverflow.com/a/21188136
abspath() {
  # $1 : relative filename
  filename=$1
  parentdir=$(dirname "${filename}")

  if [ -d "${filename}" ]; then
      echo "$(cd "${filename}" && pwd)"
  elif [ -d "${parentdir}" ]; then
    echo "$(cd "${parentdir}" && pwd)/$(basename "${filename}")"
  fi
}

script_dir="$(abspath "$(dirname "$0")")"
dockerfile="${script_dir}/Dockerfile"
default_extract_path="${script_dir}/files"

die(){
    exit_code=$1
    shift
    >&2 echo $@
    exit $exit_code
}

print_help(){
    >&2 echo "USAGE: $0 [OPTION]..."
    >&2 echo
    >&2 echo "Options:"
    >&2 echo "  -h        Prints this message"
    >&2 echo "  -s PATH   Path to source file"
    >&2 echo "  -t tag    Tag for docker image"
    >&2 echo "  -k        Keep extracted files directory"
    >&2 echo "              Warning: all files from directory will be included in image"
    >&2 echo
}

extract(){
    source_file="$1"
    extract_path="$2"
    no_clear=$3
    >&2 echo "Extracting '$source_file' files to '$extract_path'"
    [ -n "$no_clear" ] && $no_clear || rm -rf "$extract_path"
    unzip -o -d "$extract_path" "$source_file"
}

build(){
        docker_file="$(abspath "$1")"
        build_tag="$2"
        shift 2
        >&2 echo "Building docker image with tag '$build_tag'"
    (
        cd "$script_dir"
        docker build -t "$build_tag" -f "$docker_file" "$script_dir" $@
    )
}
source_file=""
build_tag=""
keep_files=false

while getopts ":hs:t:k" opt; do
    case ${opt} in
        h )
            print_help
            exit 1
        ;;
        s )
            source_file="$(abspath "$OPTARG")"
        ;;
        t )
            build_tag="$OPTARG"
        ;;
        k )
            keep_files=true
        ;;
        \? )
            >&2 echo "Invalid Option: -$OPTARG" 1>&2
            print_help
            exit 1
        ;;
    esac
done
shift $((OPTIND -1))

[ -n "$source_file" ] && [ -f "$source_file" ] || { print_help; die 2 "Source file not found '$source_file'"; }
[ -n "$build_tag" ] || { print_help; die 3 "Build tag must be specified"; }

extract "$source_file" "$default_extract_path" $keep_files
build "$dockerfile" "$build_tag" $@
