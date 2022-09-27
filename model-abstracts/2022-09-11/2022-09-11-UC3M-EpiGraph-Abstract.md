As an expert in your own model, your qualitative commentary is a key to your quantitative results. Please include any information or comments that might be relevant to interpreting your model projections. 

_Usage: Please copy this file and save in your team's `data-processed` folder, renaming the file as appropriate (`2022-07-11-Team-Model.md`). Add your team's comments and include when [submitting your results](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/wiki/Submission-via-GitHub)._

---

# Modeller commentary

## Summary comments on results

We have modelled the six scenarios proposed in Round 6 for a 10-year simulation time span. We think that the modelling fulfils the requirements related to each scenario. The main comments are the following:

The main findings are:

* Considering the pessimistic variant scenarios (scenarios D, E and F) the large reduction in the immunity (due to waning) produces a large spike in the number of infection when the first new variant is introduced in October 2022. Then, subsequent variants have a smaller incidence that is being reduced until 2026. After this time for Scenario D the incidence has waves that do not increase or decrease in magnitude. For scenarios E and F after 2016 there are several waves with higher magnitude. 

* The optimistic variant scenarios (scenarios A, B and C) exhibit a much smaller incidence than the pessimistic ones. For instance, scenario A has an aggregated incidence 4 times smaller than D. The magnitude of the waves after 2016 seems to be smaller than the ones before this time. 

* When considering the pessimistic variant scenario E we observe that the introduction of an annual vaccination reduces the number of infections and hospitalizations by 7.5% and 7.7%, respectively, compared to the baseline scenario (scenario D).

* For the pessimistic variant scenario F, the introduction of a bi-annual vaccination reduces the number of infections and hospitalizations by 12.2% and 16.9%, respectively, compared to the baseline scenario (scenario D).

* For the optimistic variant scenario B, the introduction of an annual vaccination reduces the number of infections and hospitalizations by 13.7% and 16.0%, respectively, compared to the baseline scenario (scenario A).

* For the optimistic variant scenario C, we observe that the introduction of a bi-annual vaccination reduces the number of infections and hospitalizations by 21.9% and 27.4%, respectively, compared to the baseline scenario (scenario A).


## Comments on observed dynamics given model assumptions


* Due to the large execution time of the simulation and lack of computational resources, we were only able to provide results for 3 simulations of each scenario. For these runs, we observe a small variability in the results, i.e. all the simulations of the same scenario produce similar results. 
* Natural and vaccination immunity waning are the most determinant factors in the forecasted incidence.

* Only a reduced fraction of the population receives the booters, thus the influence of the vaccination is limited. Despite of that, we observe important reductions in the incidence and hospitalization for the scenarios with booster campaigns. 


# Model assumptions

## Round 3 scenarios

### Vaccination campaigns

#### Vaccination uptake in 60+ and <60 age groups 

For the 1st, 2nd and 3rd doses we have used approximately the same vaccination percentages of vaccinated population for Spain.  

The following list shows the percentage of the population at the beginning of the simulation (October 2022) with at least one dose broken down by ages 

[0-10]	[10-20]	[20-30]	[30-40]	[40-50]	[50-60]	[60-70]	[70-80]	[80-90]	[90-100]
0.00%	10.30%	85.50%	84.90%	85.10%	85.10%	89.60%	95.60%	95.60%	96.50%

The following list shows the percentage of the population at the beginning of the simulation (October 2022) with two doses + 1 booster broken down by ages:

[0-10]	[10-20]	[20-30]	[30-40]	[40-50]	[50-60]	[60-70]	[70-80]	[80-90]	[90-100]
0.00%	0.00%	47.60%	47.60%	47.10%	47.60%	64.20%	86.40%	86.50%	86.10%

For the extra booster campaign, we assume that 50% of the population will receive the booster. This means that 43% of the population 70+ will receive a booster and only 23.8% of the population between 20 and 60 years will be vaccinated with boosters. Note that these small coverages will limit the effectiveness of the vaccination campaign. 

We assume that the vaccination uptake is constant, i.e. the previous percentages do not change over the time. Note that this is probably unrealistic. 

#### Assumptions on next generation vaccines

