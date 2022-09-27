As an expert in your own model, your qualitative commentary is a key to your quantitative results. Please include any information or comments that might be relevant to interpreting your model projections. 

_Usage: Please copy this file and save in your team's `data-processed` folder, renaming the file as appropriate (`2022-07-24-Team-Model.md`). Add your team's comments and include when [submitting your results](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/wiki/Submission-via-GitHub)._

---

# Modeller commentary

## Summary comments on results
The results suggest a sustained risk for high COVID-19 disease burden from October 2022 to April 2023 - especially for scenarios without a wider booster programme (i.e., without targeting individuals aged 18-59 years). A booster with high effectiveness (i.e., through a second generation vaccine) shows a strong burden reduction in the scenarios where a wider booster programme was implemented, but the impact is reduced much for the scenarios with booster programmes targeting individuals older than 60 years. 

## Comments on observed dynamics given model assumptions
- The differences in dynamics between samples are driven by uncertainty in seasonal forcing/behaviour
- The total projected burden is expected to be relatively high and accumulating especially during winter months
- The build up of susceptibles in simulated samples with relatively low winter burden leads to risk of heightened burden toward summer 2023
- The case fatality rate is roughly half as large as the year before. It is reduced by impact of vaccination and prior infection, but increased through higher assumed infection underascertainment (implying a much lower infection fatality rate)
- Generally, the death incidence goes down due to an increased fraction of the population that is recovered, the main source of death is the population older than 60 years 

# Model assumptions

## Round 2 scenarios

### Second booster campaign

#### Any variation from the scenarios as specified
We divide the countries into two groups, depending on whether or not the second booster rollout has “substantially" started in individuals aged 60 years or older. Here, we consider that a second booster rollout has "substantially" started in the respective country if the uptake of the second booster among individuals aged 60 years or older is at least 10% on 22 July 2022.

If the second booster rollout has started for a given country, then we consider that the second booster among individuals aged 60 years continues to increase with a linear slope and plateaus at 50% of the first booster uptake on 15 September 2022. For countries where a second booster rollout has substantially started, we consider a rollout of the third booster (either for individuals above 18 years or individuals above 60 years, depending on the scenario) which increases linearly starting on 15 September 2022 and, similarly as the second booster rollout, plateaus at 50% of the first booster uptake on 15 December 2022. 

If the second booster rollout has not started for a given country, then we consider no further rollout of the second booster (either for individuals above 18 years or individuals above 60 years, depending on the scenario) until 15 September 2022, but then a second booster campaign through a linear increase starting on 15 September 2022 and plateauing at 50% relative to the first booster uptake (within each age category) on 15 December 2022. 


### Vaccine effectiveness 

#### Optimistic vaccine effectiveness 
We estimate vaccine induced protection against infection and against severe disease based on available data of vaccine effectiveness (VE) measured against the Delta variant as an optimistic scenario of a well-matched vaccine. We further assume that the VE after a first or second booster is independent of the vaccine products used in the primary vaccination series, and we do not differentiate between a Comirnaty or Spikevax booster. We assume that the vaccine-induced protection following the booster decays the same way as following the primary vaccination schedule, both for the vaccine-induced protection against infection and against severe outcomes.


#### Pessimistic vaccine effectiveness
We estimate vaccine induced protection against infection and against severe disease based on available data of vaccine effectiveness (VE) measured against the Omicron BA.1 and BA.2 subvariant as a pessimistic scenario of a less well-matched vaccine. 



## Additional assumptions

### Waning immunity 
We assume that VE against infection wanes following a functional shape based on decaying antibody titers. We chose our waning parameters for waning of VE against infection and severe outcome to match published studies that measure vaccine effectiveness at different times since vaccination against an unvaccinated control group while accounting for previous infections. Due to lack of data, we assume the same waning shape for waning VE against hospitalisation as VE against death.

For immunity acquired from past infection, the same method was used. However, we could not identify any study of waning natural immunity against severe outcome, and therefore assume that it has the same relationship to waning against infection as our estimated relationship of VE against infection and VE against severe outcome. 

### Number/type of immune classes considered
We partition the population into 120 subgroups. Each subgroup is specified by the age (10 age groups), the vaccine status (0,1,2,3,4 or 5 vaccinations) and the recovery from past infection (recovered from a pre-Omicron infection or not). The 4th and 5th vaccination groups are further split into a 1st and a 2nd generation vaccine group, where the 1st generation vaccine represents the pessimistic booster VE scenario and the 2nd generation vaccine represented the optimistic scenario. For each subgroup, we model the disease progression with an SEIRS-approach, where the “Removed”-compartment contains individuals that are recovered from Omicron. 

#### Initial distribution of susceptibility 
We obtain the number of individuals per vaccine status and age group from the vaccine uptake and the demography of the respective country. We distribute case data stratified by age to the respective age and vaccine group, building upon the vaccine effectiveness against transmission that is estimated including waning as specified above. Here, we account for underascertainment of previous infections.  

##### Proportion of people that are naïve at start of projection (not vaccinated or infected)
The proportion of people that have not been infected follows implicitly from the fitting period, which adjusts the country-specific underascertainment rate.

##### Other
N/A

### Seasonality implementationSeasonality is modelled by a sine-shaped wave with a median amplitude of 10%. The maximum and minimum of the wave are reached on 15 January and 15 July respectively. 

### Contact rate and/or behaviour assumptions

#### Non-pharmaceutical interventions
We do not take into account non-pharmaceutical interventions in this version of our model.

#### Behaviour in response to case notification rates
We do not take into account adaptive behaviour in this version of our model.

### Other
N/A
