echo -e "Somehow installing new Kernels with Discover marks them as manually installed... \n I supppose..."
echo -e "To Fix this issue, this script SHOULD delete all older versions of the kernel by \n- first marking them as autoinstalled \n- And then running apt autoremove --purge" 
echo -e "\n\n WARNING It is not guaranteed that this will not brick something. So be care full."

echo -e "\n Marking as automatically installed..."
sudo apt-mark auto $(apt-mark showmanual | grep -E "^linux-([[:alpha:]]+-)+[[:digit:].]+-[^-]+(|-.+)$")

echo -e "Removing..."
sudo apt autoremove --purge 

echo "Done..."
