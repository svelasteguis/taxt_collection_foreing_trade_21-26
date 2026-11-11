# Methodology 
Author: Sebastián Velasteguí

## Scope
It is an independat project. It is a descrptive analysis of aggregate amounts. It is neither an audit review nor a legal one.

## Data and Period
Source, data taken from SENAE since January 2021 to September 2026. The files were downloaded in October 15, 2026. <br>
There are 1,127,816 rows.

## Metric Choice
 `amount_cash` is used to the totals., as the portal suggests, and `amount_paid` just to break down the tax. The difference is the credit notes (0.56% to 2.47% per year). Question 3(b) is sensitive to the field `amount_paid` (cash or paid).

## Cleaning Desicions
- It was decided to split the code and the name.
- normalize the two format to `OTROS`.
- The digits fields were cast to `numeric(20, 2)`; it rounds to two decimals.
- The corrupted text is kept.
- There are no duplicates.

## Comparability
- 2026 is partial since January to September.
- Question 3 (a) compares from January to September.
- Question 4 excludes 2026.

## Limitations
- The currency was assumed.
- Each row does not mean a transaction.
- The dictionary does not define the liquidation type.
- The credit notes are not cash.

# Data Quality
Author: Sebastián Velasteguí
When: 

| Checks | Results | Decision |
| --- | --- | --- |
| Duplicates | 0 | There is nothing to remove |
| Payment channel | Before: 10 values<br>  Now: 9 values. | `OTROS` was normalized |
| Accounting identity | In 2025 there is a difference of USD 0.02 | As numeric was used, the rounding is acceptable |
| Negatives | One value in cash (-730.74) and six in credit notes (-659.47) | They were kept |
| Corrupted text | `nom_tributo` column has 62,479 rows<br>  `nom_infraccion` column has 5,376 | They were kept as in the source |
| `SIN CANAL` | All the amount   | There is no cash without a channel |
| Sanction and Infraction | There are not inconsistencies | It supports the `NO APLICA` intepretation |
| Liquidation status | Only one value | The column was excluded from the view |
