USE store_project;

/*Transactions table is too large, manual import*/
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
  customer_id INT,
  trans_dt DATE,
  transaction_id INT,
  items_in_trans INT,
  store_id INT
);
LOAD DATA LOCAL INFILE 'C:/Users/Nicole/Documents/Portfolio_AnalyticsMentor/transactions.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS
(customer_id, trans_dt, transaction_id, items_in_trans, store_id);

/*transactions_items table is too large, manual import*/
DROP TABLE IF EXISTS transaction_items;
CREATE TABLE transaction_items (
  transaction_item_id INT,
  transaction_id INT,
  product_id INT
);
LOAD DATA LOCAL INFILE 'C:/Users/Nicole/Documents/Portfolio_AnalyticsMentor/transaction_items.csv'
INTO TABLE transaction_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS
(transaction_item_id,  transaction_id, product_id);

/*Products table is too large, manual import*/
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INT,
    description VARCHAR(255),
    review_count INT,
    price DECIMAL(10,2),
    amazon_url TEXT,
    category VARCHAR(50),
    console_platform VARCHAR(50)
);
LOAD DATA LOCAL INFILE 'C:/Users/Nicole/Documents/Portfolio_AnalyticsMentor/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'   
IGNORE 1 ROWS;        

'/*_____________________________________________Windows Functions Uses__________________________________________*/'
/*Aggregate Data for items_in_trans partitioned by trans_dt - Windows Function*/
select 
	t.*, 
	min(t.items_in_trans) over(partition by t.trans_dt ) as min_items_in_trans,
	max(t.items_in_trans) over(partition by t.trans_dt ) as max_items_in_trans,
    count(t.items_in_trans) over(partition by t.trans_dt ) as count_items_in_trans,
    avg(t.items_in_trans) over(partition by t.trans_dt ) as avg_items_in_trans
from transactions t;

/*Who is ordering more than once in a day? - Window Function*/
select 
	t.*,
	row_number() over(partition by t.customer_id, t.trans_dt order by t.trans_dt) as trans_hist_num
from transactions t;

/*Lead + Lag - Method 1 - Windows Function*/
select 
	t.*,
    lead(t.transaction_id) over (order by t.trans_dt) as following_trans_id,
    lag(t.transaction_id) over (order by t.trans_dt) as prior_trans_id
from transactions t
where
	trans_dt = '2021-01-01';

/*Lead + Lag - Method 2 - Self Join/CTE - *WORKS, but has performance issues**/
with numbered_record as (
	select 
		t.*,
		row_number() over(order by t.trans_dt, t.transaction_id) as row_num
    from
		transactions t)
        
select t.*,
	p.transaction_id as prior_trans_id
from numbered_record t
	left join numbered_record p
		on (t.row_num - 1) = p.row_num
order by t.row_num

'/*_________________________________________Ranks___________________________________________*/'
/*Rank vs Dense Rank*/
select
	t.*,
    row_number() over(order by t.items_in_trans desc) as row_num,
	rank() over(order by t.items_in_trans desc) as rank_val /*Rank - Does not dispute ties, results in non-consecutive ranks*/,
    dense_rank() over(order by t.items_in_trans desc) as dense_rank_val /*Dense_Rank - Does not dispute ties, results in consecutive ranks*/
from 
	transactions t
where t.trans_dt = '2022-01-12';

/*Percentile vs Quartile*/
select
	t.*,
    percent_rank() over(order by t.items_in_trans) as perc_rank,
	ntile(100) over(order by t.items_in_trans) as quartile
from 
	transactions t
where t.trans_dt = '2022-01-12';

/*Summarize Cooresponding Value with Quartile*/
with trans_items_quartiles as (
select
	t.*,
    percent_rank() over(order by t.items_in_trans) as perc_rank,
	ntile(4) over(order by t.items_in_trans) as quartile
from 
	transactions t
where t.trans_dt = '2022-01-12')

select
	t.quartile,
    min(t.items_in_trans) as min_items_in_trans
from trans_items_quartiles t 
	group by t.quartile;
/*___________________Full Stats Profile_________________*/
--Joining products table to transaction items for confirmation of total sales data--

with transactions_totals as (
	select
		ti.transaction_id,
        sum(p.price) as total_sales
	from transaction_items ti
		join products p
			on p.product_id = ti.product_id
	group by ti.transaction_id
)
, /*CTE 2 to categorize quartile placement*/ trans_sales as (
	select
		t.trans_dt,
        t.transaction_id,
        ti.total_sales,
        ntile(4) over (order by ti.total_sales asc) as quartile
    from transactions t
		join transactions_totals ti on ti.transaction_id = t.transaction_id
)
, /*CTE 3 to build the quartile from min total sales of the quartile*/ quartile_summary as(
	select
		ts.quartile,
        min(ts.total_sales) as total_sales
    from trans_sales ts
    group by ts.quartile
) -- 1, 1.99; 2, 91.97; 3, 202.98; 4, 444.13
,
total_sales_summary as (
	select
		avg(ts.total_sales) as avg_total_sales,
        min(ts.total_sales) as min_total_sales,
        max(ts.total_sales) as max_total_sales
	from trans_sales ts
)
-- Put it together
select 
	ts.avg_total_sales,
    ts.min_total_sales,
    ts.max_total_sales,
    /*Rebuild quartile summary into full summary; need to transpose quartile rows to columns*/ 
	max(case when q.quartile = 1 then q.total_sales else 0 end) as quartile_1_total_sale, -- We only want 1 value, so need to use Max else it will include where result is 0
	max(case when q.quartile = 2 then q.total_sales else 0 end) as quartile_2_total_sale,
	max(case when q.quartile = 3 then q.total_sales else 0 end) as quartile_3_total_sale,
    max(case when q.quartile = 4 then q.total_sales else 0 end) as quartile_4_total_sale
from total_sales_summary ts
	cross join quartile_summary q
group by 
	ts.avg_total_sales,
    ts.min_total_sales,
    ts.max_total_sales

/*Reviewing Trend over Time*/
with transactions_totals as (
	select
		ti.transaction_id,
        sum(p.price) as sales_total
	from transaction_items ti
		join products p
			on p.product_id = ti.product_id
	group by ti.transaction_id
)
,
 daily_sales_summary as (
	select
		t.trans_dt,
        sum(ti.sales_total) as daily_sales_total
	from transactions t
		join transactions_totals ti on ti.transaction_id = t.transaction_id
		group by t.trans_dt
        order by trans_dt
)
select
	d.trans_dt,
    d.daily_sales_total,
	round(avg(d.daily_sales_total) over(order by d.trans_dt rows between 6 preceding and current row),2) as avg_daily_sale_trailing_7d,
    sum(d.daily_sales_total) over(order by d.trans_dt) as running_total_sales
from daily_sales_summary d
order by d.trans_dt

/*______________________________Date Manipulations for Later____________________________________*/
select t.*,
	t.trans_dt + interval 1 day as next_day,
    t.trans_dt + interval 1 month as next_month,
    DAY(t.trans_dt) AS day_of_month,
    MONTH(t.trans_dt) AS month,
    YEAR(t.trans_dt) AS year,
    DATE_FORMAT(t.trans_dt, '%Y-%m-01') as date_trunc
from transactions t