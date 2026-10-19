/* ============================================================================================================================================================================
   Project:  Ecuador Customs Tax Collection (SENAE), 2021-2026
   Purpose:  Load the yearly SENAE CSV files into one raw staging table.
   Output:   raw_data (all columns stored as text, no transformations)
   Notes:    - Every column is text on purpose: casting and cleaning happen in sql/03_cleaning, so the raw layer always mirrors the source.
             - The CSV column order matches the table definition below.
             - The 2026 file is partial (January-September).
   Author:   Sebastián Velasteguí
   ============================================================================================================================================================================ */

-- Use DROP TABLE IF EXISTS to avoid any error in the future traying creating an table already exists
DROP TABLE IF EXISTS raw_data CASCADE;

-- Create a table with the headers and text value types to avoid any error at the time to load the csv's information
CREATE TABLE raw_data (
	nom_distrito                         text,
	nom_tributo                          text,
	fec_pago                             text,
	nom_tipo_liquidacion                 text,
	nom_estado_liquidacion               text,
	tipos_doc_referencia                 text,
	nom_infraccion                       text,
	nom_tipo_sancion                     text,
	canal_pago                           text,
	valor_total_tributo_en_nc            text,
	valor_total_tributo_en_efectivo      text,
	valor_total_tributo_pagado           text
);

-- Load the information from the csv to the table setting the format, delimeter and header
\copy raw_data FROM 'C:/path/senae_recaudaciones_enero_diciembre_2021.csv' WITH (FORMAT csv,DELIMITER '|', HEADER true)
\copy raw_data FROM 'C:/path/senae_recaudaciones_enero_diciembre_2022.csv' WITH (FORMAT csv,DELIMITER '|', HEADER true)
\copy raw_data FROM 'C:/path/senae_recaudaciones_enero_diciembre_2023.csv' WITH (FORMAT csv,DELIMITER '|', HEADER true)
\copy raw_data FROM 'C:/path/senae_recaudaciones_enero_diciembre_2024.csv' WITH (FORMAT csv,DELIMITER '|', HEADER true)
\copy raw_data FROM 'C:/path/senae_recaudaciones_ene_dic_2025.csv' WITH (FORMAT csv,DELIMITER '|', HEADER true)
\copy raw_data FROM 'C:/path/senae_recaudaciones_ene_sep_2026.csv' WITH (FORMAT csv,DELIMITER '|', HEADER true)
