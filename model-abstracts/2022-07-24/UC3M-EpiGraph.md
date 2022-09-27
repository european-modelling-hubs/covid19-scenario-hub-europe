As an expert in your own model, your qualitative commentary is a key to your quantitative results. Please include any information or comments that might be relevant to interpreting your model projections. 

_Usage: Please copy this file and save in your team's `data-processed` folder, renaming the file as appropriate (`2022-07-29-Team-Model.md`). Add your team's comments and include when [submitting your results](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/wiki/Submission-via-GitHub)._

---

# Modeller commentary

## Summary comments on results

We have modelled the four scenarios proposed in Round 2 fulfilling the requirements related to each one of them. The main comments are the following:

The main findings are:

* The model predicts a infection wave that will start in November 2022 and will lasts approximately three months.  2nd booster campaign scenarios have a different impact on the wave propagation. 

- The 60+ strategy (vaccination of the population over 60 years old with a 50% coverage) of scenarios A and C, produces a small reduction on the extent of wave. We think that this is because they represent a small fraction of the overall population (note that barely 43% of this collective is receiving the 2nd booster) and this collective has not related a high disease transmissibility. This would not bring enough immunity to prevent the propagation of the infection in the incoming wave. 

- The 18+ strategy (vaccination of the population over 18 years old with a 50% coverage) of scenarios D and B, produces a more significant reduction on the extent of wave both in terms of lowering the maximum values and the duration. Note that despite to the fact that only a small fraction of the young and middle-age population is vaccinated (around 20%) this produces a sensible reduction in the next epidemic wave. 


* When we compare the  COVID-19 incidence and hospitalization curves  we observe that the 60+ strategy obtains a reduction in the incident hospital admissions in a higher proportion than the reduction in number of infections. The reason is that the 60+ collective is the more vulnerable to severe disease and obtains a higher protection against it. This reduction is also noticeable for 18+ strategy.  

* In this section we compare the two booster effectiveness scenarios (Scenario A vs C, B vs D) that includes an optimistic one with an increased booster vaccine effectiveness to that seen against Delta variant and a pessimistic one with a reduced booster vaccine effectiveness against infection from BA.4/BA.5/BA.2.75 variants. Note that according to the Round 2 specifications, the difference between both scenarios is on the booster effectiveness against infection, but not against severe disease. In the latter one, the values are same in both cases. Regarding the incident cases we observe that the difference between them is not important. We think that one reason that could explain this small difference of the values is that, according to our model, the booster also increases the natural immunity of the individuals that have had the infection, and this increment in the natural immunity is the same for both scenarios. In this way, the natural immunity would be dominant (i.e. higher than the protection provided by the vaccine). Note that the difference between the optimistic and pessimistic vaccine scenarios is even smaller for the incident hospital admissions. This is because the vaccine effectiveness against severe disease is the same in both of them (optimistic and pessimistic) and the only difference would be the infection incidence in each case (it is bigger for the pessimistic case). 

* Note that the predicted wave begins before the completion of the 2nd booster campaign. This reduces the vaccination effectiveness for all considered scenarios. 

* The waning against severe disease was implemented according to the Hub specifications. It is the same for all of them thus it is not possible to quantify its effect on the number of hospitalizations. However, according to other evaluations we believe that this waning may be important.

* There is also a fraction of the population that has been reinfected. Note that because of immunity waning the real protection of each individual depends on the vaccination/infection time related to each individual. 

* We consider different professions; some individuals are more susceptible to being infected due to a larger number of contacts. Examples of these collectives (with higher infections rates according to our models) are catering workers, health professional and students. 

## Comments on observed dynamics given model assumptions

We have carried out 100 samples per scenario. We observed -as expected- that the uncertainty in the forecast becomes larger the more distant the forecasted values are. 

# Model assumptions

## Round 2 scenarios

### Second booster campaign

#### Any variation from the scenarios as specified

