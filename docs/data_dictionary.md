# Data Dictionary
- Institution: National Customs Service of Ecuador (SENAE)
- Dictionary identifier: SENAE_RECAUD_V01
- Dataset name: Foreign trade tax collections
- Licence: Creative Commons Attribution (CC BY)
- Portal Link: https://www.datosabiertos.gob.ec/dataset/datos-de-recaudaciones-de-tributos-de-comercio-exterior

## SENAE Dictionary Definitions
| Original Name | SQL View Name | SENAE description | Notes |
| --- | --- | --- | --- |
| `NOM_DISTRITO` | `district_code` `district_name` | District name of the liquidation record | Code and name split |
| `NOM_TRIBUTO` | `tax_code` `tax_name` | Tax name of the liquidation record | Group by code, not by name: One name appears with two codes |
| `FEC_PAGO` | `payment_date` `payment_year` `payment_month` | Payment date of the liquidation record | Range: 2021-01-01 to 2026-09-30 |
| `NOM_TIPO_LIQUIDACION` | `liquidation_type_code` `liquidation_type_name` | Name of the liquidation type | It is not used for the analysis |
| `NOM_ESTADO_LIQUIDACION` | not included | Status name of the liquidation record | In the six years, it is always paid (`C-PAGADO`) |
| `TIPOS_DOC_REFERENCIA` | `reference_doc_code` `reference_doc_name` | Reference document type linked to the liquidation record | It is not used; `999` does not have a label |
| `NOM_INFRACCION` | `infraction_code` `infraction_name` | Infraction name committed | `NO APLICA` is interpreted as no infraction. There are 5376 rows with corrupted text |
| `NOM_TIPO_SANCION` | `sanction_type_code` `sanction_type_name` | Sanction type name related to the infraction | Matches the infraction in each single row |
| `CANAL_PAGO` | `payment_channel_code` `payment_channel_name` | Channel where the payment was made | There are nine channels after the cleaning; `OTROS` comes in two formats |
| `VALOR_TOTAL_TRIBUTO_EN_NC` | `amount_credit_notes` | Credit note value of the generated tax | Represents 0.56% to 2.47% of the paid amount per year |
| `VALOR_TOTAL_TRIBUTO_EN_EFECTIVO` | `amount_cash` | Cash value of the generated tax | It is used for all totals |
| `VALOR_TOTAL_TRIBUTO_PAGADO` | `amount_paid` | Total value of the generated tax | It is equal to the cash plus credit notes |

## Not Definied by the SENAE Dictionary
- The currency is assumed to be United States dollar (USD)
- The meaning of each liquidation type
- There is not a liquidation identifier, so a row is not a unique transaction 
