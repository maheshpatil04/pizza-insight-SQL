use pizza;
1. Retrieve the total number of orders placed.
select count(order_id) from orders;

2. Calculate the total revenue generated from pizza sales
select sum(quantity * price) as total from pizzas
join order_details on 
order_details.pizza_id =pizzas.pizza_id;

3 Identify the highest-priced pizza.
select pizza_id, price from pizzas
order by price desc
limit 1;

4.Identify the most commonly ordered pizza size.
 select pizzas.size, count(order_details.quantity) as total
 from order_details
 join pizzas
 on
 pizzas.pizza_id=order_details.pizza_id
 group by pizzas.size
order by total desc
limit 1;

5 List the top 5 most ordered pizza types along with their quantities
desc pizzas;
select count(order_details.quantity) as total,pizza_types.name from order_details
join  pizzas
on pizzas.pizza_id = order_details.pizza_id
join pizza_types
on pizzas.pizza_type_id=pizza_types.pizza_type_id
group by pizza_types.name
order by total desc
limit 5;
desc pizza_types;
6 Join the necessary tables to find the total quantity of each pizza category ordered.

select sum(order_details.quantity) as total,pizza_types.category from order_details
join  pizzas
on pizzas.pizza_id = order_details.pizza_id
join pizza_types
on pizzas.pizza_type_id=pizza_types.pizza_type_id
group by pizza_types.category;

7 Determine the distribution of orders by hour of the day

8 Join relevant tables to find the category-wise distribution of pizzas.
SELECT pizza_types.category, COUNT(pizza_id) AS total_pizza
FROM pizzas
JOIN
pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category
ORDER BY total_pizza;

9 Group the orders by date and calculate the average number of pizzas ordered per day.
desc order_details;
select date(orders.order_date) as dates, sum(order_details.pizza_id) from order_details
join orders
on order_details.order_id=orders.order_id
group by dates;
