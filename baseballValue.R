library(dplyr)
library(data.table)



#Subset of players 27 and older and salary below $10 million
Older_than_26 <- subset(test2, age > 26 & salary < 10000000)

#Take top 30 sorted by excess value plus (fix variable names before applying to actual dataset)
top_excess_value <- Older_than_26[ Older_than_26$excess_value_plus >= Older_than_26$excess_value_plus[order(Older_than_26$excess_value_plus, decreasing=TRUE)][30] , ]
top2 <- top_excess_value[order(-top_excess_value$excess_value_plus),]
View(top2)

#Keep only the ones we've identified as the ones we want for our model. Will provide explanations for why not the others later.
newdata <- top2[ which(top2$AutoNum == 4109 | 
                       top2$AutoNum == 3780 |
                       top2$AutoNum == 3042 |
                       top2$AutoNum == 3097 |
                       top2$AutoNum == 3353 |
                       top2$AutoNum == 5039 |
                       top2$AutoNum == 2967 |
                       top2$AutoNum == 4400 |
                       top2$AutoNum == 2271 |
                       top2$AutoNum == 3872
                       ), ]
View(newdata)

#The last thing I'll do today is create a dataset from our original dataset that just has our pre-breakout players, so we
#can build our "average" player based off those players.

pre_breakout <- test2[ which(test2$AutoNum == 3296 | 
                               test2$AutoNum == 3372 |
                               test2$AutoNum == 2601 |
                               test2$AutoNum == 2653 |
                               test2$AutoNum == 2937 |
                               test2$AutoNum == 4908 |
                               test2$AutoNum == 2558 |
                               test2$AutoNum == 3994 |
                               test2$AutoNum == 1895 |
                               test2$AutoNum == 3472
),]
View(pre_breakout)

#Next, we'll need to create a new row, whether it's in this data frame or a different one, that has our average values for
#the variables we want to analyze for our "average" player. I'll look more into how to do this and likely tackle it tomorrow.
