library(dplyr)
library(data.table)
library(janitor)

test2 <- Batting_Value_Salary

#Subset test2 to include just 2006 to 2010 to get our pool of players to choose from
oh_six_to_oh_ten <- subset(test2, 2005 < yearID & yearID < 2011)

#Subset of players 27 and older and salary below $3 million
Older_than_26 <- subset(oh_six_to_oh_ten, age > 26 & salary < 3000000)

#Take top 30 sorted by excess value plus (fix variable names before applying to actual dataset)
top_excess_value <- Older_than_26[ Older_than_26$excess_value_plus >= Older_than_26$excess_value_plus[order(Older_than_26$excess_value_plus, decreasing=TRUE)][30] , ]
top2 <- top_excess_value[order(-top_excess_value$excess_value_plus),]
View(top2)


#Keep only the ones we've identified as the ones we want for our model. Will provide explanations for why not the others later.
post_breakout <- top2[ which(top2$AutoNum == 4836 | 
                       top2$AutoNum == 1633 |
                       top2$AutoNum == 4960 |
                       top2$AutoNum == 4609 |
                       top2$AutoNum == 4692
                       ), ]
View(post_breakout)

#The last thing I'll do today is create a dataset from our original dataset that just has our pre-breakout players, so we
#can build our "average" player based off those players.

pre_breakout <- test2[ which(test2$AutoNum == 4691 | 
                             test2$AutoNum == 1234 |
                             test2$AutoNum == 4796 |
                             test2$AutoNum == 4441 |
                             test2$AutoNum == 4542
                             ),]
View(pre_breakout)


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

#We've got our difference score working in our pre-breakout players.

temp_DiffSc <- ((total_sub$True_BB_plus - diff_score_subset$True_BB_plus)/total_sub$True_BB_plus) +
  ((total_sub$True_SO_plus - diff_score_subset$True_SO_plus)/total_sub$True_SO_plus) +
  ((total_sub$ISO - diff_score_subset$ISO)/total_sub$ISO) +
  ((total_sub$batting_average - diff_score_subset$batting_average)/total_sub$batting_average) +
  ((total_sub$on_base_percentage - diff_score_subset$on_base_percentage)/total_sub$on_base_percentage) +
  ((total_sub$slugging_percentage - diff_score_subset$slugging_percentage)/total_sub$slugging_percentage)

diff_score_subset$DiffSc <- temp_DiffSc * 100

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
Older_than_25 <- subset(eleven_to_fifteen, age > 25 & salary < 1000000 & WAR < 1.47 & PA > 99 & age < 36)

#We'll leave off today (5/12) having gotten our difference score working and our five players identified. I want to clean
#up a lot of this test environment tomorrow, and then finish identifying/explaining the five players the model chose.
#After that, we can move everything into the actual R Markdown, and include some analysis on which players we built the
#model off of and why, who our model chose and why, and some final conclusions. After that, all that's left to do is 
#polish up the R Markdown document so that it's coherent, concise, and entertaining to read.