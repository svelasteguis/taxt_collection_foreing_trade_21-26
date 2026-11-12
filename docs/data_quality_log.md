# Data Quality Log
Author: Sebastián Velasteguí
When the checks were run: November 8, 2026 

| Check | Result | Decision |
| --- | --- | --- |
| Duplicates | 0 | There is nothing to remove |
| Payment channel | Before: 10 values<br>  After: 9 values | `OTROS` was normalized |
| Accounting identity | In 2025 there is a difference of USD 0.02 | As numeric was used, the rounding is acceptable |
| Negatives | One value in cash (-730.74) and six in credit notes (-659.47) | They were kept |
| Corrupted text | `nom_tributo` column has 62,479 rows<br>  `nom_infraccion` column has 5,376 rows | They were kept as in the source |
| `SIN CANAL` | The 95.58% of the credit notes amount is in the `SIN CANAL` channel. It means USD 302,093,091.48 | The channel analysis is not affected because all the cash have a channel |
| Sanction and Infraction | There are no inconsistencies | It supports the `NO APLICA` interpretation |
| Liquidation status | Only one value | The column was excluded from the view |
