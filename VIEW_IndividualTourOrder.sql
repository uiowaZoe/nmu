/*_____*/
CREATE VIEW IndividualTourOrder AS
SELECT
t.transaction_id,
date_format(t.create_time, '%Y-%m-%d') AS 'create_time', 
it.product_code, 
it.tour_name, 
s.salesperson_code, 
w.wholesaler_code, 
t.currency, 
t.payment_type,
t.total_profit,
t.received as 'revenue', 
t.expense AS 'cost',
it.indiv_number, 
concat(date_format(it.depart_date, '%Y-%m-%d'), '/', date_format(it.arrival_date, '%Y-%m-%d')) as 'schedule',
sn.source_name, 
t.note, 
t.lock_status, 
t.clear_status, 
t.coupon
FROM Transactions t 
RIGHT JOIN IndividualTour it ON t.indiv_tour_id = it.indiv_tour_id 
LEFT JOIN CustomerSource sn ON t.source_id = sn.source_id
LEFT JOIN Salesperson s ON t.salesperson_id = s.salesperson_id
LEFT JOIN Wholesaler w ON it.wholesaler_id = w.wholesaler_id 
LEFT JOIN CouponCode cc ON t.cc_id = cc.cc_id
ORDER BY t.transaction_id DESC