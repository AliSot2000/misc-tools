echo  "Going to Root"
cd /

echo  "Allocating 1Gb file to have space to operate in emergency"
sudo fallocate -l 1G emergency_storage
