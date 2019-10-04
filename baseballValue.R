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



#testing -- Does the same as split, apply, combine, except in a single line of code. This code removes playerID duplicates by year.
Batting_Value_Salary <- Pre_Batting_Value_Salary %>%
  distinct(playerID, yearID, .keep_all = TRUE)
