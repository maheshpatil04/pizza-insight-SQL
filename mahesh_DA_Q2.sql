--1 Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category, SUM(order_details.quantity) AS total
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.category;


--2 Determine the distribution of orders by hour of the day.

SELECT
       EXTRACT(HOUR FROM order_time) AS order_hour,
		COUNT(*) AS total_orders
    FROM
         orders
     GROUP BY
         order_hour
     ORDER BY
		order_hour;
        
--3 Join relevant tables to find the category-wise distribution of pizzas
    
       SELECT 
    pizza_types.category, COUNT(pizza_id) AS total_pizza
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category
ORDER BY total_pizza;

--4  Group the orders by date and calculate the average number of pizzas ordered per day

SELECT 
    DATE(orders.order_date),
    SUM(order_details.quantity) AS order_total
FROM
    orders
        JOIN
    order_details ON orders.order_id = order_details.order_id
GROUP BY DATE(orders.order_date);

--5 Determine the top 3 most ordered pizza types based on revenue.

select pizzas.pizza_id,sum(order_details.quantity * pizzas.price) as total
     from order_details
     join pizzas on
     pizzas.pizza_id = order_details.pizza_id
     group by pizzas.pizza_id
     order by total desc
     limit 3;