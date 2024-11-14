CREATE TABLE raw_with_vendor AS
SELECT 
    raw.*,
    product.vendor
FROM 
    raw
JOIN 
    product
ON 
    raw.product_id = product.id;

	
CREATE TABLE discount_rate AS
SELECT 
    vendor,
    current_price,
    old_price,
	nowtime,
    ((old_price - current_price) / old_price) * 100 AS discount_rate
FROM 
    raw_with_vendor
WHERE 
    old_price IS NOT NULL;
	
	
CREATE TABLE vendor_avg_discount_rate AS
SELECT 
    vendor,
    AVG(discount_rate) AS avg_discount_rate
FROM 
    discount_rate
GROUP BY 
    vendor
ORDER BY 
    avg_discount_rate ASC;

CREATE TABLE vendor_monthly_avg_discount_rate AS
SELECT 
    vendor,
    strftime('%Y', nowtime) AS year,           
    strftime('%m', nowtime) AS month,     
    AVG(discount_rate) AS avg_discount_rate
FROM 
    discount_rate
WHERE 
    old_price IS NOT NULL AND current_price IS NOT NULL
GROUP BY 
    vendor, year, month
ORDER BY 
    vendor, year, month;
 
CREATE TABLE vendor_daily_avg_discount_rate AS   
SELECT 
    vendor,
    DATE(nowtime) AS date,
    AVG(discount_rate) AS avg_discount_rate
FROM 
    discount_rate
GROUP BY 
    vendor, DATE(nowtime)
ORDER BY 
    vendor, date;