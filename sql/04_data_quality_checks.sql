/* ================================================================================================================================================================
   Project:  Ecuador Customs Tax Collection (SENAE), 2021-2026
   Purpose:  Document and verify the data quality assumptions behind the analysis. Run after sql/03_cleaning.
   Notes:    Each check state its output and finding.
   Author:   Sebastián Velasteguí
   ================================================================================================================================================================ */
 
/* ================================================================================================================================================================
   Output:   Row count per year. Expected: 2021-2025 full years; 2026 partial.
   Finding:  There is not a notable difference throughout the years. 2021: 169249, 2022:187790, 2023:193116, 2024:205188, 2025:212793, 2026: 159680 until September.
   ================================================================================================================================================================ */
SELECT payment_year, 
	COUNT(*) 
FROM clean_data
GROUP BY payment_year;
 
/* ================================================================================================================================================================
   Output:   Accounting identity: credit note + cash = total paid.
   Finding:  In 2025 there is a difference of USD 0.02 due to the use of the numeric(20,2) format; in the other years there is no difference.
   ================================================================================================================================================================ */
SELECT payment_year, 
	SUM(ABS(amount_credit_notes + amount_cash - amount_paid)) AS total_paid
FROM clean_data
GROUP BY payment_year;
 
/* ================================================================================================================================================================
   Output:   Payment dates outside the expected window.
   Finding:  There are no payments outside the expected windows.
   ================================================================================================================================================================ */
SELECT COUNT(*) AS out_of_range
FROM clean_data
WHERE payment_date < '2021-01-01'
	OR payment_date > CURRENT_DATE;

/* ================================================================================================================================================================
   Output:   Reversals (negative amounts): count and net effect on revenue.
   Finding:  There are 7 negative amounts which have a total of USD -1390.21.
   ================================================================================================================================================================ */
SELECT 
	COUNT(*)			    AS row_negative_values, 
	SUM(amount_paid)		AS sum_negative_values
FROM clean_data
WHERE amount_paid < 0;
 
/* ================================================================================================================================================================
   Output:   Rows with corrupted characters ('??') in the infraction text.
   Finding:  There are two columns with corrupted characters, nom_tributo column with 62479 and nom_infraccion with 5376 rows.
   ================================================================================================================================================================ */
SELECT 
	COUNT(*) FILTER(WHERE nom_tributo LIKE '%??%') 					AS corrupted_nom_tributo,
	COUNT(*) FILTER(WHERE nom_tipo_liquidacion LIKE '%??%') 		AS corrupted_nom_tipo_liquidacion,
	COUNT(*) FILTER(WHERE nom_estado_liquidacion LIKE '%??%') 		AS corrupted_nom_estado_liquidacion,
	COUNT(*) FILTER(WHERE tipos_doc_referencia LIKE '%??%') 		AS corrupted_tipos_doc_referencia,
	COUNT(*) FILTER(WHERE nom_infraccion LIKE '%??%') 				AS corrupted_nom_infraccion,
	COUNT(*) FILTER(WHERE nom_tipo_sancion LIKE '%??%') 			AS corrupted_nom_tipo_sancion,
	COUNT(*) FILTER(WHERE canal_pago LIKE '%??%') 					AS corrupted_canal_pago
FROM raw_data;

/* ================================================================================================================================================================
   Output:   Columns with a single distinct value carry no information.
   Finding:  The only column with a single value is nom_estado_liquidacion.
   ================================================================================================================================================================ */
SELECT COUNT(DISTINCT nom_estado_liquidacion) AS distinr_statuses
FROM raw_data;
 
/* ================================================================================================================================================================
   Output:   Share of revenue with no recorded payment channel
   Finding:  The 1.29% of the payments don't have a channel, which means USD 302093091.48.
   ================================================================================================================================================================ */
WITH total_amount AS(
  	SELECT SUM(amount_paid) AS sum_total_amount
  	FROM clean_data
),
  sin_canal_payment AS (
  	SELECT SUM(amount_paid) AS sum_sin_canal_payment
  	FROM clean_data
  	WHERE payment_channel_name = 'SIN CANAL'
) 
SELECT t.sum_total_amount, s.sum_sin_canal_payment,  
	ROUND(100 * s.sum_sin_canal_payment/t.sum_total_amount,2) AS share_sin_canal_payment
FROM total_amount t, sin_canal_payment s;
