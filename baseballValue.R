library(dplyr)

#Read in data and view the head of the data briefly
Daily_bat <- read.csv("war_daily_bat.csv")
Daily_bat %>% select(1:10) %>% slice(1:3)

kept_Columns = select(Daily_bat, 1, 2, 4, 5, 6, 31, 32, 33, 36, 47)
years_pitchers_Subset <- subset(kept_Columns, 2005 < year_ID & year_ID < 2017 & pitcher == "N")
Batting_value <- select(years_pitchers_Subset, -9)

write.csv(Batting_value, "Batting_Value.csv")

Pre_Value_Salary <- read.csv("Value_Salary.csv")
#Create year subsets

oh_six <- subset(Pre_Value_Salary, yearID == 2006)
oh_seven <- subset(Pre_Value_Salary, yearID == 2007)
oh_eight <- subset(Pre_Value_Salary, yearID == 2008)
oh_nine <- subset(Pre_Value_Salary, yearID == 2009)
ten <- subset(Pre_Value_Salary, yearID == 2010)
eleven <- subset(Pre_Value_Salary, yearID == 2011)
twelve <- subset(Pre_Value_Salary, yearID == 2012)
thirteen <- subset(Pre_Value_Salary, yearID == 2013)
fourteen <- subset(Pre_Value_Salary, yearID == 2014)
fifteen <- subset(Pre_Value_Salary, yearID == 2015)
sixteen <- subset(Pre_Value_Salary, yearID == 2016)

#Eliminate duplicates

dup6 <- oh_six[!duplicated(oh_six$playerID),]
dup7 <- oh_seven[!duplicated(oh_seven$playerID),]
dup8 <- oh_eight[!duplicated(oh_eight$playerID),]
dup9 <- oh_nine[!duplicated(oh_nine$playerID),]
dup10 <- ten[!duplicated(ten$playerID),]
dup11 <- eleven[!duplicated(eleven$playerID),]
dup12 <- twelve[!duplicated(twelve$playerID),]
dup13 <- thirteen[!duplicated(thirteen$playerID),]
dup14 <- fourteen[!duplicated(fourteen$playerID),]
dup15 <- fifteen[!duplicated(fifteen$playerID),]
dup16 <- sixteen[!duplicated(sixteen$playerID),]

#Bind them back together

Value_Salary <- rbind(dup6, dup7, dup8, dup9, dup10, dup11, dup12, dup13, dup14, dup15, dup16)

#show duplicates in R Markdown
show_duplicates <- subset(Pre_Value_Salary, AutoNum == 1:6)