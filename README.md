# USGSupdateR
Various R scripts for utilising Olivier Hagolle python script for automated USGS downloads

USGSupdateR is configured to check an existing processed archive of downloaded USGS scenes and download anything new from the USGS archive.
It is written to check multiple path/rows but can be adjusted to update 1 if required. It defaults to checking the USGS archive up 
to the current date. If an -f option is created within the call to the python script an end date can be added. This has the benefit of
being able to update gaps in a series of images. This script is a good strating point for further adjustments/hacks.

USGSupdateRlist has been written to utilise the liste option in the python script. It will download scenes based on a USGS named
scene list.

slistCreatoR is a short script that checks a processed scene path/row for scene dates, and creates a USGS named scene list for an 
adjacent scene in the same path. The idea being that the dates of the scenes kept for the processed scene path/row are basically
cloud free and therefore good dates to download for the adjacent scene.
