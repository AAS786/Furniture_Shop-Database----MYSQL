Create database Furniture_shop;
use Furniture_shop;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PhoneNumber VARCHAR(15),
    Address VARCHAR(255)
);

CREATE TABLE Furniture (
    FurnitureID INT PRIMARY KEY AUTO_INCREMENT,
    FurnitureName VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    MaterialType ENUM('Fabric', 'Wood', 'Metal', 'Leather', 'Glass', 'Plastic', 'Engineered Wood') NOT NULL, 
    Color VARCHAR(30),
    Size VARCHAR(30),
    Price DECIMAL(10, 2) NOT NULL,
    InStockQuantity INT NOT NULL,
    IsCustomizable BOOLEAN DEFAULT FALSE
);

CREATE TABLE CustomizationOptions (
    CustomizationID INT PRIMARY KEY AUTO_INCREMENT,
    FurnitureID INT,
    OptionType ENUM('Color', 'Material', 'Size', 'Fabric Type', 'Shelf Count', 'Glass Type', 'Wood Finish', 'Leather Type', 'Seat Type') NOT NULL,
    OptionDescription VARCHAR(100) NOT NULL,
    AdditionalCost DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (FurnitureID) REFERENCES Furniture(FurnitureID)
);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY  AUTO_INCREMENT,
    CustomerID INT,
    SalesPersonID int,
    OrderDate DATE NOT NULL  ,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    OrderStatus ENUM('Pending', 'In Progress', 'Completed', 'Shipped', 'Cancelled', 'Returned') NOT NULL,
    ReturnReason VARCHAR(255),  -- Add the ReturnReason colum
    DeliveryDate DATE,
    IsCustomized BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) 
);

CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT ,
    OrderID INT,
    FurnitureID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    CustomizationID INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ,
    FOREIGN KEY (FurnitureID) REFERENCES Furniture(FurnitureID) ,
    FOREIGN KEY (CustomizationID) REFERENCES CustomizationOptions(CustomizationID) 
);

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY  AUTO_INCREMENT,
    SupplierName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100) UNIQUE,
    Address VARCHAR(255),
    ProductType ENUM('Wood', 'Metal', 'Fabric', 'Foam & Cushions','Glass') NOT NULL
);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY AUTO_INCREMENT,
    FurnitureID INT,
    SupplierID INT,
    Quantity INT NOT NULL,
    RestockDate DATE,
    FOREIGN KEY (FurnitureID) REFERENCES Furniture(FurnitureID) ,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID) 
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT ,
    OrderID INT,
    PaymentDate DATE NOT NULL  ,
    AmountPaid DECIMAL(10, 2) NOT NULL,
    PaymentMethod ENUM('Debit Card', 'Cash', 'UPI') NOT NULL,
    PaymentStatus ENUM('Paid', 'Pending', 'Failed', 'Half_Paid' ) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Position ENUM('Salesperson', 'Designer', 'Delivery Staff', 'Cashier') NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(100) UNIQUE,
    salary DECIMAL(10, 2) NOT NULL
);

-- INSERT VALUES 

-- Customers
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, PhoneNumber, Address) VALUES
(1, 'Ramesh', 'Sharma', 'ramesh.sharma@gmail.com', '9876543210', 'Mumbai, Maharashtra'),
(2, 'Anjali', 'Verma', 'anjali.verma@gmail.com', '9123456789', 'New Delhi, Delhi'),
(3, 'Suresh', 'Patel', 'suresh.patel@gmail.com', '9988776655', 'Ahmedabad, Gujarat'),
(4, 'Priya', 'Singh', 'priya.singh@gmail.com', '9876501234', 'Jaipur, Rajasthan'),
(5, 'Vikas', 'Gupta', 'vikas.gupta@gmail.com', '9123498765', 'Pune, Maharashtra'),
(6, 'Neha', 'Kulkarni', 'neha.kulkarni@gmail.com', '9988771234', 'Nagpur, Maharashtra'),
(7, 'Ravi', 'Desai', 'ravi.desai@gmail.com', '9123487654', 'Surat, Gujarat'),
(8, 'Meera', 'Menon', 'meera.menon@gmail.com', '9876523456', 'Chennai, Tamil Nadu'),
(9, 'Amit', 'Agarwal', 'amit.agarwal@gmail.com', '9123409876', 'Kolkata, West Bengal'),
(10, 'Pooja', 'Rao', 'pooja.rao@gmail.com', '9988776543', 'Bangalore, Karnataka'),
(11, 'Rajesh', 'Mishra', 'rajesh.mishra@gmail.com', '9123432109', 'Lucknow, Uttar Pradesh'),
(12, 'Sneha', 'Yadav', 'sneha.yadav@gmail.com', '9876512345', 'Indore, Madhya Pradesh'),
(13, 'Ankit', 'Kapoor', 'ankit.kapoor@gmail.com', '9123498761', 'Chandigarh, Punjab'),
(14, 'Deepa', 'Reddy', 'deepa.reddy@gmail.com', '9876540987', 'Hyderabad, Telangana'),
(15, 'Nitin', 'Jain', 'nitin.jain@gmail.com', '9123456780', 'Noida, Uttar Pradesh'),
(16, 'Sakshi', 'Kumar', 'sakshi.kumar@gmail.com', '9988765432', 'Bhopal, Madhya Pradesh'),
(17, 'Kiran', 'Bose', 'kiran.bose@gmail.com', '9123401234', 'Patna, Bihar'),
(18, 'Ajay', 'Shetty', 'ajay.shetty@gmail.com', '9876532109', 'Thane, Maharashtra'),
(19, 'Geeta', 'Pillai', 'geeta.pillai@gmail.com', '9123478901', 'Kochi, Kerala'),
(20, 'Arjun', 'Nair', 'arjun.nair@gmail.com', '9876543211', 'Trivandrum, Kerala');


