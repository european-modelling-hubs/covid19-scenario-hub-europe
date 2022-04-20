### (a) Summary of results

All results concern the simulations of epidemic in Poland.

Type of the immunity waning (optimistic or pessimistic) determines if there is a wave of infections with maximum in June 2022. It occurs only if a scenario assumes pessimistic waning.

On the other hand introducing new variant X means that there is an infection wave in autumn 2022 regardless of assumed type of immunity waning.

An autumn wave does not occur only if the  optimistic immunity waning and the lack of the new variant X are assumed. In this case there is no additional waves until the end of 2022.  
 

### (b) Explanation of observed dynamics given model assumptions

There is interesting interdependence between pace of immunity waning and expansion of the new X variant. The immunity escape gives variant X an advantage over Omicron in the case of slow (optimistic) immunity waning. In this case the variant X supersedes Omicron quickly in June. Otherwise, if the pessimistic immunity waning is assumed, variant X never  exceeds 50% share in new infections, at least until the end of 2022. That is why in the case of pessimistic immunity waning introduction of the new variant has only little effect on the epicurve.   

### (c) Model assumptions
- #### Model of immunity
Daily probability of infection is calculated for each susceptible agent at the end of the day. In simple terms, technically, all healthy agents are susceptible. (Daily) immunity is defined as reduction of the daily probability of infection. Such immunity maybe partial or full. Full (100%) immunity means that the probability of infection is reduced to 0. The immunity is a product of maximum immunity given by the appriopriate element of cross-immunity matrix c and the profile of immunity variation in time, so-called S function.

Our approach require some method to translate daily immunity as defined above into some kind of overall immunity. In this experiment we use following method. We consider the situation when susceptible (partly immune) agent is heavily exposed to infectious agent for three days, the situation might occurs when susceptible agent lives with the infectious one in one household. In this setting `daily_immunity^3 = overall_immunity`  

- #### _if available:_ Initial distribution of susceptibility

   - ##### Proportion of people that were infected with Omicron before March 13: 50% (18.876M)

   - ##### Proportion of people that are naïve at start of projection (not vaccinated or infected): 4.5%

   - ##### Other

- #### Initial variant characteristics (including Omicron transmissibility, immune escape, and how uncertainty or non-identifiability was handled) 

- #### Process for setting/calibrating P(hosp given current infection) and P(death given current infection)

- #### Waning immunity details (e.g., distribution used)

Maximum immunity within 3 months since recovery (total immunity in case of the same variant as in previous infection), after 3 months immunity decays gradually to predefined level. The predefined level is reached after 4 or 10 months since recovery. 



- #### Seasonality implementation

Seasonality taken into account indirectly by yearly modulation of contacting rates (parameters representing intensity of contacts in the given context in particular time and region). 

- #### Emerging variant details (including introduction process)
Sowing variant X: technically we convert random agents in latent state of Omicron or Delta into variant X infection at the pace of 50 agents per week beginning from 1st May within the period of time of 16 weeks.  

- #### Nonpharmaceutical interventions

NPIs are introduced in the model by changing contacting rates in time and space.
