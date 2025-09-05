
CREATE TABLE customers (
  customer_id    INTEGER PRIMARY KEY,
  full_name      VARCHAR(100) NOT NULL,
  email          VARCHAR(120) UNIQUE NOT NULL,
  city           VARCHAR(60),
  state          VARCHAR(2),
  created_at     DATE NOT NULL
);

CREATE TABLE products (
  product_id     INTEGER PRIMARY KEY,
  product_name   VARCHAR(100) NOT NULL,
  category       VARCHAR(50)  NOT NULL,
  unit_price     DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
  active         BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE orders (
  order_id       INTEGER PRIMARY KEY,
  customer_id    INTEGER NOT NULL,
  order_date     DATE NOT NULL,
  status         VARCHAR(20) NOT NULL CHECK (status IN ('PLACED','SHIPPED','DELIVERED','CANCELLED')),
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
  order_item_id  INTEGER PRIMARY KEY,
  order_id       INTEGER NOT NULL,
  product_id     INTEGER NOT NULL,
  quantity       INTEGER NOT NULL CHECK (quantity > 0),
  unit_price     DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
  CONSTRAINT fk_items_order   FOREIGN KEY (order_id)  REFERENCES orders(order_id),
  CONSTRAINT fk_items_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_items_product  ON order_items(product_id);
CREATE INDEX idx_orders_date    ON orders(order_date);
