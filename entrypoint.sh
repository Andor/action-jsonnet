#!/usr/bin/env bash

set -Eeuo pipefail

jsonnet::tool() {
    tool=$1; shift
    : "${GITHUB_WORKSPACE?GITHUB_WORKSPACE has to be set. Did you use the actions/checkout action?}"
    : "${TARGETS?No targets to check. Nothing to do.}"

    cd "${GITHUB_WORKSPACE}"
    >&2 echo -e "\nRunning $tool...\n"

    # Enable recursive glob patterns, such as '**/*.jsonnet'.
    shopt -s globstar
    case $tool in
        jsonnetfmt)
            jsonnetfmt --test ${TARGETS}
            # -n 2 --max-blank-lines 2 --string-style s --comment-style s
            ;;
        jsonnet-lint)
            jsonnet-lint ${TARGETS}
            ;;
        *)
            echo -E "Tool $tool is not known"
            exit 1
            ;;
    esac
    shopt -u globstar
}

if [ "$0" = "${BASH_SOURCE[*]}" ] ; then
    : "${1?tool is not set, please specify the tool in the command}"
    jsonnet::tool "$1"
fi
