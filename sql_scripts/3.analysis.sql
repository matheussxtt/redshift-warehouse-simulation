-- QUERY 1

-- Our first task is to find out which products have the largest discounts on sale
-- For that we have to join the products and the order_details tables
-- the former has information about the original unit_price per product while the latter has info about the price for which the products were effectively sold
-- with that, we can find create a 'discount' column, which calculates the difference between prices

select a.order_id,a.product_id,a.unit_price,a.quantity,b.product_name,b.unit_price as original_unit_price,b.unit_price - a.unit_price as discount from order_details a
INNER JOIN products b 
on a.product_id = b.product_id
where b.unit_price - a.unit_price > 0
order by discount desc;


-- QUERY 2 
-- Our second task is to build a report that shows each employee's performance on sales during the most recent year on the database
-- For this task, i grouped the total amount of sales made by employee_id, next I used left join to fetch employee information from the employee table 
-- First we can compare performance through the amount of sales made

with sales_count as (
select a.employee_id, count(a.employee_id) as total_sales from orders a 
where DATE_PART(year, order_date) = 2022
group by a.employee_id
)
select a.employee_id, a.total_sales,b.first_name + ' ' + b.last_name as name,b.title from sales_count a
inner join employees b
on a.employee_id = b.employee_id
order by total_sales desc;


-- Alternative method to get the same information

select  e.first_name + ' ' + e.last_name nome , 
sum(od.unit_price * od.quantity - od.discount) total from order_details od
inner join orders o on (o.order_id = od.order_id)
inner join employees e on (e.employee_id = o.employee_id)
where DATE_PART(year, o.order_date) = 2022
group by nome
order by total desc


-- Final report, with total amount of sales + raw earnings per sale

select a.employee_id,a.total_sales,a.name,b.raw_earnings from (
    with sales_count as (
select a.employee_id, count(a.employee_id) as total_sales from orders a 
where DATE_PART(year, order_date) = 2022
group by a.employee_id
)
select a.employee_id, a.total_sales,b.first_name + ' ' + b.last_name as name from sales_count a
inner join employees b
on a.employee_id = b.employee_id
order by total_sales desc
) a
inner join (select  e.employee_id,e.first_name + ' ' + e.last_name nome , 
sum(od.unit_price * od.quantity - od.discount) raw_earnings from order_details od
inner join orders o on (o.order_id = od.order_id)
inner join employees e on (e.employee_id = o.employee_id)
where DATE_PART(year, o.order_date) = 2022
group by nome, e.employee_id
order by raw_earnings desc
) b
on a.employee_id = b.employee_id;

-- QUERY 3 
-- In this task we need to find out which are the 10 most expensive products in our database
select product_id,product_name,unit_price from products
order by unit_price desc
limit 10;

-- QUERY 4
-- In this task we need to compare 2020 and 2021 sales per supplier, as to see what supplier's products have the most demand
-- For this, I have created a central table 'data' that I will use to build 2 subtables (for 2020 and 2021), so that I can compare sales between both years

with data as (
select a.supplier_id, 
a.company_name, 
b.product_id, 
c.order_id, 
c.quantity, 
c.unit_price, 
d.order_date 
from suppliers a
inner join products b on (a.supplier_id = b.supplier_id)
inner join order_details c on (b.product_id = c.product_id)
inner join orders d on (c.order_id = d.order_id)
)
select a.supplier_id,a.company_name,a.sales_2020,b.sales_2021, b.sales_2021 - a.sales_2020 as var_sales from (
select supplier_id, 
company_name, 
count(order_id) as sales_2020 
from data 
where date_part(year,order_date) = 2020 
group by supplier_id,company_name
) a
inner join (
select supplier_id, 
company_name, 
count(order_id) as sales_2021
from data 
where date_part(year,order_date) = 2021 
group by supplier_id,company_name
) b
on a.supplier_id = b.supplier_id
order by var_sales desc;

-- Query 5 
-- Top 5 most sold product categories per year

with result as (
  select  c.category_name categoria, DATE_PART(year, o.order_date) ano, 
  sum(od.unit_price * od.quantity - od.discount) total ,
  row_number() over (partition by ano order by ano,total desc) as res 
  from categories c
  inner join products p on (c.category_id = p.category_id)
  inner join order_details od on (p.product_id = od.product_id)
  inner join orders o on (o.order_id = od.order_id)
  group by categoria, ano
),
filter as (
  select * from result where res <=5
)
  select categoria, ano, total from filtro