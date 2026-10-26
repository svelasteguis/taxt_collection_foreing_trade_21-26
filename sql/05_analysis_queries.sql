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
-- (a) top 5 districts with share and cumulative share of the total
WITH total_paid_district AS(	
	SELECT district_name,
		SUM(amount_paid) AS total_paid
	FROM clean_data
	GROUP BY district_name
	ORDER BY total_paid DESC
)
SELECT district_name, total_paid,
	ROUND(100 * total_paid / SUM(total_paid) OVER(), 2) AS share_of_the_total,
	ROUND(100 * SUM(total_paid) OVER(ORDER BY total_paid DESC) / SUM(total_paid) OVER(), 2)
FROM total_paid_district
LIMIT 5;

-- (b) top 3 districts per year, to see whether concentration changes
WITH total_paid_district AS (
	SELECT payment_year, district_name,
		SUM(amount_paid) AS total_paid,
		ROUND(100 * SUM(amount_paid) / SUM(SUM(amount_paid)) OVER(PARTITION BY payment_year), 2) AS concentration_year
	FROM clean_data
	GROUP BY payment_year, district_name
),
ranking AS (
	SELECT *,
		RANK() OVER(PARTITION BY payment_year ORDER BY total_paid DESC)	AS ranking_year
	FROM total_paid_district
)
SELECT payment_year, district_name, total_paid, concentration_year
FROM ranking
WHERE ranking_year <= 3
ORDER BY payment_year, ranking_year;

/* ================================================================================================================================================================
   Question 2: Which payment channels dominate in the highest-collecting district?
   Output:   Top 3 payment channels with their share of that district's revenue.
   Finding:  <Write one sentence here after running the query.>
   ================================================================================================================================================================*/
WITH highest_collection_distric AS (	
	SELECT district_name
	FROM clean_data
	GROUP BY district_name
	HAVING SUM(amount_paid) = (
		SELECT MAX(total_by_district)
			FROM (
				SELECT SUM(amount_paid) AS total_by_district
				FROM clean_data
				GROUP BY district_name
		)
	)
)
SELECT c.district_name, c.payment_chanel_name, 
	SUM(amount_paid),
	ROUND(SUM(c.amount_paid) / SUM(SUM(c.amount_paid)) OVER(PARTITION BY c.district_name), 2) AS share_revenue
FROM clean_data c
JOIN highest_collection_distric h ON c.district_name = h.district_name
GROUP BY c.district_name, c.payment_chanel_name
ORDER BY share_revenue DESC
LIMIT 3;

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
