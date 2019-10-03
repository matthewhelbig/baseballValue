library(dplyr)

#Read in data and view the head of the data briefly
Daily_bat <- read.csv("war_daily_bat.csv")
Daily_bat %>% select(1:10) %>% slice(1:3)

kept_Columns = select(Daily_bat, 1, 2, 4, 5, 6, 31, 32, 33, 36, 47)
years_pitchers_Subset <- subset(kept_Columns, 2005 < year_ID & year_ID < 2017 & pitcher == "N")
Batting_value <- select(years_pitchers_Subset, -9)

write.csv(Batting_value, "Batting_Value.csv")

Pre_Value_Salary <- read.csv("Value_Salary.csv")

#split function to create subsets by year
year <- split(Pre_Value_Salary, Pre_Value_Salary$yearID)

#Eliminate duplicates

dup6 <- year$`2006`[!duplicated(year$`2006`$playerID),]
dup7 <- year$`2007`[!duplicated(year$`2007`$playerID),]
dup8 <- year$`2008`[!duplicated(year$`2008`$playerID),]
dup9 <- year$`2009`[!duplicated(year$`2009`$playerID),]
dup10 <- year$`2010`[!duplicated(year$`2010`$playerID),]
dup11 <- year$`2011`[!duplicated(year$`2011`$playerID),]
dup12 <- year$`2012`[!duplicated(year$`2012`$playerID),]
dup13 <- year$`2013`[!duplicated(year$`2013`$playerID),]
dup14 <- year$`2014`[!duplicated(year$`2014`$playerID),]
dup15 <- year$`2015`[!duplicated(year$`2015`$playerID),]
dup16 <- year$`2016`[!duplicated(year$`2016`$playerID),]

#Bind them back together

Value_Salary <- rbind(dup6, dup7, dup8, dup9, dup10, dup11, dup12, dup13, dup14, dup15, dup16)

#show duplicates in R Markdown
show_duplicates <- subset(Pre_Value_Salary, AutoNum == 1:6)