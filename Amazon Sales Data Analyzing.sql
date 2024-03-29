USE HEMANT;

CREATE TABLE AMAZON (
REGION VARCHAR (100) NOT NULL,
COUNTRY VARCHAR (60) NOT NULL,
ITEM_TYPE VARCHAR (100) NOT NULL,
SALES_CHANNEL VARCHAR (50) NOT NULL,
ORDER_PRIORITY VARCHAR (20) NOT NULL,
ORDER_DATE DATE NOT NULL,
ORDER_ID INT NOT NULL PRIMARY KEY,
SHIP_DATE DATE NOT NULL,
UNITS_SOLD INT NOT NULL,
UNIT_PRICE INT NOT NULL,
UNIT_COST INT NOT NULL,
TOTAL_REVENUE INT NOT NULL,
TOTAL_COST INT NOT NULL,
TOTAL_PROFIT INT NOT NULL
);

SELECT * FROM AMAZON;

------------------------------------------- HOW MANY REGIONS IN DATASET -----------------------------------

SELECT DISTINCT REGION FROM AMAZON;
	
----------------------------------------- HOW MANY TYPE OF ITEMTYPE AND COUNT OF ITEMTYPE IN DATASET --------------------------

SELECT ITEM_TYPE, COUNT(DISTINCT ITEM_TYPE) AS ITEMS FROM AMAZON
GROUP BY ITEM_TYPE
ORDER BY ITEMS;

-------------------------------------- WHICH ITEMTYPE HAVE THE MOST REVENUE ---------------------------------

SELECT ITEM_TYPE, ROUND(SUM(TOTAL_REVENUE),2 )AS REVENUE FROM AMAZON
GROUP BY ITEM_TYPE
ORDER BY REVENUE DESC;

----------------------------- WHICH ITEMTYPE HAVE THE MOST PROFIT -------------------------

SELECT ITEM_TYPE, ROUND(SUM(TOTAL_PROFIT),2 )AS PROFIT FROM AMAZON
GROUP BY ITEM_TYPE
ORDER BY PROFIT DESC;
############ COSMETICS HAVE MOST PROFIT AND REVNUE ITEM AND FRUITS HAVE LOWER IN BOTH CATEGORY ##########

--------------------------------------- IN WHICH REGION HAVE MOST UNITS SOLD AND WHAT IS SOLD ------------------------------

SELECT ITEM_TYPE,REGION,SUM(UNITS_SOLD) AS UNITS FROM AMAZON
GROUP BY REGION,ITEM_TYPE
ORDER BY UNITS DESC;
#### THE ANSWER IS SUB-SAHARAN AFRICA AND ITEM IS FRUITS #####

------------------------------------------ FROM WHICH COUNTRY HAVE MOST TOTALPROFIT ----------------------------

SELECT COUNTRY,SUM(TOTAL_PROFIT) AS PROFIT FROM AMAZON
GROUP BY COUNTRY
ORDER BY PROFIT DESC;
######## THE ANS IS DJIBAOUTI COUNTRY WHICH ONE UNDER SUB-SAHARAN AFRICA REGION AND IN THIS REGION MOST UNIT SOLDS ######

--------------------- WHAT IS THE AVG UNITSOLD OF EACH ITEM -------------
SELECT * FROM AMAZON;

SELECT ITEM_TYPE,AVG(UNITS_SOLD) AS AVGSOLD FROM AMAZON
GROUP BY ITEM_TYPE
ORDER BY AVGSOLD DESC;

------------------------- SHOW THE ITEMS WHICH ORDER_PRIORITY HAVE HIGH LEVEL ----------------------

SELECT ITEM_TYPE,ORDER_PRIORITY FROM AMAZON WHERE ORDER_PRIORITY LIKE '%HIGH%';

------------------------- SHOW THE ITEMS WHICH ARE SALE ON ONLINE AND PRIORITY AT MEDIUM LEVEL --------------------------

SELECT ITEM_TYPE,SALES_CHANNEL,ORDER_PRIORITY FROM AMAZON
WHERE SALES_CHANNEL = 'ONLINE' AND ORDER_PRIORITY = 'MEDIUM';

SELECT * FROM AMAZON;

SELECT YEAR(ORDER_DATE) AS ORDERYEAR FROM AMAZON;

ALTER TABLE AMAZON
ADD COLUMN ORDERYEAR INT;

UPDATE AMAZON
SET ORDERYEAR = YEAR(ORDER_DATE);

--------------- IN WHICH YEAR AMAZON EARN THE MOST TOTAL PROFIT ----------------------------

SELECT ORDERYEAR,SUM(TOTAL_PROFIT) AS PROFIT FROM AMAZON
GROUP BY ORDERYEAR
ORDER BY PROFIT DESC;

------------------- IN WHICH YEAR THE AMAZON HAS THE LESS UNITS SOLDED --------------

SELECT ORDERYEAR,SUM(UNITS_SOLD) AS UNITS FROM AMAZON
GROUP BY ORDERYEAR
ORDER BY UNITS ASC
LIMIT 1;
############ THS ANS IS YEAR 2015 IN THAT YEAR LESS UNITS SOLD AND ALSO IN THIS PROFIT ALSO LESS EARN BY AMAZON ###########

