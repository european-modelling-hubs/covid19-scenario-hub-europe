As an expert in your own model, your qualitative commentary is a key to your quantitative results. Please include any information or comments that might be relevant to interpreting your model projections. 

_Usage: Please copy this file and save in your team's `data-processed` folder, renaming the file as appropriate (`2023-08-20-Team-Model.md`). Add your team's comments and include when [submitting your results](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/wiki/Submission-via-GitHub)._

---

# Modeller commentary

## Summary comments on results

**Difference between optimistic and pessimistic waning:**
For both optimistic and pessimistic waning we observe infection waves in Fall/Winter 2023 and Spring 2024; with the optimistic waning scenarios, the waves occur several weeks later than in the pessimistic waning scenarios. The optimistic waning scenarios generally have fewer infections than the pessimistic ones; the exception is the Fall/Winter wave in 2023, where optimistic waning leads to a higher wave. This can be explained by the fact that the wave is pushed back temporally further into colder colder weather; this leads to more leisure activities occuring indoors, which, in turn, increases the case numbers.

In terms of hospitalisations, the divide between the optimistic and pessimistic waning scenarios is very clear: the pessimistic scenarios have up to 5x higher hospitalisation waves than the opimistic ones. This stark divide can be explained by the multiplicative effect of the two types of pessimistic waning: not only do a higher proportion of agents become infected with SARS-CoV-2, but also a higher proportion of those agents are hospitalised. 

**Difference between vaccination campaigns:**
No matter which vaccination campaign we assume, we observe an infection wave in Fall/Winter 2023 and a smaller infection wave in Spring 2024. The differences in the heights of peaks and valleys between the different campaigns are small. In terms of hospialisations, the vaccination campaign has a somewhat larger effect: the upper-bound vaccination campaign results in approximately 10% fewer hospitalisations than the no-vaccination scenario. 

## Comments on observed dynamics given model assumptions
We assume that future virus variants are introduced every 30 days, with a constant and relatively small immune escape speed. Earlier simulations have shown that without seasonal effects this leads, within a small number of years, to a dying out of the waves and in consequence to a constant incidence.  Once we include seasonal effects, this leads to a self-selection of a wave length that fits into the annual cycle, e.g. 1 or 1.5 or 2 waves per year. With currently plausible parameters, these wave lengths are much longer than the above 30 days, meaning that only _some_ of the new virus variants trigger a new wave.

The wavelength is determined by the waning speed of the immunity on the one hand and the escape speed of the virus variants on the other hand -- the slower the waning speed and the slower the escape speed, the longer the wavelength.  It is to be expected that both speeds get slower, and indeed the data from 2023 implies that the overall dynamics has made considerable progress in this direction.  

Our model predicts (still) two waves per year for both the "optimistic" and the "pessimistic" waning assumption of the ECDC scenario. However, in the "optimistic" case, the maximum amplitude of the summer wave is considerably reduced, from about 5800 to about 4200 (incidence per 100k inhabitants).  

The above assumes that no completely new variant emerges.

# Model assumptions

## Round 5 scenarios

### Waning of protection against infection

