CREATE TABLE analysis_data AS
SELECT product_id,
       DATE(nowtime) AS date,
       current_price,
       old_price,
       price_per_unit,
       other AS sale_status  
FROM raw
ORDER BY product_id, date;

SELECT 
    COUNT(*) AS null_old_price_count
FROM 
    analysis_data
WHERE 
    old_price IS NULL;
	
DELETE FROM 
    analysis_data
WHERE 
    old_price IS NULL;
	
SELECT *
FROM export_data
WHERE product_id IN (
    SELECT DISTINCT product_id
    FROM export_data
    ORDER BY RANDOM()
    LIMIT 500 
)
ORDER BY product_id, date;



