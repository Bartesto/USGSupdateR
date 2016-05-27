################################################################################
#  USGSupdateRlist
#
# This script utilises some python code written by Olivier Hagolle, see:
# http://www.cesbio.ups-tlse.fr/multitemp/?p=3121#comment-69220
# https://github.com/olivierhagolle/LANDSAT-Download
#
# This script will download scenes from Earth Explorer from a user supplied
# scene list. A scene list can be obtained from Earth Explorer directly (which
# is counter-intuitive as to do so you could use the USGS site and BDA for 
# downloads). An alternative is to use the script slistCreatoR (see doco for 
# details). 
#
# The scene list must contain the USGS scene name (eg LT51100711988021ASA00), 
# one per line and there must be a separate scene list per satellite sensor. 
# These must be named "list_landsat5.txt", "list_landsat7.txt" and 
# "list_landsat9.txt"respectively. Scenes from each list will be downloaded into 
# a folder of the name of the scene list.
#
# Params:
# outDir = Where to download zipped files to (suggest a processing file on local)
# softDir = location of python download script, usgs.txt and scene lists.
#
# NOTE: Along with the python download script NEEDS to be a file called usgs.txt
# This txt file needs to contain your "username" and "password" on the same line, 
# separated by a space, for the Earth Explorer website: 
# http://earthexplorer.usgs.gov/
# 
# NOTE: This script does not work any faster than the USGS BDA tool.

# Bart Huntley 27/05/2016

rm(list=ls())

outDir = "C:/processing/downloads_here/"
softDir = "C:/processing"  

USGSupdateRlist <- function(outDir, softDir){
  setwd(softDir)
  sceneLists <- list.files(pattern = "list_landsat")
  for(i in 1:length(sceneLists)){
    pScript <- "download_landsat_scene_20160525.py"
    pOption <- "-o liste"
    pList <- paste("-l", sceneLists[i], sep = " ")
    pPassWord <- "-u usgs.txt"
    outName <- strsplit(sceneLists[i], "[.]")[[1]][1]
    #if(!file.exists(outName)){dir.create(outName)}
    out <- paste0(outDir, outName, "/")
    pOut <- paste("--output", out, sep = " ")
    pyCommand <- paste(pScript, pOption, pList, pPassWord, pOut, sep = " ")
    shell(pyCommand)                   
  }
}


USGSupdateRlist(outDir, softDir)

