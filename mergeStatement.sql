CREATE DATABASE SqlShackMergeDemo
USE SqlShackMergeDemo

CREATE TABLE SourceProducts(
    ProductID		INT,
    ProductName		VARCHAR(50),
    Price			DECIMAL(9,2)
)

INSERT INTO SourceProducts(ProductID,ProductName, Price) VALUES(1,'Table',100)
INSERT INTO SourceProducts(ProductID,ProductName, Price) VALUES(2,'Desk',80)
INSERT INTO SourceProducts(ProductID,ProductName, Price) VALUES(3,'Chair',50)
INSERT INTO SourceProducts(ProductID,ProductName, Price) VALUES(4,'Computer',300)

CREATE TABLE TargetProducts(
    ProductID		INT,
    ProductName		VARCHAR(50),
    Price			DECIMAL(9,2)
)
INSERT INTO TargetProducts(ProductID,ProductName, Price) VALUES(1,'Table',100)
INSERT INTO TargetProducts(ProductID,ProductName, Price) VALUES(2,'Desk',180)
INSERT INTO TargetProducts(ProductID,ProductName, Price) VALUES(5,'Bed',50)
INSERT INTO TargetProducts(ProductID,ProductName, Price) VALUES(6,'Cupboard',300)

SELECT * FROM SourceProducts
SELECT * FROM TargetProducts

merge TargetProducts as t
using SourceProducts  as s
on t.ProductID=s.ProductID

 when not matched by target 
 then insert(ProductID,ProductName,Price)
 values(s.ProductID,s.ProductName,s.Price)
 when matched then
 update set t.ProductName=s.ProductName, t.Price=s.Price

 when Not matched by source
 then delete;
