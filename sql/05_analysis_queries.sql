/* ================================================================================================================================================================
   Project:  Ecuador Customs Tax Collection (SENAE), 2021-2026
   Author:   Sebastián Velasteguí
   ================================================================================================================================================================*/

/* ================================================================================================================================================================
   Question 1: Which customs districts collect the most, and how concentrated is revenue?
   Output:   (a) top 5 districts with share and cumulative share of the total
             (b) top 3 districts per year, to see whether concentration changes
   Finding:  (a) Guayaquil Maritime is the highest-recollecting district with nearly two-thirds of the total share (64.74%). The top five districts collect 96.45% 
				 of the total
   Finding:	 (b) The same three districts ranked in the top three every year: Guayaquil Maritime was first throughout, Manta was second in 2021-2023 and 2026, 
				 and Quito was second in 2024 and 2025.
   ================================================================================================================================================================*/
-- (a) top 5 districts with share and cumulative share of the total
WITH total_paid_district AS(	
	SELECT district_name,
		SUM(amount_paid) AS total_paid
	FROM clean_data
	GROUP BY district_name
)
SELECT district_name, total_paid,
	ROUND(100 * total_paid / SUM(total_paid) OVER(), 2) 											AS share_of_the_total,
	ROUND(100 * SUM(total_paid) OVER(ORDER BY total_paid DESC) / SUM(total_paid) OVER(), 2)			AS acumulative_share
FROM total_paid_district
ORDER BY total_paid DESC
LIMIT 5;

