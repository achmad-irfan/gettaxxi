<p align="right"> <a href="https://achmadirfana.github.io/portofolio/portfolio-gettaxi.html">Back</a></p>


<h2> Gettaxi</h2>
<p> URL Dashoboard project (Bonus) : <a href="">Gettaxi</a></p>
<h3> 1. Background Project :</h3>
<p style="margin-left: 20px;align=justify"> This is my personal project and I use postgresql to do. This project is about gettaxi, is an Israeli-developed technology platform solely focused on corporate Ground Transportation Management (GTM). They have an application where clients can order taxis, and drivers can accept their rides (offers). At the moment, when the client clicks the Order button in the application, the matching system searches for the most relevant drivers and offers them the order. In this task, we would like to investigate some matching metrics for orders that did not completed successfully, i.e., the customer didn't end up getting a car</p>
<h3>2. Purpose:</h3>
<p style="margin-left: 20px;text-align:justify">  The main purpose is to provide a number of isnight and recomendation about the data. To do this,
first I  need to identify the following data:</p>
<p style="margin-left: 20px">•  Build up distribution of orders according to reasons for failure: cancellations before and after driver assignment, and reasons for order rejection. Analyse the resulting plot. Which category has the highest number of orders? </p>
<p style="margin-left: 20px">•  Plot the distribution of failed orders by hours. Is there a trend that certain hours have an abnormally high proportion of one category or another? What hours are the biggest fails? How can this be explained? </p>
<p style="margin-left: 20px">•  Plot the average time to cancellation with and without driver, by the hour. If there are any outliers in the data, it would be better to remove them. Can we draw any conclusions from this plot?  </p>
<p style="margin-left: 20px">•  Plot the distribution of average ETA by hours. How can this plot be explained?</p>
<h3>3. Dataset:</h3>
<p style="margin-left: 20px">The project source is from stratascratch platfrom and can be accessed in this following link : <a href="https://platform.stratascratch.com/data-projects/insights-failed-orders">Click here</a></p>
<p style="margin-left: 20px">Data can be access in the following link : <a href="https://docs.google.com/spreadsheets/d/1ZX1L2hk1vAPlnWxEwaG-EnvGeM0fUqBK1O7EGHwZ3KI/edit?usp=sharing">Click here</a></p>
<p style="margin-left: 20px">Data description:</p>
 <div style="margin-left: 20px;height:450px;width:1000px;border:1px solid #ccc;font:14px/16px Georgia, Garamond, Serif;overflow:auto;">
 <p style="margin-left: 40px">The data_order data set with 8 columns: </p>
<p style="margin-left: 60px">order_datetime - time of the order </p>
<p style="margin-left: 60px">origin_longitude - longitude of the order </p>
<p style="margin-left: 60px">origin_latitude - latitude of the order </p>
<p style="margin-left: 60px">m_order_eta - time before order arrival </p>
<p style="margin-left: 60px">order_gk - order number </p>
<p style="margin-left: 60px">order_status_key - status, an enumeration consisting of the following mapping: </p>
<p style="margin-left: 80px">4 - cancelled by client, </p>
<p style="margin-left: 80px">9 - cancelled by system, i.e., a reject </p>
<p style="margin-left: 60px">is_driver_assigned_key - whether a driver has been assigned </p>
<p style="margin-left: 60px">cancellation_time_in_seconds - how many seconds passed before cancellation </p>
<p style="margin-left: 40px">The data_offerf data set is a simple map with 2 columns: </p>
<p style="margin-left: 60px">order_gk - order number, associated with the same column from the orders data set </p>
<p style="margin-left: 60px">offer_id - ID of an offer </p>
	
  </div>
  
<h3>4. Data Preparation</h3>
<h4 style="margin-left: 10px">4.1 Data Validation</h4>
<p style="margin-left: 30px"> All the data must be checked whetever there is a abnormal data. The  queery for data checking and validating :</p>

<div style="margin-left: 30px;height:200px;width:1000px;border:1px solid #ccc;font:14px/6px Georgia, Garamond, Serif;overflow:auto;">
	<p> </p>
