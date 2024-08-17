#/bin/bash

clear

input="./working.txt"
while IFS= read -r line
	do 
	sleep $((RANDOM % 3))
	echo "$line"
done < "$input"
