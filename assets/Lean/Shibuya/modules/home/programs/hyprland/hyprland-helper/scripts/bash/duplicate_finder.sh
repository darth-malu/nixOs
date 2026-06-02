#!/usr/bin/env sh

MUTSU="/media/Mutsu/Videos"
HYOGO="/media/Hyogo/Videos"
SUMBI="/media/SumbiHDD/maluFolder/Videos"

function get_videos_sumbi() {
    declare -a sumbi_array video_disks

    # Populate sumbi array
    while read -r -a trial; do
        echo "ITs working"
    done <<<"$(find $SUMBI)"

    echo "Printing The array now"
    for i in "${trial[@]}"; do
        echo "$i"
    done
}

function get_files_sumbi() {
    # for file in $find_files; do
    #     files_array+=("$file")
    # done

    # Disks array

    disks=("$mutsu" "$hyogo")

    # Get Files in SumbiHdd
    while read -r file; do
        sumbi_array+=("$file")
    done <<<"$(find)"

    find_files="$(find "$disk" "$i")"

}

display_duplicates() {
    for disk in "${disks[@]}"; do
        for i in "${files_array[@]}"; do
            if [ -n "$find_files" ]; then
                printf '%s\n' 'Found These Duplicate Files 😀'
            else
                printf '%s\n' '❌ No Duplicates'
            fi
        done
    done
}

get_videos_sumbi
