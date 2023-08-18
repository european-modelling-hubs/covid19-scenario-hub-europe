

# Modeller commentary



## Summary comments on results

We have modelled the eight scenarios of Round 5 with an upgraded version of EpiGraph simulator that includes new variants and an improved calibration process. The main comments on the obtained results are the following ones:

* For the optimistic waning scenarios (scenarios A, B, C and D) there is no waning in the immunity against severe outcomes (hospitalization) or death. This assumption greatly reduces the number of hospitalizations and deaths compared to the pessimistic scenarios. In addition, the impact of the vaccination campaign is also limited. When considering Scenario A -no vaccination- as the baseline scenario, scenarios B, C and D reduce the amount of hospitalizations by 3%, 3% and 4%, respectively. For the same scenarios (B, C and D), the number of deaths is reduced by 4%, 8% and 7%, respectively. The reason of these small values is that the existing immunity for severe outcomes or death (both provided by previous infections or vaccinations) is already very high due to the lack of waning. Regarding the reduction in the number of infections, the vaccination has a minimal impact on it.


* For the pessimistic waning scenarios (scenarios E, F, G and H) there is waning in both the immunity against severe outcomes (hospitalization) and death. Note that the waning in the protection against infection is also greater than for the optimistic case. This results in an increase of 3 times more infections than in the previous optimistic scenarios.  If we consider Scenario E -no vaccination- as the baseline scenario, scenarios F, G and H reduce the amount of hospitalizations by 11%, 18% and 19%, respectively. For the same scenarios (B, C and D), the number of deaths is reduced by 30%, 35% and 33%, respectively. The vaccination has a reduced impact on the reduction in the number of infections, which 2%, 4% and 4% for scenarios F, G and H, respectively.

* The numbers of hospitalizations and deaths are age-dependent. As we expected, we observe that the percentage of hospitalization is much higher for the older population and this age group includes most of the existing deaths. 


## Comments on observed dynamics given model assumptions

* We have analyzed the overall immunity levels -average value among all the population 60+- related to scenarios G and H and both of them are very similar and slightly better than F. Based on this we conclude that, according to EpiGraph model, scenarios G and H produce similar results in terms of protection against infection, hospitalization and death. 

* Given that the vaccination is applied only to a subset of the entire simulated population, its ability to reduce the number of infections is limited. 

* Due to the design of EpiGraph, there is a small variability in the results; i.e. all the simulations of the same scenario produce similar results. 


# Model assumptions

## Round 5 scenarios

### Waning of protection against infection

We have modelled both waning scenarios (optimistic and pessimistic) considering different distributions for the immunity against infection, severe outcomes and death. In all the cases we also distinguish between the protection provided by natural infection and by vaccination. 

#### Optimistic waning of protection against infection 

For immunity against infection the distribution starts with the maximum value that is kept for 30 days without waning -continuous uniform distribution-, and then decreases following a gamma distribution. For the optimistic waning scenarios (A, B, C and D), a transition to 70% of the initial immunity after 6 months is modelled. This includes both 30 days of continuous uniform distribution followed by 150 days of gamma distribution waning. After this time, the protection continues to decrease (no plateau assumption) until reaching the minimum protection level. This applies to both the protection provided by natural infection and by vaccination. Different maximum protection values have been considered in each case (natural infection or vaccination). In case of natural infection, we also consider different immunity scape levels for different COVID-19 variants. 


For immunity against severe outcomes and death, no waning is considered. This means that an infected or vaccinated individual maintains the maximum protection throughout the entire simulation time.

#### Pessimistic waning of protection against infection

For immunity against infection, the waning is modelled as a maximum value that lasts for 30 days after infection or vaccination, followed by a gamma distribution with no plateau for immunity against infection (i.e. the immunity decreases to zero). For the pessimistic waning scenarios (E, F, G and H), we consider a transition to 40% of the initial immunity after 6 months. In case of natural infection, we also consider different immunity scape levels for different COVID-19 variants. 

Regarding the immunity against severe outcomes and death we consider a similar distribution (30 days of maximum value plus gamma distribution) with a transition to 80% of the initial immunity after 6 months. No plateau is considered for all cases. 


#### Any variation from the scenarios as specified

None

### Vaccination

#### Any variation from the scenarios as specified

None


## Additional assumptions

### Age groups 

We have considered the following age groups: [ 0-10]  [10-20]  [20-30]  [30-40]  [40-50]  [50-60]  [60-70]  [70-80]  [80-90]  [90-100]

Each group has a different risk of hospitalization and death. The vaccine effectiveness may also be different for each group.  Additionally, social mixing may also differ for each group, as it is related to the profession of each individual. More specifically, the contact patterns of students, workers and elderly people are modelled differently. 

