library(RMySQL)
library(dplyr)

mydb = dbConnect(MySQL(), user='root', password='doorknob18pillow', dbname='Lahman2016', host='127.0.0.1')
dbListTables(mydb)
