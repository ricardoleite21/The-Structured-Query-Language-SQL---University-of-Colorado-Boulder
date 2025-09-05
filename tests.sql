
-- Sanidade básica
SELECT 'customers' t, COUNT(*) cnt FROM customers
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items;

-- Regras de negócio
-- DELIVERED deve ter itens
SELECT o.order_id FROM orders o
LEFT JOIN order_items oi ON oi.order_id=o.order_id
WHERE o.status='DELIVERED'
GROUP BY o.order_id
HAVING COALESCE(SUM(CASE WHEN oi.order_item_id IS NOT NULL THEN 1 ELSE 0 END),0)=0;

-- CANCELLED não pode ter itens
SELECT o.order_id FROM orders o
JOIN order_items oi ON oi.order_id=o.order_id
WHERE o.status='CANCELLED';
