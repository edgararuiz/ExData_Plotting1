
lr <- 2100000 #Setting up row limit
hl <- c("factor","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL") #Defining only the Date column 
pc <- data.frame(read.table("household_power_consumption.txt", 
                            header=TRUE, colClasses=hl,  nrows=lr, sep=";")) #Loading entire Date column on 'pc'
dt <- as.Date(pc$Date, "%d/%m/%Y") #Coercing $Date to date type
pc <- NULL #Removing the data frame from RAM
ss <- dt < "2007-02-01" #Finding all rows with date under 2/1
start <- sum(ss)+1 #Aggregating all TRUE values and adding 1 to figure my 'skip' value
ss <- NULL #Clearing about 8mb of RAM
es <- dt <= "2007-02-02" #Finding all rows with date under or equal 2/2
dt <- NULL #Clearing about 16mb of RAM
end <- sum(es) +1  # Aggregating all TRUE values and adding 1 to find my upper limit
es <- NULL #Clearning about 8mb of RAM
si <- end - start #Determining the size of my dataset, meaning my 'nrows'
cols <- data.frame(read.table("household_power_consumption.txt",header=TRUE, nrows=1, sep=";")) #Loading only the first row 
cc <- colnames(cols) #Extracting the column names
hl <- c("factor","factor","numeric","numeric","numeric","numeric","numeric","numeric","numeric" ) #Defining column classes
pc <- data.frame(read.table("household_power_consumption.txt", header=FALSE, colClasses=hl,  
                            col.names = cc,nrows=si, sep=";", skip = start)) #Loading only the 2880 rows within the date range


dt <- as.Date(pc$Date, "%d/%m/%Y") # Coercing pc$Date as date
dtp <-strptime(paste(dt, pc$Time),format="%Y-%m-%d %H:%M:%S") # Creating the date-time stamp
dt <-NULL

#Plot 2
png(filename="plot2.png", width=480, height =480, units="px") # Starting the PNG file save 
plot(dtp, pc$Global_active_power, type="l" , ylab="Global Active Power (kilowatts)", xlab="") #Plotting the line graph
dev.off() #Closing dev to save PNG file