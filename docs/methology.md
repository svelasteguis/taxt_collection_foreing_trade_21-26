# Methodology 
Author: Sebastián Velasteguí

## Scope
It is an independent project. It is a descriptive analysis of aggregate amounts. It is neither an audit review nor a legal one.

## Data and Period
The data come from the National Customs Service of Ecuador (SENAE) and were published on the Datos Abiertos Ecuador portal. They cover payment dates from January 2021 to September 2026. The files were downloaded on October 15, 2026.
There are 1,127,816 rows.

## Metric Choice
`amount_cash` is used for the totals, as the portal suggests, and `amount_paid` just to break down the tax. The difference is the credit notes which represent 0.56% to 2.47% of the total amount paid per year. In question 3(b) the result changes if the cash or paid column is used.

## Cleaning Decisions
- It was decided to split the code and the name.
- The two formats of the `OTROS` payment channel were normalized.
- The amount fields were cast to `numeric(20,2)`; it rounds to two decimals.
- The corrupted text is kept.
- There are no exact duplicates.

## Comparability
- 2026 only covers January to September.
- Question 3(a) compares January to September between 2026 and 2025.
- Question 4 excludes 2026 because it does not have October to December, so the result for those months could be reduced and not represent the real values.

## Limitations
- The currency was assumed to be USD because the SENAE dictionary do not state it and Ecuador is dollarized
- Each row does not mean a transaction.
- The dictionary does not define the liquidation of each type.
- The credit notes are not cash.
