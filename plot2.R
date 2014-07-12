## This code loads the household_power_consumption.txt file from the working dir
## and creates the file plot2.R

## Read in the data from the working directory
fname <- "household_power_consumption.txt"

## Get the column names
col_names <- names(read.table(fname, header=TRUE, sep=";", nrows=1))

## Read in the data just for 2007-02-01 and 2007-02-02
## ^ means start at the beginning of the line.
## [1-2] means find the range  1-2.
if(.Platform$OS.type == "windows") {
    ## /b matches the pattern if at the beginning of a line.
    ## /r uses search strings as regular expressions.
    cmd <- paste("findstr /b /r ^[1-2]/2/2007 ", fname, sep="")
} else {
    cmd <- paste("grep '^[1-2]/2/2007' ", fname, sep="")
}
dat <- read.table(pipe(cmd), header=F, sep=';', col.names=col_names, na.strings="?")

## Add a "datetime" column by converting the Date and Time columns from text to "POSIXlt" "POSIXt"
dat$datetime <- strptime(paste(dat$Date, dat$Time, sep=" "), format = "%d/%m/%Y %H:%M:%S")


## Open a PNG file device and create the file in the working directory.
png(file="plot2.png", width = 480, height = 480)

## Create the plot and send it to the png file.
par(bg="transparent")
with(dat, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

## Close in PNG file device.
dev.off()