## Download data required for the assignment
## Value: name of the file with data
downloadData <- function() {
        dataDir <- "data"
        
        if (!file.exists(dataDir)) {
                dir.create(dataDir)
        }
        
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        zipName <- paste0(dataDir, "/", "household_power_consumption.zip")
        extracted <- paste0(dataDir, "/", "household_power_consumption.txt")
        if (!file.exists(extracted)) {
                download.file(fileUrl, destfile = zipName)
                unzip(zipfile = zipName, exdir = dataDir)
        }
        
        extracted
}


## This function only reads specific rows from specified date range by using 2-pass approach:
## 1. read only dates column and select particular range
## 2. read all columns of specifc rows, which are in required date range
## this approach allows to decrease peak memory usage by a factor of 10
## and it is also about 2 times faster
## Value: data frame with with rows from specified date range
## Notes: the functions assumes that all the rows with the same date are grouped together
##        and that the table is in the same format as given in assignment 1
selectByDate <- function(fileName, beginDate, endDate) {
        ## select only specific date range and determine number of rows
        ## and how many should be skipped from the beginning of the file
        rawData <- read.table(fileName, header = TRUE, sep = ";", na.strings = "?",
                              colClasses = c("character", rep("NULL", 8)))
        rawData$Date <- as.Date(rawData$Date, format = "%d/%m/%Y")
        selected <- which(rawData$Date >= beginDate & rawData$Date <= endDate)
        rowsNumber <- length(selected)
        firstRow <- selected[1]
        
        ## now it is possible to read only specific rows
        selectedRows <- read.table(fileName, header = FALSE, sep = ";", na.strings = "?", 
                                   colClasses = c(rep("character", 2), rep("numeric", 7)),
                                   nrows = rowsNumber, skip = firstRow)
        
        ## read header separately because otherwise it is skipped when reading table
        header <- readLines(fileName, n = 1)
        names(selectedRows) <- strsplit(header, ";")[[1]]
        
        selectedRows$Time <- strptime(paste(selectedRows$Date, selectedRows$Time), format = "%d/%m/%Y %T")
        selectedRows$Date <- as.Date(selectedRows$Date, format = "%d/%m/%Y")
        
        ## raw data is not longer needed so it should be disposed
        rm(rawData)
        
        selectedRows
}