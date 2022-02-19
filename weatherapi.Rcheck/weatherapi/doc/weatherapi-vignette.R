## ---- echo = FALSE, message = FALSE, warning=FALSE----------------------------
knitr::opts_chunk$set(collapse = T, comment = "#>")
#library(weatherapi)
devtools::load_all()

## -----------------------------------------------------------------------------
get_current_weather("Kelowna")

## -----------------------------------------------------------------------------
cities <- c("Kelowna", "Vancouver", "Toronto") 
get_current_weather(cities)

## -----------------------------------------------------------------------------
get_time_zone("Kelowna")

## -----------------------------------------------------------------------------
cities <- c("Kelowna","Vancouver","Toronto")
get_time_zone(cities)

## -----------------------------------------------------------------------------
get_sports_events("London", "football")

## ---- warning=FALSE, message=FALSE, fig.width=6,fig.height=4------------------
library(ggplot2)
library(reshape2)

# Get current weather data
loc <- c("London", "New York", "Paris", "Melbourne", "Singapore") 
data <- get_current_weather(loc,"no")

# Get temperature info and melt dataframe
data <- data[c("location.name", "current.temp_c", "current.feelslike_c")]
data <- melt(data)

# Plot temperature
ggplot(data=data, aes(x=location.name, y=value, group=variable, linetype=variable)) +
  geom_line()+
  geom_point()+
  labs(title="Temperature by Location", subtitle="(in celcius)", x="", y="", linetype="")

## ---- warning=FALSE, message=FALSE, fig.width=6,fig.height=4------------------
# Get local time zone data
loc <- c("London", "Los Angeles", "Buenos Aires", "Melbourne", "Singapore")
data <- get_time_zone(loc)

# Get the world map coordinates
library(tidyverse)
world <- map_data("world")

# Plot time zone of different location in world map
ggplot() +
  geom_map(
    data = world, map = world,
    aes(long, lat, map_id = region),
    color = "lightgray", fill = "lightgray") +
  geom_text(data=data, 
            aes(location.lon, location.lat, label=location.name)) +
  geom_text(data=data, 
            aes(location.lon, location.lat, label=location.localtime),nudge_y = -10) +
  labs(title="Current Time-zone of Different Locations in the World", x="", y="")

## ---- warning=FALSE, message=FALSE, fig.width=6,fig.height=4------------------
library(ggplot2)
library(reshape2)
min_temp<- vector()
max_temp<- vector()

td <- Sys.Date()
dates <- c()
for (i in  6:0){
  dates <- c(dates, as.character(td-i))
}

for(i in seq_along(dates)){
  max_temp<-append(max_temp,get_history_daily_weather("London",dates[i])$maxtemp_c)
  min_temp<-append(min_temp,get_history_daily_weather("London",dates[i])$mintemp_c)
}
df <- data.frame(dates,max_temp, min_temp)
mdf <- melt(df,id.vars="dates")
ggplot(mdf, aes(x=dates, y=value, colour=variable, group=variable )) +
geom_line()

## ---- warning=FALSE, message=FALSE, fig.width=6,fig.height=4------------------
library(ggplot2)
library(reshape2)
temp<- vector()
hour<-0:23
for(i in seq_along(hour)){
  temp<-append(temp,get_history_hourly_weather("London","2022-02-14",hour[i])$temp_c)
}
df <- data.frame(hour,temp)
ggplot(df, aes(x=hour, y=temp)) +
  geom_line()

## ---- warning=FALSE, message=FALSE, fig.width=6,fig.height=4------------------
library(ggplot2)

years <- c()
moon_illuminations <- c()

for (i in 2011:2021){
  year <- as.character(i)
  date <- paste(year, "-06-06", sep="")
  
  # get astronomy data on desired date at Beijing
  data <- get_astronomy("Beijing", date)
  
  # extract moon_illumination 
  moon_illumination <- data$moon_illumination
  
  years <- c(years, year)
  moon_illuminations <- c(moon_illuminations, moon_illumination)
}

result <- data.frame(year=years, moon_illumination=moon_illuminations)


# Plot moon_illumination
ggplot(data=result, aes(x=year, y=moon_illumination, group=1)) +
  geom_line()+
  labs(title="Moon illumination at Beijing on July 6th", x="", y="", linetype="")

