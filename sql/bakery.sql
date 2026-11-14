-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: bakery
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `c_order`
--

DROP TABLE IF EXISTS `c_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c_order` (
  `OrderID` int NOT NULL,
  `CustomerID` int DEFAULT NULL,
  `EmployeeID` int DEFAULT NULL,
  `OrderDate` date NOT NULL DEFAULT (curdate()),
  `OrderStatus` enum('Pending','Completed') NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`OrderID`),
  KEY `fk_order_customer` (`CustomerID`),
  KEY `fk_order_employee` (`EmployeeID`),
  CONSTRAINT `fk_order_customer` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_order_employee` FOREIGN KEY (`EmployeeID`) REFERENCES `employee` (`EmployeeID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_order`
--

LOCK TABLES `c_order` WRITE;
/*!40000 ALTER TABLE `c_order` DISABLE KEYS */;
INSERT INTO `c_order` VALUES (1,1,1,'2025-08-25','Completed'),(2,2,2,'2025-08-26','Completed'),(3,3,1,'2025-08-27','Completed'),(4,4,2,'2025-08-28','Pending'),(5,5,1,'2025-08-29','Completed'),(6,1,1,'2025-09-05','Completed'),(10,6,1,'2025-09-05','Pending');
/*!40000 ALTER TABLE `c_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `CustomerID` int NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Address` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY `PhoneNumber` (`PhoneNumber`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Leen','Shannak','0791111111','leen.shannak@example.com','Amman, Jordan'),(2,'Ahmad','Odeh','0792222222','ahmad.odeh@example.com','Irbid, Jordan'),(3,'Sara','Hammad','0793333333','sara.hammad@example.com','Zarqa, Jordan'),(4,'Omar','Khalil','0794444444','omar.khalil@example.com','Aqaba, Jordan'),(5,'Dana','Nasser','0795555555','dana.nasser@example.com','Salt, Jordan'),(6,'Maya','Salem','0796666666','maya.salem@example.com','Amman, Jordan');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `EmployeeID` int NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Role` enum('Cashier','Baker','Manager') NOT NULL,
  `Salary` decimal(10,2) NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  CONSTRAINT `employee_chk_1` CHECK ((`Salary` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'Hiba','Ahmad','Cashier',600.00),(2,'Yousef','Saleh','Cashier',620.00),(3,'Mahmoud','Ali','Baker',750.00),(4,'Rania','Hassan','Baker',730.00),(5,'Khaled','Othman','Manager',1200.00);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdetails` (
  `OrderID` int NOT NULL,
  `ProductID` int NOT NULL,
  `Quantity` int NOT NULL,
  PRIMARY KEY (`OrderID`,`ProductID`),
  KEY `fk_orderdetails_product` (`ProductID`),
  CONSTRAINT `fk_orderdetails_order` FOREIGN KEY (`OrderID`) REFERENCES `c_order` (`OrderID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_orderdetails_product` FOREIGN KEY (`ProductID`) REFERENCES `product` (`ProductID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `orderdetails_chk_1` CHECK ((`Quantity` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails`
--

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
INSERT INTO `orderdetails` VALUES (1,1,1),(1,3,2),(2,4,2),(2,5,1),(3,6,4),(3,8,2),(4,1,1),(4,7,1),(5,2,1),(5,3,3),(6,2,1),(6,4,3),(10,1,1),(10,3,2);
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `PaymentID` int NOT NULL,
  `OrderID` int NOT NULL,
  `PaymentDate` date NOT NULL DEFAULT (curdate()),
  `AmountPaid` decimal(8,2) NOT NULL,
  PRIMARY KEY (`PaymentID`),
  UNIQUE KEY `OrderID` (`OrderID`),
  CONSTRAINT `fk_payment_order` FOREIGN KEY (`OrderID`) REFERENCES `c_order` (`OrderID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payment_chk_1` CHECK ((`AmountPaid` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,1,'2025-08-25',21.00),(2,2,'2025-08-26',23.00),(3,3,'2025-08-27',16.00),(4,5,'2025-08-29',18.00);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `ProductID` int NOT NULL,
  `ProductName` varchar(50) NOT NULL,
  `Price` decimal(8,2) NOT NULL,
  `StockQuantity` int NOT NULL DEFAULT '0',
  `Category` varchar(30) NOT NULL,
  PRIMARY KEY (`ProductID`),
  UNIQUE KEY `ProductName` (`ProductName`),
  CONSTRAINT `product_chk_1` CHECK ((`Price` >= 0)),
  CONSTRAINT `product_chk_2` CHECK ((`StockQuantity` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Chocolate Cake',15.00,20,'Cake'),(2,'Vanilla Cake',12.00,15,'Cake'),(3,'Croissant',3.00,50,'Pastry'),(4,'Baguette',2.50,40,'Bread'),(5,'Cheesecake',18.00,10,'Cake'),(6,'Muffin',2.00,60,'Pastry'),(7,'Baklava',10.00,25,'Dessert'),(8,'Brownie',4.00,30,'Dessert');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_frequent_customers`
--

DROP TABLE IF EXISTS `v_frequent_customers`;
/*!50001 DROP VIEW IF EXISTS `v_frequent_customers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_frequent_customers` AS SELECT 
 1 AS `CustomerID`,
 1 AS `FirstName`,
 1 AS `LastName`,
 1 AS `OrdersCount`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_order_total`
--

DROP TABLE IF EXISTS `v_order_total`;
/*!50001 DROP VIEW IF EXISTS `v_order_total`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_order_total` AS SELECT 
 1 AS `OrderID`,
 1 AS `OrderDate`,
 1 AS `OrderStatus`,
 1 AS `Customer_First_Name`,
 1 AS `Customer_Last_Name`,
 1 AS `Employee`,
 1 AS `OrderTotal`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_product_sales_total`
--

DROP TABLE IF EXISTS `v_product_sales_total`;
/*!50001 DROP VIEW IF EXISTS `v_product_sales_total`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_product_sales_total` AS SELECT 
 1 AS `ProductID`,
 1 AS `ProductName`,
 1 AS `Category`,
 1 AS `TotalQty`,
 1 AS `Revenue`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_productsinorder`
--

DROP TABLE IF EXISTS `v_productsinorder`;
/*!50001 DROP VIEW IF EXISTS `v_productsinorder`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_productsinorder` AS SELECT 
 1 AS `OrderID`,
 1 AS `ProductID`,
 1 AS `ProductName`,
 1 AS `Quantity`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_unpaid_orders`
--

DROP TABLE IF EXISTS `v_unpaid_orders`;
/*!50001 DROP VIEW IF EXISTS `v_unpaid_orders`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_unpaid_orders` AS SELECT 
 1 AS `OrderID`,
 1 AS `OrderDate`,
 1 AS `OrderStatus`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'bakery'
--

--
-- Dumping routines for database 'bakery'
--
/*!50003 DROP PROCEDURE IF EXISTS `proc_AddCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_AddCustomer`(
  IN p_customer_id INT,
  IN p_first_name  VARCHAR(50),
  IN p_last_name   VARCHAR(50),
  IN p_phone       VARCHAR(15),    -- can be NULL (MUST be UNIQUE if provided)
  IN p_email       VARCHAR(100),   -- can be NULL (MUST be UNIQUE if provided)
  IN p_address     VARCHAR(150)    -- can be NULL
)
BEGIN
  INSERT INTO Customer (CustomerID, FirstName, LastName, PhoneNumber, Email, Address)
  VALUES (p_customer_id, p_first_name, p_last_name, p_phone, p_email, p_address);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_AddEmployee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_AddEmployee`(
    IN p_employee_id INT,
    IN p_first_name  VARCHAR(50),
    IN p_last_name   VARCHAR(50),
    IN p_role        VARCHAR(20),   -- Cashier OR Baker OR Manager
    IN p_salary      DECIMAL(10,2)
)
BEGIN
    INSERT INTO Employee (EmployeeID, FirstName, LastName, Role, Salary)
    VALUES (p_employee_id, p_first_name, p_last_name, p_role, p_salary);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_AddOrderItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_AddOrderItem`(
  IN p_order_id   INT,
  IN p_product_id INT,
  IN p_qty        INT
)
Begin
  /* Insert one line item (OrderID, ProductID is a composite PK) */
  INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
  VALUES (p_order_id, p_product_id, p_qty);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_CreateOrderPending` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_CreateOrderPending`(
  IN p_order_id    INT,	  -- Must be uniqe and NOT NULL
  IN p_customer_id INT,   -- can be NULL (FK is ON DELETE SET NULL)
  IN p_employee_id INT    -- can be NULL (FK is ON DELETE SET NULL)
)
BEGIN
  INSERT INTO C_Order (OrderID, CustomerID, EmployeeID)
  VALUES (p_order_id, p_customer_id, p_employee_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_complete_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_complete_order`(IN p_order_id INT)
BEGIN
  UPDATE C_Order
  SET OrderStatus = 'Completed'
  WHERE OrderID = p_order_id
    AND OrderStatus = 'Pending';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_MonthlyProfit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_MonthlyProfit`(
    IN p_month INT,
    IN p_year INT
)
BEGIN
    SELECT 
        O.OrderID,
        C.FirstName AS CustomerName,
        E.FirstName AS EmployeeName,
        E.Role AS EmployeeRole,
        SUM(OD.Quantity * P.Price) AS OrderRevenue,
        E.Salary,
        (SUM(OD.Quantity * P.Price) - E.Salary) AS ProfitAfterSalary
    FROM C_Order O
    LEFT JOIN Customer C ON O.CustomerID = C.CustomerID
    LEFT JOIN Employee E ON O.EmployeeID = E.EmployeeID
    JOIN OrderDetails OD ON O.OrderID = OD.OrderID
    JOIN Product P ON OD.ProductID = P.ProductID
    JOIN Payment PM ON O.OrderID = PM.OrderID
    WHERE MONTH(O.OrderDate) = p_month
      AND YEAR(O.OrderDate) = p_year
    GROUP BY O.OrderID, CustomerName, EmployeeName, E.Role, E.Salary;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_frequent_customers`
--

/*!50001 DROP VIEW IF EXISTS `v_frequent_customers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_frequent_customers` AS select `c`.`CustomerID` AS `CustomerID`,`c`.`FirstName` AS `FirstName`,`c`.`LastName` AS `LastName`,count(distinct `o`.`OrderID`) AS `OrdersCount` from (`customer` `c` join `c_order` `o` on((`o`.`CustomerID` = `c`.`CustomerID`))) group by `c`.`CustomerID`,`c`.`FirstName`,`c`.`LastName` having (count(distinct `o`.`OrderID`) >= 2) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_order_total`
--

/*!50001 DROP VIEW IF EXISTS `v_order_total`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_order_total` AS select `o`.`OrderID` AS `OrderID`,`o`.`OrderDate` AS `OrderDate`,`o`.`OrderStatus` AS `OrderStatus`,`c`.`FirstName` AS `Customer_First_Name`,`c`.`LastName` AS `Customer_Last_Name`,`e`.`FirstName` AS `Employee`,sum((`od`.`Quantity` * `p`.`Price`)) AS `OrderTotal` from ((((`c_order` `o` join `orderdetails` `od` on((`od`.`OrderID` = `o`.`OrderID`))) join `product` `p` on((`p`.`ProductID` = `od`.`ProductID`))) left join `employee` `e` on((`e`.`EmployeeID` = `o`.`EmployeeID`))) left join `customer` `c` on((`c`.`CustomerID` = `o`.`CustomerID`))) group by `o`.`OrderID`,`o`.`OrderDate`,`o`.`OrderStatus`,`c`.`FirstName` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_product_sales_total`
--

/*!50001 DROP VIEW IF EXISTS `v_product_sales_total`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_product_sales_total` AS select `p`.`ProductID` AS `ProductID`,`p`.`ProductName` AS `ProductName`,`p`.`Category` AS `Category`,sum(`od`.`Quantity`) AS `TotalQty`,sum((`od`.`Quantity` * `p`.`Price`)) AS `Revenue` from (`orderdetails` `od` join `product` `p` on((`p`.`ProductID` = `od`.`ProductID`))) group by `p`.`ProductID`,`p`.`ProductName`,`p`.`Category` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_productsinorder`
--

/*!50001 DROP VIEW IF EXISTS `v_productsinorder`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_productsinorder` AS select `od`.`OrderID` AS `OrderID`,`pr`.`ProductID` AS `ProductID`,`pr`.`ProductName` AS `ProductName`,`od`.`Quantity` AS `Quantity` from (`orderdetails` `od` join `product` `pr` on((`od`.`ProductID` = `pr`.`ProductID`))) order by `od`.`OrderID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_unpaid_orders`
--

/*!50001 DROP VIEW IF EXISTS `v_unpaid_orders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_unpaid_orders` AS select `c_order`.`OrderID` AS `OrderID`,`c_order`.`OrderDate` AS `OrderDate`,`c_order`.`OrderStatus` AS `OrderStatus` from `c_order` where (`c_order`.`OrderStatus` = 'Pending') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-08 19:28:40
