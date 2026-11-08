/* ================================================================================================================================================================
   Project:  Ecuador Customs Tax Collection (SENAE), 2021-2026
   Purpose:  Document and verify the data quality assumptions behind the analysis. Run after sql/03_create_clean_view.sql.
   Notes:    Each check states its output and finding.
   Author:   Sebastián Velasteguí
   ================================================================================================================================================================ */
 
/* ================================================================================================================================================================
   Output:   Duplicate rows.
   Finding:  There is not any duplicate row.
   ================================================================================================================================================================ */
SELECT COUNT(*) 							AS total_rows,
	COUNT(DISTINCT r::text) 				AS distinct_rows,
	COUNT(*) - COUNT(DISTINCT r::text)		AS difference
FROM raw_data AS r;

/* ================================================================================================================================================================
   Output:   payment_channel verification.
   Finding:  Before the cleaning there were ten unique values, after it left nine.
   ================================================================================================================================================================ */
SELECT (SELECT COUNT(DISTINCT canal_pago) 			FROM raw_data)		AS number_payment_channel_raw_data,
	(SELECT COUNT(DISTINCT payment_channel_name) 	FROM clean_data)	AS number_payment_channel_clean_data;

/* ================================================================================================================================================================
   Output:   Row count per year. Expected: 2021-2025 full years; 2026 partial.
   Finding:  There is an increasing trend throughout the years. 2021: 169249, 2022: 187790, 2023: 193116, 2024: 205188, 2025: 212793, 2026: 159680 until September.
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
	SUM(ABS(amount_credit_notes + amount_cash - amount_paid)) AS total_difference
FROM clean_data
GROUP BY payment_year;
 
/* ================================================================================================================================================================
   Output:   Payment dates outside the expected window.
   Finding:  There are no payments outside the expected window.
   ================================================================================================================================================================ */
SELECT COUNT(*) AS out_of_range
FROM clean_data
WHERE payment_date < '2021-01-01'
	OR payment_date > CURRENT_DATE;

/* ================================================================================================================================================================
   Output:   Reversals (negative amounts): count and net effect on revenue.
   Finding:  There is one negative amount which has a total of USD -730.74; the other negative values are credit notes.
   ================================================================================================================================================================ */
SELECT 
    COUNT(*) FILTER (WHERE amount_credit_notes < 0) 					AS rows_credit_notes,
    SUM(amount_credit_notes) FILTER (WHERE amount_credit_notes < 0) 	AS amount_credit_notes,
    COUNT(*) FILTER (WHERE amount_cash < 0) 							AS row_negative_cash_values, 
    SUM(amount_cash) FILTER (WHERE amount_cash < 0) 					AS sum_negative_cash_values
FROM clean_data;
 
/* ================================================================================================================================================================
   Output:   Rows with corrupted characters ('??') in each text column.
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
   Finding:  nom_estado_liquidacion column has a single value.
   ================================================================================================================================================================ */
SELECT COUNT(DISTINCT nom_estado_liquidacion) AS distinct_statuses
FROM raw_data;
 
/* ================================================================================================================================================================
   Output:   Cash and credit notes without payment channel.
   Finding:  There are no cash payments without channel, so the movements without channel correspond to credit notes. The 95.58% of the credit notes amount doesn't 
			 have a payment channel; it means USD 302093091.48.
   ================================================================================================================================================================ */
SELECT
	COUNT(*) FILTER(WHERE payment_channel_name = 'SIN CANAL' AND amount_cash <> 0)				AS cash_rows_without_channel,
	SUM(amount_credit_notes) FILTER(WHERE payment_channel_name = 'SIN CANAL')					AS credit_notes_without_channel,
	SUM(amount_credit_notes)																	AS total_credit_notes,
	ROUND(100 * SUM(amount_credit_notes) FILTER(WHERE payment_channel_name = 'SIN CANAL')
		/ SUM(amount_credit_notes), 2)															AS share_of_credit_notes
FROM clean_data;

/* ================================================================================================================================================================
   Output:   Credit notes per year and the revenue share.
   Finding:  The year with the lowest share paid with credit notes is 2026 with 0.56% of the total amount paid (until September), and the highest is 2023 with 2.47%; 
   			 it means USD 92716798.84 from credit notes.
   ================================================================================================================================================================ */
SELECT payment_year,
	SUM(amount_credit_notes) 											AS total_credit_notes, 
	SUM(amount_paid)													AS total_amount_paid,
	ROUND(100 * SUM(amount_credit_notes) / SUM(amount_paid), 2)			AS share_credit_notes_amount_paid
FROM clean_data
GROUP BY payment_year
ORDER BY payment_year;

/* ================================================================================================================================================================
   Output:   Rows where only the sanction or the infraction is 'NO APLICA'.
   Finding:  There is not any infraction or sanction without a match between them.
   ================================================================================================================================================================ */
SELECT COUNT(*) FILTER(WHERE infraction_name = 'NO APLICA' AND sanction_type_name <> 'NO APLICA') 	AS infraction_none_sanction_present,
	COUNT(*) FILTER(WHERE infraction_name <> 'NO APLICA' AND sanction_type_name = 'NO APLICA')		AS infraction_present_sanction_none
FROM clean_data;
