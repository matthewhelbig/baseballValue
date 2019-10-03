library(dplyr)
library(data.table)

#Read in data and view the head of the data briefly
Daily_bat <- read.csv("war_daily_bat.csv")
names(Daily_bat)

#Select the columns we want to keep
kept_Columns = select(Daily_bat, 1, 2, 4, 5, 6, 31, 32, 33, 36, 47)

#Subset the data to inlcude only batters between 2006 and 2016
years_pitchers_Subset <- subset(kept_Columns, 2005 < year_ID & year_ID < 2017 & pitcher == "N")

#Drop the Pitcher column since they'll all be "No"
Batting_value <- select(years_pitchers_Subset, -9)

#Write Batting_Value to csv so we can join it with Salary in SQL
write.csv(Batting_value, "Batting_Value.csv")

#Read in our Value Salary.csv file to be cleaned more (remove duplicates)
Pre_Batting_Value_Salary <- read.csv("Value_Salary.csv")

#show duplicates in R Markdown
show_duplicates <- subset(Pre_Batting_Value_Salary, AutoNum == 1:6)



#testing -- Does the same as split, apply, combine, except in a single line of code. Will keep the other code as an example,
#but for now we should update the R Markdown with this. This code removes playerID duplicates by year.
Batting_Value_Salary <- Pre_Batting_Value_Salary %>%
  distinct(playerID, yearID, .keep_all = TRUE)

##split function to create subsets by year##
#year <- split(Pre_Value_Salary, Pre_Value_Salary$yearID)

##Eliminate duplicates

#dup6 <- year$`2006`[!duplicated(year$`2006`$playerID),]
#dup7 <- year$`2007`[!duplicated(year$`2007`$playerID),]
#dup8 <- year$`2008`[!duplicated(year$`2008`$playerID),]
#dup9 <- year$`2009`[!duplicated(year$`2009`$playerID),]
#dup10 <- year$`2010`[!duplicated(year$`2010`$playerID),]
#dup11 <- year$`2011`[!duplicated(year$`2011`$playerID),]
#dup12 <- year$`2012`[!duplicated(year$`2012`$playerID),]
#dup13 <- year$`2013`[!duplicated(year$`2013`$playerID),]
#dup14 <- year$`2014`[!duplicated(year$`2014`$playerID),]
#dup15 <- year$`2015`[!duplicated(year$`2015`$playerID),]
#dup16 <- year$`2016`[!duplicated(year$`2016`$playerID),]

##Bind them back together

#bad_vs_example <- rbind(dup6, dup7, dup8, dup9, dup10, dup11, dup12, dup13, dup14, dup15, dup16)

