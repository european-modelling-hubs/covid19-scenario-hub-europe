As an expert in your own model, your qualitative commentary is a key to your quantitative results. Please include any information or comments that might be relevant to interpreting your model projections. 

_Usage: Please copy this file and save in your team's `data-processed` folder, renaming the file as appropriate (`2023-03-15-Team-Model.md`). Add your team's comments and include when [submitting your results](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/wiki/Submission-via-GitHub)._

---

# Modeller commentary

## Summary comments on results

We have modelled the four scenarios of Round 4 with an upgraded version of EpiGraph simulator. The main comments on the obtained results are the following ones:

The main findings are:

* When we consider the scenarios with no new variant (scenario A vs C) the overall incidence is dominated by the omicron BQ.1.1 sub-variant, which in modelled with a higher transmissibility than the previous subvariants and an immune escape of 10% against infection. We observe that an optimistic waning produces a slight decrease in the number of infections of 29.5% in overall. This percentage is broken down by collectives, obtaining a decrease of infections (scenario A vs C) of 29.6%, 29.0% and 30.7% for children, adults, and older population, respectively. When we consider the number of hospitalizations and deaths for these two scenarios, we observe that scenario A has a very reduced number of cases for all considered age groups. The reason is that scenario A does not consider waning in the protection against severe outcomes, thus the risk of being hospitalized is very reduced. Note that EpiGraph simulator was calibrated considering a certain waning in this protection, thus considering a no waning produces an over-optimistic reduction in the hospitalizations and deaths that we think is not realistic. In contrast, scenario C introduces a certain waning in the in the protection against severe outcomes, which dramatically increases the number of hospitalizations and deaths. 


* When we consider the scenarios with a new variant (scenario B vs D) there is an important infection peak when the COVID19X variant appears and quickly becomes dominant. We have modelled this variant with characteristics similar to BQ.1 sub-variant. Note that this new variant has a 70% immune escape and a high transmissibility. This combination of factors produces a big increase of the infections when it is introduced. After the initial outbreak of COVID19X, there is a second smaller peak in July, in which both COVID19X and BQ.1.1 are transmitted. At this time part of the population is already infected by COVID19X and has developed specific immunity to this variant, which reduces the quick spread of the variant. When we compare scenarios B and D, we observe an overall reduction in the number of infections of 15.2% for a smaller waning (scenario B). This percentage is broken down by collectives, obtaining a decrease of infections (scenario D vs D) of 15.0%, 15.1% and 15.8% for children, adults, and older population, respectively. When we consider the number of hospitalizations and deaths for these two scenarios (scenarios B and D), we observe that scenario B has a very reduced number of cases for all considered age groups. The reason is that scenario B, like A, does not consider waning in the protection against severe outcomes. When the waning in the protection against severe outcomes is introduced (scenario D), the number of infections and deaths also increases. It is important to highlight that COVID19X is modelled with 0% immune escape against severe outcome, thus the number of hospitalizations and deaths related to this variant is proportionally smaller than the number of infections that it produces. 

* Some general comments: (1) the number of hospitalizations and deaths are age dependent. As we expected, we observe that the percentage of hospitalization is much higher for older population and this age group includes most of the existing deaths. 



## Comments on observed dynamics given model assumptions

* According to EpiGraph model, the impact of immune escape is much higher than the waning (i.e. the increase of infections from scenario A to B is much higher than the existing from scenario B to D). One possible reason for this behaviour is that when COVID19X  is introduced, a big gap is created between the existing immunity (considered as an average value across the population) and the newly introduced one (considering the infected individuals by this new variant). This produces a quick propagation of the variant. In contrast, the waning decreases the immunity more mildly, and the effects are only noticed in long term.


* Because of the design of EpiGraph, there is a small variability in the results, i.e. all the simulations of the same scenario produce similar results. 


* Only a fraction of the population receives the boosters, thus the influence of the vaccination is limited. 


# Model assumptions

## Round 4 scenarios

### Waning of protection against infection
The waning is modelled as a gamma distribution that has not plateau for immunity against infection (i.e. decreases to zero) but has a plateau for immunity against severe outcomes and death. 
The function configuration for each scenario is depicted below. 


#### Optimistic waning of protection against infection 

Here, we distinguish between the protection provided by natural infection and by vaccination. In both cases, the distribution starts with the maximum value that is kept for 30 days without waning - continuous uniform distribution-, and then decreases following a gamma distribution. For the optimistic waning scenarios (A and B) a transition to 70% of the initial immunity after 6 months is considered. This includes both 30 days of continuous uniform distribution and 150 days of gamma distribution waning. After this time, the protection continues decreasing (no plateau assumption).

 



#### Pessimistic waning of protection against infection

Here, we also distinguish between the protection provided by natural infection and by vaccination. In both cases, the distribution starts with the maximum value that is kept for 30 days without waning - continuous uniform distribution-, and then decreases following a gamma distribution. For the pessimistic waning scenarios (C and D) a transition to 70% of the initial immunity after 6 months is considered. This includes both 30 days of continuous uniform distribution and 150 days of gamma distribution waning. After this time, the protection continues decreasing (no plateau assumption). 


