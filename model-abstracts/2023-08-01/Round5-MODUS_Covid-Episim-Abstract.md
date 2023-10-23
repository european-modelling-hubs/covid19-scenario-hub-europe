As an expert in your own model, your qualitative commentary is a key to your quantitative results. Please include any information or comments that might be relevant to interpreting your model projections. 

_Usage: Please copy this file and save in your team's `data-processed` folder, renaming the file as appropriate (`2023-08-20-Team-Model.md`). Add your team's comments and include when [submitting your results](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/wiki/Submission-via-GitHub)._

---

# Modeller commentary

## Summary comments on results
FILL

## Comments on observed dynamics given model assumptions



# Model assumptions

## Round 5 scenarios

### Waning of protection against infection
In our model we assume that receiving the monovalent booster XBB1.5 or being infected with the XBB1.5 strain results in a protection against infection of XX%. We hereby assume the the novel monovalent XBB1.5. booster protects as well against the XBB1.5. variant as the initial mRNA vaccine protected against the wild type. We assume the same waning speed for all agents.

#### Optimistic waning of protection against infection 
Within 6 months the protection wanes to 70% of the initial immunty, resulting in a VE against infection of <mark>XX%</mark>.

#### Pessimistic waning of protection against infection
Within 6 months the protection wanes to 40% of the initial immunty, resulting in a VE against infection of <mark>XX%</mark>.

#### Any variation from the scenarios as specified
FILL (if applicable)

### Vaccination

#### Any variation from the scenarios as specified
We assume that Comirnaty XBB.1.5 is the only type of vaccination distributed during the vaccination campaign. This monovalent vaccine is assumed to provide the same protection against an infection with XBB.1.5. as the original mRNA vaccines protected against the wild-type of SARS-CoV-2. In the "pessimistic" and "optimistic" cases, we specified that agents could only get the new vaccinations if they hadn't been infected or vaccinated in the last year (as per [STIKO](https://www.rki.de/DE/Content/Kommissionen/STIKO/Empfehlungen/Stellungnahme-COVID-19-Varianten-adaptierte-Impfstoffe.html) reccomendation) and that only agents who were already vaccinated (+ potentially boostered) could recieve the booster. For the "upper-limit" case, we reduced the wait period to 6 months and also allowed unvaccinated agents to receive the booster. 


## Additional assumptions

### Age groups 
Agents may have any age, but the age distribution in our model is based on German demographic data.

### Vaccination
As specified by the guidelines of round 5, the vaccination campaign begins on Oct 1st, 2023 and lasts for 90 days.

### Vaccine effectiveness


### Number/type of immune classes considered
We do not consider immune classes, rather every agent has their own unique immunization history which saves all their vaccinations and infections and consequently provides them with protection against infection/hospitalization. Consequently, every combination of vaccination(s) and infection(s) may occur in the model.

#### Initial distribution of susceptibility 
In our model, whenever an agent recovers, they are automatically considered susceptible again. They never reach full immunity. Hence, every agent is (to a certain extent) susceptible.

##### Proportion of people that are naïve at start of projection (not vaccinated or infected)
FILL (if applicable)

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

Not implemented.

### Other

None.