-- Furniture
INSERT INTO Furniture (FurnitureID, FurnitureName, Category, MaterialType, Color, Size, Price, InStockQuantity, IsCustomizable) VALUES
(1, 'Sofa Set', 'Sofa', 'Fabric', 'Blue', '3-seater', 25000, 5, TRUE),
(2, 'Dining Table', 'Table', 'Wood', 'Brown', '4-seater', 15000, 10, TRUE),
(3, 'Office Chair', 'Chair', 'Metal', 'Black', 'Standard', 5000, 15, FALSE),
(4, 'Double Bed', 'Bed', 'Wood', 'Mahogany', 'Queen size', 30000, 3, TRUE),
(5, 'Coffee Table', 'Table', 'Glass', 'Clear', 'Medium', 8000, 7, FALSE),
(6, 'Bookshelf', 'Shelf', 'Wood', 'Walnut', 'Tall', 12000, 8, TRUE),
(7, 'Recliner Sofa', 'Sofa', 'Leather', 'Brown', '2-seater', 35000, 4, TRUE),
(8, 'Bunk Bed', 'Bed', 'Metal', 'White', 'Twin size', 20000, 6, FALSE),
(9, 'Wardrobe', 'Storage', 'Wood', 'Oak', 'Large', 18000, 2, TRUE),
(10, 'Dining Chair', 'Chair', 'Wood', 'Dark Brown', 'Standard', 2500, 20, FALSE),
(11, 'TV Stand', 'Stand', 'Wood', 'Black', 'Medium', 7000, 9, FALSE),
(12, 'Armchair', 'Chair', 'Fabric', 'Gray', 'Single', 6000, 12, TRUE),
(13, 'Kitchen Cabinet', 'Cabinet', 'Wood', 'White', 'Large', 22000, 5, TRUE),
(14, 'Patio Table', 'Outdoor Table', 'Plastic', 'Green', '4-seater', 5000, 11, FALSE),
(15, 'Nightstand', 'Table', 'Wood', 'Teak', 'Small', 3000, 10, FALSE),
(16, 'Study Desk', 'Desk', 'Engineered Wood', 'White', 'Standard', 10000, 7, TRUE),
(17, 'Dresser', 'Storage', 'Wood', 'Cherry', 'Large', 15000, 6, TRUE),
(18, 'Bean Bag', 'Chair', 'Fabric', 'Red', 'Single', 2000, 25, FALSE),
(19, 'Display Cabinet', 'Cabinet', 'Glass', 'Transparent', 'Medium', 12000, 3, TRUE),
(20, 'Ottoman', 'Footrest', 'Leather', 'Cream', 'Small', 3500, 14, FALSE);


