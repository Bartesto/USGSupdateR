################################################################################
# slistCreatoR  - a USGS scene list creator
#
# Use case:
# 1. You have a stack of images downloaded for a scene with no cloudy scenes
# 2. You want to download the same scene dates for an adjacent scene in the 
# same path (eg. you have 110/072 but want matching dates for 110/071)
# 3. This script will create a USGS scene name list in a txt file for use with
# the USGSupdateRlist script
#
# Params:
# dir2chk = path to existing imagery in path that has the dates of interest.
# wkdir = path to working area (if used in conjunction with USGSupdateRlist then
# this should be the location where the software and usgs.txt reside)




rm(list=ls())

dir2chk <- "W:\\usgs\\110072"
wkdir <- "C:\\processing"
newPR <- "110071"


slistCreatoR <- function(dir2chk, wkdir, newPR){
  setwd(dir2check)
  list.gz <- list.files(pattern = ".tar.gz", recursive = TRUE)
  list.gz <- strsplit(list.gz, "/")
  list.gz <- sapply(list.gz, function(x) x[2])
  list.gz <- strsplit(list.gz, "[.]")
  list.gz <- sapply(list.gz, function(x) x[1])
  
  setwd(wkdir)
  # Landsat 5
  lt5i <- grepl("LT5", list.gz)
  lt5 <- list.gz[lt5i]
  lt5n <- gsub("110072", newPR, lt5)
  df5 <- data.frame(name = "lt5", scene = lt5n, stringsAsFactors = FALSE)
  write.table(df5, file = "list_landsat5.txt", col.names = FALSE, 
              row.names = FALSE, quote = FALSE)
  
  # Landsat 7
  le7i <- grepl("LE7", list.gz)
  le7 <- list.gz[le7i]
  le7n <- gsub("110072", newPR, le7)
  df7 <- data.frame(name = "le7", scene = le7n, stringsAsFactors = FALSE)
  write.table(df7, file = "list_landsat7.txt", col.names = FALSE, 
              row.names = FALSE, quote = FALSE)
  
  # Landsat 8
  lc8i <- grepl("LC8", list.gz)
  lc8 <- list.gz[lc8i]
  lc8n <- gsub("110072", newPR, lc8)
  df8 <- data.frame(name = "lc8", scene = lc8n, stringsAsFactors = FALSE)
  write.table(df8, file = "list_landsat8.txt", col.names = FALSE, 
              row.names = FALSE, quote = FALSE)
}

slistCreatoR(dir2chk, wkdir, newPR)