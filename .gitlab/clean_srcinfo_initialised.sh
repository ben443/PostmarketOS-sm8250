#!/bin/bash

FILENAME=".srcinfo_initialised.json"

find_pkgbuild_dirs() {
    git ls-files -z '*/*/PKGBUILD' | xargs -0 dirname -z | xargs -0 -i echo '{}/'
}


main() {
    local program=("rm" "-v")
    local verb="Cleaning"
    if [[ "$1" == "-n" ]] || [[ "$1" == "--noop" ]]; then
        program=("-n1" "echo")
        verb="(SIMULATION RUN) Would clean"
    fi
    echo "${verb} orphaned $FILENAME files that don't have an associated PKGBUILD:"
    find -name "$FILENAME" -print0 | grep -z -v -f <(find_pkgbuild_dirs) | xargs --no-run-if-empty -0 "${program[@]}"
}

main "${@}"