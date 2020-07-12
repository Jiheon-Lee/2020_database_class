DROP DATABASE oliveyoung;
CREATE DATABASE oliveyoung;
USE oliveyoung;

CREATE TABLE membership(
	membershipID INT NOT NULL,
    membershipGrade VARCHAR(20),
    membershipPoint INT,
    PRIMARY KEY(membershipID)
);

CREATE TABLE customers(
    customerID VARCHAR(30) NOT NULL,
    customerPassword VARCHAR(30) UNIQUE,
    membershipID INT NOT NULL,
    customerName VARCHAR(30),
    gender ENUM('M', 'F'),
    email VARCHAR(30),
    phone VARCHAR(30),
    address VARCHAR(50),
    PRIMARY KEY(customerID),
	FOREIGN KEY(membershipID)
      REFERENCES membership(membershipID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE suppliers(
    supplierID INT NOT NULL AUTO_INCREMENT,
    companyName VARCHAR(30),
    contactName VARCHAR(20),
    phone VARCHAR(30),
    address VARCHAR(50),
    fax VARCHAR(30),
    PRIMARY KEY(supplierID)
);

CREATE TABLE products(
    productID INT NOT NULL AUTO_INCREMENT,
    productName VARCHAR(50),
    categoryName VARCHAR(30),
    price DECIMAL(7, 0),
    descriptions LONGTEXT,
    image BLOB,
    inventoryQuantity INT,
    discount DECIMAL(3, 2),
    discontinued BOOLEAN,
    PRIMARY KEY(productID)
);

CREATE TABLE orders(
    orderID INT NOT NULL AUTO_INCREMENT,
    customerID VARCHAR(30) NOT NULL,
    productID INT NOT NULL,
    orderDate DATE,
    totalDiscount DECIMAL(3, 2),
    paymentAmount DECIMAL(7, 0),
    shippedDate DATE,
    shippingCharge DECIMAL(7, 0),
    PRIMARY KEY(orderID),
    FOREIGN KEY(customerID)
      REFERENCES customers(customerID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(productID)
      REFERENCES products(productID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE supplyProducts(
    supplyID INT NOT NULL AUTO_INCREMENT,
    supplierID INT NOT NULL,
    productID INT NOT NULL,
    companyName VARCHAR(30),
    paymentAmount DECIMAL(10, 0),
    productName VARCHAR(50),
    Quantity INT,
    price DECIMAL(7, 0),
    PRIMARY KEY(supplyID),
    FOREIGN KEY(productID)
      REFERENCES products(productID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(supplierID)
      REFERENCES suppliers(supplierID) ON DELETE CASCADE ON UPDATE CASCADE
);