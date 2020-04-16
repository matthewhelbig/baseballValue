library(dplyr)
library(data.table)



#Subset of players 27 and older
test2$ISO <- test2$slugging_percentage - test2$batting_average

Older_than_27 <- subset(test2, age > 26 & salary < 10000000)






