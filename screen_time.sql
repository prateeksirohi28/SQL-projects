use screentime;
select * from screen_time;

#1. Write a query to show all rows where the screen time type is 'Total'.
select * from screen_time where Screen_Time_Type ='Total';

#2 Find the average screen time (in hours) by gender and day type, considering only Recreational screen time.
select gender , day_type, screen_time_type, avg(Average_Screen_Time_hours) as avg_time from screen_time where Screen_Time_Type = 'recreational'
group by gender, day_type;

#3 Find the age with the highest average educational screen time on weekends.
select * from (
select*, dense_rank() over( order by Average_Screen_Time_hours desc) as drn from screen_time) as t where drn = 1;

#4 For each Screen Time Type (Educational, Recreational, Total), calculate the total number of children surveyed (i.e., sum the Sample Size).
select screen_time_type , sum(sample_size) from screen_time group by Screen_Time_Type;

#5 For each Gender and Day Type (Weekday vs Weekend), count how many records exist for each Screen Time Type (Educational, Recreational, Total).
select gender, day_type, screen_time_type, count(sample_size) as Total_records from screen_time group by gender, day_type, Screen_Time_Type ;

#6 For each Day Type (Weekday and Weekend), calculate the average screen time for each gender.
select gender, day_type, avg(Average_Screen_Time_hours) as avg_time from screen_time group by gender, day_type;

#7 For each Gender, calculate the total screen time (Educational + Recreational + Total) and compare it with Recreational screen time for weekends only.
select gender,day_type, sum(Case when screen_time_type = 'recreational' then Average_Screen_Time_hours else 0 end) as recreational_time,
sum(case when screen_time_type in ('educational', 'recreational', 'total') then Average_Screen_Time_hours else 0 end ) as total_time
from screen_time where day_type = 'weekend' group by gender,day_type;

#8 Find the Highest Average Screen Time by Age
select * from screen_time;
select age, Screen_Time_Type,Average_Screen_Time_hours from (
select*, rank() over(partition by age order by Average_Screen_Time_hours desc ) as rn from screen_time) as t where rn =1;

#9  Calculate Gender-wise % Contribution to Total Weekend Screen Time
WITH weekend_totals AS (SELECT Gender,SUM(Average_Screen_Time_hours) AS gender_total FROM screen_time WHERE Day_Type = 'Weekend' GROUP BY Gender),
overall_total AS (SELECT SUM(Average_Screen_Time_hours) AS total_screen_time FROM screen_time WHERE Day_Type = 'Weekend')
SELECT w.Gender,w.gender_total,o.total_screen_time,ROUND((w.gender_total * 100.0) / o.total_screen_time, 2)
 AS percent_contribution FROM weekend_totals w, overall_total o;
 
 #10  Identify the Most Screen-Time Heavy Age-Gender Combo on Weekends
 select age, gender, sum(Average_Screen_Time_hours) as total_screen_time from screen_time where day_type = 'weekend' group by age, gender
 order by total_screen_time desc limit 1;