<p style="margin-left: 20px"> --data validation </p>
<p style="margin-left: 20px"> select min(order_datetime),max(order_datetime) from public.data_order --no found abnormal data-- </p>
<p style="margin-left: 20px"> select min(origin_longitude),max(origin_longitude) from public.data_order --no found abnormal data-- </p>
<p style="margin-left: 20px"> select min(origin_latitude),max(origin_latitude) from public.data_order --no found abnormal data-- </p>
<p style="margin-left: 20px"> select min(m_order_eta),max(m_order_eta) from public.data_order --no found abnormal data-- </p>
<p style="margin-left: 20px"> select min(order_gk),max(order_gk) from public.data_order --no found abnormal data-- </p>
<p style="margin-left: 20px"> select min(order_status_key),max(order_status_key) from public.data_order --no found abnormal data-- </p>	
<p style="margin-left: 20px"> select min(is_driver_assigned_key),max(is_driver_assigned_key) from public.data_order --no found abnormal data-- </p>
<p style="margin-left: 20px"> select min(cancellations_time_in_seconds),max(cancellations_time_in_seconds) from public.data_order --no found abnormal data-- </p>	
</div> 
<p style="margin-left: 30px"> Overall in data is not found any abnormal data </p>	


<h4 style="margin-left: 10px">4.1 Data Duplicate Checking</h4>
<p style="margin-left: 30px"> All the data must be checked whetever there is a duplicate data. The  queery for data duplicate checking :</p>
<div style="margin-left: 30px;height:100px;width:1100px;border:1px solid #ccc;font:14px/6px Georgia, Garamond, Serif;overflow:auto;">
<p>  </p>
<p style="margin-left: 20px"> --data duplicate checking  </p>
<p style="margin-left: 20px">select order_datetime,origin_longitude, origin_latitude, m_order_eta, order_status_key,is_driver_assigned_key,cancellations_time_in_seconds, count(*)</p>
<p style="margin-left: 20px">from public.data_order</p>
<p style="margin-left: 20px">group by order_datetime,origin_longitude, origin_latitude, m_order_eta, order_status_key,is_driver_assigned_key,cancellations_time_in_seconds</p>
<p style="margin-left: 20px">order by count(*) desc</p>
</div>
<p style="margin-left: 30px"> Output: </p>
<p align="center"> 
<img src="data duplicate.png" class="img-fluid" alt="">  
</p>

<p style="margin-left: 30px"> After checking data output, it's found that there are 4 row data that contain duplicate data although it's have different order_gk, so it must be removed </p>	

<h4 style="margin-left: 10px">4.2 Data Cleansing</h4>
<p style="margin-left: 30px"> From data validation, found that there are 4 rows of duplicate data although it have a different order_ok, so it must be removed, the querry for removing these duplicate rows: </p>
<div style="margin-left: 30px;height:200px;width:1000px;border:1px solid #ccc;font:14px/6px Georgia, Garamond, Serif;overflow:auto;">
	<p> </p>
<p style="margin-left: 20px"> --removing duplicate data </p>
<p style="margin-left: 20px">delete from  public.data_order </p>
<p style="margin-left: 20px">WHERE order_gk IN (</p>
<p style="margin-left: 20px">    SELECT order_gk FROM public.data_order</p>
<p style="margin-left: 20px">    EXCEPT SELECT MIN(order_gk) FROM public.data_order</p>
<p style="margin-left: 20px">    GROUP BY order_datetime,origin_longitude, origin_latitude, m_order_eta, order_status_key,is_driver_assigned_key,cancellations_time_in_seconds</p>
<p style="margin-left: 20px">    )</p>
</div> 
<p style="margin-left: 30px"> Output: </p>
<p align="center"> 
<img src="data duplicate after.png" class="img-fluid" alt="">  
</p>







  
<h3>5. Data Analyze:</h3>
<h4 style="margin-left: 20px">Distribution of orders according to reasons for failure</h4>
<p style="margin-left: 30px"> Query: </p>
<div style="margin-left: 30px;height:75px;width:1000px;border:1px solid #ccc;font:14px/6px Georgia, Garamond, Serif;overflow:auto;">
<p> </p>
<p style="margin-left: 20px">select order_status_key, count(order_gk) total from public.data_order</p>
<p style="margin-left: 20px">group by order_status_key</p>
<p style="margin-left: 20px">order by total desc</p>
</div> 

<p style="margin-left: 30px"> Output: </p>
<p align="center"> 
<img src="order_status_key.png" class="img-fluid" alt="">  
</p>

