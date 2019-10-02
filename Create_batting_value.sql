CREATE TABLE Batting_Value (
    AutoNum int NOT NULL AUTO_INCREMENT,
    name_common varchar(255),
    age int,
    player_ID varchar(255),
    year_ID int,
    team_ID varchar(255),
    WAR DECIMAL(4,2),
    WAR_def DECIMAL(4,2),
    WAR_off DECIMAL(4,2),
    OPS_plus int,
	PRIMARY KEY (AutoNum)
);