Note that the worker collective includes individuals up to 65 years old. Consequently, some members of this collective are also vaccinated. 

### Vaccination
For the 1st, 2nd and 3rd doses we have used approximately the same vaccination percentages of vaccinated population for Spain.  

The following list shows the percentage of the population, broken down by ages, at the beginning of the simulation (March 15th 2023) with at least one dose:

[0-10] [10-20]	[20-30]	[30-40]	[40-50]	[50-60]	[60-70]	[70-80]	[80-90] [90-100]
0.00%  10.00%	84.80%	84.80%	85.30%	84.80%	89.60%	94.50%	94.80%	96.00%	

The following list shows the percentage of the population, broken down by ages, at the beginning of the simulation with at least two doses + 2 boosters:

[0-10]	[10-20]	[20-30]	[30-40]	[40-50]	[50-60]	[60-70]	[70-80]	[80-90]	[90-100]
0.00%	0.00%	9.20%	11.90%	13.70%	12.50%	40.40%	73.80%	74.50%	75.40%	


### Vaccine effectiveness

For vaccination, the maximum protection (related to the first 30 days of continuous uniform distribution) is 80% for all omicron sub-variants. This is only applicable if the individual has been vaccinated with Pfizer or Moderna vaccines using boosters (3 or more doses). If only two doses have been used, then the maximum protection is reduced to 35%. A single dose does not provide any protection.

The protection against severe outcomes and death for Omicron sub variants is 97% for the third dose and boosters, 35% for two doses and 0% for one dose of Pfizer or Moderna vaccines. 

In this scenario, we assume that the boosters applied during 2023 vaccination campaign (October-December) provide the maximum considered efficacies regardless of the previous doses the individual has received. For instance, a previously non-vaccinated individual that receives the vaccine in this period acquires an 80% maximum protection against infection. 


### Number/type of immune classes considered

We have considered natural and vaccination-related immunities. We have modelled different vaccine efficacies for all the COVID-19 variants (see the next section). In the simulation interval, the XBB.1.9 variant is the dominant one.


#### Initial distribution of susceptibility 

In the initialization process we have used a distribution of infections similar to the existing conditions in Spain for the period from 1/1/2020 to 1/8/2023. We have considered the variants wild, alpha, beta, delta, and omicron’s BA.1, BA.275, BA.4, BA.5. BQ.1, BQ.1.1, XBB.1.5, and XBB.1.9. Each one has different transmissibility values and different risk of severe outcome.


##### Proportion of people that are naïve at start of projection (not vaccinated or infected)

Simulation starts on January 1st, 2020, with 100% naïve population. Then, we use historical data to infect/vaccinate the individuals until the beginning of forecast period (August 1st 2023). At this time, almost 100% of the population has been already vaccinated or infected. There is also a significant fraction of the population that has been reinfected. Note that due to immunity waning, the protection against infection for each individual depends on their vaccination and infection times.

#### Population ageing 

No considered. All individuals have the same age during the simulation interval.

#### Assumptions on severity of infection of repeat infections

We consider reinfection. For natural immunity the maximum protection (related to the first 30 days of continuous uniform distribution) is 100% if an individual is infected by the same sub-variant and 90% if it is a different one. Note that these protections are the maximum values and are subject to waning. 

In all cases, the maximum protections against hospitalization and death are the same as the protection against reinfection (100% or 90%).

##### Other

We consider different professions; some individuals are more susceptible to be infected due to a larger number of contacts. Examples of these collectives (with higher infections rates according to our models) are catering workers, health professional, and students.

### Seasonality implementation

The EpiGraph simulator considers seasonality. We use monthly statistical data from tourism to determine the catering-related social mixing in Spain. This way, the contacts reach the maximum values during the summer season. We also consider domestic tourism by increasing the mixing during Christmas and Easter holidays.

### Contact rate and/or behaviour assumptions

#### Non-pharmaceutical interventions

We consider the use of face mask. As we understand from the scenario requirements, we maintain this value (at 10% of the population) throughout all the projection periods. Note that the percentage values of face mask use are higher before the projection period.

We also consider individual testing. Positive individuals are quarantined.

#### Behaviour in response to case notification rates

The case notification rates do not introduce any changes in the simulated population behaviour.

### Other

For the considered scenario (Spain) we have used the real incidence data provided by a model developed in our team. This model overcomes the main limitation of the existing official incidence data—which only accounts for people over 60—by combining information from different Spanish notification sources (SiVIES, SiVIRA, and hospitalization incidence) to estimate the real incidence for Spain, accounting for the entire population.

