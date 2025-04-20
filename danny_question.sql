create database danny_dinner;
use danny_dinner;

# 1. What is the total amount each customer spent at the restaurant?
select* from sales;
select * from sales as s inner join menu  as m on s.product_id=m.product_id;							

select customer_id, sum(price) as total_price from sales as s inner join menu as m using(product_id) group by customer_id;

#2. How many days has each customer visited the restaurant?				
# select distinct order_date, 		
 select customer_id, count(customer_id) as No_of_times from sales group by customer_id;
 select customer_id, count(customer_id) as No_of_visits from 
 (select distinct order_date, customer_id, count(customer_id) as No_of_times from sales group by customer_id,order_date) as t 
 group by customer_id;
 
#3. What was the first item from the menu purchased by each customer?	
select * from (					
select*, row_number() over(partition by customer_id order by order_date) as drnk from sales s inner join menu m using (product_id) ) as t
where drnk = 1;

#4. What is the most purchased item on the menu and how many times was it purchased by all customers?	
select * from (
select product_name, count(product_name) as most_repated,
dense_rank() over(order by count(product_name) desc) as drnk from sales s	
 inner join menu m using( product_id)
 group by product_name) as t where drnk =1;			
 
 #5. Which item was the most popular for each customer?					
select * from ( select customer_id, product_name, count(*) as most_popular_item, 
 dense_rank() over(partition by customer_id order by count(product_name) desc ) as drnk 
 from sales as s inner join menu m using(product_id) group by customer_id,product_name) as t where drnk=1;
 
 #6. Which item was purchased first by the customer after they became a member?							
select * from (
select s.customer_id, order_date, join_date, product_name,
row_number() over(partition by customer_id order by order_date asc) as rn
from sales s inner join members m on s.customer_id=m.customer_id and s.order_date>m.join_date
inner join menu mu using(product_id)) as t where t.rn= 1;

#7. Which item was purchased just before the customer became a member?		
					
select * from (
select s.customer_id, order_date, join_date, product_name,
row_number() over (partition by customer_id order by order_date desc) as rn
from sales s inner join members m on s.customer_id=m.customer_id and s.order_date<m.join_date
inner join menu  using(product_id)) as t where rn=1;

#8. What is the total items and amount spent for each member before they became a member?							
select * from (
select s.customer_id, count(mu.product_name)as total_items, sum(price)as total_amount
from sales s inner join members m on s.customer_id=m.customer_id and s.order_date<m.join_date
inner join menu mu using(product_id) group by s.customer_id)as t ;

#9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?		

select customer_id ,sum(case when product_name ='Sushi' then price * 20 else price * 10 end) as Total_points
from sales s inner join menu m using (product_id) group by customer_id;		

#10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, 
# not just sushi - how many points do customer A and B have at the end of January?*/		
#dateadd(number, interval date) or date_add(number, interval date)

select s.customer_id,sum(case when order_date between Join_date and date_add(join_date,interval 7 day) then price * 20
 when product_name= 'Sushi' then price * 20 else price *10 end) as Total_points,count(*) as NO_of_items
 from sales s inner join members mb using (customer_id) inner join menu m using (product_id)
 where month(order_date) <= '1' group by customer_id ;
 
 # if the value of item is more than avg then print high value item or else low value item?
 select*, case when points <= 144 then 'Low value points' when points >144 then 'high value points' end as 'status' from(
 select *, case when product_name = 'Sushi' then price * 20 else price * 10 end as points
 from sales s inner join menu m using(product_id)) as t;
 
 # how to get average
 select avg(points)  as average_points from
 (select *, case when product_name = 'Sushi' then price * 20 else price * 10 end as points
 from sales s inner join menu m using(product_id)) as t;
 
 With CTE as(
 select avg(points)  as Average_points from
 (select *, case when product_name = 'Sushi' then price * 20 else price * 10 end as points
 from sales s inner join menu m using(product_id)) as t)
 
select*, case when points <= (select Average_points from CTE) then 'Low value points' when points >144 then 'high value points' end as 'status' from(
select *, case when product_name = 'Sushi' then price * 20 else price * 10 end as points
from sales s inner join menu m using(product_id)) as t;
 
 
 
 
 
		



