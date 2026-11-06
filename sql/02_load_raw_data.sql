/* ============================================================================================================================================================================
   Project:  Ecuador Customs Tax Collection (SENAE), 2021-2026
   Purpose:  Load the yearly SENAE CSV files into one raw staging table.
   Output:   raw_data (all columns stored as text, no transformations)
   Notes:    - Every column is text on purpose: casting and cleaning happen in sql/03_create_clean_view, so the raw layer always mirrors the source.
             - The CSV column order matches the table definition below.
             - The 2026 file is partial (January-September).
   Author:   Sebastián Velasteguí
   ============================================================================================================================================================================ */

-- Use DROP TABLE IF EXISTS to avoid an error when creating a table already exists
DROP TABLE IF EXISTS raw_data CASCADE;

-- Create a table with the csv headers and text data types to avoid errors when loading the data
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

-- Load each csv file into the table, setting the format, delimeter and header
\copy raw_data FROM 'C:/data/raw/senae_recaudaciones_enero_diciembre_2021.csv' WITH (FORMAT csv,DELIMITER '|', HEADER true)
\copy raw_data FROM 'C:/data/raw/senae_recaudaciones_enero_diciembre_2022.csv' WITH (FORMAT csv,DELIMITER '|', HEADER true)
\copy raw_data FROM 'C:/data/raw/senae_recaudaciones_enero_diciembre_2023.csv' WITH (FORMAT csv,DELIMITER '|', HEADER true)
\copy raw_data FROM 'C:/data/raw/senae_recaudaciones_enero_diciembre_2024.csv' WITH (FORMAT csv,DELIMITER '|', HEADER true)
\copy raw_data FROM 'C:/data/raw/senae_recaudaciones_ene_dic_2025.csv' WITH (FORMAT csv,DELIMITER '|', HEADER true)
\copy raw_data FROM 'C:/data/raw/senae_recaudaciones_ene_sep_2026.csv' WITH (FORMAT csv,DELIMITER '|', HEADER true)
