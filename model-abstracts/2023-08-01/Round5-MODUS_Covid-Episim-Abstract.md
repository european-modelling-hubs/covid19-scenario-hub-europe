As an expert in your own model, your qualitative commentary is a key to your quantitative results. Please include any information or comments that might be relevant to interpreting your model projections. 

_Usage: Please copy this file and save in your team's `data-processed` folder, renaming the file as appropriate (`2023-08-20-Team-Model.md`). Add your team's comments and include when [submitting your results](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/wiki/Submission-via-GitHub)._

---

# Modeller commentary

## Summary comments on results
**Difference between vaccination campaigns:**
No matter which vaccination campaign we assume, we observe an infection wave in October 2023 and a smaller infection wave in March 2024. The differences in heights of peaks and valleys between the different campaigns are small. 

[//]: # (We believe that we hardly see a difference in infection numbers when considering the different campaigns, as the vaccine's effect is outsized for progression to a more severe disease state, especially for the elderly &#40;60+&#41; population.)

**Difference between optimistic and pessimistic waning:**
For both optimistic and pessimistic waning we observe the above-mentioned waves in Fall 2023 and Spring 2024; with the optimistic waning scenarios, the waves occur several weeks later than in the pessimistic waning scenarios. The valley between the Fall & Spring waves, as well as the Spring peak have lower infections in the optimistic waning scenarios than in the pessimistic waning scenarios. 

## Comments on observed dynamics given model assumptions

For future virus variants, we assume that they are introduced every 30 days, with a constant and relatively small immune escape speed.
Earlier simulations have shown that without seasonal effects this leads, within a small number of years, to a dying out of the waves and in consequence to a constant incidence.  Once we include seasonal effects, this leads to a self-selection of a wave length that fits into the annual cycle, e.g. one or two or three waves per year. With currently plausible parameters, these wave lengths are much longer than the above 30 days, meaning that only _some_ of the new virus variants trigger a new wave.

The wave length is determined by the waning speed of the immunity and the the escape speed of the virus variants -- the slower the waning speed and the slower the escape speed, the longer the wave length.  It is to be expected that both get slower, and indeed the data from 2023 implies that the overall dynamics has made considerable progress in this direction.  

Our model predicts (still) two waves per year for both the "optimistic" and the "pessimistic" waning assumption of the ECDC scenario.  However, in the "optimistic" case, the maximum amplitude of the summer wave is considerably reduced, from about 5800 to about 4200 (incidence per 100k inhabitants).  Our current model calibration would actually be consistent with an even more optimistic scenario (even slower waning and mutation speeds) - assuming that no completely new variant emerges.

# Model assumptions

## Round 5 scenarios

### Waning of protection against infection

Our ABM explicitly models effective antibody levels of each agent in response to immunisation events (infections and vaccinations). Higher levels of antibodies lead to higher protection against infection. In between immunisation events, the effective antibody level decreases exponentially.  For more details on this mechanism, see [Müller et al.](https://doi.org/10.1016%2Fj.isci.2023.107554).

We assume the same waning speed for all agents.

For the present study, the speed of the exponential decrease is adjusted such that the specified reduction of immunity emerges.

In our model we assume that receiving the monovalent booster XBB1.5 or being infected with the XBB1.5 strain results in an initial protection against infection with XBB1.5 of 98%. We hereby assume that the novel monovalent XBB1.5 booster protects as well against the XBB1.5. variant as the initial mRNA vaccine protected against the wild type.

Protection against escape variants is smaller.

#### Optimistic waning of protection against infection 

Based on the Round 5 guidelines, the speed of the exponential decrease is adjusted such that the initial protection (VE) of 98% is reduced to 70% of 98% = 69% after 6 months. 

#### Pessimistic waning of protection against infection

Based on the Round 5 guidelines, the speed of the exponential decrease is adjusted such that the initial protection (VE) of 98% is reduced to 40% of 98% = 39% after 6 months. 

#### Any variation from the scenarios as specified

None. 

### Vaccination


#### Any variation from the scenarios as specified
We assume that Comirnaty XBB.1.5 is the only type of vaccination distributed during the vaccination campaign. This monovalent vaccine is assumed to provide the same protection against an infection with XBB.1.5. as the original mRNA vaccines protected against the wild-type of SARS-CoV-2. Synthetic persons could only get the new vaccinations if they hadn't been infected or vaccinated within the last 12 months (as per [STIKO](https://www.rki.de/DE/Content/Kommissionen/STIKO/Empfehlungen/Stellungnahme-COVID-19-Varianten-adaptierte-Impfstoffe.html) recommendation) and only agents who were already vaccinated (+ potentially boostered) could receive the booster. For the "upper-limit" vaccination case, we reduced the wait period to 6 months and also allowed unvaccinated agents to receive the booster. 


## Additional assumptions

### Age groups 
Agents may have any age; the age distribution in our model is based on German demographic data.

### Vaccination
As specified by the guidelines of round 5, the vaccination campaign begins on Oct 1st, 2023 and lasts for 90 days. Vaccination rates before the study period of round 5 are based on [RKI vaccination data](https://github.com/robert-koch-institut/COVID-19-Impfungen_in_Deutschland).

### Vaccine effectiveness


### Number/type of immune classes considered
We do not consider immune classes, rather every agent has their own unique immunization history which saves all their vaccinations and infections and consequently provides them with protection against infection/hospitalization. Consequently, every combination of vaccination(s) and infection(s) may occur in the model.

#### Initial distribution of susceptibility 
In our model, whenever an agent recovers, they are automatically considered susceptible again. They never reach full immunity. Hence, every agent is (to a certain extent) susceptible.

##### Proportion of people that are naïve at start of projection (not vaccinated or infected)
Around 5% of our agents are naive at the start of the projection (meaning that they have neither been vaccinated nor been infected with ANY virus strain). Note: in our Round 2 submission, <2% of agents were naive at the start of the study time frame. We have updated our model parameters since then, leading to this discrepancy. 

#### Population ageing 
Not implemented.

#### Assumptions on severity of infection of repeat infections
The likelihood to experience a more severe state is not increased when an agent is infected for a second time. However, an infection adds to the agents immunization history, thus potentially protecting them better from future (severe) infection than an agent who has not been infected.

##### Other

None.

### Seasonality implementation

Based on weather data, we set up the so-called "outdoor fraction", which determines the percentage of activities performed outside instead of inside. The introduction of the ''outdoor fraction'' is motivated by the fact that the effect of temperature is mostly transmitted via an indoors/outdoors dynamic and that it therefore needs to saturate: Below a certain temperature threshold because eventually all activities are indoors and above a certain temperature threshold because at most all activities can be outdoors.  (With air conditioning, the situation would probably be different, but Germany has little of that.)

### Contact rate and/or behaviour assumptions

#### Non-pharmaceutical interventions

None. 

#### Behaviour in response to case notification rates

None.

### Other

None.

