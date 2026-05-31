-- =========================================
-- INDEPTH EXPLORATION
-- =========================================

Q1)What is the product-wise gross margin, expenses, and derived profit for the coffee business?
ANS(QUERY):
WITH first_filter AS 
(
  SELECT a.ProductLine,a.ProductType,a.Product,
  SUM(a.Sales) AS sales_per_ingredient,
  SUM(a.Cogs) AS cogs,
  SUM(a.Sales)-SUM(a.Cogs) AS gross_margin_per_ingredient,
  SUM(a.Marketing)+SUM(a.OtherExpenses) AS expenses
  FROM business_case.coffee a
  GROUP BY a.Product,a.ProductType,a.ProductLine
)
SELECT *,b.gross_margin_per_ingredient-b.expenses AS profit
FROM first_filter b
ORDER BY profit DESC



Q2)For each state, find the store and product with the maximum sales?
ANS(QUERY):
WITH store_sales AS
(
    SELECT 
        a.State,
        a.Storeid,
        a.Product,
        SUM(a.Sales) AS total_sales
    FROM business_case.coffee a
    GROUP BY 
        a.State,
        a.Storeid,
        a.Product
),

ranked_sales AS
(
    SELECT *,
           RANK() OVER(PARTITION BY State ORDER BY total_sales DESC) AS rnk
    FROM store_sales
)

SELECT 
    State,
    Storeid,
    product,
    total_sales
FROM ranked_sales
WHERE rnk = 1;



Q3)For each state, which store and product achieved the second-highest sales performance?
ANS(QUERY):
WITH store_sales AS
(
    SELECT 
        a.State,
        a.Storeid,
        a.Product,
        SUM(a.Sales) AS total_sales

    FROM business_case.coffee a
    GROUP BY 
        a.State,
        a.Storeid,
        a.Product
),

ranked_sales AS
(
    SELECT *,
           RANK() OVER(PARTITION BY State ORDER BY total_sales DESC) AS rnk
    FROM store_sales
)

SELECT 
    State,
    Storeid,
    product,
    total_sales
FROM ranked_sales
WHERE rnk = 2;

Q4)Which market contributes most to overall revenue and profit?
ANS(QUERY):
WITH first_filter AS 
(
  SELECT 
      a.Market AS sector,
      SUM(a.Sales) AS sales,
      SUM(a.Profit) AS Profit
  FROM business_case.coffee a
  GROUP BY a.Market
  ORDER BY sales,Profit DESC
)

SELECT 
    b.sector,
    b.sales,
    b.Profit
FROM first_filter b;



Q5)Analyze marketing and operational expenses across different market sectors?
ANS(QUERY):
WITH first_filter AS 
(
  SELECT 
      a.Market AS sector,
      SUM(a.Marketing) AS marketing,
      SUM(a.OtherExpenses) AS other_expenses
  FROM business_case.coffee a
  GROUP BY a.Market
  ORDER BY marketing DESC, other_expenses DESC
)

SELECT 
    b.sector,
    b.marketing,
    b.other_expenses
FROM first_filter b;

Q6)Who are the top 3 performing stores in each state based on operating income?
ANS(QUERY):
WITH first_filter AS (
  SELECT
    State,
    Storeid,
    SUM(Cogs) AS cogs,
    SUM(Sales) AS sales,
    SUM(OtherExpenses) AS otherexp,
    SUM(Marketing) AS marketing
  FROM business_case.coffee
  GROUP BY State, Storeid
),
store_profit AS (
  SELECT
    State,
    Storeid,
    sales - cogs - marketing - otherexp AS operating_profit
  FROM first_filter
)
SELECT
  State,
  Storeid,
  operating_profit,
  RANK() OVER (
    PARTITION BY State
    ORDER BY operating_profit DESC
  ) AS state_rank
FROM store_profit
QUALIFY state_rank <= 3
ORDER BY State, state_rank;