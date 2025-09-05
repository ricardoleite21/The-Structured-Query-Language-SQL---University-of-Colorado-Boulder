
-- PostgreSQL-specific (inclui triggers de regras de negócio)
CREATE TABLE IF NOT EXISTS customers (
  customer_id INTEGER PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(120) UNIQUE NOT NULL,
  city VARCHAR(60), state CHAR(2), created_at DATE NOT NULL
);
CREATE TABLE IF NOT EXISTS products (
  product_id INTEGER PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  category VARCHAR(50) NOT NULL,
  unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price>=0),
  active BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE TABLE IF NOT EXISTS orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
  order_date DATE NOT NULL,
  status VARCHAR(20) NOT NULL CHECK (status IN ('PLACED','SHIPPED','DELIVERED','CANCELLED'))
);
CREATE TABLE IF NOT EXISTS order_items (
  order_item_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL REFERENCES orders(order_id),
  product_id INTEGER NOT NULL REFERENCES products(product_id),
  quantity INTEGER NOT NULL CHECK (quantity>0),
  unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price>=0)
);

CREATE INDEX IF NOT EXISTS idx_orders_customer ON orders(customer_id);
CREATE INDEX IF NOT EXISTS idx_items_product  ON order_items(product_id);
CREATE INDEX IF NOT EXISTS idx_orders_date    ON orders(order_date);

CREATE OR REPLACE FUNCTION trg_validate_delivered_fn()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.status='DELIVERED' THEN
    IF NOT EXISTS (SELECT 1 FROM order_items WHERE order_id=NEW.order_id) THEN
      RAISE EXCEPTION 'Pedido entregue sem itens (%).', NEW.order_id;
    END IF;
  END IF;
  RETURN NEW;
END; $$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_validate_delivered ON orders;
CREATE TRIGGER trg_validate_delivered
BEFORE INSERT OR UPDATE ON orders
FOR EACH ROW EXECUTE FUNCTION trg_validate_delivered_fn();

CREATE OR REPLACE FUNCTION trg_validate_cancelled_fn()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.status='CANCELLED' THEN
    IF EXISTS (SELECT 1 FROM order_items WHERE order_id=NEW.order_id) THEN
      RAISE EXCEPTION 'Pedido cancelado não pode ter itens (%).', NEW.order_id;
    END IF;
  END IF;
  RETURN NEW;
END; $$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_validate_cancelled ON orders;
CREATE TRIGGER trg_validate_cancelled
BEFORE INSERT OR UPDATE ON orders
FOR EACH ROW EXECUTE FUNCTION trg_validate_cancelled_fn();
