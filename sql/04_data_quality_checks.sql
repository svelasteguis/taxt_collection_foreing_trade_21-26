/* ======================================================================================================================
   Project:  Ecuador Customs Tax Collection (SENAE), 2021-2026
   Purpose:  Document and verify the data quality assumptions behind the analysis. Run after sql/03_cleaning.
   Notes:    Expected results are written next to each check. Findings and
             the decisions taken are summarized in docs/data_quality_log.md.
   Author:   Sebastián Velasteguí
   ====================================================================================================================== */
 
-- 1. Row count per year. Expected: 2021-2025 full years; 2026 partial.
SELECT payment_year, 
	COUNT(*) 
FROM clean_data
GROUP BY payment_year;
 
-- 2. Accounting identity: credit note + cash = total paid.
SELECT payment_year, 
	SUM(ABS(amount_credit_notes + amount_cash - amount_paid)) 
FROM clean_data
GROUP BY payment_year;
 
-- 3. Payment dates outside the expected window. Expected: 0.
SELECT COUNT(*) AS out_of_range
FROM clean_data
WHERE payment_date < '2021-01-01'
	OR payment_date > CURRENT_DATE;

 
-- 4. Reversals (negative amounts): count and net effect on revenue.
SELECT 
	COUNT(*)			    AS row_negative_values, 
	SUM(amount_paid)	AS sum_negative_values
FROM clean_data
WHERE amount_paid < 0;
 
 
-- 5. Rows with corrupted characters ('??') in the infraction text.
WITH nom_tributo AS(
	SELECT COUNT(*)             AS corrupted_nom_tributo
	FROM raw_data
	WHERE nom_tributo LIKE '%??%'
),
nom_tipo_liquidacion AS(
	SELECT COUNT(*)             AS corrupted_nom_tipo_liquidacion
	FROM raw_data
	WHERE nom_tipo_liquidacion LIKE '%??%'
),
nom_estado_liquidacion AS(
	SELECT COUNT(*)             AS corrupted_nom_estado_liquidacion
	FROM raw_data
	WHERE nom_estado_liquidacion LIKE '%??%'
),
tipos_doc_referencia AS(
	SELECT COUNT(*)             AS corrupted_tipos_doc_referencia
	FROM raw_data
	WHERE tipos_doc_referencia LIKE '%??%'
),
nom_infraccion AS(
	SELECT COUNT(*)             AS corrupted_nom_infraccion
	FROM raw_data
	WHERE nom_infraccion LIKE '%??%'
),
nom_tipo_sancion AS(
	SELECT COUNT(*)             AS corrupted_nom_tipo_sancion
	FROM raw_data
	WHERE nom_tipo_sancion LIKE '%??%'
),
canal_pago AS(
	SELECT COUNT(*)             AS corrupted_canal_pago
	FROM raw_data
	WHERE canal_pago LIKE '%??%'
)
SELECT t.corrupted_nom_tributo, l.corrupted_nom_tipo_liquidacion, e.corrupted_nom_estado_liquidacion, d.corrupted_tipos_doc_referencia, i.corrupted_nom_infraccion, s.corrupted_nom_tipo_sancion, c.corrupted_canal_pago
FROM nom_tributo t, nom_tipo_liquidacion l, nom_estado_liquidacion e, tipos_doc_referencia d, nom_infraccion i, nom_tipo_sancion s, canal_pago c;

 
-- 6. Columns with a single distinct value carry no information.
SELECT COUNT(DISTINCT nom_estado_liquidacion) AS distinr_statuses
FROM raw_data;
 
-- 7. Share of revenue with no recorded payment channel.
WITH total_amount AS(
  	SELECT SUM(amount_paid) AS sum_total_amount
  	FROM clean_data
),
  sin_canal_payment AS (
  	SELECT SUM(amount_paid) AS sum_sin_canal_payment
  	FROM clean_data
  	WHERE payment_chanel_name = 'SIN CANAL'
) 
  SELECT t.sum_total_amount, s.sum_sin_canal_payment, ROUND(s.sum_sin_canal_payment/t.sum_total_amount,4)
  FROM total_amount t, sin_canal_payment s;
