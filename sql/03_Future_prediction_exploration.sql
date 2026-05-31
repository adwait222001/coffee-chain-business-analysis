-- =========================================
-- FUTURE PREDICTION EXPLORATION
-- =========================================

Q1)Analyze projected sales, profit, and COGS targets across states?
ANS(QUERY):
SELECT a.State,
SUM(a.TargetSales) AS future_sales,
SUM(a.TargetProfit) AS future_profit,
SUM(a.TargetCOGS) AS future_cogs
FROM business_case.coffee a
GROUP BY a.State
ORDER BY future_sales DESC


Q2)Which market sectors are expected to generate the highest future revenue and profitability?
ANS(QUERY):
SELECT a.Market AS sector,
SUM(a.TargetSales) AS future_sales,
SUM(a.TargetProfit) AS future_profit,
SUM(a.TargetCOGS) AS future_cogs
FROM business_case.coffee a
GROUP BY a.Market
ORDER BY future_sales DESC

Q3)Which market size category is expected to generate higher future revenue and profitability?
ANS(QUERY):
SELECT a.MarketSize,
SUM(a.TargetSales) AS future_sales,
SUM(a.TargetProfit) AS future_profit,
SUM(a.TargetCOGS) AS future_cogs
FROM business_case.coffee a
GROUP BY a.MarketSize
ORDER BY future_sales DESC