-- (b) top 3 districts per year, to see whether concentration changes
WITH total_paid_district AS (
	SELECT payment_year, district_name,
		SUM(amount_paid) 																			AS total_paid,
		ROUND(100 * SUM(amount_paid) / SUM(SUM(amount_paid)) OVER(PARTITION BY payment_year), 2) 	AS concentration_year
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
   Finding:  The hisghest-collecting district is Guayaquil - Maritime and the top 3 payment channels in this district are Internet with a share of 41.88%. 
			 Other devices with 31.06% and last one, Ventanilla with 24.17%
   ================================================================================================================================================================*/
WITH highest_collection_district AS (	
	SELECT district_name
	FROM clean_data
	GROUP BY district_name
	HAVING SUM(amount_paid) = (
		SELECT MAX(total_by_district)
			FROM (
				SELECT SUM(amount_paid) AS total_by_district
				FROM clean_data
				GROUP BY district_name
		) sub
	)
)
SELECT c.district_name, c.payment_channel_name, 
	SUM(amount_paid)													AS total_amount_paid,
	ROUND(100 * SUM(c.amount_paid) 
	/ SUM(SUM(c.amount_paid)) OVER(PARTITION BY c.district_name), 2) 	AS share_revenue
FROM clean_data c
JOIN highest_collection_district h ON c.district_name = h.district_name
GROUP BY c.district_name, c.payment_channel_name
ORDER BY share_revenue DESC
LIMIT 3;

/* ================================================================================================================================================================
   Question 3: How does monthly collection evolve, and which months were the best?
   Output:   (a) monthly total with year-over-year change
             (b) top 5 individual months by collection
   Finding:  (a) The highest-collecting months are August and September in the most of the years. The collecting amount tends to increase throughout the years, 
				 except 2023, year in which the amount reduce in almost all months
   Finding:	 (b) The individual months from 2021 to partial 2026 with most collecting amount were April, 2026; October, 2025; July, 2026; December, 2025; August, 2026.
				 The highest-collecting month had 4.75 hundred million of USD and the lowest of the group had 4.39 hundred million
   ================================================================================================================================================================*/
-- (a) monthly total with year-over-year change
SELECT payment_year, payment_month,
	SUM(amount_paid)																				AS total_amount_paid,
	LAG(SUM(amount_paid), 12) OVER(ORDER BY payment_year, payment_month)							AS total_paid_previous_year,
	SUM(amount_paid) - LAG(SUM(amount_paid), 12) OVER(ORDER BY payment_year, payment_month)			AS diff_vs_prior_year
FROM clean_data
GROUP BY payment_year, payment_month
ORDER BY payment_year, payment_month;

-- (b) top 5 individual months by collection
SELECT payment_year, payment_month,
	SUM(amount_paid) AS total_amount_paid
FROM clean_data
GROUP BY payment_year, payment_month
ORDER BY total_amount_paid DESC
LIMIT 5;

/* ================================================================================================================================================================
   Question 4: Which calendar months are structurally the strongest?
   Output:   Top 3 months by average share of the annual collection.
   Finding:  In the period 2021 - 2025 the months with more impact in the share of the annual collection were October, August and September collecting in average 
			 around 27% of the total of the years 
   ================================================================================================================================================================*/
WITH monthly AS(
	SELECT payment_year, payment_month, 
		SUM(amount_paid)	AS total_amount_paid
	FROM clean_data
	WHERE payment_year < (SELECT MAX(payment_year) FROM clean_data)
	GROUP BY payment_year, payment_month
),
	shares AS(
	SELECT payment_month,
		total_amount_paid / SUM(total_amount_paid) OVER(PARTITION BY payment_year)AS share_of_year
	FROM monthly
	)
SELECT payment_month,
	TO_CHAR(MAKE_DATE(2000, payment_month, 1), 'Mon') 	AS month_name,
	ROUND(100 * AVG(share_of_year), 2) 					AS avg_pct_of_year
FROM shares
GROUP BY payment_month
ORDER BY avg_pct_of_year DESC
LIMIT 3;

/* ================================================================================================================================================================
   Question 5: How much revenue comes from sanctions, and which types and infractions matter most?
   Output:   (a) sanctions as a share of total revenue
             (b) top 3 sanction types by amount
             (c) top 3 infractions by amount
   Finding:  (a) This income just represents 0.17% from sanctions.
   Finding:	 (b) The 3 highest-collecting sanctions are 'Falta Reglamentaria', 'Contravención' and 'Contravención - Contrabando'. The first of them are registered 
				 most of the 34 thousand times and recollect 18303208.14 USD
   Finding:	 (c) The 3 highest-collecting infraction are "COPCI ART. 193 LITERAL d", "COPCI ART. 190 LITERAL B" and 
				 "LEY S/N R.O. 525-5S COPCI ART. 190, LIT N; COIP ART. 299, NUM 3; COIP DISP. GEN. 4TA-ART. 299 COIP, NUMERAL 3" The first of them are registered 
				 most of the 13 thousand times and recollect 8011393.02 USD
   ================================================================================================================================================================*/
-- (a) sanctions as a share of total revenue
SELECT 
	ROUND( 100 * SUM(amount_paid) FILTER(WHERE sanction_type_name <> 'NO APLICA') 
	/ SUM(amount_paid), 2) AS sanction_share_revenue
FROM clean_data;

--  (b) top 3 sanction types by amount
SELECT sanction_type_name,
	COUNT(*) 				AS record_count,
	SUM(amount_paid)		AS total_amount_paid	
FROM clean_data
WHERE sanction_type_name <> 'NO APLICA'
GROUP BY sanction_type_name
ORDER BY total_amount_paid DESC
LIMIT 3;

-- (c) top 3 infractions by amount
SELECT infraction_code, 
	LEFT(infraction_name, 110)		AS art_infraction, 
	COUNT(*) 						AS record_count,
	SUM(amount_paid) 				AS total_amount_paid	
FROM clean_data
WHERE infraction_name <> 'NO APLICA'
GROUP BY infraction_code, infraction_name
ORDER BY total_amount_paid DESC
LIMIT 3;

/* ================================================================================================================================================================
   Question 6: How many times larger is Guayaquil Maritime collection than Guayaquil Air, and is that ratio stable over time?
   Output:   One row per year with both totals and their ratio.
   Finding:  In 2021 the maritime to air ratio was 16.08 times and in 2026 until September is 17.11 times. So the variation is not big.
   ================================================================================================================================================================*/
SELECT payment_year,
	SUM(amount_paid) FILTER(WHERE district_name = 'GUAYAQUIL - MARITIMO')						AS maritime_paid,
	SUM(amount_paid) FILTER(WHERE district_name = 'GUAYAQUIL - AEREO')							AS air_paid,
	ROUND(SUM(amount_paid) FILTER(WHERE district_name = 'GUAYAQUIL - MARITIMO') / 
		NULLIF(SUM(amount_paid) FILTER(WHERE district_name = 'GUAYAQUIL - AEREO'), 0), 2) 		AS maritime_to_air_ratio
FROM clean_data
GROUP BY payment_year
ORDER BY payment_year;
