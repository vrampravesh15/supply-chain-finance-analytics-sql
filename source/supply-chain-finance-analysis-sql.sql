Create Database SupplyChainFinanceManagement;
use SupplyChainFinanceManagement;

Create table dim_customer( 
customer_code Int Primary Key,
Customer varchar(150),
Platform varchar (45),
Channel varchar (45),
Market varchar (45),
Sub_Zone Varchar(45),
Region Varchar (45)
);

Create table dim_product(
Product_Code Varchar (45) Primary Key,
Division varchar (45),
Segment Varchar (45),
Category varchar (45),
Product varchar (200),
Variant varchar (45)
);


Create table fact_sales_monthly(
Date Date,
Product_Code varchar(45),
Customer_Code Int,
Sold_Quantity Int,
Dim_Customer_Consumer_Code Int,
Fact_Post_Invoice_Deductions_Customer_Code Int,
Fact_Post_Invoice_Deductions_Product_Code varchar (45),
fact_post_invoice_deductions_Date Date,
Fact_Pre_Invoice_Deductions_Customer_Code Int,
Fact_Pre_Invoice_Deductions_Fiscal_Year Int,
Primary Key (Date, Product_Code, Customer_Code),
Foreign Key (Product_Code) References dim_product(Product_Code),
Foreign Key (Customer_Code) References dim_customer(Customer_Code)
);

select * from fact_sales_monthly;

Create table fact_post_invoice_deductions(
Customer_Code Int,
Product_Code varchar(45),
Date Date, 
Discount_pct Decimal (5,4),
Other_Deductions_pct Decimal(5,4),
Primary Key (Customer_Code, Product_Code, Date),
Foreign Key (Customer_Code) References dim_customer(Customer_Code),
Foreign Key(Product_Code) References dim_product(Product_Code)
);


Create table fact_pre_invoice_deductions(
Customer_Code Int,
Fiscal_Year Int,
pre_invoice_discount_pct Decimal(5,4),
Primary Key (Customer_Code, Fiscal_Year),
Foreign Key (Customer_Code) References dim_customer(Customer_Code)
);

Create Table fact_forecast_monthly (
Date Date, 
Fiscal_Year Int,
Product_Code Varchar(45),
Customer_Code Int,
Forecast_Quantity Int,
dim_customer_customer_code Int,
dim_product_product_code varchar (45),
Primary Key (Date, Product_Code, Customer_Code),
Foreign Key (Product_Code) References dim_product(Product_Code),
Foreign Key (Customer_Code) References dim_customer(Customer_Code)
);

Create table fact_manufacturing_cost(
Product_Code Varchar(45),
Cost_Year Int,
Manufacturing_Cost Decimal (15,4),
dim_product_product_code varchar(45),
Primary Key (Product_Code, Cost_Year),
Foreign Key (Product_Code) References dim_product(Product_Code)
);

Create Table fact_freight_cost(
Market Varchar(45),
Fiscal_Year Int,
Freight_pct Decimal(5,4),
Other_Cost_pct Decimal(5,4),
Primary Key (Market, Fiscal_Year)
);


Create table fact_gross_price(
Product_Code varchar(45),
Fiscal_Year Int,
Gross_Price Decimal(15,4),
dim_product_product_code varchar(45),
Primary Key (Product_Code, Fiscal_Year),
Foreign Key (Product_Code) References dim_product(Product_Code)
);


--Altered the table as per the data available for the project:


ALTER TABLE fact_sales_monthly DROP COLUMN Dim_Customer_Consumer_Code;
ALTER TABLE fact_sales_monthly DROP COLUMN Fact_Post_Invoice_Deductions_Customer_Code;
ALTER TABLE fact_sales_monthly DROP COLUMN Fact_Post_Invoice_Deductions_Product_Code;
ALTER TABLE fact_sales_monthly DROP COLUMN fact_post_invoice_deductions_Date;
ALTER TABLE fact_sales_monthly DROP COLUMN Fact_Pre_Invoice_Deductions_Customer_Code;
ALTER TABLE fact_sales_monthly DROP COLUMN Fact_Pre_Invoice_Deductions_Fiscal_Year;

select * from fact_sales_monthly;

ALTER TABLE fact_forecast_monthly
DROP COLUMN dim_customer_customer_code;
ALTER TABLE fact_forecast_monthly
DROP COLUMN dim_product_product_code;

select * from fact_forecast_monthly;

ALTER TABLE fact_manufacturing_cost
DROP COLUMN dim_product_product_code;

select * from fact_manufacturing_cost;

ALTER TABLE fact_gross_price
DROP COLUMN dim_product_product_code;

Select * from fact_gross_price;

--TASK 2

--Q1) After creating the tables insert the given records which is in the below image in respective tables:

INSERT INTO dim_customer (customer_code, customer, platform, channel, market, sub_zone, region) VALUES
(7002104,'Atliq e Store','E-Commerce','Direct','Austria','NE','EU'),
(70021096,'Atliq e Store','E-Commerce','Direct','United Kingdom','NE','EU'),
(70022084,'Atliq Exclusive','Brick & Mortar','Direct','USA','NA','EU'),
(70022085,'Atliq e Store','E-Commerce','Direct','USA','NA','EU'),
(70023031,'Atliq Exclusive','Brick & Mortar','Direct','Canada','NA','EU'),
(70023032,'Atliq e Store','E-Commerce','Direct','Canada','NA','EU'),
(70022606,'Atliq e Store','E-Commerce','Direct','Mexico','LATAM','LATAM'),
(70022708,'Atliq e Store','E-Commerce','Direct','Brazil','LATAM','LATAM'),
(80001019,'Neptune','Brick & Mortar','Distributor','China','ROA','APAC'),
(80006154,'Synthetic','Brick & Mortar','Distributor','Philipines','ROA','APAC'),
(80006155,'Novus','Brick & Mortar','Distributor','Philipines','ROA','APAC');

