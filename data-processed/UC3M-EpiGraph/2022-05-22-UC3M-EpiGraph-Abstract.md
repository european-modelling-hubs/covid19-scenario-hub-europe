As an expert in your own model, your qualitative commentary is a key to your quantitative results. Please include any information or comments that might be relevant to interpreting your model projections. 

_Usage: Please copy this file and save in your team's `data-processed` folder, renaming the file as appropriate (`2022-05-22-Team-Model.md`). Add your team's comments and include when [submitting your results](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/wiki/Submission-via-GitHub)._

---

# Modeller commentary

## Summary comments on results

We have modelled the four scenarios proposed in Round 1 fulfilling the requirements related to each one of them. The main comments are the following:

* When comparing the optimistic vs pessimistic immune waning scenarios (A,B vs C ,D) the magnitude and frequency of incoming COVID-19 waves significantly increase for the pessimistic scenario. The immune waning seems to be the dominant factor in the disease propagation.

* The waning against severe disease was implemented according to the Hub specifications. It is the same for all the considered scenarios thus it is not possible to quantify its effect on the number of hospitalizations. However, according to other evaluations we believe that this waning may be important. 

* When comparing the slow and fast booster campaign scenarios for an optimistic immune waning (A vs B) the difference between the infection cases seems not to be important. The model predicts two waves: the first one (Wave1) that lasts from June to July 2022; and the second one (Wave2) that is between November and 2022 and January 2023.  An analysis for each wave is depicted below:

- Regarding Wave1: second booster vaccination campaign of Scenario A starts at the falling slope of Wave1 and it seems not to be effective in reducing infections in this wave. The Booster campaign for Scenario B happens after Wave1. In conclusion both campaigns seem to be ineffective in reducing the spread related to Wave1.
 
- Regarding Wave2: both booster vaccination campaigns end in the middle of Wave2. However, Scenario B seems to be slightly more effective in reducing the number of infections. The reason is that for Scenario B the booster waning has not decreased its effectiveness to the same extent as in Scenario A.

* When comparing the slow and fast booster campaign scenarios for a pessimistic immune waning (C vs D) the difference between the infection cases is still small but more noticeable than in the previous scenarios. The model predicts three waves: the first one (Wave1) lasts from June to July 2022, the second one (Wave2) is between September and October 2022, and the third (Wave3) between December 2022 and January 2023.  An analysis for each wave is found below:

- For Wave 1 neither C nor D have any effect in reducing the number of infections. The reason is that the booster campaign for scenario C occurs during the falling slope of Wave1 and does not provide enough immunity to reduce its extent.
 
- For Wave2 vaccination campaign of  D is carried out during the rising slope of the wave, providing less immunity than in scenario C. For this reason, scenario D produces a slightly bigger number of infections than scenario C.  

- For Wave3 vaccination campaign of D is now more effective than C because of a smaller waning related to D. This produces a more noticeable reduction in the number of infections for scenario D. 


## Comments on observed dynamics given model assumptions

We have carried out 100 samples per scenario. We observed -as expected- that the uncertainty in the forecast becomes larger the more distant the forecasted values are. 

# Model assumptions

## Round 1 scenarios

### Second booster campaign

#### Any variation from the scenarios as specified

The end time of the 2nd booster campaign (scheduled for being completed by 15th December) may have 1 week of discrepancy, i.e., it actually ends between 7th and 15th December for some scenarios. The reason is that the booster can only be administrated 6 months after the infection, and given the stochastic processes used in the simulation, it is not possible to determine in advance when each individual can be vaccinated (the individual can be infected at any time). This introduces some uncertainly around the vaccination campaign duration. Note that the 2nd booster campaign starting time is the same as the one specified in the Round 1, thus we think that the overall effect of this uncertainly is negligible because it only affects the end of the campaign when the most vulnerable population is already vaccinated (see Other Comments at the end of the document).  
We think that the current version of EpiGraph model fulfils the rest of the Round 1 specifications.

#### Vaccine effectiveness assumptions

•	The vaccine effectiveness against infection depends on the COVID-19 variant. In the considered forecast the Omicron variant is the dominant variant.

•	Vaccine effectiveness against severe disease is age-dependent and depends on the COVID-19 variant.
 
•	The effectiveness of Pfizer and Moderna vaccines is the same for Omicron variant. These are the only two vaccines applied as boosters. 

•	If the individual has been infected, the booster reactivates natural immune protection. After that, this protection reaches its maximum value. 


### Waning immunity 

#### Details of waning protection against infection (e.g., distribution used)

In the case of vaccination, the booster takes 7 days to reach the maximum effectiveness of 70%. Then this value is kept for 30 days (flat stage). After that, a waning decrease in immunity follows a gamma distribution. In order to fulfil the Round 1 specification: 

•	The optimistic waning (scenarios A and B) includes 1 month of flat stage + 7 months gamma decaying (8 months between reaching the maximum and minimum effectiveness). 

•	The pessimistic waning (scenarios C and D) includes 1 month of flat stage + 2 months gamma decaying (3 months between reaching the maximum and minimum effectiveness).

In case of infection (natural immunity) the maximum effectiveness (that now is 100%) is reached immediately after the infection. Then, it is maintained for 30 days and decreases in the same way as the protection provided by vaccination. 


#### Waning protection against severe disease

In the case of vaccination, the booster takes 7 days to reach the maximum effectiveness against severe disease (which is age-dependant). Then this value is maintained for 30 days (flat stage). After that, there is a waning decrease in the immunity following a gamma distribution. In order to fulfil the Round 1 specifications: all scenarios have 1 month of flat stage + 2 months gamma decaying (3 months between reaching the maximum and minimum protection). Protection decreases by 20%. 

In the case of infection (natural immunity) the maximum protection is reached immediately after the infection. Then, it is maintained for 30 days and decreases in the same way as protection provided by vaccination. (3 months in total, 20% decrease). 


## Additional assumptions

### Number/type of immune classes considered

We consider two classes: provided by vaccination and natural immunity. 

#### Initial distribution of susceptibility 

##### Proportion of people that are naïve at start of projection (not vaccinated or infected)

Simulation starts on December 1 2020, with 100% naïve population. Then, we use historical data to infect/vaccinate the individuals until the beginning of the forecast period (May 22 2022). At this time almost 100% of the population has been already vaccinated/infected. There is also a fraction of the population that has been reinfected. Note that because of immunity waning the real protection of each individual depends on the vaccination/infection time.  

##### Other

We consider different professions; some individuals are more susceptible to being infected due to a larger number of contacts. Examples of these collectives (with higher infections rates according to our models) are catering workers, health professional and students. 

### Seasonality implementation

We have developed (and included in this forecast) a new model that considers seasonality. We use the monthly statistical data from tourism to determine the catering-related social mixing in Spain. In this way, the contacts reach the maximum values during the Summer season. We also consider the domestic tourism by increasing the mixing during Christmas and Easter holidays. 

### Contact rate and/or behaviour assumptions

#### Non-pharmaceutical interventions

We consider face mask use. As we understood from the scenario requirements, we keep this value (at 10% of the population) during all the projection periods (starting on May 22 2022). Note that facemask use percentage values are larger before the projection period. 

#### Behaviour in response to case notification rates

The case notification rates do not introduce any changes in the simulated population behaviour.

### Other

Booster Vaccination campaigns are carried out in age-descending order. In this way the most vulnerable part of the population is vaccinated at the very beginning of the campaign. 