library(dplyr)
library(data.table)

#The below code is what we'll work on today 4/14. We don't necessarily need to subset just the old players yet. We can look 
#at the cost per win stuff and "notice" that it's all younger players, then subset based on that. We'll continue to work
#in "test" and "test2" until we have results stable enough for the actual "Batting_Value_Salary" table.

#This code subsets the data for all excess_value_plus > 1000. It'll show that, by and large, the players with the most
#excess value skew young.

excess_subset_1000 <- subset(test2, test2$excess_value_plus > 1000)

#Let's compare the mean age for all players to the mean age for players who provide the most excess value.

mean(test2$age) #29.25
mean(excess_subset_1000$age)

#Now let's compare the players with above average excess value to the players with below average excess value.

excess_subset_100_plus <- subset(test2, test2$excess_value_plus > 100)
excess_subset_100_minus <- subset(test2, test2$excess_value_plus < 100)

mean(excess_subset_100_plus$age) #28.01
mean(excess_subset_100_minus$age) #30.02

#Now let's see how old the players were who had negative value.

excess_subset_0_less <- subset(test2, test2$excess_value_plus < 0)
mean(excess_subset_0_less$age) #30.34

#So an interesting thing to do tomorrow 4/15 would be to create a table showing the mean age of excess value plus in one
#column and the subset in the other column (excess value is less than 0, between 0 and 100, 100 and 300, 300 and 500
#500 and 700, 700 and 900, 900+) and showing that as excess value goes up, age goes down (maybe you could also include
#the average salaries(?) in that range of excess value plus). The point is, we want to show that we'll need to limit our
#data to not include younger players, since our data would be limited to entirely young players and it's not super
#valuable to say "Just sign good young players." That'll be the focus for tomorrow.


#This is an old subset that isn't needed right now but I don't necessarily want to delete because it could be valuable.
olds_money <- subset(test2, test2$age > 27 & test2$salary > 500000 & test2$salary < 10000000)






#I don't want to put batting average in R markdown as a variable yet so I'm storing it here as of 4/14
###Batting average
#The next variable we'll create is "Batting average." Simply put, batting average is how often a player gets a hit. 
#This is one of the oldest and simplest statistics in baseball, and is still frequently used to determine how valuable 
#a player is. 

#We'll create batting average in our "Batting_Value_Salary" table by running the following:
#  ```{r}
#batting_average_raw <- Batting_Value_Salary$H / Batting_Value_Salary$AB
#Batting_Value_Salary$batting_average <- format(batting_average_raw, digits = 2)
#```
#This gives us batting average as a new variable in our dataset, and it's been limited to three digits, as batting average 
#is often represented as ".300," ".260," or ".185" Let's take a look:
  
#  ```{r}
#name_average <- Batting_Value_Salary %>% select(name_common, batting_average)
#head(name_average)
#```