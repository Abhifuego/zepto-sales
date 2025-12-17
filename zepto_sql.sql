Create  database zepto_project

USE zepto_project;
SELECT * 
FROM zepto_v2;
-- count rows
Select count(*) from zepto_v2;
-- sample data
Select * from zepto_v2 limit 10; 
-- null values 
Select * from zepto_v2
Where name IS null 
or
Category is null 
or
mrp is null 
or
discountPercent is null 
or 
availableQuantity is null
or 
discountedSellingPrice is null
or
weightInGms is null
or
outOfStock is null
or
quantity is null
-- different product categories
Select Distinct category
from zepto_v2 
order by category ;
-- products in stock vs out of stock
Select outOfStock ,count(id)
from zepto_v2
GROUP BY outOfStock ;
ALTER TABLE zepto_v2
ADD COLUMN id INT NOT NULL AUTO_INCREMENT PRIMARY KEY;

-- products name present multiple times 
select name ,count(id) as "number of skus"
from zepto_v2
group by name
HAVING count(id) > 1
ORDER BY COUNT(ID) DESC;

--- DATA CLEANING
--- PRODUCT WITH PRICE = 0
Select * from zepto_v2
where mrp = 0  or discountedSellingPrice = 0 ;

DELETE FROM zepto_v2
WHERE id IN (
    SELECT id FROM (
        SELECT id FROM zepto_v2 WHERE mrp = 0
    ) AS temp
);
--- converting paisa into ruppes
UPDATE zepto_v2
SET mrp = mrp / 100.0,
discountedSellingPrice = discountedSellingPrice / 100.0;

SELECT  mrp ,discountedSellingPrice FROM zepto_v2;

UPDATE zepto_v2
SET mrp = mrp / 100.0,
discountedSellingPrice = discountedSellingPrice / 100.0;
SET SQL_SAFE_UPDATES = 0;
UPDATE zepto_v2
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;
--- QUESTIONS 1) -- Q1. Find the top 10 best-value products based on the discount percentage.
Select  distinct name , discountPercent ,id from zepto_v2
order by discountPercent desc 
limit 10;
-- question 2   --Q2.What are the Products with High MRP but Out of Stock
Select name ,mrp FROM zepto_v2
where mrp > 300 and outOfStock =TRUE 
order by mrp desc ;
SELECT COUNT(*) FROM zepto_v2 WHERE outOfStock = TRUE;
-- question 3 Calculate Estimated Revenue for each category
SELECT category ,SUM(discountedSellingPrice*availableQuantity) AS TOTAL_REVENUE
FROM zepto_v2
group by category
order by TOTAL_REVENUE  DESC;
-- QUESTION 4 -- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT DISTINCT name, mrp , discountPercent FROM zepto_v2
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC ; 
-- QUESTION 5 -- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category ,avg(discountPercent) from zepto_v2
group by category 
order by category desc 
limit 5;
-- question 6 
-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT distinct name , weightInGms ,discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms , 2) as pricepergms
from zepto_v2
where weightInGms >= 100
ORDER BY pricepergms;
-- question 7 .Group the products into categories like Low, Medium, Bulk.
SELECT distinct name , weightINGms , 
CASE WHEN  weightINGms < 1000 THEN 'LOW'
WHEN weightINGms <500 THEN 'MEDIUM'
ELSE 'BULK'
END AS weight_category
from zepto_v2 ;
-- question 8Q8.What is the Total Inventory Weight Per Category 
SELECT category , SUM(weightINGms * availableQuantity ) AS total_weight
from zepto_v2
GROUP BY category
ORDER BY total_weight;

















