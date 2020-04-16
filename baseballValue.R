library(dplyr)
library(data.table)



#Maybe it'd be good to make a salary plus statistic
test2$salary_plus <- ((test2$salary / mean(test2$salary)*100))

#Let's try salary
agg <- aggregate(x = test2$salary_plus,                # Specify data column
          by = list(test2$age),              # Specify group indicator
          FUN = mean)                           # Specify function (i.e. mean)

names(agg)[1] <- "Age"
names(agg)[2] <- "Average Salary"
plot(agg$Age, agg$`Average Salary`)

#Now let's do excess value
agg3 <- aggregate(x = test2$excess_value_plus,                # Specify data column
                  by = list(test2$age),              # Specify group indicator
                  FUN = mean)                           # Specify function (i.e. mean)

names(agg3)[1] <- "Age"
names(agg3)[2] <- "Excess Value Plus"
plot1 <- plot(agg$Age, agg$`Average Salary`, xlab="Age", ylab="Salary Plus & Excess Value Plus", type = 'l', col = 'blue',
              ylim = c(-100,400))
par(new=TRUE)
plot3 <- plot(agg3$Age, agg3$`Excess Value Plus`, xlab="Age", ylab="Salary Plus & Excess Value Plus", type = 'l', col = 'red',
              ylim = c(-100,400))
legend("topright", legend=c("Excess Value Plus", "Salary Plus"),
       col=c("red", "blue"), lty=1:1, cex=0.8)

#So today, we spent all our time trying to figure out how to show that all the most valuable players are the young players,
#and that this is primarily because they're so cheap.

#We created a salary plus metric, and then we plotted Salary Plus and Excess Value Plus against age on the same graph,
#which shows that there's a huge inverse relationship between Salary and Excess Value. This also shows that the players
#with the most excess value are the players with the lowest salaries. I think if we created a table and showed that 
#salary plus peaks at a certain age, we could use that, along with our graph, to show why a cutoff of 27 or 28 is the most
#ideal.
