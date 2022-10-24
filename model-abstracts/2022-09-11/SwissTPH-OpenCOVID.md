# Modeller commentary
?
## Summary comments on results
OpenCOVID is an invidual-based stochastic discrete-time model of SARS-CoV-2 tranmission and COVID-19 disease dynamics. Our team used OpenCOVID to simulate 6 scenarios varying in vaccination frequency and variant characteristics over a 5-year period. Boosting annually (Scenarios B & E ) has the largest relative impact on cumulative hospital admissions, ICU admission, and death. Although  bi-annual vaccination (Scenarios C & F) have lower cumulative outcomes the return is not as high relative to annual boosting. *With the decrease in severity due to multiple infections, deaths and ICU peaks begin to diminishing in size as the percentage of people previously exposed rises closer to 100%.*
?
## Comments on observed dynamics given model assumptions
The peak when vaccinating annually (Scenarios B & E ) and bi-annual (Scenarios C & F) have similar shifts to the right relative to no vaccination (Scenarios A & D). There is a bigger difference between magnitudes of the annual and bi-annual vaccination peaks in scenarios with the optimistic variants (Scenarios A, B, & C) than with pessimistic variants (Scenarios E, F, & G). 
?
# Model assumptions
?
## Round 3 scenarios
?
### Vaccination campaigns
?
#### Vaccination uptake in 60+ and <60 age groups 
Vaccination uptake is based on vaccination coverage in the Netherlands as reported by the ECDC COVID-19 Vaccine Tracker. The population is divided into three groups: 5-17 years old, 18-60 years old, and 60+/those with comorbidities. The coverage for the first course of vaccines is 22%, 73%, and 90% respectively. It is assumed that probability of an individual receiving a booster during each campaign (only if they have received the previous vaccine) is equal to the percentage of those in each group which received the first booster after the primary course. These probabilities are as followed respectively: 0.22, 0.73, and 0.90. Due to a lack of data we assume these probabilities are constant throughout the 5 years.
?
#### Assumptions on next generation vaccines
Next generation vaccines are introduced 6 months after a new variant is introduced. It effectively protects from exposure to all variants circulating at that time. 
?
#### Any variation from the scenarios as specified
Not applicable 
?
### New variants
?
#### Any variation from the scenarios as specified
Not applicable
?
?
## Additional assumptions
?
### Waning immunity 
Immunity acquired through natural infection is assumed to wane following an inverse logistic curve with an upper bound of 0.95, lower bound of 0.15, slope of 1.8, and a half-life of 105 days. Immunity acquired through vaccination is assumed to wane also following an inverse logistic curve but with an upper bound of 0.85, lower bound of 0.10, slope of 1.8, and a half-life of 70 days. 
?
### Vaccine effectiveness
As described in the section above, vaccine effectiveness is assumed to be begin at 85% and wane over time in all scenarios. 
?
### Number/type of immune classes considered
Comorobities are assumed to effect 0.08 of the population within the age range of 0-75. Those with comorbidities are vaccinated at the same rate as those above the age of 60. 
?
#### Initial distribution of susceptibility 
xxx
?
##### Proportion of people that are naïve at start of projection (not vaccinated or infected)
The proportion of people which have not been previously infected at the start the projection is about 25%.
?
#### Population ageing 
The population does age in one-year increments. 
?
#### Assumptions on severity of infection of repeat infections
Severity of infection does take into account variant, vaccine doses, and past exposure. The *risk?* of ICU on average is reduced 40% (S.D of 0.05) per exposure. The *risk?* of death on average is reduced by 65% (S.D of 0.05) per exposure.
?
##### Other
?
### Seasonality implementation
Seasonality is assumed to follow a cosine function with a minimum of -1 ( to represent the peak of summer), maximum of 1 (to represent the peak of winter), and length of 365. The cosine scaling factor, 0.3, was from a previous paper assessing the COVID-19 epidemic in Switzerland.
?
### Contact rate and/or behaviour assumptions
Contact rate is calibrated in order to fit model output to epidemiological data. The model uses an age structured network that utilizes a country specific (in this case the Netherlands) network matrix. 
?
#### Non-pharmaceutical interventions
The only NPI included is isolation which we assume 10% of those *infected? testing positive?* will adhere to for 10 days. 
?
#### Behaviour in response to case notification rates
Not applicable 
?
### Other
A testing rate of 0.01 without symptoms and 0.1 with symptoms is assumed. 
