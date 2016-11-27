#!/bin/bash

set -e
set -x

PACKAGE_INDEX=https://sWoQZzYY7qYkZEzD_cvA@push.fury.io/jdgillespie91/
LOG=/tmp/release.log

make build
file=$(ls dist/*)
status=$(curl -s -o "${LOG}" -w "%{http_code}" -F package="@${file}" "${PACKAGE_INDEX}")
if [ "${status}" -ne 200 ]; then
    cat "${LOG}"
    exit 1
fi
