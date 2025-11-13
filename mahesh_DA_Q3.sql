use pizza;
1. Calculate the percentage contribution of each pizza type to total revenue.
desc pizzas;

2 Analyze the cumulative revenue generated over time

SELECT pt.name AS pizza_type,
       ROUND(SUM(od.quantity * p.price), 2) AS revenue,
       ROUND(SUM(od.quantity * p.price) * 100.0 /
            (SELECT SUM(od2.quantity * p2.price)
             FROM order_details od2
             JOIN pizzas p2 ON od2.pizza_id = p2.pizza_id), 2) AS percentage_contribution
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY percentage_contribution DESC;

SELECT o.date,
       SUM(od.quantity * p.price) AS daily_revenue,
       SUM(SUM(od.quantity * p.price)) 
           OVER (ORDER BY o.date) AS cumulative_revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY o.date
ORDER BY o.date;

WITH PizzaRevenue AS (
    SELECT pt.category,
           pt.name AS pizza_type,
           SUM(od.quantity * p.price) AS revenue
    FROM order_details od
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.category, pt.name
),
RankedRevenue AS (
    SELECT category, pizza_type, revenue,
           RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rank_no
    FROM PizzaRevenue
)
SELECT category, pizza_type, revenue
FROM RankedRevenue
WHERE rank_no <= 3
ORDER BY category, revenue DESC;