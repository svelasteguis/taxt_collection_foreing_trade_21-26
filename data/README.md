# Data

## Source
- Dataset: Registros de recaudaciones de tributos de comercio exterior
- Publisher: National Customs Service of Ecuador (SENAE), through the Datos Abiertos Ecuador portal
- Portal: https://www.datosabiertos.gob.ec/dataset/datos-de-recaudaciones-de-tributos-de-comercio-exterior
- License: Creative Commons Attribution (CC BY) http://www.opendefinition.org/licenses/cc-by
- Update frequency: monthly
- Source system: ECUAPASS
- Downloaded on: October 15, 2026

## Files
### Data Files
| File Name | Title on the Portal | Period | Rows | Size |
| --- | --- | --- | --- | --- |
| `senae_recaudaciones_enero_diciembre_2021.csv` | SENAE_RECAUDACIONESDETRIBUTOSDECOMERCIOEXTERIOR_2021 | January-December 2021 | 169,249 | 37.2 MB |
| `senae_recaudaciones_enero_diciembre_2022.csv` | SENAE_RECAUDACIONESDETRIBUTOSDECOMERCIOEXTERIOR_2022 | January-December 2022 | 187,790 | 40.9 MB |
| `senae_recaudaciones_enero_diciembre_2023.csv` | SENAE_RECAUDACIONESDETRIBUTOSDECOMERCIOEXTERIOR_2023 | January-December 2023 | 193,116 | 33.9 MB |
| `senae_recaudaciones_enero_diciembre_2024.csv` | SENAE_RECAUDACIONESDETRIBUTOSDECOMERCIOEXTERIOR_2024 | January-December 2024 | 205,188 | 36.1 MB |
| `senae_recaudaciones_ene_dic_2025.csv` | SENAE_RECAUDACIONESDETRIBUTOSDECOMERCIOEXTERIOR_2025 | January-December 2025 | 212,793 | 37.4 MB |
| `senae_recaudaciones_ene_sep_2026.csv` | SENAE_RECAUDACIONESDETRIBUTOSDECOMERCIOEXTERIOR_2026ENE-SEP | January-September 2026 | 159,680 | 27.9 MB |
| **TOTAL** | | | **1,127,816** | **213.4 MB** |

### Documentation Files
| File Name | Title on the Portal | Content |
| --- | --- | --- |
| `senae_recaudacionesdetributoscomercioexterior_dd_2024ene.ods` | SENAE_RecaudacionesDeTributosDeComercioExterior_DD_2024ENE | Data dictionary (SENAE_RECAUD_V01) |
| `senae_recaudacionesdetributosdecomercioexterior_pm_2024ene.ods` | SENAE_RecaudacionesDeTributosDeComercioExterior_PM_2024ENE | Metadata file |

- File Name is the name used by `02_load_raw_data.sql`.
- The Number of rows in the files downloaded on October 15, 2026, was counted on November 8, 2026.

## Format
- CSV files have twelve columns separated by `|` with a header row.
- The 2021 and 2022 files are in ASCII format.
- The files from 2023 to 2026 are in UTF-8 format.
- The corrupted text (??) comes from the source; it is not a loading error.

## How to get the data
1. Download the six CSV files from the portal.
2. Put them in `data/raw/` with the names in the `File Name` column.
3. Run `01_create_database.sql` first and then `02_load_raw_data.sql`, using psql from the root of the repo.

## Why the data is not in the repository
- The size of all the files (213.4 MB) will make the repo too heavy.
- The data author is SENAE. The files should be linked rather than distributed and the data is updated monthly.
