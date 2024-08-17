#!/bin/bash

clear
while true
do

	input="./working.txt"
	while IFS= read -r line
		do
		sleep $((RANDOM % 3))
		echo "$line" 
	done < "$input"
done
