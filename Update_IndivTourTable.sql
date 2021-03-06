SELECT 
transaction_id,
create_time,
product_code, 
tour_name, 
wholesaler_code,
schedule,
currency, 
total_profit,
revenue, 
cost, 
coupon
FROM IndividualTourOrder
WHERE transaction_id LIKE '%'
AND create_time >= '%'
AND create_time < current_timestamp
AND product_code LIKE '%'
AND clear_status = 'N'
AND lock_status = 'N'
AND salesperson_code = 'hahk'
LIMIT 15;
