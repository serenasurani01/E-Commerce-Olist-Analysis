use database olist;
use schema public;
with customer_orders as (

select 
c.customer_id, 
o.order_id,
c.customer_zip_code_prefix,
g.geolocation_zip_code_prefix,
g.geolocation_lat,
g.geolocation_lng
from customers c
join orders o on c.customer_id = o.customer_id
join geolocation g on c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
),
order_values as (

select 
order_id, 
sum(price) as total_order_value
from order_items
group by order_id
)

select
co.customer_zip_code_prefix,
count(co.customer_id) as customer_count,
avg(ov.total_order_value) as avg_order_value,
co.geolocation_lat,
co.geolocation_lng
from customer_orders co
join order_values ov on co.order_id = ov.order_id
group by co.customer_zip_code_prefix, co.geolocation_lat, co.geolocation_lng
order by avg_order_value desc;

with customer_order_frequency as (
select 
c.customer_id, 
count(o.order_id) as order_count,
sum(oi.price) as total_spent
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
group by c.customer_id
)

select 
customer_id,
order_count,
total_spent,
total_spent / order_count as avg_order_value,
case 
when order_count = 1 then 'one-time customer'
when order_count between 2 and 5 then 'frequent customer'
when order_count > 5 then 'loyal customer'
end as customer_segment
from customer_order_frequency
order by order_count desc;

with customer_category_purchases as (
-- find distinct product categories purchased by each customer and concatenate them
select 
o.customer_id, 
count(distinct p.product_category_name) as distinct_categories,
listagg(distinct p.product_category_name, ', ') as purchased_categories,
count(distinct o.order_id) as total_orders
from orders o
join order_items oi on o.order_id = oi.order_id
join product p on oi.product_id = p.product_id
group by o.customer_id
),
repeat_store_purchases as (
select 
o.customer_id, 
oi.seller_id,
count(oi.seller_id) as purchases_from_same_seller
from orders o
join order_items oi on o.order_id = oi.order_id
group by o.customer_id, oi.seller_id
having count(oi.seller_id) > 1
)

select 
ccp.customer_id,
ccp.total_orders,
ccp.distinct_categories as categories_purchased,
ccp.purchased_categories as category_list,
coalesce(rsp.purchases_from_same_seller, 0) as repeat_purchases_from_same_seller
from customer_category_purchases ccp
left join repeat_store_purchases rsp on ccp.customer_id = rsp.customer_id
order by categories_purchased desc, repeat_purchases_from_same_seller desc;

select sp.product_category_name_english as product_category,
oi.product_id,
oi.price,
count(oi.order_id) as number_orders
from order_items oi 
left join ( select p.product_id as product_id, p.product_category_name as product_category_name, 
pe.c2 as product_category_name_english
from product p
left join product_eng pe
on pe.c1 = p.product_category_name) as sp
on sp.product_id = oi.product_id
group by product_category,oi.product_id,
oi.price;





with product_price_stats as (

select 
oi.product_id,
min(oi.price) as min_price,
max(oi.price) as max_price,
count(distinct oi.price) as price_count
from order_items oi
group by oi.product_id
having count(distinct oi.price) > 1 
),
min_max_orders as (

select
oi.product_id,
case 
    when oi.price = pps.min_price then 'min'
    when oi.price = pps.max_price then 'max'
end as price_type,
count(oi.order_id) as number_orders
from order_items oi
join product_price_stats pps on oi.product_id = pps.product_id
where oi.price = pps.min_price or oi.price = pps.max_price  
group by oi.product_id, oi.price, price_type
),
final_orders as (

select
mmo.product_id,
max(case when mmo.price_type = 'min' then mmo.number_orders end) as orders_at_min_price,
max(case when mmo.price_type = 'max' then mmo.number_orders end) as orders_at_max_price,
max(case when mmo.price_type = 'min' then pps.min_price end) as min_price,
max(case when mmo.price_type = 'max' then pps.max_price end) as max_price
from min_max_orders mmo
join product_price_stats pps on mmo.product_id = pps.product_id
group by mmo.product_id
)

select 
sp.product_category_name_english as product_category,
fo.product_id,
fo.min_price,
fo.orders_at_min_price,
fo.max_price,
fo.orders_at_max_price
from final_orders fo
left join (

select 
p.product_id as product_id, 
p.product_category_name as product_category_name, 
pe.c2 as product_category_name_english
from product p
left join product_eng pe on pe.c1 = p.product_category_name
) as sp
on sp.product_id = fo.product_id;

select p.order_id as order_id, 
od.total_order_cost, 
p.payment_installments 
from payments p
left join (select order_id as order_id, 
sum(price +freight_value) as total_order_cost 
from order_items 
group by order_id) od
on od.order_id = p.order_id; 