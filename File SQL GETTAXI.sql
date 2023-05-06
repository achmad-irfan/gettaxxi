--data preparation
select min(order_datetime),max(order_datetime) from public.data_order --no found abnormal data--
select min(origin_longitude),max(origin_longitude) from public.data_order --no found abnormal data--
select min(origin_latitude),max(origin_latitude) from public.data_order --no found abnormal data--
select min(m_order_eta),max(m_order_eta) from public.data_order --no found abnormal data--
select min(order_gk),max(order_gk) from public.data_order --no found abnormal data--
select min(order_status_key),max(order_status_key) from public.data_order --no found abnormal data--
select min(is_driver_assigned_key),max(is_driver_assigned_key) from public.data_order --no found abnormal data--
select min(cancellations_time_in_seconds),max(cancellations_time_in_seconds) from public.data_order --no found abnormal data--

--data duplicate checking--
select order_datetime,origin_longitude, origin_latitude, m_order_eta, order_status_key,is_driver_assigned_key,cancellations_time_in_seconds, count(*)
from public.data_order
group by order_datetime,origin_longitude, origin_latitude, m_order_eta, order_status_key,is_driver_assigned_key,cancellations_time_in_seconds
order by count(*) desc




--distribution by status order
select order_status_key, count(order_gk) total from public.data_order
group by order_status_key
order by total desc

--distribution by status order
select is_driver_assigned_key, count(order_gk) total from public.data_order
group by is_driver_assigned_key
order by total desc

--distribution by hour
select extract(hour from order_datetime) "Hour", count(order_gk) total from public.data_order
group by "Hour"
order by total desc

--Group Hour

select 
case
when extract(hour from order_datetime) between 0 and 6  then '00-06'
when extract(hour from order_datetime) between 7 and 9  then '07-09'
when extract(hour from order_datetime) between 10 and 15  then '10-15'
when extract(hour from order_datetime) between 15 and 20  then '15-20'
	else '20-24'
end "group hour",count(order_gk) total  from public.data_order
group by "group hour"
order by total desc

select extract(hour from order_datetime) "Hour", is_driver_assigned_key, avg(cancellations_time_in_seconds) from public.data_order
group by "Hour", is_driver_assigned_key
order by "Hour"

--average order eta
select extract(hour from order_datetime) "Hour",  avg(m_order_eta) average_eta from public.data_order
group by "Hour"
order by average_eta desc