-- CustomizationOptions
INSERT INTO CustomizationOptions (CustomizationID, FurnitureID, OptionType, OptionDescription, AdditionalCost) VALUES
(1, 1, 'Color', 'Red', 1000),
(2, 2, 'Material', 'Teak Wood', 5000),
(3, 4, 'Size', 'King Size', 8000),
(4, 1, 'Fabric Type', 'Leather', 7000),
(5, 7, 'Color', 'Dark Gray', 1500),
(6, 9, 'Material', 'Pine Wood', 3000),
(7, 6, 'Shelf Count', '5 Shelves', 2000),
(8, 5, 'Glass Type', 'Tinted', 1200),
(9, 12, 'Fabric Type', 'Velvet', 2500),
(10, 13, 'Color', 'Matte Black', 1800),
(11, 17, 'Size', 'Extra Large', 5000),
(12, 10, 'Wood Finish', 'Glossy Finish', 700),
(13, 8, 'Color', 'Blue', 1000),
(14, 15, 'Material', 'Bamboo Wood', 1200),
(15, 18, 'Color', 'Yellow', 500),
(16, 19, 'Glass Type', 'Frosted Glass', 2000),
(17, 14, 'Color', 'Brown', 800),
(18, 20, 'Leather Type', 'Italian Leather', 3000),
(19, 7, 'Seat Type', 'Memory Foam', 4000),
(20, 16, 'Color', 'Dark Walnut', 1500);

-- Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, OrderStatus, ReturnReason, DeliveryDate, IsCustomized) VALUES
(1, 1, '2024-10-01', 28000, 'Completed', NULL, '2024-10-10', TRUE),
(2, 2, '2024-10-03', 5000, 'Pending', NULL, '2024-10-15', FALSE),
(3, 3, '2024-10-05', 38000, 'In Progress', NULL, '2024-10-20', TRUE),
(4, 4, '2024-10-07', 15000, 'Completed', NULL, '2024-10-15', FALSE),
(5, 5, '2024-10-08', 22000, 'Pending', NULL, '2024-10-18', TRUE),
(6, 6, '2024-10-09', 12000, 'Completed', NULL, '2024-10-16', FALSE),
(7, 7, '2024-10-10', 7000, 'In Progress', NULL, '2024-10-22', FALSE),
(8, 8, '2024-10-11', 50000, 'Shipped', NULL, '2024-10-25', TRUE),
(9, 9, '2024-10-12', 2500, 'Cancelled', NULL, '2024-10-20',FALSE),
(10, 10, '2024-10-21', 27500, 'Pending', NULL, '2024-10-31', TRUE),
(11, 11, '2024-10-22', 4800, 'Completed', NULL, '2024-10-29', FALSE),
(12, 12, '2024-10-23', 5200, 'Cancelled', NULL, '2024-10-30', FALSE),
(13, 12, '2024-10-24', 15000, 'Returned', 'Customer Changed Mind', NULL, TRUE),
(14, 14, '2024-10-25', 20000, 'Returned', 'Damaged During Delivery', NULL, FALSE),
(15, 15, '2024-10-26', 12000, 'Returned', 'Received Wrong Item', NULL, TRUE),
(16, 16, '2024-10-27', 45000, 'Returned', 'Item Not as Described', NULL, FALSE),
(17, 17, '2024-10-28', 30000, 'Returned', 'Defective Product', NULL, TRUE),
(18, 18, '2024-10-29', 25000, 'Returned', 'Color Did Not Match Expectation', NULL, FALSE),
(19, 19, '2024-10-30', 18000, 'Returned', 'Quality Not as Expected', NULL, TRUE),
(20, 20, '2024-10-31', 16000, 'Returned', 'Incompatible with Existing Furniture', NULL, FALSE);




-- OrderItems
INSERT INTO OrderItems (OrderItemID, OrderID, FurnitureID, Quantity, UnitPrice, TotalPrice, CustomizationID) VALUES
(1, 1, 1, 1, 25000, 28000, 1),
(2, 2, 3, 1, 5000, 5000, NULL),
(3, 3, 4, 1, 30000, 38000, 3),
(4, 4, 2, 1, 15000, 15000, NULL),
(5, 5, 5, 2, 8000, 18000, 8),
(6, 6, 7, 1, 7000, 7000, NULL),
(7, 7, 8, 1, 50000, 50000, 10),
(8, 8, 9, 3, 2500, 7500, NULL),
(9, 9, 6, 1, 12000, 12000, NULL),
(10, 10, 11, 1, 18000, 20000, 11),
(11, 11, 13, 1, 8000, 8000, NULL),
(12, 12, 14, 1, 45000, 53000, 14),
(13, 13, 15, 1, 12000, 12000, NULL),
(14, 14, 16, 2, 1100, 2200, NULL),
(15, 15, 17, 1, 6000, 7000, 17),
(16, 16, 18, 1, 33000, 38000, 18),
(17, 17, 20, 1, 12500, 15500, 20),
(18, 18, 19, 2, 2400, 4800, NULL),
(19, 19, 12, 1, 4500, 5200, 12),
(20, 20, 10, 1, 5000, 5000, NULL);


