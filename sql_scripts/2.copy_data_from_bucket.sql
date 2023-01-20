-- Copy values from AWS bucket into redshift tables, credentials were hidden for security reasons

copy categories 
from 's3://bucket_name/categories.csv' 
CREDENTIALS 'aws_access_key_id=?????;aws_secret_access_key=?????' 
delimiter ';' 
region '?????'
IGNOREHEADER 1
DATEFORMAT AS 'YYYY-MM-DD HH:MI:SS'
removequotes;

copy customers
from 's3://bucket_name/customers.csv' 
CREDENTIALS 'aws_access_key_id=?????;aws_secret_access_key=?????' 
delimiter ';' 
region '?????'
IGNOREHEADER 1
DATEFORMAT AS 'YYYY-MM-DD HH:MI:SS'
removequotes;

copy employees 
from 's3://bucket_name/employees.csv' 
CREDENTIALS 'aws_access_key_id=?????;aws_secret_access_key=?????' 
delimiter ';' 
region '?????'
IGNOREHEADER 1
DATEFORMAT AS 'YYYY-MM-DD HH:MI:SS'
removequotes;

copy order_details 
from 's3://bucket_name/order_details.csv' 
CREDENTIALS 'aws_access_key_id=?????;aws_secret_access_key=?????' 
delimiter ';' 
region '?????'
IGNOREHEADER 1
DATEFORMAT AS 'YYYY-MM-DD HH:MI:SS'
removequotes;

copy orders 
from 's3://bucket_name/orders.csv' 
CREDENTIALS 'aws_access_key_id=?????;aws_secret_access_key=?????' 
delimiter ';' 
region '?????'
IGNOREHEADER 1
DATEFORMAT AS 'YYYY-MM-DD HH:MI:SS'
removequotes;

copy products 
from 's3://bucket_name/products.csv' 
CREDENTIALS 'aws_access_key_id=?????;aws_secret_access_key=?????' 
delimiter ';' 
region '?????'
IGNOREHEADER 1
DATEFORMAT AS 'YYYY-MM-DD HH:MI:SS'
removequotes;

copy shippers 
from 's3://bucket_name/shippers.csv' 
CREDENTIALS 'aws_access_key_id=?????;aws_secret_access_key=?????' 
delimiter ';' 
region '?????'
IGNOREHEADER 1
DATEFORMAT AS 'YYYY-MM-DD HH:MI:SS'
removequotes;

copy suppliers 
from 's3://bucket_name/suppliers.csv' 
CREDENTIALS 'aws_access_key_id=?????;aws_secret_access_key=?????' 
delimiter ';' 
region '?????'
IGNOREHEADER 1
DATEFORMAT AS 'YYYY-MM-DD HH:MI:SS'
removequotes;


-- verifying if data is correct
select * from shippers;
select * from suppliers;
select * from products;
select * from orders;
select * from order_details;
select * from employees;
select * from customers;
select * from categories;
