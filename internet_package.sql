create database internet;
use internet;

select * from plans;
select * from subscription;

#  Write a query to retrieve all plan_id, plan_name, and price from the plans table.
select * from plans;

# Find customers who are currently on the pro monthly plan.
select customer_id
 from plans p inner join subscription s using (plan_id) where plan_name ='pro monthly';
 
 # Get the customers who started their trial on or after 2020-08-01.
 select customer_id from subscription where start_date > 01-08-2020;
 
 # Count the total number of customers who have subscribed to the basic monthly plan.
 select count(distinct customer_id)
from plans p inner join subscription s using (plan_id) where plan_name = 'basic monthly';

# Retrieve the customers who churned.
select customer_id
from plans p inner join subscription s using (plan_id) where plan_name = 'Churn';

#  Get the list of all customers who are on the pro monthly or pro annual plan.
select customer_id
from plans p inner join subscription s using (plan_id) where plan_name in ('pro monthly', 'pro annual');

# Get the count of customers subscribed to each plan.
select plan_name, count( customer_id) as NO_of_customer
from plans p inner join subscription s using (plan_id) group by plan_name;

# Find the customers who have been on the pro monthly plan since 2020-01-01.
select customer_id
from plans p inner join subscription s using (plan_id) where plan_name = 'pro monthly' and start_date <= 2020-01-01;


 