We assume that the vaccines have a higher efficacy for variants older than 6 months, and a smaller one for newer variants.

The vaccines also increase the natural immunity by restoring the maximum natural immunity protection level. In other words, the vaccination resets the natural immunity waning. 

#### Any variation from the scenarios as specified

We think that there are no variations.

### New variants

#### Any variation from the scenarios as specified

We think that there are no variations.

## Additional assumptions

### Waning immunity 

The waning time (time between the maximum and minimum efficacies) is 8 months. Waning was modelled following a gamma distribution both for natural immunity and vaccine-related immunity. The maximum and minimum values are depicted in “Vaccine effectiveness” Section.


### Vaccine effectiveness

The vaccine provides a maximum efficacy (100%) for any new COVID-19 variant older than 6 months. Otherwise, the vaccine provides an 80% maximum efficacy. 

In the pessimistic waning scenarios (D, E and F) the minimum efficacy is reduced to 25% of the maximum value. 

In the optimistic waning scenarios (A, B and C) the minimum efficacy is reduced to 80% of the maximum value. 

### Number/type of immune classes considered

We have considered natural and vaccination-related immunities. We have considered different vaccine efficacies for all the considered COVID-19 variants (see next section). In the simulation time, the BA.4 and BA.5 variants are the dominant ones, and they are replaced by the new introduced ones. 

#### Initial distribution of susceptibility

In the initialization process we have used a distribution of infections similar to the existing conditions in Spain for the period from 1/1/2020 to 1/10/2022. We have considered the variants wild, Alpha, Beta, Delta, and Omicron’s BA.1, BA.275, BA.4 and BA.5. 

The new variants introduced (one every 9 months) have the similar characteristics (R0 values, severity) as the BA.5 variant. 


##### Proportion of people that are naïve at start of projection (not vaccinated or infected)

Simulation starts on December 1 2020, with 100% naïve population. Then, we use historical data to infect/vaccinate the individuals until the beginning of the forecast period (October 2022). At this time almost 100% of the population has been already vaccinated or infected. There is also a fraction of the population that has been reinfected. Note that because of immunity waning the real protection of each individual depends on the vaccination and infection times.  


#### Population ageing 

No considered. All individuals keep the same age during all the simulation period. 

#### Assumptions on severity of infection of repeat infections

We consider reinfection. For natural immunity, if the variant that is producing the infection is the same as the previous one (the one that produced the infection last time), then the maximum efficacy is 100%. Otherwise, there is a scape factor of 5%. 

For natural immunity the minimum efficacy is 80% for all the previous variants (before October 2022). For the new variants (after October 2022), the minimum efficacy is 80% in the optimistic scenario and 25% in the pessimistic one. 

The waning period of natural immunity is 8 months for all cases.

In all cases, the protection against hospitalization and death is a maximum 97% and a minimum with a reduction to 80% (waning of 8 months). 


##### Other

We consider different professions; some individuals are more susceptible to being infected due to a larger number of contacts. Examples of these collectives (with higher infections rates according to our models) are catering workers, health professional and students.

### Seasonality implementation

We have developed (and included in this forecast) a new model that considers seasonality. We use the monthly statistical data from tourism to determine the catering-related social mixing in Spain. In this way, the contacts reach the maximum values during the summer season. We also consider the domestic tourism by increasing the mixing during Christmas and Easter holidays.

### Contact rate and/or behaviour assumptions

#### Non-pharmaceutical interventions

We consider face mask use. As we understood from the scenario requirements, we keep this value (at 10% of the population) during all the projection periods. Note that facemask use percentage values are larger before the projection period. 

We also consider individual testing. Positive individuals are quarantined.


#### Behaviour in response to case notification rates

The case notification rates do not introduce any changes in the simulated population behaviour.

### Other

* Booster Vaccination campaigns are carried out in age-descending order. In this way the most vulnerable part of the population is vaccinated at the very beginning of the campaign.
* Due to a problem generating the log files, it was not possible to record the number of doses applied after week 399 for scenarios C and F. For these two scenarios we provided extrapolated values in the csv files after week 399. Note that in the current simulations the vaccination pattern repeats itself for each new booster round, thus the extrapolation will accurately consider the applied vaccines in this missing time interval. 