<h4 style="margin-left: 20px">Distribution of failed orders by hours</h4>
<p style="margin-left: 30px"> Query for total per hour: </p>
<div style="margin-left: 30px;height:75px;width:1000px;border:1px solid #ccc;font:14px/6px Georgia, Garamond, Serif;overflow:auto;">
<p> </p>
<p style="margin-left: 20px">select extract(hour from order_datetime) "Hour", count(order_gk) total from public.data_order</p>
<p style="margin-left: 20px">group by "Hour"</p>
<p style="margin-left: 20px">order by total desc</p>
</div> 

<p style="margin-left: 30px"> Output: </p>
<p align="center"> 
<img src="hour.png" class="img-fluid" alt="">  
</p>

<p style="margin-left: 30px"> Query for total per group hour: </p>
<div style="margin-left: 30px;height:75px;width:1000px;border:1px solid #ccc;font:14px/6px Georgia, Garamond, Serif;overflow:auto;">
<p> </p>
<p style="margin-left: 20px">select </p>
<p style="margin-left: 20px">case</p>
<p style="margin-left: 20px">when extract(hour from order_datetime) between 0 and 6  then '00-06'</p>
<p style="margin-left: 20px">when extract(hour from order_datetime) between 7 and 9  then '07-09'</p>
<p style="margin-left: 20px">when extract(hour from order_datetime) between 10 and 15  then '10-15'</p>
<p style="margin-left: 20px">when extract(hour from order_datetime) between 15 and 20  then '15-20'</p>
<p style="margin-left: 20px"></p>
<p style="margin-left: 20px">end "group hour",count(order_gk) total  from public.data_order</p>
<p style="margin-left: 20px">group by "group hour"</p>
<p style="margin-left: 20px">order by total desc</p>
</div> 

<p style="margin-left: 30px"> Output: </p>
<p align="center"> 
<img src="group hour.png" class="img-fluid" alt="">  
</p>

<h4 style="margin-left: 20px">Average time to cancellation with and without driver,</h4>
<p style="margin-left: 30px"> Query: </p>
<div style="margin-left: 30px;height:75px;width:1000px;border:1px solid #ccc;font:14px/6px Georgia, Garamond, Serif;overflow:auto;">
<p> </p>
<p style="margin-left: 20px">select is_driver_assigned_key, avg(cancellations_time_in_seconds) </p>
<p style="margin-left: 20px">from public.data_order</p>
<p style="margin-left: 20px">group  by is_driver_assigned_key</p>
</div> 

<p style="margin-left: 30px"> Output: </p>
<p align="center"> 
<img src="avgcancel.png" class="img-fluid" alt="">  
</p>


<h4 style="margin-left: 20px">Distribution of average ETA by hours</h4>
<p style="margin-left: 30px"> Query: </p>
<div style="margin-left: 30px;height:75px;width:1000px;border:1px solid #ccc;font:14px/6px Georgia, Garamond, Serif;overflow:auto;">
<p> </p>
<p style="margin-left: 20px">select extract(hour from order_datetime) "Hour",  avg(m_order_eta) average_eta from public.data_order</p>
<p style="margin-left: 20px">group by "Hour"</p>
<p style="margin-left: 20px">order by average_eta desc</p>
</div> 

<p style="margin-left: 30px"> Output: </p>
<p align="center"> 
<img src="average order eta.png" class="img-fluid" alt="">  
</p>



<h3>6. Insight and Recomendation</h3>
<h4 style="margin-left: 20px">>6.1 Insight</h4>
<p style="margin-left: 30px"> • Based on data, 70% of cancellation of order is canceled by customer and 30% cancellation is by system</p>
<p style="margin-left: 30px"> • The time around 8 am is the time with the most of cancellation order  </p>
<p style="margin-left: 30px"> • The average time of cancellation order when driver driver has been assigned is 230 seconds (4 minutes)  </p>
<p style="margin-left: 30px"> • The longest of ETA order is about in 8 am , around 600 s (5 minutes)   </p>
<h4 style="margin-left: 20px">>6.2 Reccmendation</h4>
<p style="margin-left: 30px"> • After looking at the data above, because of the high number of cancellations, besides that the time before order arrival is also very long at 8 am, then you should be able to improve the user experience by updating the application or system to be more user-friendly, updating information about the driver and vehicles in real-time, and introduced an option for users to view estimated wait times and update their location automatically/p>
<p style="margin-left: 30px"> • If possible, you may consider offering promotions or special discounts during peak hours to increase the number of orders and reduce the cancellation rate for taxi orders. /p>
