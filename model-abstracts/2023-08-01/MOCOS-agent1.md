As an expert in your own model, your qualitative commentary is a key to your quantitative results. Please include any information or comments that might be relevant to interpreting your model projections. 

_Usage: Please copy this file and save in your team's `data-processed` folder, renaming the file as appropriate (`2023-08-20-Team-Model.md`). Add your team's comments and include when [submitting your results](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/wiki/Submission-via-GitHub)._

---

# Modeller commentary

## Summary comments on results
The results are showing a possibility of developing a new wave (or a double wave) near the  end of the year - February 2024. The wave will be small on stastics due to assumed low detection rates and good immunity from vaccinations according to shared assumptions made for Round 5.

## Comments on observed dynamics given model assumptions
The optimistic waning assumption gives very low number of deaths due to covid for all Scenarios, because of no waning of the immunity against severe progression and most people were either already infected or vaccinated.

# Model assumptions

## Round 5 scenarios

### Waning of protection against infection


#### Optimistic waning of protection against infection 
FILL (if applicable)

#### Pessimistic waning of protection against infection
FILL (if applicable)

#### Any variation from the scenarios as specified
We implemented waning according to the shared specification.

### Vaccination

#### Any variation from the scenarios as specified
We implemented a new wave of vaccination according to the specification, which means that among two age groups: children and adults (<60) we assumed no new vaccinations will be applied.


## Additional assumptions

### Age groups 
We have agents representing Polish population - for the purpose of the proposed assumptions we use 3 age groups: children (0-17), adults (18-59) and older (60+). In our modeled population we have 6667130 children, 21418457 adults and 9412423 older people. 

### Vaccination
We assumed a constant number of doses daily distributed in dates mentioned in the specification. We followed https://raw.githubusercontent.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/main/data-truth/data/Round_5_vaccination_uptake.csv for Poland.

### Vaccine effectiveness
We assumed that vaccine initial effectiveness is 90% and then after 180 days drops to 36% (40% of the initial value) for pessimistic waning or to 63% (70% of the initial value) for optimistic waning.

### Number/type of immune classes considered
FILL (if applicable)

#### Initial distribution of susceptibility 
We applied vaccinations according to the age group distribution provided in the source data. We assumed distribution of earlier infections (from previous wave) according to the results of our model in the past. 

##### Proportion of people that are naïve at start of projection (not vaccinated or infected)
This is calculated according to (scarce) public data available for Poland. We are setting it based on two sources: the government report https://arcgis.com/sharing/rest/content/items/b860f2797f7f4da789cb6fccf6bd5bc7/data (data on vaccinations) and a website https://koronawirusunas.pl/ providing up-to-date statistics on cases/deaths/hospitalizations for Poland.

#### Population ageing 
We use our old set up of the population based on latest available PL census and microcensus data and we do not implemented ageing. 

#### Assumptions on severity of infection of repeat infections
we assume reinfections come with lower risk on severe progression giving similar effect to protection from the vaccination. For severe progression we applied the same protection level whether the agent has been infected or vaccinated (waning times apply if necessary)

##### Other

FILL (if applicable)

### Seasonality implementation

We downscale infectivity during the summer season (mid-May - mid-Sept). 

### Contact rate and/or behaviour assumptions

#### Non-pharmaceutical interventions

FILL (if applicable)

#### Behaviour in response to case notification rates

household can response in trying to protect others from infecting them but we made an assumption that these mechanism, although are very strong, are currently not widely used, so we assumed only 20% households will adapt the behavior in response to case notification. 

### Other

FILL 
