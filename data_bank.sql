use data_bank;

#  Write a query to fetch all columns from the customer_nodes table.
select * from customer_nodes;

# Write a query to list all regions with their region_id and region_name from the regions table.
select region_id, region_name from regions;

# Write a query to get all transactions for the customer with customer_id = 429.
select * from customer_transactions where customer_id = '429';

# Write a query to find all customers in the region_name ‘Asia’ from the customer_nodes table.
select * from regions r inner join customer_nodes c using (region_id) where region_name = 'Asia';

# Write a query to get all deposit transactions greater than 500.
select * from customer_transactions where txn_type = 'deposit' and txn_amount >500;

#  Find the number of transactions made by each customer.
select customer_id, count(*) from customer_transactions group by customer_id;

# Get the sum of all deposits for each customer.
select customer_id, sum(txn_amount) as Total_deposit from customer_transactions where txn_type ='deposit'  group by customer_id ;

# Find the most recent transaction for each customer.
select customer_id, max(txn_date) as recent_txn from customer_transactions group by customer_id;

# Write a query to display each customer's current node.
select customer_id, node_id from customer_nodes where end_date >= current_date;

# Find the average transaction amount for all deposits.
select avg(txn_amount) as Avg_deposits from customer_transactions where txn_type = 'deposit';

#Write a query to list customers who have moved to a new node in the last 7 days.
select * from customer_nodes;
select customer_id, node_id, end_date from customer_nodes where end_date >= current_date();

# Find customers who made a transaction in both January and February 2020.
select customer_id
from customer_transactions where txn_date  between '2020-01-01' and '2020-02-29'
group by customer_id having count(distinct extract(month from txn_date)) = 2;

#Find the top 5 customers who have made the highest number of transactions.
select customer_id, txn_amount
 from customer_transactions order by txn_amount desc limit 5;
 
 #  Write a query to identify customers who made both a deposit and a withdrawal on the same date.
 select customer_id , txn_date from customer_transactions where txn_type in ('deposit','withdrawal')
 group by customer_id, txn_date having count(distinct(txn_type)) = 2;
 
 # Write a query to get the total number of transactions for each region.
 select region_name, count(*) as No_of_transactions
 from regions r inner join customer_nodes c using (region_id) inner join customer_transactions ct using (customer_id) group by region_name;
 
 #  Write a query to find regions with the highest average deposit amount.
 select region_name, avg(txn_amount) as avg_deposits
 from regions r inner join customer_nodes c using (region_id) inner join customer_transactions ct using (customer_id) where txn_type ='deposit' group by region_name
 order by avg_deposits desc limit 1;
 
 #  Write a query to find customers who have changed nodes across multiple regions
 select customer_id
 from regions r inner join customer_nodes c using (region_id) group by customer_id having count(distinct region_id) >=2;

#Write a query to identify customers who made at least one transaction every month from January 2020 to February 2020.
select customer_id
from customer_transactions where txn_date  between '2020-01-01' and '2020-02-29'
group by customer_id having count(distinct extract(month from txn_date)) = 2;



 
 

