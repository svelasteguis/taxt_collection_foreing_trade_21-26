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
-- Create the table with the 2021 headers
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

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Rank the top 5 districts with highest total tax collection
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT nom_distrito, 
	SUM (CAST(valor_total_tributo_pagado AS numeric)) AS tributo_pagado
FROM tax_foreign_trade
GROUP BY nom_distrito
ORDER BY tributo_pagado DESC
LIMIT 5;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Ranking the top 3 payment types from the district with highest tax collectio
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT canal_pago, total_tributo_pagado 
FROM (
	SELECT nom_distrito, canal_pago, 
		SUM (CAST(valor_total_tributo_pagado AS numeric)) AS total_tributo_pagado
	FROM tax_foreign_trade
	WHERE nom_distrito = '028-GUAYAQUIL - MARITIMO'
	GROUP BY nom_distrito, canal_pago
	ORDER BY total_tributo_pagado DESC
	LIMIT 3)
AS sub;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Ranking the top 5 dates with the highest tax collection
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT LEFT(fec_pago, 7) AS date,
	SUM(CAST(valor_total_tributo_pagado AS numeric)) as total_tributo_pagado
FROM tax_foreign_trade
GROUP BY date
ORDER BY total_tributo_pagado DESC
LIMIT 5;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Rank the top 3 months with highest tax collection from 2021 to 2026
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT TO_CHAR(CAST(fec_pago AS date), 'Mon') AS month, 
	SUM(CAST(valor_total_tributo_pagado AS numeric)) AS total_tributo_pagado
FROM tax_foreign_trade
GROUP BY month
ORDER BY total_tributo_pagado DESC
LIMIT 3;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Rank the top 3 regulatory infractions andt their corresponding tax collection
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT nom_tipo_sancion, 
	COUNT(*) AS num_registros,
	SUM(CAST(valor_total_tributo_pagado AS numeric)) AS total_tributo_pagado
FROM tax_foreign_trade
WHERE nom_tipo_sancion <> 'NO APLICA'
GROUP BY nom_tipo_sancion
ORDER BY num_registros DESC
LIMIT 3;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Calculate rhe proportion between GUAYAQUIL - MARITIMO and GUAYAQUIL - AEREO
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT veces_maritimo 
FROM (
	WITH maritimo AS(
		SELECT SUM(CAST(valor_total_tributo_pagado AS numeric)) AS total_tributo_pagado_maritimo
		FROM tax_foreign_trade
		WHERE nom_distrito = '028-GUAYAQUIL - MARITIMO'
	),
	aereo AS (
		SELECT SUM(CAST(valor_total_tributo_pagado AS numeric)) AS total_tributo_pagado_aereo
		FROM tax_foreign_trade
		WHERE nom_distrito = '019-GUAYAQUIL - AEREO'
	)
	SELECT m.total_tributo_pagado_maritimo, a.total_tributo_pagado_aereo,
		ROUND(m.total_tributo_pagado_maritimo / a.total_tributo_pagado_aereo, 2) AS veces_maritimo
	FROM maritimo m, aereo a
) AS difference;
