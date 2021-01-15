#https://covidtracking.com/api/v1/us/daily.csv
library(tidyverse)
a  = read_csv( 'https://covidtracking.com/api/v1/us/daily.csv',col_types= cols(
#a  = read_csv( '/Users/steve/Downloads/daily(1).csv',col_types= cols(
  .default = col_double(),
  hash = col_character(),
  dateChecked = col_datetime(format = ""),
 # fips = col_logical(),
  date=col_datetime(),
  lastModified = col_datetime(format="")
))

predDate = as.POSIXct("2020-05-05")
startDate = as.POSIXct("2020-05-01")
plotEndDate = as.POSIXct( "2021-04-01")

b <- filter(a, date < predDate & date > startDate)
p3 = lm( data=b, deathIncrease ~ poly(as.numeric(date),3) )
a$p3 = predict(p3, a)
a$p3[a$date < as.POSIXct("2020-3-16")] = 0
p = ggplot(data = a) + 
  geom_line( aes(date,p3), color="red") + 
   geom_line( aes(date,deathIncrease)) + 
 
  geom_vline( aes(xintercept=predDate), linetype="dotted") + 
  coord_cartesian(ylim=c(0,3500), xlim=c( min(a$date), plotEndDate))
png( filename="out.png", width=800, height=600)
print(p)