Our ABM explicitly models effective antibody levels of each agent in response to immunisation events (infections and vaccinations). Higher levels of antibodies lead to higher protection against infection. In between immunisation events, the effective antibody level decreases exponentially.  For more details on this mechanism, see [Müller et al.](https://doi.org/10.1016%2Fj.isci.2023.107554).

We assume the same waning speed for all agents.

For the present study, the speed of the exponential decrease is adjusted such that the reduction of immunity emerges as specified by the different scenarios. 

In our model we assume that receiving the monovalent booster XBB1.5 results in an initial protection against infection with XBB1.5 of 98%. We hereby assume that the novel monovalent XBB1.5 booster protects as well against the XBB1.5 variant as the initial mRNA vaccine protected against the wild type.

Protection against escape variants is smaller.

#### Optimistic waning of protection against infection 

Based on the Round 5 guidelines, the speed of the exponential decrease is adjusted such that the initial protection (VE) of 98% is reduced to 70% of 98% = 69% after 6 months. 

#### Pessimistic waning of protection against infection

Based on the Round 5 guidelines, the speed of the exponential decrease is adjusted such that the initial protection (VE) of 98% is reduced to 40% of 98% = 39% after 6 months. 

#### Optimistic (= no) waning of protection against hospitalisation
The protection against hospitalisation is calculated from the maximum effective antibody levels the agent has ever reached. There is no waning. 

#### Pessimistic waning of protection against hospitalisation
The guidelines for round 5 demand a "6 months median time to transition to 80% of the initial immunity". Our initial protection against hospitalisation (VE) is assumed to be 98%. Consequently, after 6 months we assume P(Hospitalisation | Infection) = 0.78. The protection against hospitalisation decays exponentially. 

#### Any variation from the scenarios as specified

None. 

### Vaccination


#### Any variation from the scenarios as specified
We assume that Comirnaty XBB.1.5 is the only type of vaccination distributed during the vaccination campaign. This monovalent vaccine is assumed to provide the same protection against an infection with XBB.1.5 as the original mRNA vaccines protected against the wild-type of SARS-CoV-2. Agents could only get the new vaccinations if they had not been infected or vaccinated within the last 12 months (as per [STIKO](https://www.rki.de/DE/Content/Kommissionen/STIKO/Empfehlungen/Stellungnahme-COVID-19-Varianten-adaptierte-Impfstoffe.html) recommendation) and only agents who were already vaccinated (+ potentially boostered) could receive the booster. For the "upper-bound" vaccination case, we reduced the wait period to 6 months and also allowed unvaccinated agents to receive the booster. 


## Additional assumptions

### Age groups 
Agents may have any age; the age distribution in our model is based on German demographic data.

### Vaccination
As specified by the guidelines of round 5, the vaccination campaign begins on Oct 1st, 2023 and lasts for 90 days. Vaccination rates before the study period of round 5 are based on [RKI vaccination data](https://github.com/robert-koch-institut/COVID-19-Impfungen_in_Deutschland).

### Vaccine effectiveness
See above.

### Number/type of immune classes considered
We do not consider immune classes, rather every agent has their own unique immunization history which saves all their vaccinations and infections and consequently provides them with protection against infection/hospitalization. Consequently, every combination of vaccination(s) and infection(s) may occur in the model.

#### Initial distribution of susceptibility 
In our model, whenever an agent recovers, they are automatically considered susceptible again. They never reach full immunity. Hence, every agent is (to a certain extent) susceptible. The distribution of susceptibility at the start of projection is generated by the model dynamics up to that point in time. 

##### Proportion of people that are naïve at start of projection (not vaccinated or infected)
As a consequence of the above dynamics, around 5% of our agents are naive at the start of the projection (meaning that they have neither been vaccinated nor been infected with ANY virus strain). Note: in our Round 2 submission, <2% of agents were naive at the start of the study time frame. We have updated our model parameters since then, leading to this discrepancy. 

#### Population ageing 
Not implemented.

#### Assumptions on severity of infection of repeat infections
The likelihood to experience a more severe state is not increased when an agent is infected for a second time. However, an infection adds to the agents immunization history, thus potentially protecting them better from future (severe) infection than an agent who has not been infected.

##### Other
The model is implemented for the region of Cologne, not for all of Germany. The results are scaled up to the population of Germany. We believe that it is indicative for the overall situation in all of Germany.

### Seasonality implementation
Based on weather data, we set up the so-called "outdoor fraction", which determines the percentage of activities performed outdoors instead of indoors. The introduction of the ''outdoor fraction'' is motivated by the model assumption that the effect of temperature is mostly transmitted via an indoors/outdoors dynamic and that it therefore needs to saturate: Below a certain temperature threshold because eventually all activities are indoors and above a certain temperature threshold because at most all activities can be outdoors.  (With air conditioning, the situation would probably be different, but Germany has little of that.)

### Contact rate and/or behaviour assumptions
Contacts are given by the underlying agent-based transport model (MATSim), see [Müller et al.](https://doi.org/10.1371/journal.pone.0259037).

#### Non-pharmaceutical interventions

None. 

#### Behaviour in response to case notification rates

None.

### Other

Our results were submitted towards the end of October 2023, later than most if not all other simulation results.  However, the SARS-CoV-2 wastewater surveillance data available to us, against which we calibrate our model, ends at the end of June 2023.  In consequence, we may have used more general information about the progression of SARS-CoV-2 than the other projects, but the time period for which we could calibrate was not any longer.

We thank the public health authority of Cologne (Gesundheitsamt Köln) for making the wastewater surveillance data available to us.

