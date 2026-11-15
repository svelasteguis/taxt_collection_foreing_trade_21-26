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
			 - payment_date is the date when the tax was paid, so the amounts were registered in the month of payment.
			 - amount_paid is the total amount of the tax generated. It is equal to amount_cash plus amount_credit_notes.
			 - NO APLICA in the columns infraction_name and sanction_type_name was interpreted to mean that the record does not have an infraction or a sanction.
			 - The channel OTROS appears in the raw dataset as '12-OTROS' and '5 12-OTROS'; both were cleaned to the code 12.
			 - amount_cash is used for analysis totals.
			 - amount_paid is kept in the view for tax breakdown, as the portal suggests.
   Author:   Sebastián Velasteguí
   ======================================================================================================================================================== */

CREATE OR REPLACE VIEW clean_data AS
SELECT NULLIF("substring"(TRIM(BOTH FROM nom_distrito), '^\d+'::text), ''::text)::integer 		AS district_code,				-- '^\d+' is used to identify a sequence of digits at the beginning of the text
    regexp_replace(TRIM(BOTH FROM nom_distrito), '^\d+\s*-\s*'::text, ''::text) 				AS district_name,				-- '^\d+' is used to identify at the beginning a series of numeric characters followed by '\s*-\s*' and replace it with ''
    NULLIF("substring"(TRIM(BOTH FROM nom_tributo), '^\d+'::text), ''::text)::integer 			AS tax_code,
    regexp_replace(TRIM(BOTH FROM nom_tributo), '^\d+\s*-\s*'::text, ''::text) 					AS tax_name,
    fec_pago::date 																				AS payment_date,				-- :: is used in PostgreSQL instead of CAST(fec_pago AS date)
    EXTRACT(year FROM fec_pago::date)::integer 													AS payment_year,
    EXTRACT(month FROM fec_pago::date)::integer 												AS payment_month,
    NULLIF("substring"(TRIM(BOTH FROM nom_tipo_liquidacion), '^\d+'::text), ''::text)::integer 	AS liquidation_type_code,
    regexp_replace(TRIM(BOTH FROM nom_tipo_liquidacion), '^\d+\s*-\s*'::text, ''::text)			AS liquidation_type_name,
    NULLIF("substring"(TRIM(BOTH FROM tipos_doc_referencia), '^\d+'::text), ''::text)::integer 	AS reference_doc_code,
    regexp_replace(TRIM(BOTH FROM tipos_doc_referencia), '^\d+\s*-\s*'::text, ''::text) 		AS reference_doc_name,
    NULLIF("substring"(TRIM(BOTH FROM nom_infraccion), '^\d+'::text), ''::text)::integer		AS infraction_code,
    regexp_replace(TRIM(BOTH FROM nom_infraccion), '^\d+\s*-\s*'::text, ''::text) 				AS infraction_name,
    NULLIF("substring"(TRIM(BOTH FROM nom_tipo_sancion), '^\d+'::text), ''::text)::integer		AS sanction_type_code,
    regexp_replace(TRIM(BOTH FROM nom_tipo_sancion), '^\d+\s*-\s*'::text, ''::text) 			AS sanction_type_name,
    NULLIF("substring"(TRIM(BOTH FROM canal_pago), '(\d+)\s*-'::text), ''::text)::integer		AS payment_channel_code,
    regexp_replace(TRIM(BOTH FROM canal_pago), '^[0-9 ]+-\s*'::text, ''::text) 					AS payment_channel_name,		-- There are two formats (5 12-OTROS and 12-OTROS) for Others (OTROS) so it keeps the code 12 
    valor_total_tributo_en_nc::numeric(20,2) 													AS amount_credit_notes,			-- numeric rounds to two decimal places
    valor_total_tributo_en_efectivo::numeric(20,2) 												AS amount_cash,
    valor_total_tributo_pagado::numeric(20,2) 													AS amount_paid					-- Cash plus credit note
FROM raw_data;
