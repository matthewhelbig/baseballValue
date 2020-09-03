library(dplyr)
library(data.table)
library(janitor)
library(car)

##Create copy of data table to play with
test2 <- Batting_Value_Salary

#We've got our difference score working in our pre-breakout players. (I don't think we need this, I think it was just a test
#to see if the difference score would work.)

temp_DiffSc <- ((total_sub$True_BB_plus - diff_score_subset$True_BB_plus)/total_sub$True_BB_plus) +
  ((total_sub$True_SO_plus - diff_score_subset$True_SO_plus)/total_sub$True_SO_plus) +
  ((total_sub$ISO - diff_score_subset$ISO)/total_sub$ISO) +
  ((total_sub$batting_average - diff_score_subset$batting_average)/total_sub$batting_average) +
  ((total_sub$on_base_percentage - diff_score_subset$on_base_percentage)/total_sub$on_base_percentage) +
  ((total_sub$slugging_percentage - diff_score_subset$slugging_percentage)/total_sub$slugging_percentage)


#Now we can test the difference score formula in our "test2" data frame.

temp_DiffSc2 <- ((total_sub$True_BB_plus - test2$BB_plus)/total_sub$True_BB_plus) +
  ((total_sub$True_SO_plus - test2$SO_plus)/total_sub$True_SO_plus) +
  ((total_sub$ISO - test2$ISO)/total_sub$ISO) +
  ((total_sub$batting_average - test2$batting_average)/total_sub$batting_average) +
  ((total_sub$on_base_percentage - test2$on_base_percentage)/total_sub$on_base_percentage) +
  ((total_sub$slugging_percentage - test2$slugging_percentage)/total_sub$slugging_percentage)

test2$DiffSc <- abs(temp_DiffSc2 * 100)

#Subset so it's just 2011 to 2015
eleven_to_fifteen <- subset(test2, 2010 < yearID & yearID < 2016)


#Subset again so it's just players older than 25 making under $3 million
Older_than_25 <- subset(eleven_to_fifteen, salary < 3000000 & age > 25 & excess_value_plus < 100)

View(Older_than_25)

#EXPLAIN WHY WE"RE PICKING THESE GUYS
pre_breakout_two <- Older_than_25[ which(Older_than_25$AutoNum == 3785 | 
                                           Older_than_25$AutoNum == 3715 |
                                           Older_than_25$AutoNum == 5242 |
                                           Older_than_25$AutoNum == 3243 |
                                           Older_than_25$AutoNum == 2218
),]
View(pre_breakout_two)

post_breakout_two <- Batting_Value_Salary[ which(Batting_Value_Salary$AutoNum == 4155 | 
                                                   Batting_Value_Salary$AutoNum == 4090 |
                                                   Batting_Value_Salary$AutoNum == 5433 |
                                                   Batting_Value_Salary$AutoNum == 3630 |
                                                   Batting_Value_Salary$AutoNum == 2581
), ]
View(post_breakout_two)

#End of day 9/1. I had to go through and figure out what it was that I last did. 