-- Suppliers
INSERT INTO Suppliers (SupplierID, SupplierName, ContactName, Phone, Email, Address, ProductType) VALUES
(1, 'Royal Woods', 'Amit Singh', '9876543210', 'amit@royalwoods.com', 'Jaipur, Rajasthan', 'Wood'),
(2, 'Fabric House', 'Priya Menon', '9123456789', 'priya@fabrichouse.com', 'Surat, Gujarat', 'Fabric'),
(3, 'Metal Makers', 'Vishal Iyer', '9988776655', 'vishal@metalmakers.com', 'Pune, Maharashtra', 'Metal'),
(4, 'Glassworks India', 'Ravi Deshmukh', '9867541230', 'ravi@glassworksindia.com', 'Mumbai, Maharashtra', 'Glass'),
(5, 'Cushion Comfort', 'Shweta Nair', '9998887766', 'shweta@cushioncomfort.com', 'Bangalore, Karnataka', 'Foam & Cushions');

-- Inventory
INSERT INTO Inventory (InventoryID, FurnitureID, SupplierID, Quantity, RestockDate) VALUES
(1, 1, 2, 10, '2024-09-01'),
(2, 2, 1, 8, '2024-09-10'),
(3, 3, 3, 20, '2024-09-15'),
(4, 4, 1, 5, '2024-09-18'),
(5, 5, 2, 15, '2024-09-20'),  -- Sofa Set
(6, 6, 1, 12, '2024-09-25'),  -- Dining Chair
(7, 7, 3, 25, '2024-09-30'),  -- Office Desk
(8, 8, 4, 7, '2024-10-01'),   -- Coffee Table
(9, 9, 2, 30, '2024-10-05'),   -- Bookshelf
(10, 10, 1, 10, '2024-10-10'),  -- Recliner Chair
(11, 11, 3, 20, '2024-10-15'),  -- Side Table
(12, 12, 2, 18, '2024-10-20'),  -- King Size Bed
(13, 13, 4, 5, '2024-10-25'),   -- Night Stand
(14, 14, 3, 22, '2024-10-30');  -- TV Unit

-- Payments
INSERT INTO Payments (PaymentID, OrderID, PaymentDate, AmountPaid, PaymentMethod, PaymentStatus) VALUES
(1, 1, '2024-10-02', 28000, 'debit Card', 'Paid'),
(2, 2, '2024-10-04', 5000, 'UPI', 'Pending'),
(3, 3, '2024-10-06', 15000, 'UPI', 'Paid'),
(4, 4,  '2024-10-02', 25000, 'Debit Card', 'Paid'),  -- Payment for Sofa Set (Order ID 1)
(5, 5,  '2024-10-05', 15000, 'Cash', 'Paid'),        -- Payment for Dining Table (Order ID 2)
(6, 6,  '2024-10-03', 30000, 'Debit Card', 'Paid'), -- Second payment for customized Double Bed (Order ID 1)
(7, 7,  '2024-10-06', 8000, 'UPI', 'Paid'),  -- Payment for Office Chair (Order ID 2)
(8, 8,  '2024-10-07', 20000, 'Debit Card', 'Paid'),  -- Payment for another Sofa Set (Order ID 3)
(9, 9,  '2024-10-08', 7000, 'Cash', 'Paid'),          -- Partial payment for customized Dining Table (Order ID 1)
(10, 10,  '2024-10-09', 5000, 'UPI', 'Paid'),         -- Payment for Coffee Table (Order ID 4)
(11, 11,  '2024-10-10', 18000, 'Debit Card', 'Paid'), -- Payment for King Size Bed (Order ID 3)
(12, 12,  '2024-10-11', 12000, 'UPI', 'Paid'), -- Payment for Recliner Chair (Order ID 2),
(13, 13,  '2024-10-12', 35000, 'Debit Card', 'Paid'),  -- Payment for Office Desk (Order ID 6)
(15, 15,  '2024-10-14', 4000, 'Cash', 'Paid'),          -- Payment for Small Table (Order ID 3)
(16, 16,  '2024-10-15', 16000, 'UPI', 'Paid'), -- Payment for Bookshelf (Order ID 7)
(17, 17,  '2024-10-16', 9000, 'UPI', 'Paid'),          -- Payment for Dining Chair Set (Order ID 2)
(18, 18,  '2024-10-17', 2500, 'Debit Card', 'Paid'),  -- Payment for Side Table (Order ID 4)
(19, 19,  '2024-10-18', 30000, 'UPI', 'Paid'), -- Payment for Customized Wardrobe (Order ID 8)
(20, 20,  '2024-10-19', 15000, 'Debit Card', 'Paid');  -- Payment for Dressing Table (Order ID 9)


