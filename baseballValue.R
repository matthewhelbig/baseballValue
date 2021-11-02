library(dplyr)
library(data.table)
library(janitor)
library(car)

##Create copy of data table to play with
test2 <- Batting_Value_Salary

#Need to figure out how to display stats for our pre-breakout players (table of pre-breakout, table of post-breakout, show difference)

sum(pre_breakout_two$excess_value)
sum(pre_breakout_two$excess_value)

(sum(post_breakout_two$excess_value) - sum(pre_breakout_two$excess_value)) / 5

