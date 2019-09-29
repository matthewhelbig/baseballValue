INSERT INTO Player_Salary_Info 
SELECT 0, Salaries_post_2006.playerID, Master.birthYear, Salaries_post_2006.yearID, Salaries_post_2006.salary
FROM Salaries_post_2006 
INNER JOIN Master ON Salaries_post_2006.playerID = Master.playerID