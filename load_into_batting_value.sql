LOAD DATA LOCAL INFILE '/users/matthelbig/baseballValue/Batting_Value.csv'
INTO TABLE Batting_Value FIELDS TERMINATED BY ','
ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES