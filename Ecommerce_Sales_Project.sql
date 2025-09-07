select * from [dbo].[women_clothing_ecommerce_sales$]

--Top 10 Best-Selling SKUs by Revenue
--1st
select TOP 10 sku , Sum(unit_price*quantity) as Total_Revenue
from [dbo].[women_clothing_ecommerce_sales$]
group by sku
order by Total_Revenue desc
--2nd
select top 10 sku, sum(revenue)  as Total_Revenue
from [dbo].[women_clothing_ecommerce_sales$]
group by sku
order by Total_Revenue desc

--Most Popular Sizes by Units Sold
 select top 3 size ,sum(quantity) as Units_Sold
 from [dbo].[women_clothing_ecommerce_sales$]
 group by size
 order by Units_Sold desc


 --Which Color Generated the Highest Revenue
select color , sum(revenue) as total_revenue
from [dbo].[women_clothing_ecommerce_sales$]
group by color
having sum(revenue)= (select max(total_rev) from
(select  color,sum(revenue)as total_rev
from [dbo].[women_clothing_ecommerce_sales$]
group by color)as t)

--Total Monthly Revenue Trend
select datename (month,order_date)as month, sum(revenue) as monthly_revenue
from [dbo].[women_clothing_ecommerce_sales$]
group by datename (month,order_date),month(order_date)
order by month

--Average Order Value (AOV)
select avg(Order_Value)as avg_order_value
from (select order_id , sum(revenue) as Order_Value
from [dbo].[women_clothing_ecommerce_sales$]
group by order_id)
as order_totals


--Repeat Purchase Customers
select order_id,count( sku) as repeat_order  
from [dbo].[women_clothing_ecommerce_sales$]
group by order_id
having count(*)>1


--SKU Contribution to Total Revenue (%)
select sku,sum(revenue)as total_revenue,
round((sum(revenue)*100/(select sum(revenue)
from [dbo].[women_clothing_ecommerce_sales$])),2) as revenue_pct
from [dbo].[women_clothing_ecommerce_sales$]
group by sku
order by revenue_pct desc


--Best-Selling SKU by Each Color
select sku, color,sum(revenue) as best_selling_sku
from [dbo].[women_clothing_ecommerce_sales$]
group by sku,color
having sum(revenue)=( select max(total_rev) from
(select color as c,sku,sum(revenue) as total_rev 
from [dbo].[women_clothing_ecommerce_sales$]
group by sku ,color) as t
where t.c = color)order by best_selling_sku desc


--Daily Revenue Trend
select convert(date,order_date) as order_day,sum(revenue) as total_revenue
from [dbo].[women_clothing_ecommerce_sales$]
group by convert(date,order_date)


--High-Value Orders (orders > ₹1,000 revenue)
select order_id , sum (revenue) as total_revenue
from [dbo].[women_clothing_ecommerce_sales$]
group by order_id
having sum(revenue)>1000
order by total_revenue asc



