USE restaurant_project;

ALTER TABLE foods
CHANGE COLUMN `ï»¿food_id` food_id INT;

ALTER TABLE drinks
CHANGE COLUMN `ï»¿drink_id` drink_id INT;

ALTER TABLE food_inventories
CHANGE COLUMN `ï»¿food_inventory_id` food_inventory_id INT;

/*Number and Percent of Foods per Brand*/
select 
	f.brand_name,
    count(*) as food_count,
    round(count(*)*100.0/sum(count(*)) over (),2) as percent_of__total
from foods f
group by f.brand_name
order by food_count desc;


/*Update empty storage type*/
SET SQL_SAFE_UPDATES = 0;

UPDATE foods
SET storage_type = 'unknown'
WHERE storage_type = '';

SET SQL_SAFE_UPDATES = 1;

/*Number of Foods per Storage Type*/
select 
	DISTINCT storage_type,
    count(*) as food_count
from foods f
group by f.storage_type
order by food_count desc

/*Outdated Inventory Check*/
SELECT
    f.food_id,
    f.item_name,
    f.storage_type,
    f.package_size,
    f.package_size_uom,
    f.brand_name,
    f.package_price,
    f.price_last_updated_ts,
    datediff(current_date, cast(f.price_last_updated_ts as date)) as days_since_pricelist_update,
    'food' as type
FROM foods f
union all
SELECT
    d.drink_id,
    d.item_name,
    d.storage_type,
    d.package_size,
    d.package_size_uom,
    d.brand_name,
    d.package_price,
    d.price_last_updated_ts,
    datediff(current_date, cast(d.price_last_updated_ts as date)) as days_since_pricelist_update,
	'drinks' as type
from drinks d

/*------------------Creating Food Shopping list based on latest inventory-----------------*/
with latest_inventory as (
select 
	f.item_name,
    fi.*
from foods f
left join food_inventories fi on fi.food_item_id = f.food_id where 
fi.inventory_dt = (
	select
		max(fi.inventory_dt) as max_inventory_dt
	from food_inventories fi)
)

select
	f.*,
    i.inventory_dt,
   COALESCE(i.quantity, 0) AS current_quantity
from foods f
left join latest_inventory i on i.food_item_id = f.food_id
order by current_quantity asc, f.storage_type asc