-- Employees
INSERT INTO Employees (EmployeeID, FirstName, LastName, Position, Phone, Email, Salary) VALUES
(1, 'Manish', 'Sinha', 'Salesperson', '9988001122', 'manish@furnishop.com', 20000.00),
(2, 'Kavita', 'Desai', 'Designer', '9123456789', 'kavita@furnishop.com', 25000.00),
(3, 'Rahul', 'Mehta', 'Delivery Staff', '9988776655', 'rahul@furnishop.com', 12000.00),
(4, 'Sneha', 'Patil', 'Designer', '9876543210', 'sneha@furnishop.com', 30000.00),
(5, 'Raj', 'Kapoor', 'Delivery Staff', '9876543222', 'raj@furnishop.com', 10000.00),
(6, 'Vikram', 'Singh', 'Delivery Staff', '9988776644', 'vikram@furnishop.com', 8000.00),
(7, 'Pooja', 'Nair', 'Delivery Staff', '9988001133', 'pooja@furnishop.com', 15000.00),
(8, 'Anil', 'Kumar', 'Salesperson', '9123456701', 'anil@furnishop.com', 22000.00),
(9, 'Sunita', 'Joshi', 'Salesperson', '9123456711', 'sunita@furnishop.com', 18000.00),
(10, 'Neha', 'Bose', 'Cashier', '9988776650', 'neha@furnishop.com', 28000.00);

select * from customers;
select * from Furniture;
select * from CustomizationOptions;
select * from Orders;
select * from OrderItems;
select * from Suppliers;
select * from Inventory;
select * from Payments;
select * from Employees;

desc customers;
desc Furniture;
desc CustomizationOptions;
desc Orders;
desc OrderItems;
desc Suppliers;
desc Inventory;
desc Payments;
desc Employees;

ALTER TABLE Orders
ADD SalesPersonID INT,
ADD FOREIGN KEY (SalesPersonID) REFERENCES Employees(EmployeeID);

UPDATE Orders SET SalesPersonID = 1 WHERE OrderID = 1;  -- Ravi Kumar
UPDATE Orders SET SalesPersonID = 8 WHERE OrderID = 2;  -- Priya Sharma
UPDATE Orders SET SalesPersonID = 9 WHERE OrderID = 3;  -- Ravi Kumar
UPDATE Orders SET SalesPersonID = 1 WHERE OrderID = 4;  -- Amit Mehta
UPDATE Orders SET SalesPersonID = 1 WHERE OrderID = 5;  -- Priya Sharma
UPDATE Orders SET SalesPersonID = 8 WHERE OrderID = 6;  -- Amit Mehta
UPDATE Orders SET SalesPersonID = 9 WHERE OrderID = 7;  -- Ravi Kumar
UPDATE Orders SET SalesPersonID = 9 WHERE OrderID = 8;  -- Priya Sharma
UPDATE Orders SET SalesPersonID = 9 WHERE OrderID = 9;  -- Amit Mehta
UPDATE Orders SET SalesPersonID = 8 WHERE OrderID = 10;  -- Ravi Kumar
UPDATE Orders SET SalesPersonID = 8 WHERE OrderID = 11;  -- Priya Sharma
UPDATE Orders SET SalesPersonID = 9 WHERE OrderID = 12;  -- Ravi Kumar
UPDATE Orders SET SalesPersonID = 8 WHERE OrderID = 13;  -- Amit Mehta
UPDATE Orders SET SalesPersonID = 8 WHERE OrderID = 14;  -- Priya Sharma
UPDATE Orders SET SalesPersonID = 9 WHERE OrderID = 15;  -- Amit Mehta
UPDATE Orders SET SalesPersonID = 1 WHERE OrderID = 16;  -- Ravi Kumar
UPDATE Orders SET SalesPersonID = 1 WHERE OrderID = 17;  -- Priya Sharma
UPDATE Orders SET SalesPersonID = 1 WHERE OrderID = 18;  -- Amit Mehta


-- Questions 

-- Retrieve all orders placed by a customer with CustomerID = 1.
SELECT * FROM Orders
WHERE CustomerID = 1;

