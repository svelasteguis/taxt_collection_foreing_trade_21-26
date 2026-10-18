-- ============================================================================================================================================================================
-- PROJECT: Analysis of tax revenues collected by the National Customs Service of Ecuador
-- SCRIPT: Analytic Queries to Develop Insights
-- AUTHOR: Sebastián Velasyeguí
-- ============================================================================================================================================================================

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Creat the Database for the new project
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE DATABASE foreign_trade_senae;

-- Connect to the Database using PowerShell
\c foreign_trade_senae;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create the table with the 2021 headers
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE year_2021 (	
	NOM_DISTRITO VARCHAR(150), 
	NOM_TRIBUTO VARCHAR(150), 
	FEC_PAGO VARCHAR(150), 
	NOM_TIPO_LIQUIDACION VARCHAR(150),
    NOM_ESTADO_LIQUIDACION VARCHAR(50), 
	TIPOS_DOC_REFERENCIA VARCHAR(100), 
	NOM_INFRACCION TEXT,
    NOM_TIPO_SANCION VARCHAR(100), 
	CANAL_PAGO VARCHAR(50), 
	VALOR_TOTAL_TRIBUTO_EN_NC VARCHAR(100),
    VALOR_TOTAL_TRIBUTO_EN_EFECTIVO VARCHAR(100), 
	VALOR_TOTAL_TRIBUTO_PAGADO VARCHAR(100)
);

-- Populate the table from the 2021 CSV file using '|' as the delimiter
\copy year_2021 (nom_distrito, nom_tributo, fec_pago, nom_tipo_liquidacion, nom_estado_liquidacion, tipos_doc_referencia, nom_infraccion, nom_tipo_sancion, canal_pago, valor_total_tributo_en_nc, valor_total_tributo_en_efectivo, valor_total_tributo_pagado) FROM 'C:/Users/Sebas/Downloads/senae_recaudaciones_enero_diciembre_2021.csv' WITH DELIMITER '|' CSV HEADER QUOTE '"';

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create the table with the 2022 headers
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE year_2022 (
	NOM_DISTRITO VARCHAR(150), 
	NOM_TRIBUTO VARCHAR(150), 
	FEC_PAGO VARCHAR(150), 
	NOM_TIPO_LIQUIDACION VARCHAR(150),
    NOM_ESTADO_LIQUIDACION VARCHAR(50), 
	TIPOS_DOC_REFERENCIA VARCHAR(100), 
	NOM_INFRACCION TEXT,
    NOM_TIPO_SANCION VARCHAR(100), 
	CANAL_PAGO VARCHAR(50), 
	VALOR_TOTAL_TRIBUTO_EN_NC VARCHAR(100),
    VALOR_TOTAL_TRIBUTO_EN_EFECTIVO VARCHAR(100), 
	VALOR_TOTAL_TRIBUTO_PAGADO VARCHAR(100)
);

-- Populate the table from the 2022 CSV file using '|' as the delimiter
\copy year_2022 (nom_distrito, nom_tributo, fec_pago, nom_tipo_liquidacion, nom_estado_liquidacion, tipos_doc_referencia, nom_infraccion, nom_tipo_sancion, canal_pago, valor_total_tributo_en_nc, valor_total_tributo_en_efectivo, valor_total_tributo_pagado) FROM 'C:/Users/Sebas/Downloads/senae_recaudaciones_enero_diciembre_2022.csv' WITH DELIMITER '|' CSV HEADER QUOTE '"';

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create the table with the 2023 headers
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE year_2023 (
	NOM_DISTRITO VARCHAR(150), 
	NOM_TRIBUTO VARCHAR(150), 
	FEC_PAGO VARCHAR(150), 
	NOM_TIPO_LIQUIDACION VARCHAR(150),
    NOM_ESTADO_LIQUIDACION VARCHAR(50), 
	TIPOS_DOC_REFERENCIA VARCHAR(100), 
	NOM_INFRACCION TEXT,
    NOM_TIPO_SANCION VARCHAR(100), 
	CANAL_PAGO VARCHAR(50), 
	VALOR_TOTAL_TRIBUTO_EN_NC VARCHAR(100),
    VALOR_TOTAL_TRIBUTO_EN_EFECTIVO VARCHAR(100), 
	VALOR_TOTAL_TRIBUTO_PAGADO VARCHAR(100)
);