#### Any variation from the scenarios as specified


### New variants

#### Any variation from the scenarios as specified

None

## Additional assumptions

### Age groups 

We have considered the following age groups: [ 0-10]  [10-20]  [20-30]  [30-40]  [40-50]  [50-60]  [60-70]  [70-80]  [80-90]  [90-100]

Each group has a different risk of hospitalization and death. In some vaccines, the vaccine effectiveness is also different for each group.  In addition, the social mixing may be also different for each group, given that it is related to the profession of each individual. More specifically, the contact patterns of students, workers and elderly people are modelled differently. 


### Vaccination

For the 1st, 2nd and 3rd doses we have used approximately the same vaccination percentages of vaccinated population for Spain.  

The following list shows the percentage of the population, broken down by ages, at the beginning of the simulation (March 15th 2023) with at least one dose:

[0-10] [10-20]	[20-30]	[30-40]	[40-50]	[50-60]	[60-70]	[70-80]	[80-90] [90-100]
0.00%	10.30%	84.80%	85.10%	85.10%	85.10%	89.70%	95.60%	95.90%	96.50%

The following list shows the percentage of the population, broken down by ages, at the beginning of the simulation with at least two doses + 2 boosters:

[0-10]	[10-20]	[20-30]	[30-40]	[40-50]	[50-60]	[60-70]	[70-80]	[80-90]	[90-100]
0.00%	0.00%	15.20%	15.50%	15.40%	14.50%	41.80%	75.00%	75.80%	74.40%


### Vaccine effectiveness

* For vaccination, the maximum protection (related to the first 30 days of continuous uniform distribution) is 80% for all omicron sub-variants. COVID19X variant has a 70% protection. This only applicable if the individual has been vaccinated with Pfizer or Moderna vaccines using boosters (3 or more doses). If only two doses have been used, then the maximum protection is reduced to 35%. One single dose does not provide any protection. 

### Number/type of immune classes considered

We have considered natural and vaccination-related immunities. We have modelled different vaccine efficacy for all the COVID-19 variants (see next section). In the simulation interval, the BA.5, BQ.1 and BQ.1.1 variants are the dominant ones, and for Scenarios B and D they are replaced by the new introduced COVID-19X. 

#### Initial distribution of susceptibility 
In the initialization process, we have used a distribution of infections similar to the existing conditions in Spain for the period from 1/1/2020 to 15/3/2023. We have considered the variants wild, alpha, beta, delta, and omicron’s BA.1, BA.275, BA.4, BA.5. BQ.1 and BQ.1.1. Each one has a different transmissibility and different risk of severe outcome.


##### Proportion of people that are naïve at start of projection (not vaccinated or infected)


Simulation starts on December 1st 2020, with 100% naïve population. Then, we use historical data to infect/vaccinate the individuals until the beginning of forecast period (March 15th 2022). At this time almost 100% of the population has been already vaccinated or infected. There is also a significative fraction of the population that has been reinfected. Note that because of immunity waning, the protection against infection that each individual has depends on the vaccination and infection times that the individual has. 



#### Population ageing 
No considered. All individuals have the same age during the simulation interval. 

#### Assumptions on severity of infection of repeat infections

We consider reinfection. For natural immunity, the maximum protection (related to the first 30 days of continuous uniform distribution) is 100% if one individual is infected by the same sub-variant, 90% if it is a different one and 70% if is the COVID19X variant. Note that an individual that is being reinfected by the COVID19X will have a protection of 100%.

For natural immunity, if the variant that is producing the infection is the same as the previous one (the one that produced the infection last time), then the maximum efficacy is 100%. Otherwise, there is a scape factor of 10%. COVID-19X has a scape factor of 30%. Note that this protection is subjected to waning. 

In all cases, the protection against hospitalization and death is a maximum 97%. 




##### Other

We consider different professions; some individuals are more susceptible to be infected due to a larger number of contacts. Examples of these collectives (with higher infections rates according to our models) are catering workers, health professional and students.


### Seasonality implementation

We have developed (and included in this forecast) a new model that considers seasonality. We use the monthly statistical data from tourism to determine the catering-related social mixing in Spain. In this way, the contacts reach the maximum values during the summer season. We also consider the domestic tourism by increasing the mixing during Christmas and Easter holidays.

### Contact rate and/or behaviour assumptions

#### Non-pharmaceutical interventions

We consider face mask use. As we understood from the scenario requirements, we keep this value (at 10% of the population) during all the projection periods. Note that facemask use percentage values are larger before the projection period. 

We also consider individual testing. Positive individuals are quarantined.

#### Behaviour in response to case notification rates

The case notification rates do not introduce any changes in the simulated population behaviour.

### Other

* Booster Vaccination campaigns are carried out in age-descending order. In this way, the most vulnerable part of the population is vaccinated at the very beginning of the campaign.