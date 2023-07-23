As an expert in your own model, your qualitative commentary is a key to your quantitative results. Please include any information or comments that might be relevant to interpreting your model projections. 

_Usage: Please copy this file and save in your team's `data-processed` folder, renaming the file as appropriate (`2023-08-20-Team-Model.md`). Add your team's comments and include when [submitting your results](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/wiki/Submission-via-GitHub)._

---

# Modeller commentary

## Summary comments on results
FILL

## Comments on observed dynamics given model assumptions
FILL

# Model assumptions

## Round 5 scenarios

### Waning of protection against infection
Waning is performed as a constant rate stochastic transfert from full protection compartments to waning compartments, with 6/log(2) mean, which corresponds to 6 month median.

#### Optimistic waning of protection against infection 
FILL (if applicable)

#### Pessimistic waning of protection against infection
FILL (if applicable)

#### Any variation from the scenarios as specified
FILL (if applicable)

### Vaccination

#### Any variation from the scenarios as specified
FILL (if applicable)


## Additional assumptions

### Age groups 
FILL 

### Vaccination
FILL

### Vaccine effectiveness
Fixed inputs on vaccine effectiveness
Vaccine type | Alpha Infection | Alpha severe | Delta Infection | Delta severe | Omicron Infection* | Omicron severe
:---: | :---: | :---: | :---: | :---: | :---: | :---: | 
Adeno: 1st dose | 49% | 76% | 43% | 76% | 18%* | 65%
Adeno: 2nd dose | 74% | 86% | 83% | 95% | 49%* | 81%
mRNA: 1st dose | 48% | 83% | 72% | 79% | 32%* |65%
mRNA: 2nd dose | 94% | 95% | 91% | 99% | 66%* | 81%
Natural immunity | 100% | 100% | 100% | 100% | 100% | 100%
Waning  after 2 doses or natural immunity (opti) | 63% | 92% | 63% | 92% | 46%* | 81%
Waning  after 2 doses or natural immunity (pessi) | 63% | 92% | 63% | 92% | 26%* | 65%
Booster (1st/2nd/3rd) (mRNA) | 94% | 95%  | 95% | 99% | 67%* | 90%
Hybrid immunity | 100% | 100% | 100% | 100% | 100% | 100%
Waning after booster or hybrid immunity (opti) | 89% | 92% | 89% | 92% | 47%* | 90%
Waning after booster or hybrid immunity (pessi) | 89% | 92% | 89% | 92% | 27%* | 72%

*Omicron variants (regrouped as ba1/ba2, ba4/ba5, bq1/ba2.75/xbb, xbb1.5/xbb1.16/xbb1.9) have additional reductions in vaccine effectiveness and protection from previous infections (previous variants) which are estimated by the model (immune evasion concerning new infections). New bivariant boosters (mRNA) avoid those reductions vs current and previous variants (as well as protection from previous infections with the current variant).

Protection after waning vs alpha and delta variant are fixed by the literature. Protection after waning vs omicron-like variants are according to scenarios in comparison to the protection after 2 doses or a booster dose. Protection after waning from natural or hybrid immunity are similar to those after waning from 2 doses or booster doses in order to avoid long term differences in case of re-vaccination.

Waning is performed as a constant rate stochastic transfert (exponential process) from full protection compartments to waning compartments, with 6/log(2) months mean, which corresponds to 6 months median.


### Number/type of immune classes considered
FILL (if applicable)

#### Initial distribution of susceptibility 
FILL (if applicable)

##### Proportion of people that are naïve at start of projection (not vaccinated or infected)
FILL (if applicable)

#### Population ageing 
FILL

#### Assumptions on severity of infection of repeat infections
FILL

##### Other

FILL (if applicable)

### Seasonality implementation

FILL (if applicable)

### Contact rate and/or behaviour assumptions

#### Non-pharmaceutical interventions

FILL (if applicable)

#### Behaviour in response to case notification rates

FILL (if applicable)

### Other

FILL 