-- Find all furniture items where InStockQuantity is 12
SELECT FurnitureName, Category, Price FROM Furniture
WHERE InStockQuantity = 12;

-- List all furniture items that are customizable.
SELECT FurnitureName, Category, MaterialType FROM Furniture
WHERE IsCustomizable = TRUE;

-- Calculate the total revenue for orders marked as Completed.
SELECT SUM(TotalAmount) AS TotalRevenue FROM Orders
WHERE OrderStatus = 'Completed';

-- List furniture categories and their total quantities sold, ordered by popularity.
SELECT F.Category, SUM(OI.Quantity) AS TotalQuantitySold
FROM OrderItems OI
JOIN Furniture F ON OI.FurnitureID = F.FurnitureID
GROUP BY F.Category
ORDER BY TotalQuantitySold DESC;

-- Retrieve all suppliers who provide wood materials.
SELECT * FROM Suppliers
WHERE ProductType = 'Wood';

-- List all pending payments with order information.
SELECT P.PaymentID, P.OrderID, P.AmountPaid, P.PaymentMethod, O.TotalAmount
FROM Payments P
JOIN Orders O ON P.OrderID = O.OrderID
WHERE P.PaymentStatus = 'Pending';

-- Find names of customers who have placed at least one customized order.
SELECT DISTINCT C.FirstName, C.LastName
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.IsCustomized = TRUE;

-- Find the average salary for each position in the Employees table.
SELECT Position, AVG(salary) AS AvgSalary
FROM Employees
GROUP BY Position;

-- List all furniture items supplied by SupplierID = 2.
SELECT F.FurnitureName, F.Category, F.MaterialType, I.Quantity
FROM Inventory I
JOIN Furniture F ON I.FurnitureID = F.FurnitureID
WHERE I.SupplierID = 2;

-- Retrieve all returned orders with their reasons.
SELECT OrderID, ReturnReason
FROM Orders
WHERE OrderStatus = 'Returned';

-- List furniture items priced above 25000.
SELECT FurnitureName, Price, Category
FROM Furniture
WHERE Price > 25000;

-- Count the total number of orders per customer.
SELECT C.CustomerID, C.FirstName, C.LastName, COUNT(O.OrderID) AS TotalOrders
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName;

-- List all employees whose position is Salesperson with salary.
SELECT FirstName, LastName, Email,salary
FROM Employees
WHERE Position = 'Salesperson';

-- Retrieve customization options for a furniture item with FurnitureID = 6.
SELECT OptionType, OptionDescription, AdditionalCost
FROM CustomizationOptions
WHERE FurnitureID = 6;

-- Find all customers whose name start with 'a' letter 
SELECT FirstName, LastName, Email
FROM Customers
WHERE FirstName LIKE 'A%';

-- Find all furniture items that contain the word "Table" in their name.
SELECT FurnitureName, Category, Price
FROM Furniture
WHERE FurnitureName LIKE '%Table%';

-- Retrieve all suppliers whose phone numbers start with "91" (Indian country code).
SELECT SupplierName, Phone
FROM Suppliers
WHERE Phone LIKE '91%';

-- List all furniture items that come in colors starting with "B" (e.g., "Blue", "Black")
SELECT FurnitureName, Color
FROM Furniture
WHERE Color LIKE 'B%';

-- Retrieve all orders with statuses starting with "C" (e.g., "Completed", "Cancelled").
SELECT OrderID, OrderStatus, TotalAmount
FROM Orders
WHERE OrderStatus LIKE 'C%';




-- Get the total quantity of each furniture category in stock.
SELECT Category, SUM(InStockQuantity) AS TotalQuantityInStock
FROM Furniture
GROUP BY Category;

-- List all categories with total sales above rs 15,000.
SELECT F.Category, SUM(OI.TotalPrice) AS TotalSales
FROM OrderItems OI
JOIN Furniture F ON OI.FurnitureID = F.FurnitureID
GROUP BY F.Category
HAVING TotalSales > 15000;

-- how many furniture purchase on 2024-10-10
SELECT SUM(oi.Quantity) AS TotalFurniturePurchased
FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID
WHERE o.OrderDate = '2024-10-10';


-- which customer purchased which furniture
SELECT CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    f.FurnitureName AS PurchasedFurniture, oi.Quantity AS QuantityPurchased,
    o.OrderDate AS PurchaseDate, o.TotalAmount AS TotalOrderAmount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Furniture f ON oi.FurnitureID = f.FurnitureID
ORDER BY o.OrderDate DESC limit 10;


