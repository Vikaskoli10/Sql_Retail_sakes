-- SQL Retail Sales Analysis - P1
CREATE DATABASE sql_project;


-- Create TABLE
create table retail_sales
            (
                transaction_id Int primary key,	
                sale_date Date,	 
                sale_time Time,	
                customer_id	Int,
                gender	Varchar(15),
                age	Int,
                category Varchar(15),	
                quantity	Int,
                price_per_unit Float,	
                cogs	Float,
                total_sale Float
            );

select * from retail_sales



select 
    count(*) 
from retail_sales

-- Data Cleaning

select * from retail_sales
where 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- 
delete from retail_sales
where 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- Data Exploration

-- How many sales we have ?
select count(*) as total_sale from retail_sales

-- How many uniuque customers we have ?

select count(distinct customer_id) as total_sale from retail_sales

-- How many category do we have ?

select distinct category from retail_sales


-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select 
  *
from 
    retail_sales
where 
    sale_date = '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

select
   * 
from retail_sales
where 
    category = 'Clothing'
	and 
	quantity >= 4 
    and 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select 
     category, 
     sum(total_sale) as Total_Sales,
	 count(*) as Total_orders  
from 
     retail_sales
group by
     category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
    ROUND(AVG(age),0) as Average_Age 
from 
    retail_sales 
where 
    category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select
  * 
from 
  retail_sales 
where 
  total_sale >= '1000'

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select 
    category, 
	gender, 
	count(*) as count_of_category 
from 
    retail_sales
group by 
    category, gender 
order by 
    category

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year


select 
     year,
	 month,
	 avg_sales
from
    (
select 
     Extract (year from sale_date) as year,
	 Extract (month from sale_date) as month,
	 Avg(total_sale) as Avg_sales,
	 Rank() over (partition by Extract (year from sale_date) order by Avg(total_sale) desc)
from 
     retail_sales
group by 
		year, month
	) as Best_selling_month
where rank = 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select 
    customer_id, 
    sum(total_sale) as Total 
from 
    retail_sales
group by
    customer_id 
order by
    Total 
desc limit 5
 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select 
    count(distinct (customer_id)) as Count_of_Unique_customers, 
	category 
from
    retail_sales
group by 
    category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

with 
    hourly_sale
as (
select *, case 
              when extract (hour from sale_time) < 12 then 'Morning'
			  when extract (hour from sale_time) between 12 and 17 then 'Afternoon'
			  else 'Evening'
			  end as shift
from 
	retail_sales
   )	
 select 
    shift,
	count(*) 
from 
    hourly_sale
group by
    shift

-- End of project

