
### Vaccination data by age

Sourced from [ECDC](https://www.ecdc.europa.eu/en/publications-data/data-covid-19-vaccination-eu-eea); see their [data dictionary](https://www.ecdc.europa.eu/sites/default/files/documents/Variable_Dictionary_VaccineTracker-17-05-2022.pdf) for metadata. Currently age-stratified data do not include Greece (GR), Netherlands (NL), United Kingdom (GB)

- `vaccination-age-week.csv`
   - Clean version of raw ECDC dataset, starting in 2020 and including vaccinations administered by country, target group (age, health care workers, long term care facilities), and type of dose (first, second, first booster, second booster, unknown). Raw data also include a breakdown by type of vaccine, not included here.

- `vaccination-60plus-booster1.csv`
   - Includes only first booster doses administered, in total ("all"), and doses to ages over 60, with their proportion.
