# 🛒 Zepto SQL Data Analysis Project

A complete SQL-based analysis project to understand order patterns, customer behavior, delivery performance, and operational efficiency for a quick-commerce company like **Zepto / Blinkit / Swiggy Instamart**.

## 📂 Project Structure
```
├── zepto_sql/             → SQL queries used for analysis
├── zepto_data.xlsx        → Dataset (orders, customers, products, delivery, riders)
└── README.md              → Project documentation
```

## 📊 Project Overview
Zepto-style quick commerce platforms rely on ultra-fast delivery, inventory planning, and customer retention.  
This project explores:
- Operational efficiency  
- Customer ordering patterns  
- Revenue insights  
- Delivery partner performance  
- Area-wise demand  

## 🗂️ Dataset Description

### customers
| customer_id | name | location |

### orders
| order_id | customer_id | order_date | status | payment_method |

### order_items
| order_item_id | order_id | product_id | quantity | unit_price |

### products
| product_id | product_name | category | price |

### delivery_time
| order_id | delivery_partner_id | dispatch_time | delivered_time |

### delivery_partners
| partner_id | name | rating |

## 🎯 Objectives
- Identify top customers  
- Evaluate delivery efficiency  
- Analyze category performance  
- Study repeat customer behavior  
- Revenue analysis  

## 🧠 Key SQL Queries

### Top 5 Customers by Spending
```sql
SELECT o.customer_id,
       SUM(oi.quantity * oi.unit_price) AS total_spending
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY total_spending DESC
LIMIT 5;
```

### Average Delivery Time
```sql
SELECT AVG(TIMESTAMPDIFF(MINUTE, dispatch_time, delivered_time)) AS avg_delivery_time
FROM delivery_time;
```

### Best-Selling Products
```sql
SELECT product_id,
       SUM(quantity) AS total_quantity
FROM order_items
GROUP BY product_id
ORDER BY total_quantity DESC;
```

### Repeat Customers
```sql
SELECT customer_id,
       COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING total_orders > 1;
```

### Delivery Partner Performance
```sql
SELECT d.partner_id, d.name,
       AVG(TIMESTAMPDIFF(MINUTE, dispatch_time, delivered_time)) AS avg_delivery_time
FROM delivery_partners d
JOIN delivery_time t ON d.partner_id = t.delivery_partner_id
GROUP BY d.partner_id, d.name
ORDER BY avg_delivery_time ASC;
```

## 📈 Key Insights
- Top customers contribute majority revenue  
- Delivery performance varies by region and time  
- Evening hours show peak order trends  
- Fast-moving SKUs dominate category sales  

## 🧑‍💻 Tools Used
- MySQL / PostgreSQL  
- Excel  
- GitHub  

## 📝 How to Run
1. Clone repo  
2. Import Excel files  
3. Execute SQL queries  
4. Analyze insights  

## ⭐ Author  
Abhishek chandola 
Data Analyst passionate about SQL & BI.

If you like the project, ⭐ star the repo!
