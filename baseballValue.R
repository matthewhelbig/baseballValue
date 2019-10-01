library(dplyr)

#Read in data and view the head of the data briefly
Daily_bat <- read.csv("war_daily_bat.csv")
Daily_bat %>% select(1:10) %>% slice(1:3)

kept_Columns = select(Daily_bat, 1, 2, 4, 5, 6, 31, 32, 33, 36, 47)
years_pitchers_Subset <- subset(kept_Columns, 2005 < year_ID & year_ID < 2017 & pitcher == "N")
Batting_value <- select(years_pitchers_Subset, -9)

write.csv(Batting_value, "Batting_Value.csv")

trout <- subset(Batting_value, player_ID == "troutmi01")
View(trout)