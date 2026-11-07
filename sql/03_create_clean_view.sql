/* ========================================================================================================================================================
   Project:  Ecuador Customs Tax Collection (SENAE), 2021-2026
   Purpose:  Build the typed, English-named view used by every analysis query.
   Output:   clean_data view
   Notes:    - Codes are split from labels (e.g. '07-IVA' -> '07' and 'IVA').
             - Amounts are cast to numeric(20,2). Amounts appear to be in USD (Ecuador is dollarized); the SENAE data dictionary does not 
			   state the currency.
             - Some source text contains corrupted characters ('??'). They are kept as-is because the original character cannot be recovered.
			 - The 'nom_estado_liquidacion' column was not used because it has a single value ('C-PAGADO'): all rows are paid.
			 - The fields' meanings are in the SENAE's dictionary (senae_recaudacionesdetributoscomercioexterior_dd_2024ene.ods).
			 - payment_date is the date when the tax was paid, so the amounts were registered in the month of paid.
			 - amount_paid is the total amount of the tax generated. It is equal to amount_cash plus amount_credit_notes.
			 - NO APLICA in the columns infraction_name and sanction_type_name were interpreted as the record does not have an infraction or a sanction
			 - The channel OTROS appears in the raw dataset as '12-OTROS' and '5 12-OTROS'; both were cleaned to the code 12
			 - amount_cash is used for analysis totals.
			 - amount_paid is kept in the view for tax breakdown, as the portal suggests
   Author:   Sebastián Velasteguí
   ======================================================================================================================================================== */

CREATE OR REPLACE VIEW clean_data AS
SELECT
	NULLIF(SUBSTRING(TRIM(nom_distrito) FROM '^\d+'),'') 				AS district_code,			-- '^\d+' is used to identify a sequence of digits at the beginning of the text
	REGEXP_REPLACE(TRIM(nom_distrito), '^\d+\s*-\s*', '') 				AS district_name,			-- '^\d+' is used to identify at the begining a serie of numeric characters followed by '\s*-\s*' and replace it with ''
	NULLIF(SUBSTRING(TRIM(nom_tributo) FROM '^\d+'), '') 				AS tax_code,
	REGEXP_REPLACE(TRIM(nom_tributo), '^\d+\s*-\s*', '') 				AS tax_name,
	fec_pago :: DATE													AS payment_date,			-- :: is used in PostgreSQL instead of CAST(fec_pago AS date)
	EXTRACT(YEAR FROM fec_pago::DATE)::INT								AS payment_year,
	EXTRACT(MONTH FROM fec_pago::DATE)::INT								AS payment_month,
	NULLIF(SUBSTRING(TRIM(nom_tipo_liquidacion) FROM '^\d+'), '') 		AS liquidation_type_code,
	REGEXP_REPLACE(TRIM(nom_tipo_liquidacion), '^\d+\s*-\s*', '') 		AS liquidation_type_name,
	NULLIF(SUBSTRING(TRIM(tipos_doc_referencia) FROM '^\d+'),'') 		AS reference_doc_code,
	REGEXP_REPLACE(TRIM(tipos_doc_referencia), '^\d+\s*-\s*', '') 		AS reference_doc_name,
	NULLIF(SUBSTRING(TRIM(nom_infraccion) FROM '^\d+'),'') 				AS infraction_code,
	REGEXP_REPLACE(TRIM(nom_infraccion), '^\d+\s*-\s*', '') 			AS infraction_name,
	NULLIF(SUBSTRING(TRIM(nom_tipo_sancion) FROM '^\d+'), '')			AS sanction_type_code,
	REGEXP_REPLACE(TRIM(nom_tipo_sancion), '^\d+\s*-\s*', '')			AS sanction_type_name,
	NULLIF(SUBSTRING(TRIM(canal_pago) FROM '(\d+)\s*-'), '')   			AS payment_channel_code,
	REGEXP_REPLACE(TRIM(canal_pago), '^[0-9 ]+-\s*', '')        		AS payment_channel_name,	-- There are two formats (5 12-OTROS and 12-OTROS) for Others (OTROS) so it keeps the code 12 
	valor_total_tributo_en_nc :: numeric(20,2)							AS amount_credit_notes, 	-- numeric keeps exact decimal values
	valor_total_tributo_en_efectivo :: numeric(20,2)					AS amount_cash,
	valor_total_tributo_pagado :: numeric(20,2)							AS amount_paid				-- Cash plus credit note
FROM raw_data;
