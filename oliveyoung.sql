DROP DATABASE oliveyoung;
CREATE DATABASE oliveyoung;
USE oliveyoung;

CREATE TABLE membership(
	membershipID INT NOT NULL,
    membershipName VARCHAR(20),
    PRIMARY KEY(membershipID)
);

CREATE TABLE customers(
    customerID VARCHAR(30) NOT NULL,
    customerPassword VARCHAR(30) UNIQUE,
    membershipID INT NOT NULL,
    customerName VARCHAR(30) NOT NULL,
    juminNumber VARCHAR(20) NOT NULL,
    gender ENUM('M', 'F'),
    email VARCHAR(30),
    phone VARCHAR(30) NOT NULL,
    address VARCHAR(50) NOT NULL,
    PRIMARY KEY(customerID),
	FOREIGN KEY(membershipID)
      REFERENCES membership(membershipID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE coupon(
    couponID INT NOT NULL AUTO_INCREMENT,
    couponName VARCHAR(50),
    startDate DATE, 
    endDate DATE,
    couponType INT,
    discount DECIMAL(3, 2),
    PRIMARY KEY(couponID)
);

CREATE TABLE customersCoupon(
	couponCode VARCHAR(30) NOT NULL,
    customerID VARCHAR(30) NOT NULL,
    couponID INT NOT NULL,
    IssueDate DATE,
    usageStatus BOOLEAN,
    PRIMARY KEY(couponCode),
    FOREIGN KEY(customerID)
      REFERENCES customers(customerID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(couponID)
      REFERENCES coupon(couponID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE categories(
    categoryID INT NOT NULL AUTO_INCREMENT,
    categoryName VARCHAR(20),
    PRIMARY KEY(categoryID)
);

CREATE TABLE suppliers(
    supplierID INT NOT NULL AUTO_INCREMENT,
    companyName VARCHAR(30),
    contactName VARCHAR(20),
    contactTitle VARCHAR(30),
    address VARCHAR(50),
    phone VARCHAR(30),
    fax VARCHAR(30),
    PRIMARY KEY(supplierID)
);

CREATE TABLE products(
    productID INT NOT NULL AUTO_INCREMENT,
    productName VARCHAR(50),
    categoryID INT NOT NULL,
    supplierID INT NOT NULL,
    Price DECIMAL(7, 0),
    descriptions LONGTEXT,
    image BLOB,
    inventoryQuantity INT,
    discount DECIMAL(3, 2),
    discontinued BOOLEAN,
    PRIMARY KEY(productID),
    FOREIGN KEY(categoryID)
      REFERENCES categories(categoryID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE comments(
	commentID INT NOT NULL AUTO_INCREMENT,
    customerID VARCHAR(30) NOT NULL,
    productID INT NOT NULL,
    title VARCHAR(50),
    descriptions VARCHAR(255),
    reviewScore DECIMAL(2, 2),
    image BLOB,
    PRIMARY KEY(commentID),
    FOREIGN KEY(customerID)
      REFERENCES customers(customerID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(productID)
      REFERENCES products(productID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE commentDetails(
	commentDetailID INT NOT NULL AUTO_INCREMENT,
    commentID INT NOT NULL,
    reply VARCHAR(255),
    PRIMARY KEY(commentDetailID),
    FOREIGN KEY(commentID)
      REFERENCES comments(commentID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE supplyProducts(
    supplyID INT NOT NULL AUTO_INCREMENT,
    productID INT NOT NULL,
    supplierID INT NOT NULL,
    Quantity INT,
    paymentAmount DECIMAL(10, 0),
    deliveryStatus BOOLEAN,
    PRIMARY KEY(supplyID),
    FOREIGN KEY(productID)
      REFERENCES products(productID) ON DELETE CASCADE ON UPDATE CASCADE,
	 FOREIGN KEY(supplierID)
      REFERENCES suppliers(supplierID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE shippers(
    shipperID INT NOT NULL AUTO_INCREMENT,
    companyName VARCHAR(30),
    contactName VARCHAR(20),
    phone VARCHAR(30),
    PRIMARY KEY(shipperID)
);

CREATE TABLE orders(
    orderID INT NOT NULL AUTO_INCREMENT,
    customerID VARCHAR(30) NOT NULL,
    shipperID INT NOT NULL,
    orderDate DATE,
    totalDiscount DECIMAL(3, 2),
    paymentAmount DECIMAL(7, 0),
    shippedDate DATE,
    shipAdress VARCHAR(50),
    shippingCharge DECIMAL(7, 0),
    PRIMARY KEY(orderID),
    FOREIGN KEY(customerID)
      REFERENCES customers(customerID) ON DELETE CASCADE ON UPDATE CASCADE,
	 FOREIGN KEY(shipperID)
      REFERENCES shippers(shipperID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE status(
	statusID INT NOT NULL,
    statusName VARCHAR(30),
    PRIMARY KEY(statusID)
);

CREATE TABLE orderStatus(
	orderID INT NOT NULL,
	statusID INT NOT NULL,
    FOREIGN KEY(orderID)
      REFERENCES orders(orderID) ON DELETE CASCADE ON UPDATE CASCADE,
	 FOREIGN KEY(statusID)
      REFERENCES status(statusID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE orderDetails(
    orderID INT NOT NULL,
    productID INT NOT NULL,
    Quantity INT,
    FOREIGN KEY(orderID)
      REFERENCES orders(orderID) ON DELETE CASCADE ON UPDATE CASCADE,
	 FOREIGN KEY(productID)
      REFERENCES products(productID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE event(
	eventID INT NOT NULL AUTO_INCREMENT,
    eventType VARCHAR(30),
    startDate DATE, 
    endDate DATE,
    desciption VARCHAR(255),
    image BLOB,
    PRIMARY KEY(eventID)
);