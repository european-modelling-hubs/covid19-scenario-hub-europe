
# Modeller commentary

## Summary comments on results

In all 4 scenarios (A-D), we experience a rise in weekly Omicron BA.5 numbers in the upcoming weeks in Germany. This rise reaches its peak in early September, before any vaccination campaign is introduced. With the introduction of any of the 4 vaccination campaigns we see a reduction in weekly cases which plateaus in November, before then further decreasing in the beginning of December.

## Comments on observed dynamics given model assumptions

None.

# Model assumptions

## Round 2 scenarios

### Second booster campaign

#### Any variation from the scenarios as specified

A second booster is already offered to individuals aged 70 and above in Germany. Hence, in our model the 2nd booster rate of agents aged 70 and above is in accordance with the 2nd booster rate provided by the Robert Koch Institute (RKI). We assume that agents 70 and above, who have already received a 2nd booster, are eligible for a 3rd booster (5th shot) if their 2nd booster was more than 90 days ago. 

### Vaccine effectiveness
In our model, the initial immune response varies between agents. The variation is modelled via a lognormal distribution. Immune response varies between 1/10 and 10x the average antibody responder.

#### Optimistic vaccine effectiveness

At time of infection, an agent's current neutralizing antibody level against Omicron BA.5 is either
a) multiplied by 15 (http://doi.org/10.1101/2021.10.10.21264827) or 
b) assigned the initial neutralizing antibody level that a 2-dose mRNA vaccine would have provided that agent vs. **Delta** if they were to have been naive, 
whichever is greater.
For an agent who has an "average" immune response to immunization events (vaccinations/infections), this translates to a VE of 92%.

#### Pessimistic vaccine effectiveness

At time of infection, an agent's current neutralizing antibody level against Omicron BA.5 is either
a) multiplied by 15 (http://doi.org/10.1101/2021.10.10.21264827) or 
b) assigned the initial neutralizing antibody level that a 2-dose mRNA vaccine would have provided that agent vs. **Omicron BA5** if they were to have been naive, 
whichever is greater.
For an agent who has an "average" immune response to immunization events, this translates to a VE of 38%.

## Additional assumptions

### Waning immunity

The same exponential decay rate for both vaccination- and infection-derived protection is assumed. An agent's antibody level is assumed to have a half-life of 60 days.

### Number/type of immune classes considered

Not applicable, as our model is not a compartmental model and (partial) immunity of an agent is instead based on their antibody level.

#### Initial distribution of susceptibility

In our model, whenever an agent recovers, they are automatically considered susceptible again. They never reach full immunity. Hence, every agent is (to a certain extent) susceptible. 

##### Proportion of people that are naïve at start of projection (not vaccinated or infected)

Less than 2% of our agents are naive at the start of the projection (meaning that they have neither been vaccinated nor been infected with  ANY virus strain).

##### Other

Not applicable. 

### Seasonality implementation

Based on weather data, we set up the so-called "outdoor fraction", which determines the percentage of activities performed outside instead of inside. 

### Contact rate and/or behaviour assumptions

#### Non-pharmaceutical interventions

The only NPIs/protective measures we include in round 2 are mask-wearing on public transport (which is still mandatory in Germany) and a slightly increased ventilation rate in schools (windows are opened every 90 minutes). For masks on public transport, we assume a compliance of 50%,  where half the agents wear a medical and the other half wear a FFP2 mask. 

#### Behaviour in response to case notification rates

None.

### Other

Not applicable.