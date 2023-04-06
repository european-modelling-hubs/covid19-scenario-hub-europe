As an expert in your own model, your qualitative commentary is a key to your quantitative results. Please include any information or comments that might be relevant to interpreting your model projections. 

_Usage: Please copy this file and save in your team's `data-processed` folder, renaming the file as appropriate (`2023-03-15-Team-Model.md`). Add your team's comments and include when [submitting your results](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/wiki/Submission-via-GitHub)._

---

# Modeller commentary

## Summary comments on results
In all scenarios the autumn wave is predicted. In terms of new infection there is little variation across 4 scenarios. 

In terms of hospital admission pessimistic waning assumption gives higher prediction of hospital addmission during the autumn wave.

Overall influence of new variant X in scenarios B and D as compared with scenarios A and C is barely noticable.

## Comments on observed dynamics given model assumptions
There are two important things to take into account while interpreting our results of Round 4. 

Firstly, in order to calibrate to the current wave of infections we needed to compensate against pessimistic or optimistic waning assumption with absolute level of contacting rates. Most likely, it is the reason why there is little variation across 4 scenarios in terms of new infections. 

Secondly, the very little influence of new variant X is likely due to the assumption of relatively high peak cross-immunity against infection with variant X, especially for vaccinations and also it stems from the assumption of full protection against hospitalisation with variant X (see section "New variants").      

# Model assumptions

## Model of immunity
Daily probability of infection is calculated for each susceptible agent at the end of the day. In simple terms, technically, all healthy agents are susceptible. (Daily) immunity against infection is defined as reduction of the daily probability of infection. Such immunity maybe partial or full. Full (100%) immunity means that the probability of infection is reduced to 0. The immunity is a product of maximum immunity given by the appriopriate element of cross-immunity matrix $c_{inf}$ and the profile of immunity variation in time, so-called $S_{inf}$ function.

Our approach require some method to translate daily immunity against infection as defined above into some kind of overall immunity against infection. In this experiment we use following method. We consider the situation when susceptible (partly immune) agent is heavily exposed to infectious agent for three to five days, the situation might occurs when susceptible agent lives with the infectious one in one household. In this setting $\mathrm{daily\_immunity\_against\_infection}^4 \approx \mathrm{overall\_immunity\_against\_infection}$

 Once the agent gets infected, the course of infection consists of a chain of subsequent disease states that the agent goes through. These states represent the severity of symptoms such asymptomatic, mild symptomatic, requiring hospitalisation or requiring ICU treatment. The probabilities of transition from each state to other states determine the total probabilities of each particular course of the whole infection. The daily probability of infection as well as transition probabilities between states may be reduced due to the agent’s immunity gained from vaccination or past infection within the frame of a multi-step immunity mechanism. The reduction of transition probability between mild symptomatic state and requiring hospitalisation state is given by the product of relevant element of hospitalisation cross-immunity matrix $c_{hosp}$ and function $S_{hosp}$. Function $S_{hosp}$ gives the time profile of transition probability reduction. 



## Round 4 scenarios

### Waning of protection against infection
Functions $S_{inf}$ and $S_{hosp}$ are always piecewise linear.

#### Optimistic waning of protection against infection 
6 months median time to transition to 70% of the initial immunity =>  
$S_{inf}=1$ until 3 months after immunization, then 6 months after immunisation $S_{inf}=0.915$ ($0.915^4 \approx 0.7$), $S_{inf}=0$ after 24 months since immunisation.

#### Optimistic waning of protection against severe outcomes:
no waning =>  
$S_{hosp} = 1$ It means very slow effective waning against severe outcome.


#### Pessimistic waning of protection against infection
6 months median time to transition to 80% of the initial immunity =>  
$S_{inf}=1$ until 3 months after immunization, then 6 months after immunisation $S_{inf}=0.8$ ($0.8^4 \approx 0.4$), $S_{inf}=0$ after 24 months since immunisation.
#### Pessimistic waning of protection against severe outcomes:
6 months median time to transition to 80% of the initial immunity =>  
$S_{hosp}=1$ until 3 months after immunization, then 6 months after immunisation $S_{hosp}=0.8$ and  plateu since 6 months after immunisation at the level of $S_{hosp}=0.8$. 

#### Any variation from the scenarios as specified
FILL (if applicable)

### New variants

In scenarios B and D new variant X is sown (imported to Poland) at pace of 50 new X variant infections weekly for 16 weeks from 1st May 2023 onwards.

Cross-immunity assumptions are consistent with round 4 guideline, i.e., elements of cross-immunity matrix $c_{inf}$ for variant X are equal to 0.915 because $0.915^4 \approx 0.7$ and elements of cross-immunity matrix $c_{hosp}$ for variant X are equal to 1.

However, above-mentioned (and used here) assumptions about variant X differ from what we routinely assume about Omicron variants while using our model. Namely, we usually assume that protection efficacy against infection with Omicron variant is higher for past Omicron infection than for vaccination (particularly primary course vaccination). Additionally, we usually assume that protection against hospitalisation with Omicron variant  is not full for past Omicron infection or vaccination even before it wanes.

We interpret "0% immune escape against severe outcomes" in round 4 specs as a full protection against severe outcome.  

#### Any variation from the scenarios as specified
FILL (if applicable)


## Additional assumptions

### Age groups 
Each agents has an age assigned
The disease course vary with agent's age. To differenciate the course of disease with age transition propbablities between agent states are defined in 10 year bands.

### Vaccination
The vaccination process in Poland has practically stalled since October 2022 in terms of the second booster
In terms of the primary course and the first booster vaccination has stalled since April 2022.
In our model we have a good represantation of primary course coverage and we also take into account aboat 10 milion out of 12.5 milion first booster doses administered until March 2023. 

### Vaccine and past infection effectiveness
primary course (full dose) maximum (before it wanes) VE against XBB.1.5 infection: $0.76^4 \approx 30\%$  
first booster maximum (before it wanes) VE against XBB.1.5 infection: $0.875^4 \approx 60\%$  

past BQ.1/BQ.1.1 infection gives maximum (before it wanes) efficacy against XBB.1.5 infection: $0.92^4 \approx 70\%$
### Number/type of immune classes considered
In our model an agent's immunity is described as continous quantity (See section "model of immunity")

#### Initial distribution of susceptibility 
FILL (if applicable)

##### Proportion of people that are naïve at start of projection (not vaccinated or infected)
FILL (if applicable)

#### Population ageing 
Not implemented

#### Assumptions on severity of infection of repeat infections
We assume that past Omicron infection reduces transition probability between mild symptomatic state and requiring hospitalisation state by at most 80%. The reduction wanes in time in pessimistic waning scenarios.

##### Other

FILL (if applicable)

### Seasonality implementation

Implemented via time varying contact rates.

### Contact rate and/or behaviour assumptions


#### Non-pharmaceutical interventions

 Obligation to wear a mask in health care facilities and pharmacies is the only NPI binding now in Poland.

#### Behaviour in response to case notification rates

Not relevant - we estimate that just 1 out of 120 infections is officialy reported.

### Other

FILL 
