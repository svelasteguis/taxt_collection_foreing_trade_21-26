/* ============================================================================
   Project:  Ecuador Customs Tax Collection (SENAE), 2021-2026
   Purpose:  Build the typed, English-named view used by every analysis query.
   Output:   clean_data view
   Notes:    - Codes are split from labels (e.g. '07-IVA' -> '07' and 'IVA').
             - Amounts are cast to numeric(20,2). Amounts appear to be in USD (Ecuador is dollarized); confirm in the SENAE data dictionary.
             - Some source text contains corrupted characters ('??'). They are kept as-is because the original character cannot be recovered.
             - Exact duplicate rows are kept: without a unique key they cannot be told apart from legitimate identical payments.
   Author:   Sebastián Velasteguí
   ============================================================================ */

CREATE OR REPLACE VIEW clean_data AS
SELECT
	NULLIF(SUBSTRING(TRIM(nom_distrito) FROM '^\d+'),'') 				AS district_code,			-- '^\d+' is used to identify from the begining a serial of numeric characters
	REGEXP_REPLACE(TRIM(nom_distrito), '^\d+\s*-\s*', '') 				AS district_name,			-- :: is is used to identify from the begining a serial of numeric characters following of ' - ' and remplace with ''
	NULLIF(SUBSTRING(TRIM(nom_tributo) FROM '^\d+'), '') 				AS tax_code,
	REGEXP_REPLACE(TRIM(nom_tributo), '^\d+\s*-\s*', '') 				AS tax_name,
	fec_pago :: DATE													AS payment_date,			-- :: is used in Postgres insede CASE(fec_pago AS date)
	EXTRACT(YEAR FROM fec_pago::DATE)::INT								AS payment_year,
	EXTRACT(MONTH FROM fec_pago::DATE)::INT								AS payment_month,
	NULLIF(SUBSTRING(TRIM(nom_tipo_liquidacion) FROM '^\d+'), '') 		AS type_liquidation_code,
	REGEXP_REPLACE(TRIM(nom_tipo_liquidacion), '^\d+\s*-\s*', '') 		AS type_liquidation_name,
	NULLIF(SUBSTRING(TRIM(tipos_doc_referencia) FROM '^\d+'),'') 		AS reference_doc_code,
	REGEXP_REPLACE(TRIM(tipos_doc_referencia), '^\d+\s*-\s*', '') 		AS reference_doc_name,
	NULLIF(SUBSTRING(TRIM(nom_infraccion) FROM '^\d+'),'') 				AS infraction_code,
	REGEXP_REPLACE(TRIM(nom_infraccion), '^\d+\s*-\s*', '') 			AS infraction_name,
	NULLIF(SUBSTRING(TRIM(nom_tipo_sancion) FROM '^\d+'), '')			AS sanction_type_code,
	REGEXP_REPLACE(TRIM(nom_tipo_sancion), '^\d+\s*-\s*', '')			AS sanction_type_name,
	NULLIF(SUBSTRING(TRIM(canal_pago) FROM '^\d+'), '')					AS payment_channel_code,
	REGEXP_REPLACE(TRIM(canal_pago), '^\d+\s*-\s*', '')					AS payment_chanel_name,
	valor_total_tributo_en_nc :: numeric(20,2)							AS amount_credit_notes, 	-- numeric type is used to keep the acurrete value
	valor_total_tributo_en_efectivo :: numeric(20,2)					AS amount_cash,
	valor_total_tributo_pagado :: numeric(20,2)							AS amount_paid
FROM raw_data;