The end time of the 2nd booster campaign (scheduled for being completed by 15th December) may have 1 week of discrepancy. The reason is that the booster can only be administrated 6 months after the infection, and given the stochastic processes used in the simulation, it is not possible to determine in advance when everyone can be vaccinated (the individual can be infected at any time). This introduces some uncertainly around the vaccination campaign duration. Note that the 2nd booster campaign starting time is the same as the one specified in the Round 2, thus we think that the overall effect of this uncertainly is negligible because it only affects the end of the campaign when the most vulnerable population is already vaccinated (see Other Comments at the end of the document).  
We think that the current version of EpiGraph model fulfils the rest of the Round 2 specifications.

#### Vaccine effectiveness assumptions

•	The vaccine effectiveness against infection depends on the COVID-19 variant. In the considered forecast the Omicron variant is the dominant variant.

•	Vaccine effectiveness against severe disease is age-dependent and depends on the COVID-19 variant.
 
•	The effectiveness of Pfizer and Moderna vaccines is the same for Omicron variants. These are the only two vaccines applied as boosters. 

•	If the individual has been infected, the booster reactivates natural immune protection. After that, this protection reaches its maximum value. 


### Waning immunity 

#### Details of waning protection against infection (e.g., distribution used)

In the case of vaccination, the booster takes 7 days to reach the maximum effectiveness of 90% for the optimistic scenario and 70% for the pessimistic one. Then this value is kept for 30 days (flat stage). After that, a waning decrease in immunity follows a gamma distribution. In order to fulfil the Round 2 specification: 

•	The  waning (all scenarios A and B) includes 1 month of flat stage + 7 months gamma decaying (8 months between reaching the maximum and minimum effectiveness) with a decrease of 60%. 

In case of infection (natural immunity) the maximum effectiveness (that now is 100%) is reached immediately after the infection when the new infective variant is the same as the one that produced the previous infection (cross immunity). When both variants are different, then maximum effectiveness is 90%. The maximum value is maintained for 30 days and decreases in the same way as the protection provided by vaccination. 


#### Waning protection against severe disease

In the case of vaccination, the booster takes 7 days to reach the maximum effectiveness against severe disease (which is age-dependant). Then this value is maintained for 30 days (flat stage). After that, there is a waning decrease in the immunity following a gamma distribution. In order to fulfil the Round 2 specifications: all scenarios have 1 month of flat stage + 2 months gamma decaying (3 months between reaching the maximum and minimum protection). Protection decreases by 20%. 

In the case of infection (natural immunity) the maximum protection is reached immediately after the infection. Then, it is maintained for 30 days and decreases in the same way as protection provided by vaccination. (3 months in total, 20% decrease). 


## Additional assumptions

### Number/type of immune classes considered

We consider two classes: provided by vaccination and natural immunity. 

#### Initial distribution of susceptibility 

##### Proportion of people that are naïve at start of projection (not vaccinated or infected)

Simulation starts on December 1 2020, with 100% naïve population. Then, we use historical data to infect/vaccinate the individuals until the beginning of the forecast period (July 18 2022). At this time almost 100% of the population has been already vaccinated/infected. There is also a fraction of the population that has been reinfected. Note that because of immunity waning the real protection of each individual depends on the vaccination/infection time.  

##### Other

We consider different professions; some individuals are more susceptible to being infected due to a larger number of contacts. Examples of these collectives (with higher infections rates according to our models) are catering workers, health professional and students. 

### Seasonality implementation

We have developed (and included in this forecast) a new model that considers seasonality. We use the monthly statistical data from tourism to determine the catering-related social mixing in Spain. In this way, the contacts reach the maximum values during the summer season. We also consider the domestic tourism by increasing the mixing during Christmas and Easter holidays. 

### Contact rate and/or behaviour assumptions

#### Non-pharmaceutical interventions

We consider face mask use. As we understood from the scenario requirements, we keep this value (at 10% of the population) during all the projection periods (starting on May 22 2022). Note that facemask use percentage values are larger before the projection period. We also consider individual testing. Positive individuals are quarantined. 

#### Behaviour in response to case notification rates

The case notification rates do not introduce any changes in the simulated population behaviour.

### Other

Booster Vaccination campaigns are carried out in age-descending order. In this way the most vulnerable part of the population is vaccinated at the very beginning of the campaign.
