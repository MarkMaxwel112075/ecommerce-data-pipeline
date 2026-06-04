#SQL — Create database
CREATE DATABASE IF NOT EXISTS ecommerce_pipeline;
USE ecommerce_pipeline;
#All tables below go inside this database

#SQL - customers table
CREATE TABLE customers (
customer_id VARCHAR(50) PRIMARY KEY,
customer_unique_id VARCHAR (50) NOT NULL,
zip_code VARCHAR (10),
city VARCHAR(100),
state CHAR(2),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

#SQL - sellers table
CREATE TABLE sellers (
seller_id VARCHAR(50) PRIMARY KEY,
zip_code VARCHAR(10),
city VARCHAR(100),
state CHAR(2),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

#SQL - products table
CREATE TABLE products(
product_id VARCHAR(50) PRIMARY KEY,
category_name VARCHAR(100),
category_name_english VARCHAR(100),
name_length INT,
description_length INT,
photos_qty INT,
weight_g DECIMAL(10,2),
length_cm DECIMAL(10,2),
height_cm DECIMAL(10,2),
width_cm DECIMAL(10,2),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

#SQL - orders table
CREATE TABLE orders (
order_id VARCHAR(50) PRIMARY KEY,
customer_id VARCHAR(50) NOT NULL,
order_status VARCHAR(20),
order_purchase_timestamp DATETIME,
order_approved_at DATETIME,
order_delivered_carrier_date DATETIME,
order_delivered_customer_date DATETIME,
ordered_estimated_delivery_date DATETIME,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

#SQL - order_items table
CREATE TABLE order_items (
order_id VARCHAR (50) NOT NULL,
order_item_id INT NOT NULL,
product_id VARCHAR(50) NOT NULL,
seller_id VARCHAR(50) NOT NULL,
shipping_date DATETIME,
price DECIMAL(10,2) NOT NULL,
freight_value DECIMAL(10,2),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (order_id, order_item_id),
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id),
FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

#SQL - order_payments table
CREATE TABLE order_payments (
order_id VARCHAR(50) NOT NULL,
payment_sequential INT NOT NULL,
payment_type VARCHAR(30),
payment_installments INT,
payment_value DECIMAL (10,2),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (order_id, payment_sequential),
FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

#SQL - order_reviews table
CREATE TABLE order_reviews (
review_id VARCHAR(50) PRIMARY KEY,
order_id VARCHAR(50) NOT NULL,
review_score INT,
review_comment_title VARCHAR(100),
review_comment_message TEXT,
review_creation_date DATETIME,
review_answer_timestamp DATETIME,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

#SQL - indexes
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_status ON orders(order_status);
CREATE INDEX idx_orders_purchase_dt ON orders(order_purchase_timestamp);
CREATE INDEX idx_items_product ON order_items(product_id);
CREATE INDEX idx_items_seller ON order_items(seller_id);
CREATE INDEX idx_payments_type ON order_payments(payment_type);
CREATE INDEX idx_reviews_score ON order_reviews(review_score);
CREATE INDEX idx_products_category ON products(category_name_english);