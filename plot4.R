
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

#Plot 4
png(filename="plot4.png", width=480, height =480, units="px") # Starting the PNG file save
par(mfrow=c(2,2))
plot(dtp, pc$Global_active_power, type="l" , ylab="Global Active Power (kilowatts)", xlab="") #Creating top left plot
plot(dtp, pc$Voltage, type="l" , ylab="Voltage", xlab="datetime") #Creating top right plot
plot(dtp, pc$Sub_metering_1, type="l" , xlab = "", ylab="Energy sub metering", ylim=c(0,38)) #Sub 1 plot line
par(new=T) #New plot part
plot(dtp, pc$Sub_metering_2, type="l" , col="red", xlab = "", ylab="", ylim=c(0,38)) #Sub 2 plot line
par(new=T) #New plot part
plot(dtp, pc$Sub_metering_3, type="l" , col="blue", xlab = "", ylab="", ylim=c(0,38)) #Sub 3 plot line
par(new=T) #New plot part
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1), lwd=c(2.5,2.5,2.5), col=c("black","blue","red"), bty="n")
par(new=F)#No new plot parts
plot(dtp, pc$Global_reactive_power, type="l" , ylab="Global_reactive_power", xlab="datetime") #Creating botton right plot
dev.off() #Closing dev to save PNG file