INSERT INTO dim_customer (customer_code, customer, platform, channel, market, sub_zone, region) VALUES
(70002017, 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown'),
(70002018, 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown'),
(70003181, 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown'),
(70003182, 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown'),
(70006157, 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown'),
(70006158, 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown'),
(70007198, 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown'),
(70007199, 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown'),
(70008169, 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown'),
(70008170, 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown'),
(70011193, 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown');


select * from dim_customer;

INSERT INTO dim_product (product_code, division, segment, category, product, variant) VALUES
('A1919150403','P & A','Peripherals','MotherBoard','AQ MB Lito','Plus 2'),
('A1920150404','P & A','Peripherals','MotherBoard','AQ MB Lito','Premium'),
('A2020150501','P & A','Peripherals','MotherBoard','AQ MB Lito 2','Standard'),
('A2020150502','P & A','Peripherals','MotherBoard','AQ MB Lito 2','Plus 1'),
('A2021150503','P & A','Peripherals','MotherBoard','AQ MB Lito 2','Plus 2'),
('A2021150504','P & A','Peripherals','MotherBoard','AQ MB Lito 2','Premium'),
('A2118150101','P & A','Accessories','Mouse','AQ Master wired x1 Ms','Standard 1'),
('A2118150102','P & A','Accessories','Mouse','AQ Master wired x1 Ms','Standard 2'),
('A2118150103','P & A','Accessories','Mouse','AQ Master wired x1 Ms','Plus 1'),
('A2118150104','P & A','Accessories','Mouse','AQ Master wired x1 Ms','Plus 2'),
('A2118150105','P & A','Accessories','Mouse','AQ Master wired x1 Ms','Premium 1');

INSERT INTO dim_product (product_code, division, segment, category, product, variant) VALUES
('A0118150101','Accessories','Mouse','Accessories','AQ Master wired x1 Ms','Standard 1'),
('A0118150102','Accessories','Mouse','Accessories','AQ Master wired x1 Ms','Standard 2'),
('A0118150103','Accessories','Mouse','Accessories','AQ Master wired x1 Ms','Plus 1');

INSERT INTO dim_product (product_code, division, segment, category, product, variant)
SELECT 'B0218150105', 'Accessories', 'Mouse', 'Accessories', 'AQ Master wired x2 Ms', 'Premium B'
WHERE NOT EXISTS (
    SELECT 1 FROM dim_product WHERE product_code = 'B0218150105'
);

INSERT INTO dim_product (product_code, division, segment, category, product, variant)
SELECT 'C0418150109', 'Accessories', 'Mouse', 'Accessories', 'AQ Master wired x3 Ms', 'Premium C'
WHERE NOT EXISTS (
    SELECT 1 FROM dim_product WHERE product_code = 'C0418150109'
);



select * from dim_product;

INSERT INTO fact_gross_price (Product_Code, fiscal_year, Gross_Price) VALUES
('A0118150101',2018,15.3952),
('A0118150101',2019,14.4392),
('A0118150101',2020,16.2323),
('A0118150101',2021,19.0573),
('A0118150102',2018,19.5875),
('A0118150102',2019,18.5595),
('A0118150102',2020,19.8577),
('A0118150102',2021,21.4565),
('A0118150103',2018,19.3630),
('A0118150103',2019,19.3442),
('A0118150103',2020,22.1317);

select Fiscal_Year from fact_gross_price;

INSERT INTO fact_freight_cost (market, fiscal_year, freight_pct, other_cost_pct) VALUES
('Germany',2020,0.0226,0.0060),
('Germany',2021,0.0226,0.0060),
('Germany',2022,0.0226,0.0060),
('India',2018,0.0244,0.0026),
('India',2019,0.0219,0.0057),
('India',2020,0.0309,0.0029),
('India',2021,0.0309,0.0029),
('India',2022,0.0309,0.0029),
('Indonesia',2018,0.0190,0.0042),
('Indonesia',2019,0.0187,0.0052),
('Indonesia',2020,0.0195,0.0023);

Select * from fact_freight_cost;

INSERT INTO fact_manufacturing_cost (product_code, cost_year, manufacturing_cost) VALUES
('A0118150101',2018,4.6190),
('A0118150101',2019,4.2033),
('A0118150101',2020,5.0207),
('A0118150101',2021,5.5172),
('A0118150102',2018,5.6036),
('A0118150102',2019,5.3235),
('A0118150102',2020,5.7180),
('A0118150102',2021,6.2835),
('A0118150103',2018,5.9469),
('A0118150103',2019,5.5306),
('A0118150103',2020,6.3264);

select * from fact_manufacturing_cost;

select * from dim_product
where product_code In('A0118150101','A0118150102','A0118150103');
--

INSERT INTO fact_sales_monthly (date, product_code, customer_code, sold_quantity) VALUES
('2017-09-01','A0118150101',70002017,51),
('2017-09-01','A0118150101',70002018,77),
('2017-09-01','A0118150101',70003181,17),
('2017-09-01','A0118150101',70003182,6),
('2017-09-01','A0118150101',70006157,5),
('2017-09-01','A0118150101',70006158,7),
('2017-09-01','A0118150101',70007198,29),
('2017-09-01','A0118150101',70007199,34),
('2017-09-01','A0118150101',70008169,22),
('2017-09-01','A0118150101',70008170,5),
('2017-09-01','A0118150101',70011193,10),
('2017-09-01','B0218150105',70002017,20),  
('2017-09-01','C0418150109',70002018,30), 
('2017-10-01','A0118150101',70002017,40),
('2017-10-01','B0218150105',70002018,50),
('2017-10-01','C0418150109',70003181,60);


SELECT date, product_code, customer_code 
FROM fact_sales_monthly 
WHERE date = '2017-09-01'

INSERT INTO fact_sales_monthly (date, product_code, customer_code, sold_quantity) VALUES
('2017-09-01','B0218150105',70002017,20),  
('2017-09-01','C0418150109',70002018,30), 
('2017-10-01','A0118150101',70002017,40),
('2017-10-01','B0218150105',70002018,50),
('2017-10-01','C0418150109',70003181,60);

select * from fact_sales_monthly;
--

INSERT INTO fact_pre_invoice_deductions (customer_code, fiscal_year, pre_invoice_discount_pct) VALUES
(70002017,2018,0.0824),
(70002017,2019,0.0777),
(70002017,2020,0.0735),
(70002017,2021,0.0703),
(70002017,2022,0.1057),
(70002018,2018,0.2956),
(70002018,2019,0.2577),
(70002018,2020,0.2255),
(70002018,2021,0.2061),
(70002018,2022,0.2931),
(70003181,2018,0.0536);


--

INSERT INTO fact_forecast_monthly (date, fiscal_year, product_code, customer_code, forecast_quantity) VALUES
('2017-09-01',2018,'A0118150101',70002017,18),
('2017-09-01',2018,'A0118150101',70002018,11),
('2017-09-01',2018,'A0118150101',70003181,9),
('2017-09-01',2018,'A0118150101',70003182,6),
('2017-09-01',2018,'A0118150101',70006157,5),
('2017-09-01',2018,'A0118150101',70006158,6),
('2017-09-01',2018,'A0118150101',70007198,4),
('2017-09-01',2018,'A0118150101',70007199,7),
('2017-09-01',2018,'A0118150101',70008169,7),
('2017-09-01',2018,'A0118150101',70008170,8),
('2017-09-01',2018,'A0118150101',70011193,5);

--

INSERT INTO fact_post_invoice_deductions (Customer_Code, Product_Code, Date, Discount_pct, Other_Deductions_pct) VALUES
(70002017,'A0118150101','2017-09-01',0.2660,0.0719),
(70002017,'A0118150101','2017-10-01',0.3090,0.0976),
(70002017,'A0118150101','2017-11-01',0.3313,0.0752),
(70002017,'A0118150101','2018-01-01',0.2958,0.0720),
(70002017,'A0118150101','2018-02-01',0.3208,0.0793),
(70002017,'A0118150101','2018-03-01',0.2635,0.1007),
(70002017,'A0118150101','2018-05-01',0.2231,0.0820),
(70002017,'A0118150101','2018-06-01',0.3020,0.0791),
(70002017,'A0118150101','2018-07-01',0.3123,0.0929),
(70002017,'A0118150101','2018-09-01',0.1530,0.1288),
(70002017,'A0118150101','2018-10-01',0.1363,0.1542);


--Task 3:

--Q1) Assume calendar_date is '2023-07-15'. Apply the function to this date and explain what value it will return as the fiscal year.

Select case
When month('2023-07-15') >= 9
Then Year('2023-07-15') + 1
Else Year('2023-07-15')
End as fiscal_year;

--Q2) Analyzing Gross Sales: Monthly Product Transactions Report 
Write a Query for making report on monthly product transactions, including details such as date, product code, product name, variant, sold quantity, gross price, and gross price total. 
The query should involves joining several tables and filtering results based on customer code and fiscal year.

Select 
fs.date,
fs.Product_Code,
dp.Product as Product_Name,
dp.variant,
fs.Sold_Quantity,
fg.Gross_Price,
(fs.Sold_Quantity * fg.Gross_Price) as Gross_Price_Total
from
fact_sales_monthly fs
Inner Join dim_product dp on fs.Product_Code = dp.Product_Code
Inner Join fact_gross_price fg on fs.Product_Code = fg.Product_Code
Where fs.customer_code = Customer_Code
AND fg.fiscal_year = Fiscal_Year
Order By 
fs.Date,
fs.Product_Code;

SELECT * FROM fact_sales_monthly;
SELECT * FROM dim_product;
SELECT * FROM fact_gross_price;

--TASK 4

--Sales Trend Analysis:
---Query the fact_monthly_sales table to identify the monthly sales trend for each product. How do the sales volumes fluctuate over time?
Select 
Product_Code,
Datepart(Year, Date) as Sales_Year,
Datepart(Month, Date) as Sales_Month,
Sum(Sold_Quantity) as Total_Sold_Quantity
From
fact_sales_monthly
Group By
Product_Code,
Datepart(Year, Date),
Datepart(Month, Date)
Order BY 
Product_Code,
Sales_Year,
Sales_Month;

--Customer Segmentation: Utilizing the dim_customer table, segment customers based on their purchasing behavior. Which customer segments contribute the most to sales revenue?
--(Segment By Platform)
Select dc.Platform,
sum(fs.sold_Quantity) as Total_Units_Sold
From
dim_customer dc
Inner Join fact_sales_monthly fs on dc.customer_code = fs.customer_code
Group By 
dc.platform
Order By
Total_Units_Sold Desc;

--(Segment By Region)

SELECT dc.region,
       SUM(fs.sold_quantity * fg.gross_price) AS total_sales_revenue
FROM dim_customer dc
INNER JOIN fact_sales_monthly fs ON dc.customer_code = fs.customer_code
INNER JOIN fact_gross_price fg ON fs.product_code = fg.product_code
GROUP BY dc.region
ORDER BY total_sales_revenue DESC;

--Product Performance Comparison:
--Compare the performance of products in terms of sales quantity and revenue generated. Which products are the top performers, and which ones need improvement?
Select 
fs.Product_Code,
dp.Product as product_name,
Sum(fs.Sold_Quantity) as Total_Sold_Quantity,
Sum(fs.Sold_Quantity * fg.Gross_Price) as Total_Sales_Revenue
From
Fact_Sales_Monthly fs
Inner Join dim_Product dp on fs.Product_Code = dp.Product_Code
Inner Join fact_gross_price fg on fs.Product_Code = fg.Product_code
Group by 
fs.Product_Code,
dp.Product
Order by
Total_Sales_Revenue Desc, Total_Sold_Quantity Desc;

SELECT DISTINCT YEAR(date) FROM fact_sales_monthly;
SELECT DISTINCT fiscal_year FROM fact_gross_price;

--Market Expansion Opportunities:
-- Analyze the fact_forecast_monthly table to identify potential market expansion opportunities. Which markets show the highest forecasted demand growth?
Select 
dc.market,
ff.Fiscal_year, 
Sum(ff.forecast_quantity) as Total_Forecast_Demand
From
fact_forecast_monthly ff
Inner join dim_customer dc on ff.Customer_Code = dc.Customer_Code
Group By 
dc.Market,
ff.Fiscal_Year
Order By
Dc.market,
ff.Fiscal_Year;

--Cost Analysis:
--Calculate the total manufacturing cost for each product and compare it with the gross price to determine profitability. Which products have the highest profit margins?
Select
mc.product_code,
dp.product as Product_Name,
mc.cost_year,
fg.gross_price,
mc.manufacturing_cost,
(fg.gross_price - mc.manufacturing_cost) as Profit,
Round((fg.gross_price - mc.manufacturing_cost)/ fg.gross_price * 100,2) as Profit_Margin_pct
From
fact_manufacturing_cost mc
Inner Join fact_gross_price fg on mc.product_code = fg.product_code and mc.cost_year = fg.fiscal_year
Inner Join dim_product dp on mc.Product_Code = dp.Product_code
Order By
profit_margin_pct Desc;

--Discount Impact Analysis:
--Assess the impact of pre-invoice discounts on sales revenue. How do varying discount levels affect overall revenue and customer retention?

Select
fs.Customer_Code,
Sum(fs.sold_quantity * fg.gross_price) as Gross_Revenue,
Sum(fs.sold_quantity * fg.gross_price * (1-pid.pre_invoice_discount_pct)) as Net_Revenue,
avg(pid.pre_invoice_discount_pct) as avg_discount
From
fact_sales_monthly fs
Inner Join fact_gross_price fg on fs.Product_code = fg.Product_Code
Inner Join fact_pre_invoice_deductions pid on fs.customer_code = pid.customer_code 
Group By 
fs.Customer_Code
Order By
net_revenue Desc;

--Market-specific Freight Costs:
--Determine the average freight costs for different markets over the years. Are there any noticeable trends or outliers in freight expenses?

Select
Market,
Fiscal_Year,
AVG(Freight_pct) as AVG_Freight_pct,
AVG(Other_cost_pct) as AVG_Other_Cost_pct
from
fact_freight_cost
Group By
Market,
Fiscal_Year
Order By 
Market,
Fiscal_Year;

--Seasonal Sales Patterns:
--Explore the fact_monthly_sales table to identify seasonal sales patterns. How do sales volumes vary throughout the year, and are there any recurring trends?
Select
Year(date) as Sales_Year,
MOnth(Date) as Sales_Month,
Sum(Sold_Quantity) as Total_Sold_Quantity
From
Fact_Sales_Monthly
Group By
Year(date),
Month(date)
Order By
Sales_Year,
Sales_Month;

--Customer Loyalty Analysis:
--Analyze customer purchase frequency and retention rates over time. Which customers exhibit the highest levels of loyalty, and how can their behavior be leveraged for targeted marketing campaigns?
Select
fs.Customer_Code,
Count(Distinct Year(fs.Date) * 100 + Month(fs.date)) as Purchase_Frequency,
Min(fs.date) as First_Purchase,
Max(fs.date) as Last_Purchase,
Count(Distinct Year(fs.date)) as Active_Years
From
fact_Sales_Monthly fs
Group By
fs.Customer_Code
Order BY
Purchase_Frequency Desc, Active_Years Desc;

--Forecast Accuracy Evaluation:
--Evaluate the accuracy of sales forecasts by comparing forecasted quantities with actual sales data. Are there any significant discrepancies, and how can forecast models be improved?
SELECT
    f.Product_Code,
    f.Customer_Code,
    f.fiscal_year,
    SUM(f.forecast_quantity) AS Total_Forecast,
    SUM(s.sold_quantity) AS Total_Actual,
    SUM(s.sold_quantity) - SUM(f.forecast_quantity) AS Variance,
    ROUND(
      (SUM(s.sold_quantity) - SUM(f.forecast_quantity)) * 100.0 / NULLIF(SUM(f.forecast_quantity), 0), 
      2
    ) AS Percent_Variance
FROM
    fact_forecast_monthly f
    LEFT JOIN fact_sales_monthly s
      ON f.Product_Code = s.Product_Code
      AND f.Customer_Code = s.Customer_Code
      AND YEAR(s.date) = f.Fiscal_Year
GROUP BY
    f.Product_Code, f.Customer_Code, f.Fiscal_Year
ORDER BY
    Percent_Variance DESC;


--Channel Performance Assessment:
--Compare sales performance across different sales channels (e.g., E-Commerce vs. Brick & Mortar). Which channels are most effective in driving sales, and are there any opportunities for optimization?
Select
dc.Channel,
Sum(fs.Sold_Quantity) as Total_Units_Sold,
Sum(fs.Sold_Quantity * fg.Gross_Price) as Total_Revenue
From
dim_Customer dc
Inner Join fact_Sales_Monthly fs on dc.Customer_Code = fs.Customer_Code
Inner Join fact_Gross_Price fg on fs.Product_Code = fg.Product_Code
Group By
dc.Channel
Order By
Total_Revenue Desc;

--Geographical Sales Distribution:
--Analyze sales distribution across different geographical regions. How does sales performance vary by region, and are there any emerging markets worth focusing on?
Select
dc.Region,
Sum(fs.Sold_Quantity) as Total_Units_Sold,
Sum(fs.Sold_Quantity * fg.Gross_Price) as Total_Revenue
From
dim_Customer dc
Inner Join fact_Sales_Monthly fs on dc.Customer_Code = fs.Customer_Code
Inner Join fact_Gross_Price fg on fs.Product_Code = fg.Product_Code
Group By
dc.Region
Order By
Total_Revenue Desc;

--Customer Acquisition Cost Analysis:
--Calculate the customer acquisition cost (CAC) for each market and channel. Which acquisition channels provide the highest return on investment (ROI), and where should resources be allocated for customer acquisition?

CREATE TABLE fact_acquisition_cost (
    market VARCHAR(45),
    channel VARCHAR(45),
    acquisition_cost DECIMAL(15,2),
    period INT
);

INSERT INTO fact_acquisition_cost (market, channel, acquisition_cost, period) VALUES ('India', 'E-Commerce', 50000, 2024);
INSERT INTO fact_acquisition_cost (market, channel, acquisition_cost, period) VALUES ('India', 'Brick & Mortar', 35000, 2024);
INSERT INTO fact_acquisition_cost (market, channel, acquisition_cost, period) VALUES ('Europe', 'E-Commerce', 60000, 2024);
INSERT INTO fact_acquisition_cost (market, channel, acquisition_cost, period) VALUES ('Europe', 'Brick & Mortar', 45000, 2024);
INSERT INTO fact_acquisition_cost (market, channel, acquisition_cost, period) VALUES ('LATAM', 'Social Media', 20000, 2024);
INSERT INTO fact_acquisition_cost (market, channel, acquisition_cost, period) VALUES ('LATAM', 'E-Commerce', 25000, 2024);
INSERT INTO fact_acquisition_cost (market, channel, acquisition_cost, period) VALUES ('APAC', 'E-Commerce', 30000, 2024);
INSERT INTO fact_acquisition_cost (market, channel, acquisition_cost, period) VALUES ('APAC', 'Channel Partners', 18000, 2024);

Select * from fact_acquisition_cost;

SELECT
    ac.Market,
    ac.Channel,
    ac.Acquisition_Cost,
    COUNT(DISTINCT fs.Customer_Code) AS Customers_Acquired,
    SUM(fs.sold_quantity * fg.gross_price) AS Sales_Revenue,
    ac.Acquisition_Cost / NULLIF(COUNT(DISTINCT fs.Customer_Code), 0) AS CAC,
    SUM(fs.Sold_Quantity * fg.gross_price) / NULLIF(ac.Acquisition_Cost, 0) AS ROI
FROM
    fact_acquisition_cost ac
    INNER JOIN dim_Customer dc ON ac.Market = dc.Market AND ac.Channel = dc.Channel
    INNER JOIN fact_sales_monthly fs ON dc.Customer_Code = fs.Customer_Code
    INNER JOIN fact_gross_price fg ON fs.Product_Code = fg.Product_Code
        AND YEAR(fs.date) = fg.Fiscal_Year
GROUP BY ac.Market, ac.Channel, ac.Acquisition_Cost
ORDER BY ROI DESC;

SELECT ac.Market, ac.Channel, dc.Market, dc.Channel
FROM fact_acquisition_cost ac
INNER JOIN dim_Customer dc ON ac.Market = dc.Market;

INSERT INTO dim_Customer (Customer_Code, Market, Channel) VALUES ('CUST001', 'India', 'E-Commerce');
INSERT INTO fact_sales_monthly (Customer_Code, Product_Code, Date, Sold_Quantity) VALUES ('CUST001', 'PROD001', '2024-03-01', 100);
-- ... matching data for gross price etc.

--Product Mix Optimization:
--Determine the optimal product mix based on sales volume, profitability, and market demand. How can product portfolios be adjusted to maximize overall revenue?
Select
p.Product_Code,
p.Product as Product_Name,
Sum(fs.Sold_Quantity) as Total_Sales_Volume,
Sum(fs.Sold_Quantity * fg.Gross_Price) as Total_Revenue,
AVG(fg.Gross_Price - mc.manufacturing_cost) as AVG_Profit_Per_Unit,
Sum(fm.forecast_quantity) as Forecasted_Demand
FROM
    dim_product p
    LEFT JOIN fact_sales_monthly fs ON p.Product_Code = fs.Product_Code
    LEFT JOIN fact_gross_price fg ON fs.Product_Code = fg.Product_Code AND YEAR(fs.Date) = fg.Fiscal_Year
    LEFT JOIN fact_manufacturing_cost mc ON p.Product_Code = mc.Product_Code AND mc.Cost_Year = fg.Fiscal_Year
    LEFT JOIN fact_forecast_monthly fm ON p.Product_Code = fm.Product_Code
Group By
p.Product_Code, p.product
Order BY
Total_Revenue Desc, AVG_Profit_Per_Unit Desc, forecasted_Demand Desc;

--Customer Lifetime Value Calculation:
--Calculate the customer lifetime value (CLV) for each customer segment. Which segments are the most valuable in terms of  long-term revenue generation?
Select
dc.Channel,
Count(Distinct fs.Customer_Code) as Customers,
Sum(fs.sold_quantity * fg.gross_price) as Total_Revenue,
Sum(fs.sold_quantity * fg.gross_price) / Count(Distinct fs.Customer_Code) as AVG_CLV
From
dim_Customer dc
Inner Join fact_sales_monthly fs on dc.Customer_Code = fs.Customer_Code
Inner Join fact_gross_price fg on fs.Product_Code = fg.Product_Code
Group By
dc.Channel
Order By
AVG_clv Desc, Total_Revenue DESC;

--Inventory Management Analysis:
--Analyze inventory turnover rates and identify slow-moving or obsolete products. How can inventory management practices be optimized to reduce carrying costs and improve cash flow?

SELECT
    p.Product_Code,
    p.Product,
    SUM(fs.sold_quantity) AS Total_Units_Sold,
    COUNT(DISTINCT YEAR(fs.date) * 100 + MONTH(fs.date)) AS Active_Months,
    CASE 
        WHEN COUNT(DISTINCT YEAR(fs.date) * 100 + MONTH(fs.date)) = 0 THEN 0
        ELSE ROUND(SUM(fs.sold_quantity) * 1.0 / COUNT(DISTINCT YEAR(fs.date) * 100 + MONTH(fs.date)), 2)
    END AS AVG_Monthly_Sales
FROM
    dim_product p
    LEFT JOIN fact_sales_monthly fs ON p.product_code = fs.product_code
GROUP BY
    p.product_code, p.product
ORDER BY
    AVG_Monthly_Sales ASC, Total_Units_Sold ASC;


--Competitor Benchmarking:
--Compare sales performance with competitors in the same market segments. How does your company's market share and growth rate compare to industry benchmarks?


--Price Elasticity Estimation:
--Assess the price elasticity of demand for different product categories. How sensitive are sales volumes to changes in product prices, and what pricing strategies can be implemented to maximize revenue?
Select
p.Category,
Year(fs.Date) as Sales_Year,
AVG(fg.gross_price) as AVG_Price,
Sum(fs.sold_quantity) as Total_Units_Sold
From
dim_product p
Inner Join fact_gross_price fg on p.product_code = fg.product_code
Inner Join fact_sales_monthly fs on p.product_code = fs.product_code
Group By
p.category, Year(fs.Date)
Order By
p.category, Sales_Year;


SELECT DISTINCT YEAR(date) AS sales_year FROM fact_sales_monthly;
SELECT DISTINCT fiscal_year FROM fact_gross_price;


--Customer Satisfaction Analysis:
--Utilize customer feedback data to assess overall satisfaction levels and identify areas for improvement. How do customer satisfaction scores correlate with sales performance?

--Feedback Table
CREATE TABLE customer_feedback (
    feedback_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_code INT,
    feedback_date DATE,
    satisfaction_score INT, 
    comments VARCHAR(500)
);

--Data into Feedback table
INSERT INTO customer_feedback (customer_code, feedback_date, satisfaction_score, comments) VALUES
(7002104, '2025-10-15', 9, 'Great online experience, quick delivery.'),
(70021096, '2025-10-16', 8, 'Service was good, product as described.'),
(70022084, '2025-10-17', 6, 'Average selection, but store staff helpful.'),
(70022085, '2025-10-18', 10, 'Loved the product and fast shipping!'),
(70023031, '2025-10-19', 5, 'Some issues with payment, overall fine.'),
(70023032, '2025-10-20', 7, 'Decent selection but packaging was subpar.'),
(70022606, '2025-10-21', 4, 'Had to wait for customer support, slow process.'),
(70022708, '2025-10-22', 5, 'Product quality OK, delivery late.'),
(80001019, '2025-10-23', 8, 'Satisfied, will return for more electronics.'),
(80006154, '2025-10-24', 7, 'Store was clean, staff knowledgeable.'),
(80006155, '2025-10-25', 6, 'Product range needs improvement.'),
(70002017, '2017-09-01', 51, 'Automated score entry.'),
(70002018, '2017-09-01', 77, 'Automated score entry.'),
(70003181, '2017-09-01', 17, 'Automated score entry.'),
(70003182, '2017-09-01', 6, 'Automated score entry.'),
(70006157, '2017-09-01', 5, 'Automated score entry.'),
(70006158, '2017-09-01', 7, 'Automated score entry.'),
(70007198, '2017-09-01', 29, 'Automated score entry.'),
(70007199, '2017-09-01', 34, 'Automated score entry.'),
(70008169, '2017-09-01', 22, 'Automated score entry.'),
(70008170, '2017-09-01', 5, 'Automated score entry.'),
(70011193, '2017-09-01', 10, 'Automated score entry.');

select * from customer_feedback;

SELECT
    f.satisfaction_score,
    COUNT(DISTINCT f.customer_code) AS num_customers,
    SUM(fs.sold_quantity * fg.gross_price) AS total_revenue
FROM
    customer_feedback f
    INNER JOIN fact_sales_monthly fs ON f.customer_code = fs.customer_code
    INNER JOIN fact_gross_price fg ON fs.product_code = fg.product_code
     GROUP BY
    f.satisfaction_score
ORDER BY
    f.satisfaction_score DESC;

SELECT DISTINCT customer_code FROM customer_feedback;
SELECT DISTINCT customer_code FROM fact_sales_monthly;

SELECT satisfaction_score, COUNT(*) FROM customer_feedback GROUP BY satisfaction_score;

--Marketing Campaign Effectiveness:
--Evaluate the effectiveness of marketing campaigns in driving sales and brand awareness. Which campaigns have yielded the highest return on investment, and how can future campaigns be optimized for better results?

CREATE TABLE Marketing_Campaign (
    campaign_id INT IDENTITY(1,1) PRIMARY KEY,
    campaign_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    cost DECIMAL(15,2),
    channel VARCHAR(50),
    market VARCHAR(50)
);

INSERT INTO Marketing_Campaign (campaign_name, start_date, end_date, cost, channel, market) VALUES
('Spring Sale Europe', '2025-03-01', '2025-03-31', 55000, 'E-Commerce', 'Europe'),
('Summer Brand Push LATAM', '2025-06-15', '2025-07-15', 39000, 'Social Media', 'LATAM'),
('USA Back-to-School', '2025-08-10', '2025-08-31', 72000, 'Brick & Mortar', 'USA'),
('APAC Hardware Expo', '2025-05-10', '2025-05-20', 37000, 'Trade Show', 'APAC'),
('Holiday Blitz UK', '2025-12-01', '2025-12-31', 48000, 'E-Commerce', 'United Kingdom');

select * from Marketing_Campaign;


UPDATE fact_gross_price
SET gross_price = 100.0
WHERE product_code = 'A0118150101' AND fiscal_year = 2017;

select * from fact_gross_price;

INSERT INTO Marketing_Campaign (campaign_name, start_date, end_date, cost, channel, market)
VALUES ('September 2017 Direct Promo', '2017-09-01', '2017-09-01', 15000, 'Direct', 'Multi-region');

SELECT
    c.campaign_name,
    SUM(fs.sold_quantity * fg.gross_price) AS Campaign_Sales,
    SUM(fs.sold_quantity * fg.gross_price) / c.cost AS ROI
FROM
    marketing_campaign c
    INNER JOIN fact_sales_monthly fs ON fs.date BETWEEN c.start_date AND c.end_date
    INNER JOIN fact_gross_price fg ON fs.product_code = fg.product_code
      AND YEAR(fs.date) = fg.fiscal_year
GROUP BY
    c.campaign_name, c.cost
ORDER BY
    ROI DESC;


--TASK: 5
--1. Define a user-defined function to calculate the total forecasted quantity for a given product and fiscal year.
Create Function dbo.TotalForecastedQuantity
(
@ProductCode Varchar(45),
@FiscalYear Int
)
Returns Int
As
Begin
Declare @TotalQuantity Int;
Select @TotalQuantity = ISNULL(sum(forecast_quantity),0)
From fact_forecast_monthly
Where product_code = @ProductCode and fiscal_year = @FiscalYear;

Return @TotalQuantity;
End;

SELECT dbo.TotalForecastedQuantity('A0118150101', 2017) AS TotalForecastedQty;


SELECT * FROM fact_forecast_monthly
WHERE product_code = 'A0118150101' AND fiscal_year = 2017;


--2. Write a query to find the customers who made purchases exceeding the average monthly sales quantity across all products.
With AVGMonthlySales as (
Select
AVG(Monthly_Sales) as AVG_Monthly_Sales
from(
Select
Year(date) as Sales_Year,
Month(date) as Sales_Month,
Sum(sold_quantity) as Monthly_Sales
from fact_sales_monthly
Group By Year(date), Month(date)
) monthly_summary
)

Select
dc.customer_code,
dc.customer,
Sum(fs.sold_quantity) as Total_purchase_qty
from
dim_customer dc
Inner Join fact_sales_monthly fs on dc.customer_code = fs.customer_code
Group By
dc.customer_code,
dc.customer
Having
Sum(fs.sold_quantity) > (Select AVG_Monthly_Sales from AvgMonthlySales)
Order By 
total_purchase_qty Desc;

SELECT
    AVG(Monthly_Sales) AS AVG_Monthly_Sales
FROM (
    SELECT
        YEAR(date) AS Sales_Year,
        MONTH(date) AS Sales_Month,
        SUM(sold_quantity) AS Monthly_Sales
    FROM fact_sales_monthly
    GROUP BY YEAR(date), MONTH(date)
) monthly_summary;

SELECT
    dc.customer_code,
    dc.customer,
    SUM(fs.sold_quantity) AS Total_purchase_qty
FROM
    dim_customer dc
    INNER JOIN fact_sales_monthly fs ON dc.customer_code = fs.customer_code
GROUP BY
    dc.customer_code, dc.customer
ORDER BY
    Total_purchase_qty DESC;

--3. Create a stored procedure to update the gross price of a product for a specific fiscal year.
Create Procedure UpdateGrossPrice
@ProductCode varchar(45),
@FiscalYear Int,
@NewGrossPrice Decimal(15,2)
as
Begin
Update fact_gross_price
Set gross_price = @NewGrossPrice
Where product_code = @ProductCode and  fiscal_year = @FiscalYear;
End;

--4. Implement a trigger that automatically inserts a record into the audit log table whenever a new entry is added to the sales table.
Create Table sales_audit_log (
Audit_id Int Identity(1,1) Primary Key,
Sale_Date Date,
product_code varchar(45),
customer_code Int,
sold_quantity Int,
Inserted_at DateTime Default GetDate()
);

Create Trigger trg_AuditSalesInsert
On fact_sales_monthly
After Insert
As
Begin
Insert Into sales_audit_log (Sale_Date, product_code, customer_code, sold_quantity)
Select date, product_code, customer_code, sold_quantity
from inserted;
End;

--5. Use a window function to rank products based on their monthly sales quantity, partitioned by fiscal year.
Select 
Year(fs.date) AS fiscal_year,
Month(fs.date) as sales_month,
fs.product_code,
Sum(fs.sold_quantity) as monthly_sales_qty,
Rank() Over(
Partition By Year(fs.date), Month(fs.date)
Order By Sum(fs.sold_quantity) Desc
) as product_rank
from
fact_sales_monthly fs
Group By 
Year(fs.date),
Month(fs.date),
fs.product_code
Order By
fiscal_year,
sales_month,
product_rank;

--6. Utilize the STRING_AGG function to concatenate the names of all customers who purchased a specific product within a given timeframe.
Select 
fs.product_code,
String_Agg(dc.customer,',') as Customer_Names
from
fact_sales_monthly fs
Inner Join dim_customer dc on fs.customer_code = dc.customer_code
Where 
fs.date between '2017-09-01' and '2017-09-30'
Group by 
fs.product_code;

--7. Develop a user-defined function that calculates the total manufacturing cost for a product over a specified range of years, using a subquery to retrieve the necessary data.

Create Function dbo.TotalManufacturingCost
(
@ProductCode varchar(45),
@StartYear Int,
@EndYear Int
)
Returns Decimal (18,2)
as
Begin
Declare @TotalCost Decimal(18,2);

Select @TotalCost = ISNull(Sum(manufacturing_cost),0)
from fact_manufacturing_cost
Where product_code = @ProductCode
and Cost_Year Between @StartYear and @EndYear

Return @TotalCost;
End;

SELECT
product_code,
dbo.TotalManufacturingCost(product_code, 2016,2018) as Total_Mfg_Cost
from
(Select Distinct product_code from fact_manufacturing_cost) as p;

--8. Design a stored procedure to insert new records into the sales table and use a trigger to enforce constraints on the quantity sold, ensuring it doesn't exceed the available inventory.
Create Procedure InsertSales
@Date Date,
@product_code varchar(45),
@customer_code Int,
@sold_quantity Int
As
Begin
Insert Into fact_sales_monthly (date,product_code, customer_code, sold_quantity)
values (@date, @product_code, @customer_code, @sold_quantity);
End;

Create Trigger Trg_Inventory_SalesCheck
on fact_sales_monthly
Instead of Insert
as
Begin
If Exists(
Select 1
from inserted i
Inner Join inventory_master im on i.product_code = im.product_code
Where i.sold_quantity > im.available_quantity
)
Begin
Raiserror('Sold Quantity exceeds available inventory.',16,1);
Rollback Transaction;
Return;
end

INSERT INTO fact_sales_monthly (date, product_code, customer_code, sold_quantity)
    SELECT date, product_code, customer_code, sold_quantity FROM inserted;

UPDATE im
    SET im.available_quantity = im.available_quantity - i.sold_quantity
    FROM inventory_master im
    INNER JOIN inserted i ON im.product_code = i.product_code;
END;

--9. Apply the LEAD or LAG function to compare monthly sales quantities of a product with the previous month's sales.
Select
product_code,
year(date) As Sales_Year,
Month(date) as Sales_Month,
Sum(sold_quantity) as Current_Month_Sales,
LAG(SUM(sold_quantity)) over(
Partition by product_code
Order By Year(date), Month(date)
) as Pre_Month_Sales,
SUm(sold_quantity) -
LAG(SUM(sold_quantity)) over (
Partition by product_code
Order by Year(date) , Month(date)
) as Sales_Difference 
From
fact_sales_monthly
Group By 
product_code,
Year(date),
Month(date)
Order By
product_code,
Sales_Year,
Sales_Month;

--10. Create a query to identify the top-selling products in each market based on their total sales quantity, utilizing subqueries and window functions.
With ProductMarketSales as (
Select
fs.product_code,
dc.market,
sum(fs.sold_quantity) as Total_Quantity
from
fact_sales_monthly fs
Inner Join dim_customer dc on fs.customer_code = dc.customer_code
Group by
fs.product_code,
dc.market
),
RankedProducts as (
Select
product_code,
market,
Total_Quantity,
Rank() Over (Partition by Market order by Total_Quantity Desc) as Product_Rank
from
ProductMarketSales
)
Select
product_code,
Market,
Total_Quantity
from
RankedProducts
Where
product_rank = 1
Order By
Market,
product_code;

--11. Develop a user-defined function to calculate the total freight cost for a product based on its market and fiscal year. Then, integrate this function into a stored procedure to update the overall cost.
Create Function dbo.TotalFreightCost
(
@dim_product_product_code varchar(45),
@Market varchar(45),
@FiscalYear Int
)
Returns Decimal(18,2)
As
Begin
Declare @TotalCost Decimal(18,2);

Select @TotalCost = ISNULL(SUM(freight_pct), 0)
from fact_freight_cost
Where Other_Cost_pct = @dim_product_product_code
and Market = @Market
and fiscal_year = @fiscalYear;

Return @TotalCost;
End;

---
Create Procedure UpdateOverallCost
@dim_product_product_code Varchar(45),
@Market varchar(50),
@fiscalYear Int
AS
Begin
Declare @FreightCost Decimal(18,2);
Set @FreightCost = dbo.TotalFreightCost(@dim_product_product_code, @Market, @FiscalYear);

Update Product_Overall_Cost
Set overall_cost = Overall_cost + @FreightCost
Where product_code = @dim_product_product_code
And Market = @Market
And fiscal_year = @fiscalYear;
End;

SELECT 
    dbo.TotalFreightCost('A0118150103', 'Europe', 2025) AS Total_Freight_Cost;


--12. Write a trigger that automatically updates the inventory count in the product table whenever a new sale is recorded, utilizing inbuilt functions to perform the calculation.
Create Trigger TRIG_UpdateInventoryonSales
on fact_sales_monthly
After insert
as
Begin
Set NOCOUNT on;
Update p
Set p.inventory_count = p.inventory_count - i.sold_quantity
from dim_product p
Inner Join inserted i On p.product_code = i.product_code;
End;

Alter table dim_product
Add inventory_count Int Default 0;

--13. Implement a trigger to enforce referential integrity, ensuring that only products listed in the product table can be added to the sales table, utilizing subqueries to validate the data.


--14. Design a stored procedure to generate a report showing the month-over-month growth rate of sales for each product, using window functions to calculate the percentage change.
CREATE PROCEDURE sp_ProductSalesMoMGrowthReport
AS
BEGIN
    
    WITH MonthlyProductSales AS (
        SELECT
            product_code,
            YEAR([date]) AS sales_year,
            MONTH([date]) AS sales_month,
            SUM(sold_quantity) AS monthly_sales
        FROM fact_sales_monthly
        GROUP BY product_code, YEAR([date]), MONTH([date])
    ),
    GrowthRates AS (
        SELECT
            product_code,
            sales_year,
            sales_month,
            monthly_sales,
            LAG(monthly_sales) OVER (PARTITION BY product_code ORDER BY sales_year, sales_month) AS prev_month_sales,
            CASE
                WHEN LAG(monthly_sales) OVER (PARTITION BY product_code ORDER BY sales_year, sales_month) = 0 
                     OR LAG(monthly_sales) OVER (PARTITION BY product_code ORDER BY sales_year, sales_month) IS NULL
                THEN NULL
                ELSE
                    CAST((monthly_sales - LAG(monthly_sales) OVER (PARTITION BY product_code ORDER BY sales_year, sales_month)) AS FLOAT) 
                    / LAG(monthly_sales) OVER (PARTITION BY product_code ORDER BY sales_year, sales_month) * 100
            END AS growth_pct
        FROM MonthlyProductSales
    )
    SELECT
        product_code,
        sales_year,
        sales_month,
        monthly_sales,
        prev_month_sales,
        growth_pct
    FROM GrowthRates
    ORDER BY product_code, sales_year, sales_month;
END;

EXEC sp_ProductSalesMoMGrowthReport;

--15. Develop a user-defined function to calculate the average discount percentage given to customers for a specific product, utilizing inbuilt functions to aggregate and analyze the data.
Create Function dbo.AvgDiscountPctForProduct (
@ProductCode varchar(45)
)
Returns Decimal(10,4)
as
Begin
Return (

Select AVG(Cast(Discount_pct as Decimal(10,4)))
from fact_post_invoice_deductions
Where Product_Code = @ProductCode
);
End;

SELECT dbo.AvgDiscountPctForProduct('A0118150101') AS Avg_Discount_Percentage;

--16. Write a query to identify the customers who made the highest total purchases in each region, using subqueries and window functions to perform the analysis.
WITH CustomerRegionTotals AS (
    SELECT
        dc.region,
        fs.customer_code,
        dc.customer,
        SUM(fs.sold_quantity) AS total_purchases
    FROM
        fact_sales_monthly fs
        INNER JOIN dim_customer dc ON fs.customer_code = dc.customer_code
    GROUP BY
        dc.region,
        fs.customer_code,
        dc.customer
),
RankedCustomers AS (
    SELECT
        region,
        customer_code,
        customer,
        total_purchases,
        RANK() OVER (PARTITION BY region ORDER BY total_purchases DESC) AS customer_rank
    FROM
        CustomerRegionTotals
)
SELECT
    region,
    customer_code,
    customer,
    total_purchases
FROM
    RankedCustomers
WHERE
    customer_rank = 1
ORDER BY
    region,
    customer;

--17. Create a stored procedure to calculate the total revenue generated from sales for a given period, using inbuilt functions to handle date manipulation and aggregation.
Create Procedure sp_TotalRevenueForPeriod
@StartDate Date,
@EndDate Date
AS
Begin
Select 
Sum(fs.sold_quantity *gp.gross_price) as Total_Revenue
From
fact_sales_monthly fs
Inner Join  fact_gross_price gp
on fs.product_code = gp.product_code
and Year(fs.date) = gp.fiscal_year
Where 
fs.date Between @StartDate and @EndDate;
End;

--18. Implement a trigger to automatically update the forecasted quantity in the forecast table whenever a new product is added to the product table, utilizing a userdefined function to calculate the forecast.
Create Function dbo.CalculateForecastForNewProduct (
@ProductCode varchar(45)
)
Returns Int
As
Begin
Return 100;
End;

Create Trigger Trig_InsertForecastonNewProduct
on dim_product
After Insert
as
Begin
Set NOCOUNT ON;
Insert Into fact_forecast_monthly(date,fiscal_year,product_code, customer_code, forecast_quantity)
Select
GetDate(),
Year(GetDate()),
i.product_code,
70002017,
dbo.CalculateForecastForNewProduct(i.product_code)
From Inserted i;
End;

--19. Develop a trigger to identify outliers in the monthly sales data and flag them for further investigation, leveraging window functions to detect deviations from the expected sales patterns.
ALTER TABLE fact_sales_monthly
ADD outlier_flag BIT DEFAULT 0;

Select * from fact_sales_monthly;

CREATE TRIGGER trg_FlagSalesOutliers
ON fact_sales_monthly
AFTER INSERT
AS
BEGIN
    -- Flag as outlier if the sold_quantity is outside [avg - 2*stdev, avg + 2*stdev]
    UPDATE fs
    SET fs.outlier_flag = 1
    FROM fact_sales_monthly fs
    INNER JOIN inserted i ON 
        fs.date = i.date AND 
        fs.product_code = i.product_code AND
        fs.customer_code = i.customer_code
    WHERE
        i.sold_quantity > (
            SELECT AVG(sold_quantity) + 2*STDEV(sold_quantity)
            FROM fact_sales_monthly
            WHERE product_code = i.product_code
                  AND YEAR(date) = YEAR(i.date)
                  AND MONTH(date) = MONTH(i.date)
        )
        OR
        i.sold_quantity < (
            SELECT AVG(sold_quantity) - 2*STDEV(sold_quantity)
            FROM fact_sales_monthly
            WHERE product_code = i.product_code
                  AND YEAR(date) = YEAR(i.date)
                  AND MONTH(date) = MONTH(i.date)
        );
END;

--20. Write a query to retrieve the products with the highest average gross price across all fiscal years, using subqueries and inbuilt functions to perform the analysis
WITH ProductAvgGrossPrice AS (
    SELECT
        product_code,
        AVG(gross_price) AS avg_gross_price
    FROM
        fact_gross_price
    GROUP BY
        product_code
)
SELECT
    pagp.product_code,
    dp.product,
    dp.variant,
    pagp.avg_gross_price
FROM
    ProductAvgGrossPrice pagp
    INNER JOIN dim_product dp ON pagp.product_code = dp.product_code
WHERE
    pagp.avg_gross_price = (
        SELECT MAX(avg_gross_price) FROM ProductAvgGrossPrice
    )
ORDER BY
    pagp.product_code;


--TASK 6:

SELECT
    f.fiscal_year,
    MONTH(f.date) AS Month,
    SUM(f.forecast_quantity) AS Total_Forecast,
    SUM(s.sold_quantity) AS Total_Sold,
    CASE 
        WHEN SUM(f.forecast_quantity) > 0 
        THEN ROUND(100.0 * SUM(s.sold_quantity) / SUM(f.forecast_quantity), 2)
        ELSE NULL
    END AS Forecast_Accuracy_Pct
FROM
    fact_forecast_monthly f
    LEFT JOIN fact_sales_monthly s
        ON f.product_code = s.product_code
        AND f.customer_code = s.customer_code
        AND MONTH(f.date) = MONTH(s.date)
        AND YEAR(f.date) = YEAR(s.date)
WHERE
    f.product_code = 'A0118150101'
GROUP BY
    f.fiscal_year,
    MONTH(f.date)
ORDER BY
    f.fiscal_year,
    MONTH(f.date);


SELECT *
FROM
(
    SELECT
        f.fiscal_year,
        DATENAME(MONTH, f.date) AS Month,
        SUM(f.forecast_quantity) AS Total_Forecast,
        SUM(s.sold_quantity) AS Total_Sold,
        CASE 
            WHEN SUM(f.forecast_quantity) > 0 
            THEN ROUND(100.0 * SUM(s.sold_quantity) / SUM(f.forecast_quantity), 2)
            ELSE NULL
        END AS Forecast_Accuracy_Pct
    FROM
        fact_forecast_monthly f
        LEFT JOIN fact_sales_monthly s
            ON f.product_code = s.product_code
            AND f.customer_code = s.customer_code
            AND MONTH(f.date) = MONTH(s.date)
            AND YEAR(f.date) = YEAR(s.date)
    WHERE
        f.product_code = 'A0118150101'
    GROUP BY
        f.fiscal_year,
        DATENAME(MONTH, f.date)
) SourceTable
PIVOT 
(
    MAX(Forecast_Accuracy_Pct)
    FOR Month IN ([January], [February], [March], [April], [May], [June], [July], [August], [September], [October], [November], [December])
) AS PivotedTable;


