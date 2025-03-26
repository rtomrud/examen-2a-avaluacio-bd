#!/bin/bash

order() {
    IFS=$'\t' read -r -a headers
    sorted_headers=($(printf "%s\n" "${headers[@]}" | sort))
    declare -A header_map
    for i in "${!headers[@]}"; do
        header_map["${headers[i]}"]=$i
    done

    for header in "${sorted_headers[@]}"; do
        printf "%s\t" "$header"
    done

    printf "\n"
    while IFS=$'\t' read -r -a row; do
        for header in "${sorted_headers[@]}"; do
            printf "%s\t" "${row[${header_map[$header]}]}"
        done
        printf "\n"
    done
}

container_id=$(docker compose ps --format "{{.Name}}" | head -1)
expected_dir="test"
actual_dir="."
cmd="docker exec -i ${container_id} psql -U postgres"
files=("$expected_dir"/*.sql)

printf "TAP version 14\n"
printf "1..%i\n" "${#files[@]}"
for expected in "${files[@]}"; do
    actual=$(find "$actual_dir" -maxdepth 1 -type f -name "*$(basename "${expected}")*")
    mapfile -t diagnostics < <(
        diff --color <($cmd < ${expected} | order) <($cmd < "${actual}" | order)
    )
    test_number=$(($test_number + 1))
    description=$(grep -E '^--|^/\*' -m1 "${expected}") # Extract comment
    if [[ "${#diagnostics[@]}" -gt 1 ]]; then
        printf "not ok %i - %s\n" "$test_number" "$description"
        printf "# %s\n" "${diagnostics[@]}"
    else
        printf "ok %i - %s\n" "$test_number" "$description"
    fi
    printf "\n"
done
