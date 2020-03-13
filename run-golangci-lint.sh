#!/usr/bin/env bash
export GO111MODULE=on

cmd=(golangci-lint run)

# Walks up the file path looking for go.mod
#
function find_module_roots() {
	for arg in "$@" ; do
	  local path="${arg}"
	  if [ "${path}" == "" ]; then
	    path="."
	  elif [ -f "${path}" ]; then
	    path=$(dirname "${path}")
	  fi
	  while [ "${path}" != "." ] && [ ! -f "${path}/go.mod" ]; do
	    path=$(dirname "${path}")
	  done
	  if [ -f "${path}/go.mod" ]; then
	  	echo "${path}"
	  fi
	done
}

# Create array of arguments passed from pre-commit
#
OPTIONS=()
while [ $# -gt 0 ] && [ "$1" != "-" ] && [ "$1" != "--" ] && [ ! -f "$1" ]; do
	OPTIONS+=("$1")
	shift
done

# Create array of files, ignore the args
#
FILES=()
while [ $# -gt 0 ] && [ "$1" != "-" ] && [ "$1" != "--" ]; do
	FILES+=("$1")
	shift
done
echo "${FILES[@]}"

for sub in $(find_module_roots "${FILES[@]}" | sort -u) ; do
    pushd "${sub}" >/dev/null
    "${cmd[@]}" "${OPTIONS[@]}" ./...
    if [ $? -ne 0 ]; then
		errCode=1
	fi
    popd >/dev/null
done

exit $errCode
