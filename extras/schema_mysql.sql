
-- MySQL 8+ (InnoDB) com triggers equivalentes
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(120) UNIQUE NOT NULL,
  city VARCHAR(60), state CHAR(2), created_at DATE NOT NULL
) ENGINE=InnoDB;

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  category VARCHAR(50) NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price>=0),
  active BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE=InnoDB;

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATE NOT NULL,
  status VARCHAR(20) NOT NULL,
  CONSTRAINT chk_status CHECK (status IN ('PLACED','SHIPPED','DELIVERED','CANCELLED')),
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
) ENGINE=InnoDB;

CREATE TABLE order_items (
  order_item_id INT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL CHECK (quantity>0),
  unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price>=0),
  CONSTRAINT fk_items_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
  CONSTRAINT fk_items_product FOREIGN KEY (product_id) REFERENCES products(product_id)
) ENGINE=InnoDB;

CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_items_product  ON order_items(product_id);
CREATE INDEX idx_orders_date    ON orders(order_date);

DELIMITER //
CREATE TRIGGER trg_validate_delivered_before
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
  IF NEW.status='DELIVERED' THEN
    IF NOT EXISTS (SELECT 1 FROM order_items WHERE order_id=NEW.order_id) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Pedido entregue sem itens';
    END IF;
  END IF;
END//
CREATE TRIGGER trg_validate_delivered_update
BEFORE UPDATE ON orders
FOR EACH ROW
BEGIN
  IF NEW.status='DELIVERED' THEN
    IF NOT EXISTS (SELECT 1 FROM order_items WHERE order_id=NEW.order_id) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Pedido entregue sem itens';
    END IF;
  END IF;
END//
CREATE TRIGGER trg_validate_cancelled_before
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
  IF NEW.status='CANCELLED' THEN
    IF EXISTS (SELECT 1 FROM order_items WHERE order_id=NEW.order_id) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Pedido cancelado não pode ter itens';
    END IF;
  END IF;
END//
CREATE TRIGGER trg_validate_cancelled_update
BEFORE UPDATE ON orders
FOR EACH ROW
BEGIN
  IF NEW.status='CANCELLED' THEN
    IF EXISTS (SELECT 1 FROM order_items WHERE order_id=NEW.order_id) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Pedido cancelado não pode ter itens';
    END IF;
  END IF;
END//
DELIMITER ;
