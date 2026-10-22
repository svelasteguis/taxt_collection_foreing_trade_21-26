/* ================================================================================================================================================================
   Project:  Ecuador Customs Tax Collection (SENAE), 2021-2026
   Author:   Sebastián Velasteguí
   ================================================================================================================================================================*/

/* ================================================================================================================================================================
   Question 1: Which customs districts collect the most, and how concentrated is revenue?
   Output:   (a) top 5 districts with share and cumulative share of the total
             (b) top 3 districts per year, to see whether concentration changes
   Finding:  <Write one sentence here after running the query.>
   ================================================================================================================================================================*/
SELECT district_name, 
	SUM(amount_paid) 	AS sum_amount_paid,
	ROUND(100 * SUM(amount_paid)/(SELECT SUM(amount_paid)
							 FROM clean_data AS total_amount_paid),2)
FROM clean_data
GROUP BY district_name
ORDER BY sum_amount_paid DESC;
	



/* ================================================================================================================================================================
   Question 2: Which payment channels dominate in the highest-collecting district?
   Output:   Top 3 payment channels with their share of that district's revenue.
   Finding:  <Write one sentence here after running the query.>
   ================================================================================================================================================================*/

/* ================================================================================================================================================================
   Question 3: How does monthly collection evolve, and which months were the best?
   Output:   (a) monthly total with year-over-year change
             (b) top 5 individual months by collection
   Finding:  <Write one sentence here after running the query.>
   ================================================================================================================================================================*/

/* ================================================================================================================================================================
   Question 4: Which calendar months are structurally the strongest?
   Output:   Top 3 months by average share of the annual collection.
   Finding:  <Write one sentence here after running the query.>
   ================================================================================================================================================================*/

/* ================================================================================================================================================================
   Question 5: How much revenue comes from sanctions, and which types and infractions matter most?
   Output:   (a) sanctions as a share of total revenue
             (b) top 3 sanction types by amount
             (c) top 3 infractions by amount
   Finding:  <Write one sentence here after running the query.>
   ================================================================================================================================================================*/

/* ================================================================================================================================================================
   Question 6: How many times larger is Guayaquil Maritime collection than Guayaquil Air, and is that ratio stable over time?
   Output:   One row per year with both totals and their ratio.
   Finding:  <Write one sentence here after running the query.>
   ================================================================================================================================================================*/
