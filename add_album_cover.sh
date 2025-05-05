#!/bin/bash

SHORT=c:,d:,h,o:
LONG=cover:,directory:,help,output:
OPTS=$(getopt -a -n "add_cover_to_mp3" --options $SHORT --longoptions $LONG -- "$@")
eval set -- "$OPTS"
# echo $OPTS

function help_message() {
    echo "Cover Adding Script
===================
This scirpt relies on ffmpeg. Make sure you have it installed

-c | --cover       Path to the coveer image
-d | --directory   Directory who's
-h | --help        Print this message
-o | --output      Directory to write output to

cover and directory are mandatory!
"
}

while :
do
  case "${1}" in
    -c | --cover )
      cover="${2}"
      shift 2
      echo "${cover}"
      ;;
    -d | --directory )
      directory="${2}"
      shift 2
      echo "${directory}"
      ;;
    -h | --help )
      help_message
      exit 0
      ;;
    -o | --output )
      output="${2}"
      shift 2
      echo "${output}"
      ;;
    -- )
      shift;
      break
      ;;
    * )
      echo "Unexpected option: ${1}"
      exit 1
      ;;
  esac
done

# Check dependencies
if ! type "ffmpeg" > /dev/null 
then
	echo "ffmpeg is missing. Install ffmpeg to use this script"
fi

# Check we have the necessasry variables set
if [ -z "${cover+x}" ]
then
	echo "Cover Empty"
	exit 2
fi

if [ -z "${directory+x}" ]
then
	echo "Source Directory Empty"
	exit 2
fi

abs_cover="$(realpath "${cover}")"
abs_dir="$(realpath "${directory}")"

# Check that the paths exist
if [[ ! -f "${abs_cover}" ]]
then 
	echo "${abs_cover} doesn't exist"
	exit 2
fi

if [[ ! -d "${abs_dir}" ]]
then
	echo "${abs_dir} doesn't exist"
	exit 2
fi

# If the output doesn't exist, we create it 
if [ ! -z "${output+x}" ]
then 
	abs_out="$(realpath "${output}")"
	if [[ ! -d "${abs_out}" ]]
	then
		echo "Creating Output Directory: ${abs_out}"
		mkdir -p "${abs_out}"

	fi
fi
# Iterate through all files in the source directory and add the cover to them with ffmpeg
for file in "${abs_dir}"/*
do
	# Determien the output path
	if [[ ! -z "${abs_out+x}" ]]
	then
		target="${abs_out}/$(basename "${file}")"
	else
		target="${abs_dir}/c_$(basename "${file}")"
	fi

	if [[ "${file,,}" =~ \.(mp4|mp3|m4a|ogg|wma) ]] 
	then
		ffmpeg -i "${file}" -i "${abs_cover}" -map_metadata 0 -map 0 -map 1 -acodec copy "${target}"
	elif [[ "${file,,}" =~ \.flac ]]
	then
		ffmpeg -i "${file}" -i "${abs_cover}" -map_metadata 0 -map 0 -map 1 -acodec copy -disposition:v "${target}" 
	else
		echo "Unsupported File: $(basename "${file}")"
	fi	
done
