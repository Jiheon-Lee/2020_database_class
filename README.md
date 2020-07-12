# 2020_database_class
2020년도 1학기 가천대학교 소프트웨어학과 데이터베이스 수업 팀 프로젝트입니다.
하나의 기업으로 올리브영 온라인 몰을 선정하여 업무들을 파악하고 데이터베이스 실무 설계를 진행합니다.

### 수정 전 (MySQL)

- **논리적 데이터 모델 ERD**<br>
![7조_올리브영쇼핑몰_논리적모델_ERD_수정전](https://user-images.githubusercontent.com/48443734/87250195-3b7ac580-c49e-11ea-9ff2-071ec1571fc4.png)

- **DataBase create code**
```sql
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
    customerName VARCHAR(30),
    juminNumber VARCHAR(20),
    gender ENUM('M', 'F'),
    email VARCHAR(30),
    phone VARCHAR(30),
    address VARCHAR(50),
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
    price DECIMAL(7, 0),
    descriptions LONGTEXT,
    image BLOB,
    inventoryQuantity INT,
    discount DECIMAL(3, 2),
    discontinued BOOLEAN,
    PRIMARY KEY(productID),
    FOREIGN KEY(categoryID)
      REFERENCES categories(categoryID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(supplierID)
      REFERENCES suppliers(supplierID) ON DELETE CASCADE ON UPDATE CASCADE
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
```

- **물리적 데이터 모델 ERD**<br>
![oliveyoung_ERD](https://user-images.githubusercontent.com/48443734/87250265-9f04f300-c49e-11ea-8eda-7689368a9db6.png)

### 교수님의 피드백으로 수정 (MySQL)
- **논리적 데이터 모델 ERD**<br>
![논리적_모델_ERD_최종](https://user-images.githubusercontent.com/48443734/87250357-323e2880-c49f-11ea-8220-88549c31c3ea.PNG)

- **DataBase create code**
```sql
CREATE DATABASE oliveyoung;
USE oliveyoung;

CREATE TABLE customers(
    customerID VARCHAR(30) NOT NULL,
    customerPassword VARCHAR(30) UNIQUE,
    customerName VARCHAR(30),
    gender ENUM('M', 'F'),
    email VARCHAR(30),
    address VARCHAR(50),
    phone VARCHAR(30),
    membershipPoint INT,
    PRIMARY KEY(customerID)
);

CREATE TABLE products(
    productID INT NOT NULL AUTO_INCREMENT,
    productName VARCHAR(50),
    category VARCHAR(30),
    price DECIMAL(7, 0),
    descriptions LONGTEXT,
    image BLOB,
    inventoryQuantity INT,
    discount DECIMAL(3, 2),
    discontinued BOOLEAN,
    shippingCharge DECIMAL(7, 0),
    PRIMARY KEY(productID)
);

CREATE TABLE orders(
    orderID INT NOT NULL AUTO_INCREMENT,
    orderDate DATE,
    customerID VARCHAR(30) NOT NULL,
    customerName VARCHAR(30),
    phone VARCHAR(30),
    membershipPoint INT,
    shippingAddress VARCHAR(50),
    shippedDate DATE,
    productID INT NOT NULL,
    productName VARCHAR(50),
    productPrice DECIMAL(7, 0),
    quantity INT,
    totalAmount DECIMAL(7, 0),
    PRIMARY KEY(orderID),
    FOREIGN KEY(customerID)
      REFERENCES customers(customerID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(productID)
      REFERENCES products(productID) ON DELETE CASCADE ON UPDATE CASCADE
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

CREATE TABLE purchaseProducts(
    purchaseID INT NOT NULL AUTO_INCREMENT,
    purchaseDate DATE,
    supplierID INT NOT NULL,
    companyName VARCHAR(30),
    contactName VARCHAR(20),
    phone VARCHAR(30),
    productID INT NOT NULL,
    productName VARCHAR(50),
    productPrice DECIMAL(7, 0),
    Quantity INT,
    totalAmount DECIMAL(7, 0),
    PRIMARY KEY(purchaseID),
    FOREIGN KEY(productID)
      REFERENCES products(productID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(supplierID)
      REFERENCES suppliers(supplierID) ON DELETE CASCADE ON UPDATE CASCADE
);
```

- **물리적 데이터 모델 ERD**<br>
![올리브영_DB_ERD_최종](https://user-images.githubusercontent.com/48443734/87250330-06bb3e00-c49f-11ea-849b-7d6ec449a838.png)

프로젝트 참여자
---------------
- 가천대학교 산업경영공학과 윤석
- 가천대학교 산업경영공학과 이지헌
- 가천대학교 경영학과 이은빈
- 가천대학교 경영학과 하현주
