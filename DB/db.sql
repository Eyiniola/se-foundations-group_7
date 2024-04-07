-- Creating db for petstore

CREATE DATABASE pet_pal_db;

USE pet_pal_db;
-- users table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL
);
-- pets table
CREATE TABLE pets (
    pet_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    species VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    image_url VARCHAR(255)
);
-- accessories table
CREATE TABLE accessories (
    accessory_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    price DECIMAL(10, 2),
    image_url VARCHAR(255)
);
-- medicals table
CREATE TABLE medicals (
    medical_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    price DECIMAL(10, 2)
);
-- appointments table
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    appointment_id DATE,
    doctor_name VARCHAR(100),
    notes TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
-- immunizations table
CREATE TABLE immunizations (
    immunization_id INT AUTO_INCREMENT PRIMARY KEY,
    pet_id INT,
    immunization_name VARCHAR(100),
    immunization_date DATE,
    next_due_date DATE,
    FOREIGN KEY (pet_id) REFERENCES pets(pet_id)
);
-- reviews table
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    pet_id INT,
    review_date DATE,
    review_text TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (pet_id) REFERENCES pets(pet_id)
);
-- cart table
CREATE TABLE carts (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
-- cart_items table
CREATE TABLE cart_items (
    cart_item_id INT AUTO_INCREMENT PRIMARY KEY,
    cart_id INT,
    product_id INT,
    item_type ENUM('pet', 'accessory') NOT NULL,
    quantity INT,
    price_per_unit DECIMAL(10, 2),
    FOREIGN KEY (cart_id) REFERENCES cart(cart_id),
    FOREIGN KEY (product_id) REFERENCES pets(pet_id),
    FOREIGN KEY (product_id) REFERENCES accessories(accessory_id)
);
-- orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
-- order_items table
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    item_type ENUM('pet', 'accessory') NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES pets(pet_id),
    FOREIGN KEY (product_id) REFERENCES accessories(accessory_id)
);