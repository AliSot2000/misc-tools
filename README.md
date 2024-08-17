# Misc-Tools

This Repo contains some small shell tools I've created to make my life easier. The tools aren't fully fledged _tools_ in that sense but more a few shell scripts that I've created to specifically fit my needs. 
I think it is useful as a baseline for others that want or need similar tools themselves. And it's also saving some effort since one doesn't have to gather the info again and write the tool again. 

### Without any guarantee for completeness, here's the list of all the tools currently in the repo:
- `autoremove_flatpak.sh` script to perform equivalent of `apt autoremove` for Flatpak.
- `autoremove_old_kernels.sh` script to mark all kernels as automatically installed and then remove them with `apt autoremove`. At some point the kernels didn't get removed automatically and this was the fix.
- `autoremove_snap` script to perform equivalent of `apt autoremove` for Snapcraft.
- `clear_snap_cache.sh` script to clear the cache of the Snapcraft.
- `convert_heif_jpg.sh` tool to convert all `.heif` and `.heic` files within a given directory to another format [`.jpg`, `.png`, `.y4m`], preserving the filename and possibly writing to a different directory.
- `emergency_space.sh` script to create a 1Gb file `/emergency_space` to have some room to breath again if your filesystem is full.
