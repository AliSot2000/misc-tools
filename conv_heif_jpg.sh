#!/bin/bash

echo "!!Quality Behavior has not been tested!!! - 2024_03_19"

help_msg="
convert all .heif and .heic files in a directory and create new files with the same file namei
-h	--help		Output this help message
-s	--source	Directory to convert all files from, defaults to current working directory.
-c	--create	Create the target directory if it is provided
-t	--target	Write all converted files into the specified directory
-q  --quality   Output Quality of the transcoded image [0-100] only has an effect if the file extension is .jpg, default 100
-e  --extension File type to convert to, valid [jpg, png, y4m], default png
"

# CLI ARGS
LONG_ARGS=source:,create,target:,quality:,extension:,help
SHORT_ARGS=s:,c,t:,q:,e:,h
OPTS=$(getopt -a -n hief_converter --options $SHORT_ARGS --longoptions $LONG_ARGS -- "$@")
eval set -- "$OPTS"

new_ext="jpg"
# quality=100
while :
do
	case "$1" in 
		-s | --source )
			source_dir="${2}"
			echo "Converting all files in $source_dir"
			shift 2
			;;
		-c | --create )
			create_dir=true
			shift 1
			;;
		-t | --target )
			target_dir="${2}"
			echo "Outputting converted files to $target_dir"
			shift 2
			;;
        -e | --extension )
            new_ext="$2"
            shift 2
            ;;
        -q | --quality )
            quality="$2"
            shift 2
            ;;
        -h | --help )
            echo "${help_msg}"
            exit 0
            ;;
		-- )
			shift
			break
			;;
		* )
			echo "Unexpected option $1"
			exit -2;
			;;
	esac
done

# Checking extension
if [[ "$new_ext" != "jpg" && "$new_ext" != "jpg" && "$new_ext" != "jpg" ]]
then
    echo "Unsupported target type: $new_ext"
    exit -3
fi

# checking quality > can be removed, and quality def below moved up 
if [[ "${quality+x}"  && "$new_ext" != "jpg" ]]
then
    echo "Quality only valid for jpg output. It will be ignored"
fi

quality=100


# Create directory if not exists
if [[ "${create_dir+x}" ]]
then
	if [[ -z "${target_dir+x}" ]]
	then
		echo "Target Directory Empty"
		exit -1
 	else
		echo "Creating Directory ${target_dir}"
		mkdir -p "${target_dir}"		
	fi
fi

heic_files="$(ls "${source_dir}" | grep -i ".heic\|.heif")"

file_array=($heic_files)
for file in "${file_array[@]}"
do
    file_name="${file%.*}"
    echo "Source: ${source_dir}/${file} Target: ${target_dir}/${file_name}.${new_ext} "
    heif-convert -q "${quality}" "${source_dir}/${file}" "${target_dir}/${file_name}.${new_ext}"
done

