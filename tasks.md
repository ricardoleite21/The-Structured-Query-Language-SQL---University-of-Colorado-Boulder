# Desafios (RetailX)

## SELECT
1) Produtos ativos (id, nome, preço) por preço desc.
2) Top 3 mais caros.
3) Clientes criados em 2024-04.

## Agregações/Subtotais
4) Total de pedidos por status.
5) Receita por categoria.
6) Ticket médio por pedido (2 casas).
7) Métricas por produto: qty total, receita, preço médio ponderado.

## Subqueries
8) Produtos acima do preço médio.
9) Clientes que nunca compraram.
10) Pedidos acima do valor médio.

## JOINs
11) Para cada pedido: id, data, cliente, total.
12) Top 5 cidades por faturamento.
13) Produto de maior receita por categoria.
14) Pedidos com >= 2 categorias distintas.
15) View `vw_order_totals` com total do pedido.

## DDL/Índices/Constraints
16) Regra: `DELIVERED` exige itens (descrever trigger/cheque).
17) Índice composto `order_items(order_id, product_id)` — quando usar?
18) View `vw_customer_ltv` (LTV por cliente).

## Extra/Performance
19) Receita por mês para 2025-07 com funções ANSI.
20) Estratégia para `CANCELLED` com total 0 (exemplo + validação).
