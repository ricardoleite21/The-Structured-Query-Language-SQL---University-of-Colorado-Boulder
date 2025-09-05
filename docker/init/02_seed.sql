-- Seed de exemplo
INSERT INTO customers (customer_id, full_name, email, city, state, created_at) VALUES
  (1, 'Ana Souza', 'ana.souza@example.com', 'São Paulo', 'SP', '2024-01-05'),
  (2, 'Bruno Lima', 'bruno.lima@example.com', 'Rio de Janeiro', 'RJ', '2024-02-14'),
  (3, 'Carla Nunes', 'carla.nunes@example.com', 'Belo Horizonte', 'MG', '2024-03-02'),
  (4, 'Diego Alves', 'diego.alves@example.com', 'Curitiba', 'PR', '2024-03-18'),
  (5, 'Eduarda Faria', 'eduarda.faria@example.com', 'Salvador', 'BA', '2024-04-01'),
  (6, 'Felipe Costa', 'felipe.costa@example.com', 'Fortaleza', 'CE', '2024-04-22'),
  (7, 'Gabriela Dias', 'gabriela.dias@example.com', 'Porto Alegre', 'RS', '2024-05-10'),
  (8, 'Henrique Rocha', 'henrique.rocha@example.com', 'Campinas', 'SP', '2024-06-06');

INSERT INTO products (product_id, product_name, category, unit_price, active) VALUES
  (101, 'Notebook 14"', 'Eletrônicos', 3500.0, True),
  (102, 'Mouse Óptico', 'Acessórios', 60.0, True),
  (103, 'Teclado Mecânico', 'Acessórios', 420.0, True),
  (104, 'Monitor 27"', 'Eletrônicos', 1800.0, True),
  (105, 'Cabo HDMI 2m', 'Acessórios', 35.0, True),
  (106, 'Headset USB', 'Acessórios', 220.0, True);

INSERT INTO orders (order_id, customer_id, order_date, status) VALUES
  (1001, 1, '2025-07-01', 'DELIVERED'),
  (1002, 2, '2025-07-02', 'DELIVERED'),
  (1003, 1, '2025-07-08', 'SHIPPED'),
  (1004, 3, '2025-07-10', 'CANCELLED'),
  (1005, 4, '2025-07-11', 'DELIVERED'),
  (1006, 5, '2025-07-12', 'DELIVERED'),
  (1007, 6, '2025-07-15', 'PLACED'),
  (1008, 7, '2025-07-18', 'DELIVERED'),
  (1009, 8, '2025-07-20', 'DELIVERED'),
  (1010, 3, '2025-07-22', 'DELIVERED'),
  (1011, 2, '2025-07-24', 'DELIVERED'),
  (1012, 4, '2025-07-25', 'SHIPPED');

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
  (1.0, 1001.0, 101.0, 1.0, 3500.0),
  (2.0, 1001.0, 102.0, 1.0, 60.0),
  (3.0, 1002.0, 104.0, 1.0, 1800.0),
  (4.0, 1002.0, 105.0, 2.0, 35.0),
  (5.0, 1003.0, 103.0, 1.0, 420.0),
  (6.0, 1003.0, 105.0, 1.0, 35.0),
  (7.0, 1004.0, 101.0, 1.0, 3500.0),
  (8.0, 1005.0, 106.0, 2.0, 220.0),
  (9.0, 1006.0, 102.0, 1.0, 60.0),
  (10.0, 1006.0, 103.0, 1.0, 420.0),
  (11.0, 1007.0, 105.0, 3.0, 35.0),
  (12.0, 1008.0, 104.0, 2.0, 1800.0),
  (13.0, 1009.0, 101.0, 1.0, 3500.0),
  (14.0, 1009.0, 106.0, 1.0, 220.0),
  (15.0, 1010.0, 102.0, 2.0, 60.0),
  (16.0, 1010.0, 105.0, 2.0, 35.0),
  (17.0, 1011.0, 103.0, 1.0, 420.0),
  (18.0, 1011.0, 104.0, 1.0, 1800.0),
  (19.0, 1012.0, 106.0, 1.0, 220.0),
  (20.0, 1012.0, 101.0, 1.0, 3500.0),
  (21.0, 1005.0, 105.0, 1.0, 35.0),
  (22.0, 1008.0, 102.0, 1.0, 60.0),
  (23.0, 1002.0, 106.0, 1.0, 220.0),
  (24.0, 1006.0, 104.0, 1.0, 1800.0);