-- Populate the table from the 2023 CSV file using '|' as the delimiter
\copy year_2023 (nom_distrito, nom_tributo, fec_pago, nom_tipo_liquidacion, nom_estado_liquidacion, tipos_doc_referencia, nom_infraccion, nom_tipo_sancion, canal_pago, valor_total_tributo_en_nc, valor_total_tributo_en_efectivo, valor_total_tributo_pagado) FROM 'C:/Users/Sebas/Downloads/senae_recaudaciones_enero_diciembre_2023.csv' WITH DELIMITER '|' CSV HEADER QUOTE '"';

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create the table with the 2024 headers
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE year_2024 (
	NOM_DISTRITO VARCHAR(150), 
	NOM_TRIBUTO VARCHAR(150), 
	FEC_PAGO VARCHAR(150), 
	NOM_TIPO_LIQUIDACION VARCHAR(150),
    NOM_ESTADO_LIQUIDACION VARCHAR(50), 
	TIPOS_DOC_REFERENCIA VARCHAR(100), 
	NOM_INFRACCION TEXT,
    NOM_TIPO_SANCION VARCHAR(100), 
	CANAL_PAGO VARCHAR(50), 
	VALOR_TOTAL_TRIBUTO_EN_NC VARCHAR(100),
    VALOR_TOTAL_TRIBUTO_EN_EFECTIVO VARCHAR(100), 
	VALOR_TOTAL_TRIBUTO_PAGADO VARCHAR(100)
);

-- Populate the table from the 2024 CSV file using '|' as the delimiter
\copy year_2024 (nom_distrito, nom_tributo, fec_pago, nom_tipo_liquidacion, nom_estado_liquidacion, tipos_doc_referencia, nom_infraccion, nom_tipo_sancion, canal_pago, valor_total_tributo_en_nc, valor_total_tributo_en_efectivo, valor_total_tributo_pagado) FROM 'C:/Users/Sebas/Downloads/senae_recaudaciones_enero_diciembre_2024.csv' WITH DELIMITER '|' CSV HEADER QUOTE '"';

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create the table with the 2025 headers
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE year_2025 (
	NOM_DISTRITO VARCHAR(150), 
	NOM_TRIBUTO VARCHAR(150), 
	FEC_PAGO VARCHAR(150), 
	NOM_TIPO_LIQUIDACION VARCHAR(150),
    NOM_ESTADO_LIQUIDACION VARCHAR(50), 
	TIPOS_DOC_REFERENCIA VARCHAR(100), 
	NOM_INFRACCION TEXT,
    NOM_TIPO_SANCION VARCHAR(100), 
	CANAL_PAGO VARCHAR(50), 
	VALOR_TOTAL_TRIBUTO_EN_NC VARCHAR(100),
    VALOR_TOTAL_TRIBUTO_EN_EFECTIVO VARCHAR(100), 
	VALOR_TOTAL_TRIBUTO_PAGADO VARCHAR(100)
);

-- Populate the table from the 2025 CSV file using '|' as the delimiter
\copy year_2025 (nom_distrito, nom_tributo, fec_pago, nom_tipo_liquidacion, nom_estado_liquidacion, tipos_doc_referencia, nom_infraccion, nom_tipo_sancion, canal_pago, valor_total_tributo_en_nc, valor_total_tributo_en_efectivo, valor_total_tributo_pagado) FROM 'C:/Users/Sebas/Downloads/senae_recaudaciones_ene_dic_2025.csv' WITH DELIMITER '|' CSV HEADER QUOTE '"';

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create the table with the 2026 headers
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE year_2026 (
	NOM_DISTRITO VARCHAR(150), 
	NOM_TRIBUTO VARCHAR(150), 
	FEC_PAGO VARCHAR(150), 
	NOM_TIPO_LIQUIDACION VARCHAR(150),
    NOM_ESTADO_LIQUIDACION VARCHAR(50), 
	TIPOS_DOC_REFERENCIA VARCHAR(100), 
	NOM_INFRACCION TEXT,
    NOM_TIPO_SANCION VARCHAR(100), 
	CANAL_PAGO VARCHAR(50), 
	VALOR_TOTAL_TRIBUTO_EN_NC VARCHAR(100),
    VALOR_TOTAL_TRIBUTO_EN_EFECTIVO VARCHAR(100), 
	VALOR_TOTAL_TRIBUTO_PAGADO VARCHAR(100)
);

-- Populate the table from the 2026 CSV file using '|' as the delimiter
\copy year_2026 (nom_distrito, nom_tributo, fec_pago, nom_tipo_liquidacion, nom_estado_liquidacion, tipos_doc_referencia, nom_infraccion, nom_tipo_sancion, canal_pago, valor_total_tributo_en_nc, valor_total_tributo_en_efectivo, valor_total_tributo_pagado) FROM 'C:/Users/Sebas/Downloads/senae_recaudaciones_ene_sep_2026.csv' WITH DELIMITER '|' CSV HEADER QUOTE '"';

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create a master view across all tables to atomatically reflect new months added to the year_2026 table
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW tax_foreign_trade AS
	SELECT * FROM year_2021
	UNION ALL
	SELECT * FROM year_2022
	UNION ALL
	SELECT * FROM year_2023
	UNION ALL
	SELECT * FROM year_2024
	UNION ALL
	SELECT * FROM year_2025
	UNION ALL
	SELECT * FROM year_2026;
