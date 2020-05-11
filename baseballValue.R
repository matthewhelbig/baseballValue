library(dplyr)
library(data.table)
library(janitor)



#Subset of players 27 and older and salary below $10 million
Older_than_26 <- subset(test2, age > 26 & salary < 10000000)

#Take top 30 sorted by excess value plus (fix variable names before applying to actual dataset)
top_excess_value <- Older_than_26[ Older_than_26$excess_value_plus >= Older_than_26$excess_value_plus[order(Older_than_26$excess_value_plus, decreasing=TRUE)][30] , ]
top2 <- top_excess_value[order(-top_excess_value$excess_value_plus),]
View(top2)

#Keep only the ones we've identified as the ones we want for our model. Will provide explanations for why not the others later.
post_breakout <- top2[ which(top2$AutoNum == 3042 | 
                       top2$AutoNum == 2967 |
                       top2$AutoNum == 5039 |
                       top2$AutoNum == 3872 |
                       top2$AutoNum == 2271
                       ), ]
View(post_breakout)

#The last thing I'll do today is create a dataset from our original dataset that just has our pre-breakout players, so we
#can build our "average" player based off those players.

pre_breakout <- test2[ which(test2$AutoNum == 2601 | 
                             test2$AutoNum == 2558 |
                             test2$AutoNum == 4908 |
                             test2$AutoNum == 3472 |
                             test2$AutoNum == 1895
                             ),]
View(pre_breakout)

#Create new column that is plate appearances for each of our datasets, which will make it easier to make BB% and K%.

pre_breakout$PA <- pre_breakout$AB + pre_breakout$BB + pre_breakout$HBP + pre_breakout$SF

#Now that we've got all the info we need, we need to keep the selected columns for our Differential score project so that
#we're not dealing with a ton of unnecessary columns

pre_diff_score_subset <- pre_breakout%>%
                        select(name_common, PA, AB, H, X2B, X3B, HR, BB, SO, SF, HBP)
View(pre_diff_score_subset)

#Now we create a new row in our data frame that is a sum of all the totals for each of the players
#Need the "janitor" library for this.
#library(janitor)
diff_score_subset <- pre_diff_score_subset %>%
  adorn_totals("row")
View(diff_score_subset)

#Now create our variables in our dataset again

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

##K-percentage
test_K <- ((diff_score_subset$SO)/(diff_score_subset$PA)*100)
diff_score_subset$K_percentage <- round(test_K, digits = 2)

##BB-percentage
test_BB <- ((diff_score_subset$BB)/(diff_score_subset$PA)*100)
diff_score_subset$BB_percentage <- round(test_BB, digits = 2)

##ISO
diff_score_subset$ISO <- (diff_score_subset$slugging_percentage) - (diff_score_subset$batting_average)

##BABIP
test_BABIP <- (diff_score_subset$H - diff_score_subset$HR)/(diff_score_subset$AB- diff_score_subset$SO - 
                                                              diff_score_subset$HR + diff_score_subset$SF)
diff_score_subset$BABIP <- round(test_BABIP, digits = 3)

#The last thing we'll do before getting back to our markdown document and actually make these changes is work on our
#difference score number.
write.csv(diff_score_subset,'diff_score_subset.csv')

#Where we'll leave off today is that we got our difference score working in Excel. The first thing we'll do tomorrow is
#make all of the changes we made in this R document in the actual R Markdown. Once that's done, we can look up a bit on
#how to do our difference score stuff in R specifically. Once we have that, we can add it to our new "older than 25"
#data frame which we'll create (older than 26 minus one since it's for a year before breakout) and then hopefully find the
#five players with the smallest difference scores. After that, we can load up the 2017 data doing a lot of the same stuff
#that we did to load in the 2006 to 2016 data and then see if our "pre-breakout" players actually broke out.