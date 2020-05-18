library(dplyr)
library(data.table)
library(janitor)

test2 <- Batting_Value_Salary


#Now that we've got all the info we need, we need to keep the selected columns for our Differential score project so that
#we're not dealing with a ton of unnecessary columns

#Don't just keep the selected columns because the diff score example did, run a regression to show that the ones we keep
#are relevant to predicting future success.

fit <- lm(WAR_Off ~ BB_percentage + SO_percentage + ISO + OPS, data = test2)
summary(fit)

pre_diff_score_subset <- pre_breakout%>%
                        select(name_common, PA, AB, H, X2B, X3B, HR, BB, SO, SF, HBP, SO_plus, BB_plus)
View(pre_diff_score_subset)

#Create our Adjusted SO+ and BB+ so we can properly average these totals.
pre_diff_score_subset$adj_SO_plus <- pre_diff_score_subset$PA * pre_diff_score_subset$SO_plus
pre_diff_score_subset$adj_BB_plus <- pre_diff_score_subset$PA * pre_diff_score_subset$BB_plus

#Now we create a new row in our data frame that is a sum of all the totals for each of the players
#Need the "janitor" library for this.
#library(janitor)
diff_score_subset <- pre_diff_score_subset %>%
  adorn_totals("row")
View(diff_score_subset)

#Now create our variables in our dataset again

#True SO+ and BB+
test_SO_plus <- diff_score_subset$adj_SO_plus / diff_score_subset$PA
diff_score_subset$True_SO_plus <- round(test_SO_plus, digits = 2)

test_BB_plus <- diff_score_subset$adj_BB_plus / diff_score_subset$PA
diff_score_subset$True_BB_plus <- round(test_BB_plus, digits = 2)

##Batting average
test_BA <- diff_score_subset$H / diff_score_subset$AB
diff_score_subset$batting_average <- round(test_BA, digits = 3)

##On-base-percentage
test_OBP <- (diff_score_subset$H + diff_score_subset$BB + diff_score_subset$HBP) / 
  (diff_score_subset$AB + diff_score_subset$BB + diff_score_subset$HBP + diff_score_subset$SF)
diff_score_subset$on_base_percentage <- round(test_OBP, digits = 3)

##Slugging-percentage
test_SLG <- ((diff_score_subset$H - diff_score_subset$X2B - diff_score_subset$X3B - diff_score_subset$HR) + 
               (diff_score_subset$X2B * 2) + (diff_score_subset$X3B * 3) + (diff_score_subset$HR * 4))/
    (diff_score_subset$AB)
diff_score_subset$slugging_percentage <- round(test_SLG, digits = 3)

##ISO
diff_score_subset$ISO <- (diff_score_subset$slugging_percentage) - (diff_score_subset$batting_average)


#The last thing we'll do before getting back to our markdown document and actually make these changes is work on our
#difference score number.

#Need to put just the Total in a different subset to make the difference score stuff
total_sub <- subset(diff_score_subset, name_common == "Total")
View(total_sub)

#We've got our difference score working in our pre-breakout players.

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

#End of day 5/18. I changed up the metric for finding players a bit, and everything has been updated in this R document. I
#just need to move all the analysis from the R document here to the R Markdown, and then the analysis is done. Then I just
#need to edit the paper itself.