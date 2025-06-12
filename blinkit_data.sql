use blinkit_database;
select * from blinkit_customers;

-- count of customer id
select count(customer_id)from blinkit_customers;

-- customer list name starts with n
select * from blinkit_customers
where customer_name like 'n%';

-- order of customer is high or low
select customer_name,total_orders,
case
when total_orders >=10 then 'high orders'
else 'low order'
end
as order_status
from blinkit_customers;

-- orders between 10 to 20
select * from blinkit_customers
where total_orders between 10 and 20;

-- count of order betweeen 10 to 20
select count(*) from blinkit_customers
where total_orders between 10 and 20;

-- customer from vishakhapatnam
select customer_name,area from blinkit_customers
where area='Visakhapatnam';

select customer_name,area from blinkit_customers
where area in('Udupi','Kozhikode','Malegoan');

-- registratin date difference from today
select customer_name,datediff(now(),registration_date) as registered_date_from_today from blinkit_customers;

select * from blinkit_orders;
-- day of actual date
select actual_delivery_time, dayname(actual_delivery_time) as delivered_day from blinkit_orders;


select product_name,price from blinkit_products 
where price>(select avg(price)from blinkit_products)
order by price desc
limit 10;

-- joins
select c.customer_name ,o.payment_method 
from blinkit_customers c
inner join blinkit_orders o
on c.customer_id=o.customer_id;

select * from blinkit_order_items;
select * from blinkit_customers;
select * from blinkit_products;
select * from blinkit_orders;

SELECT 
    blinkit_customers.customer_name,
    blinkit_products.product_name,
    blinkit_orders.payment_method
   from blinkit_order_items
INNER JOIN blinkit_orders ON blinkit_order_items.order_id = blinkit_orders.order_id
INNER JOIN blinkit_products ON blinkit_order_items.product_id = blinkit_products.product_id
INNER JOIN blinkit_customers ON blinkit_orders.customer_id=blinkit_customers.customer_id;

select blinkit_products.product_name,
count(blinkit_customers.customer_name),
sum(blinkit_products.price),
blinkit_orders.payment_method
from blinkit_order_items
inner join blinkit_products on blinkit_order_items.product_id=blinkit_products.product_id
inner join blinkit_orders on blinkit_order_items.order_id=blinkit_orders.order_id
inner join blinkit_customers on blinkit_orders.customer_id=blinkit_customers.customer_id
group by blinkit_products.product_name,
blinkit_orders.payment_method;


-- sub query
select min(price) from blinkit_products;
select 
blinkit_customers.customer_name,
blinkit_products.product_name,
blinkit_products.price,
blinkit_orders.payment_method
from blinkit_order_items
inner join blinkit_orders on blinkit_order_items.order_id=blinkit_orders.order_id
inner join blinkit_customers on blinkit_orders.customer_id=blinkit_customers.customer_id
inner join blinkit_products on blinkit_order_items.product_id=blinkit_products.product_id
where price=(select min(price) from blinkit_products);


select blinkit_orders.delivery_status,
count(blinkit_customers.customer_name) as customer_count
from blinkit_orders
inner join blinkit_customers on blinkit_orders.customer_id=blinkit_customers.customer_id
group by delivery_status;

-- group by having clause
select product_name,sum(price) from blinkit_products
group by product_name
having sum(price)>500;
 
select product_name,min(price) from blinkit_products
group by product_name
having min(price)<=600
order by min(price)  desc
limit 5;

select product_name,price from blinkit_products
where price=(select max(price) from blinkit_products);
 
 

