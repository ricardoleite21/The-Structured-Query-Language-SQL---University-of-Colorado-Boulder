-- Exemplos de respostas (ANSI-like)
-- 1
SELECT product_id, product_name, unit_price
FROM products
WHERE active = TRUE
ORDER BY unit_price DESC, product_id;

-- 2
SELECT product_id, product_name, unit_price
FROM products
WHERE active = TRUE
ORDER BY unit_price DESC, product_id
FETCH FIRST 3 ROWS ONLY;

-- 3
SELECT * FROM customers
WHERE created_at >= DATE '2024-04-01' AND created_at < DATE '2024-05-01';

-- 4
SELECT status, COUNT(*) total FROM orders GROUP BY status;

-- 5
SELECT p.category, SUM(oi.quantity * oi.unit_price) receita
FROM order_items oi JOIN products p ON p.product_id = oi.product_id
GROUP BY p.category ORDER BY receita DESC;

-- 6
WITH order_totals AS (
  SELECT order_id, SUM(quantity*unit_price) total
  FROM order_items GROUP BY order_id
)
SELECT CAST(AVG(total) AS DECIMAL(10,2)) ticket_medio FROM order_totals;

-- 7
SELECT product_id,
       SUM(quantity) qty_total,
       SUM(quantity*unit_price) receita_total,
       CAST(SUM(quantity*unit_price)/NULLIF(SUM(quantity),0) AS DECIMAL(10,2)) preco_medio_ponderado
FROM order_items GROUP BY product_id;

-- 8
SELECT * FROM products
WHERE unit_price > (SELECT AVG(unit_price) FROM products);

-- 9
SELECT c.* FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;

-- 10
WITH order_totals AS (
  SELECT order_id, SUM(quantity*unit_price) total
  FROM order_items GROUP BY order_id
), avg_total AS (
  SELECT AVG(total) avg_total FROM order_totals
)
SELECT ot.* FROM order_totals ot, avg_total a
WHERE ot.total > a.avg_total;

-- 11
WITH order_totals AS (
  SELECT order_id, SUM(quantity*unit_price) total
  FROM order_items GROUP BY order_id
)
SELECT o.order_id, o.order_date, c.full_name, ot.total
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN order_totals ot ON ot.order_id = o.order_id;

-- 12
WITH city_rev AS (
  SELECT c.city, SUM(oi.quantity*oi.unit_price) receita
  FROM order_items oi
  JOIN orders o ON o.order_id=oi.order_id
  JOIN customers c ON c.customer_id=o.customer_id
  GROUP BY c.city
)
SELECT * FROM city_rev ORDER BY receita DESC FETCH FIRST 5 ROWS ONLY;

-- 13
WITH prod_rev AS (
  SELECT p.category, p.product_id, p.product_name,
         SUM(oi.quantity*oi.unit_price) receita
  FROM order_items oi JOIN products p ON p.product_id=oi.product_id
  GROUP BY p.category, p.product_id, p.product_name
), ranked AS (
  SELECT pr.*,
         DENSE_RANK() OVER (PARTITION BY category ORDER BY receita DESC, product_id) rnk
  FROM prod_rev pr
)
SELECT category, product_id, product_name, receita
FROM ranked WHERE rnk=1;

-- 14
WITH cats AS (
  SELECT oi.order_id, COUNT(DISTINCT p.category) cat_count
  FROM order_items oi JOIN products p ON p.product_id=oi.product_id
  GROUP BY oi.order_id
)
SELECT o.order_id, o.order_date, c.full_name, cat_count
FROM cats JOIN orders o ON o.order_id=cats.order_id
JOIN customers c ON c.customer_id=o.customer_id
WHERE cat_count >= 2;

-- 15
CREATE VIEW vw_order_totals AS
SELECT o.order_id, o.customer_id, o.order_date,
       SUM(oi.quantity*oi.unit_price) total_value
FROM orders o JOIN order_items oi ON oi.order_id=o.order_id
GROUP BY o.order_id, o.customer_id, o.order_date;

-- 17
CREATE INDEX idx_items_order_product ON order_items(order_id, product_id);

-- 18
CREATE VIEW vw_customer_ltv AS
SELECT c.customer_id, c.full_name,
       COALESCE(SUM(oi.quantity*oi.unit_price),0) ltv
FROM customers c
LEFT JOIN orders o ON o.customer_id=c.customer_id
LEFT JOIN order_items oi ON oi.order_id=o.order_id
GROUP BY c.customer_id, c.full_name;

-- 19
SELECT EXTRACT(YEAR FROM DATE '2025-07-01') yr,
       EXTRACT(MONTH FROM DATE '2025-07-01') mon,
       SUM(oi.quantity*oi.unit_price) receita
FROM order_items oi JOIN orders o ON o.order_id=oi.order_id
WHERE o.order_date >= DATE '2025-07-01' AND o.order_date < DATE '2025-08-01'
GROUP BY EXTRACT(YEAR FROM DATE '2025-07-01'),
         EXTRACT(MONTH FROM DATE '2025-07-01');

-- 16 e 20: ver triggers nos esquemas específicos (Postgres/MySQL) para validar regras de negócio.
