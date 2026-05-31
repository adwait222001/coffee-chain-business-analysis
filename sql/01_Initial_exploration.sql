-- =========================================
-- INITIAL EXPLORATION
-- =========================================

Q1)Data Types of all columns in customers table?
ANS(Query):
SELECT
    column_name,
    data_type,
    is_nullable
FROM `business_case.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'coffee'
ORDER BY ordinal_position;


Q2)Amount of the raw materials bought acrossed all shops?
ANS(Query):
SELECT a.ProductLine,a.ProductType,SUM(a.Cogs) AS product_cost
FROM business_case.coffee a
GROUP BY a.ProductLine,a.ProductType
ORDER BY product_cost DESC



Q3)Finding the MarketSize for each state?
ANS(Query):
SELECT a.State,a.MarketSize
FROM business_case.coffee a
GROUP BY a.MarketSize,a.State

Q4)Which ProductLine and ProductType have the highest sales?
ANS(Query):
SELECT a.ProductLine,a.ProductType,SUM(a.Sales) AS sales
FROM business_case.coffee a
GROUP BY a.ProductType,a.ProductLine
ORDER BY sales DESC

Q5)Analyze state-wise sales performance for stores categorized under Major Market?
ANS(Query):
With first_filter AS 
(
  SELECT a.State,SUM(a.Sales) AS sales_by_state
  FROM business_case.coffee a
  WHERE a.MarketSize = "Major Market"
  GROUP BY a.State
  ORDER BY sales_by_state DESC
)
SELECT *
FROM first_filter b

Q6)Analyze state-wise sales performance for stores categorized under Small Market?
ANS(Query):
With first_filter AS 
(
  SELECT a.State,SUM(a.Sales) AS sales_by_state
  FROM business_case.coffee a
  WHERE a.MarketSize = "Small Market"
  GROUP BY a.State
  ORDER BY sales_by_state DESC
)
SELECT *
FROM first_filter b

Q7)Which states belong to each market segment (West, South, East, Central) in the dataset, and how are they grouped across regions?
ANS(QUERY):
SELECT DISTINCT(a.State),a.Market
FROM business_case.coffee a
ORDER BY a.Market DESC

Q8)Write a SQL query to find the total COGS incurred in each market. Return the market and total COGS, ordered from the highest to the lowest total COGS?
ANS(QUERY):
SELECT a.market,SUM(a.Cogs) AS cogs
FROM business_case.coffee a
GROUP BY a.Market
ORDER BY cogs DESC



