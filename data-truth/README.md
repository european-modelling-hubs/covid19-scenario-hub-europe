# Reference data

For the Scenario Hub we use incident data over a Sunday-Saturday [(MMWR) week](https://github.com/covid19-forecast-hub-europe/covid19-forecast-hub-europe/wiki/Targets-and-horizons#horizon-and-frequency) for [32 countries](././data-locations/locations_eu.csv). Note that data sources vary, including in week definitions, with ECDC and Our World in Data typically using a Monday-Sunday (ISO) week.


Data | Source | Download | Includes 32 Hub countries | Notes
--- | --- | --- | --- | ---
Cases | [Euro Forecast Hub / JHU](https://github.com/covid19-forecast-hub-europe/covid19-forecast-hub-europe/tree/main/data-truth) | [csv](https://raw.githubusercontent.com/covid19-forecast-hub-europe/covid19-forecast-hub-europe/main/data-truth/JHU/truth_JHU-Incident%20Cases.csv) | Yes
Cases by age | [ECDC](https://www.ecdc.europa.eu/en/publications-data/covid-19-data-14-day-age-notification-rate-new-cases) | [csv](https://opendata.ecdc.europa.eu/covid19/agecasesnational/csv/data.csv)| No | Missing** GR, GB, CH
Deaths | [Euro Forecast Hub / JHU](https://github.com/covid19-forecast-hub-europe/covid19-forecast-hub-europe/tree/main/data-truth) | [csv](https://raw.githubusercontent.com/covid19-forecast-hub-europe/covid19-forecast-hub-europe/main/data-truth/JHU/truth_JHU-Incident%20Deaths.csv) | Yes |
Hospitalisations | [Euro Forecast Hub / ECDC](https://github.com/covid19-forecast-hub-europe/covid19-forecast-hub-europe/tree/main/data-truth) | [csv](https://raw.githubusercontent.com/covid19-forecast-hub-europe/covid19-forecast-hub-europe/main/data-truth/ECDC/truth_ECDC-Incident%20Hospitalizations.csv) | No | Data available based on quality: see [notes](https://github.com/covid19-forecast-hub-europe/covid19-forecast-hub-europe/tree/main/code/auto_download/hospitalisations#readme)
Vaccinations | [Our World in Data](https://github.com/owid/covid-19-data/tree/master/public/data#readme) | [csv](https://github.com/owid/covid-19-data/blob/master/public/data/vaccinations/vaccinations.csv?raw=true) | Yes | [Example R code](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/blob/main/data-truth/code/vaccination.R)
Vaccinations by age group | [Our World in Data](https://github.com/owid/covid-19-data/tree/master/public/data#readme) | [csv](https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations-by-age-group.csv) | Yes | [Example R code](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/blob/main/data-truth/code/vaccination.R)
Testing | [Our World in Data](https://github.com/owid/covid-19-data/tree/master/public/data#readme) | [csv](https://github.com/owid/covid-19-data/blob/master/public/data/testing/covid-testing-all-observations.csv?raw=true) | Yes | [Example R code](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/blob/main/data-truth/code/testing.R)
Variants | [ECDC](https://www.ecdc.europa.eu/en/publications-data/data-virus-variants-covid-19-eueea) | [csv](https://opendata.ecdc.europa.eu/covid19/virusvariant/csv/data.csv) | No | Missing** GR, GB, CH. More countries available at: [GISAID](https://www.gisaid.org/) |
Response measures | [ECDC](https://www.ecdc.europa.eu/en/publications-data/download-data-response-measures-covid-19) | [csv](https://www.ecdc.europa.eu/sites/default/files/documents/response_graphs_data_2022-02-24.csv) | No | Missing** GR, GB, CH. More countries available at alternative source: [OxCGRT](https://www.bsg.ox.ac.uk/research/research-projects/covid-19-government-response-tracker)
Contact matrices | [CoMix](http://www.socialcontactdata.org/data/) |  | No | Includes 14 hub countries

** Missing: Greece (GR), United Kingdom (GB), Switzerland (CH)