SELECT * FROM AMAZON;

--------------------- WHAT IS AVG UNIT PRICE OF EACH ITEM -------------------
 
SELECT ITEM_TYPE,AVG(UNIT_PRICE) AS AVGPRICE FROM AMAZON
GROUP BY ITEM_TYPE
ORDER BY AVGPRICE DESC;

---------------------------------------------- WHAT IS THE MAXIMUM PROFIT ITEM -----------------------------------------------------

SELECT ITEM_TYPE, MAX(TOTAL_PROFIT) AS PROFIT FROM AMAZON
GROUP BY ITEM_TYPE
ORDER BY PROFIT DESC;

------------------- WHAT IS TOTALPROFIT FOR EACH ITEM TYPE --------------

SELECT ITEM_TYPE,SUM(TOTAL_PROFIT) AS PROFIT FROM AMAZON
GROUP BY ITEM_TYPE
ORDER BY PROFIT DESC;

----------- CALCULATE THE AVG TIME TAKEN FOR ORDERS TO BE SHIPPED ---------------

SELECT AVG(TIMESTAMPDIFF(DAY,ORDER_DATE,SHIP_DATE)) AS AVGSHIPINGTIME FROM AMAZON
WHERE SHIP_DATE IS NOT NULL
AND ORDER_DATE <= SHIP_DATE;

------------  WHAT IS DIFF BETWEEN UNIT PRICES AND UNIT COST TO UNDERSTAND PRICING STRATEGIES ------------------

SELECT AVG(UNIT_PRICE) AS AVGPRICE,
AVG(UNIT_COST) AS AVGCOST,
AVG(UNIT_PRICE - UNIT_COST) AS PRICECOSTDIFF
FROM AMAZON;
######### SO AVG UNIT PRICE IS GREATER THAN AVG UNIT COST ITS MEANS BUSINESS HAVE EARNING PROFIT #################

------------------------------- ANALYSE CUSTOMER BEHAVIOR BASED ON COUNTRY OR REGION -------------------------

SELECT REGION,COUNTRY,COUNT(*) AS TOTALORDERS, SUM(TOTAL_REVENUE) AS TOTALSALES, AVG(TOTAL_REVENUE) AS AVGORDERVALUE FROM AMAZON
GROUP BY REGION,COUNTRY;

------------------------------------ IDENTIFY HIGH VALUE CUSTOMERS OR CUSTOMERS SEGMENT ------------------------------

SELECT ORDER_ID,SUM(TOTAL_REVENUE) AS TOTALSPENDING,AVG(TOTAL_REVENUE) AS AVGORDERVALUE,COUNT(*) AS TOTALORDER FROM AMAZON
GROUP BY ORDER_ID
ORDER BY TOTALSPENDING DESC;

SELECT * FROM AMAZON;

---------------------------------------------- DELETE THE ORDERYEAR COLUMN FROM DATASET -------------------------------

ALTER TABLE AMAZON
DROP COLUMN ORDERYEAR;

--------------------------------------------------- ADD ORERYEAR COLUMN IN DATASET -------------------------------

SELECT YEAR(ORDER_DATE) AS ORDERYEAR FROM AMAZON;

ALTER TABLE AMAZON
ADD COLUMN ORDERYEAR INT;

UPDATE AMAZON 
SET ORDERYEAR = YEAR(ORDER_DATE);

----------------------------------------------- ADD ORDERMONTH COLUMN IN DATASET ---------------------------------------

SELECT MONTHNAME(ORDER_DATE) AS ORDEROFMONTH FROM AMAZON;

SELECT * FROM AMAZON;

ALTER TABLE AMAZON
ADD COLUMN ORDEROFMONTH VARCHAR (50);

UPDATE AMAZON
SET ORDEROFMONTH = MONTHNAME(ORDER_DATE);

SELECT DISTINCT ORDERYEAR FROM AMAZON;

----------------------------------------- IN WHICH YEAR AMAZON SOLD THE MOST UNITS AND OF WHICH ITEM ----------------------

SELECT ITEM_TYPE,ORDERYEAR,SUM(UNITS_SOLD) AS SALES  FROM AMAZON
GROUP BY ITEM_TYPE,ORDERYEAR
ORDER BY SALES DESC;

---------------------------------------------------- IN WHICH MONTH AMAZON MAKE LOSS -------------------------------

SELECT ORDEROFMONTH,SUM(TOTAL_PROFIT) AS PROFIT FROM AMAZON
GROUP BY ORDEROFMONTH
ORDER BY PROFIT ASC;

------------------------------------------------- ON 2017 OF WHICH MONTH AMAZON MAKES THE GOOD PROFIT -------------------------------------
SELECT * FROM AMAZON;

SELECT ORDEROFMONTH,SUM(TOTAL_PROFIT) AS PROFIT FROM AMAZON
WHERE ORDERYEAR = 2017
GROUP BY ORDEROFMONTH
ORDER BY PROFIT DESC;

