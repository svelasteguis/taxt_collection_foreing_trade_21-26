-- ============================================================================================================================================================================
-- PROJECT: Analysis of tax revenues collected by the National Customs Service of Ecuador
-- SCRIPT: Analytic Queries to Develop Insights
-- AUTHOR: Sebastián Velasyeguí
-- ============================================================================================================================================================================

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
-- Rank the top 3 regulatory infractions and their corresponding tax collection
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

