################################################################################
#  USGSupdateR
#
# This script utilises some python code written by Olivier Hagolle, see:
# http://www.cesbio.ups-tlse.fr/multitemp/?p=3121#comment-69220
# https://github.com/olivierhagolle/LANDSAT-Download
#
# This script will update a path row folder with any new images from the USGS
# site based on the last date of imagery that we have processed. It will iterate 
# through the 3 Landsat sensors and deliver zipped files to a location of choice.
# It will also update multiple path rows if desired.
#
# Params:
# pathRow = USGS path/row of desired location (enter vector of characters)
# outDir = Where to download zipped files to (suggest a processing file on local)
# softDir = location of python download script
#
# NOTE: Along with the python download script NEEDS to be a file called usgs.txt
# This txt file needs to contain your "username" and "password" on the same line, 
# separated by a space, for the Earth Explorer website: 
# http://earthexplorer.usgs.gov/
# 
# NOTE: This script does not work any faster than the USGS BDA tool and can take
# sometime depending on internet speeds

# Bart Huntley 20/05/2016


rm(list=ls())
pathRow = c("113075", "113074")
outDir = "C:/processing/downloads_here/"
softDir = "Z:/DOCUMENTATION/Software/R/R_DEV/USGSupdateR"  


USGSupdateR <- function(pathRow, imDir = "W:/usgs", outDir, softDir){
  sensors <- c("LT5", "LE7", "LC8")
  for(i in 1:length(pathRow)){
    sceneDir <- paste(imDir, pathRow[i], sep = "/")
    list.dirs <- function(path=".", pattern=NULL, all.dirs=FALSE,
                          full.names=FALSE, ignore.case=FALSE) {
      # use full.names=TRUE to pass to file.info
      all <- list.files(path, pattern, all.dirs,
                        full.names=TRUE, recursive=FALSE, ignore.case)
      dirs <- all[file.info(all)$isdir]
      # determine whether to return full names or just dir names
      if(isTRUE(full.names))
        return(dirs)
      else
        return(basename(dirs))
    }
    out <- paste0(outDir, pathRow[i], "/")
    folds <- as.Date(list.dirs(sceneDir), "%Y%m%d")
    dates <- folds[!is.na(folds)]
    lastDate <- as.numeric(gsub("-", "", tail(dates, n = 1)))+1
    for(j in 1:length(sensors)){
      pScript <- "download_landsat_scene_20160525.py"
      pOption <- "-o scene"
      pSat <- paste("-b", sensors[j], sep = " ")
      pDateFrom <- paste("-d", lastDate, sep = " ")
      #pDateTo <- paste("-f", " XXXX")
      pScene <- paste("-s", pathRow[i], sep = " ")
      pPassWord <- "-u usgs.txt"
      setwd(outDir)
      if(!file.exists(pathRow[i])){dir.create(pathRow[i])}
      pOut <- paste("--output", out, sep = " ")
      pyCommand <- paste(pScript, pOption, pSat, pDateFrom, pDateTo, pScene,  
                         pPassWord, pOut, sep = " ")
      setwd(softDir)
      shell(pyCommand)
      print(paste0("Finished ", sensors[j]))
    }
    
    print(paste0("Finished with path row: ", pathRow[i]))
  }
  
}


USGSupdateR(pathRow, imDir = "W:/usgs", outDir, softDir)
