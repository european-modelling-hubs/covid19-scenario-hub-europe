As an expert in your own model, your qualitative commentary is a key to your quantitative results. Please include any information or comments that might be relevant to interpreting your model projections.

_Usage: Please copy this file and save in your team's `data-processed` folder, renaming the file as appropriate (`2022-05-22-Team-Model.md`). Add your team's comments and include when [submitting your results](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/wiki/Submission-via-GitHub)._

---

# Modeller commentary

## Summary comments on results

Under all scenarios (A-D), a large rise in weekly cases due to Omicron (BA.2) begins in fall 2022 and peaks in winter 2022/2023 in the Netherlands. Under the assumption of pessimistic waning (A, C) the peak in weekly cases occurs in early November 2022, while under the assumption of optimistic waning (B, D), the peak is delayed until January 2023. Implementation of a fall booster campaign (5th dose) in the Netherlands in those aged 60 years and above results in a reduction of ~45% in peak weekly cases, regardless of assumptions about waning immunity.

## Comments on observed dynamics given model assumptions

FILL

# Model assumptions

## Round 1 scenarios

### Second booster campaign

#### Any variation from the scenarios as specified

The Netherlands has already offered a second booster (4th dose) to individuals aged 60 years and above; therefore, for scenarios A and C the continuation of this booster campaign up to a coverage of 50% is assumed. For scenarios B & D, we assume a third booster dose (5th dose) is offered in the fall booster campaign.

#### Vaccine effectiveness assumptions

We assume vaccine effectiveness (VE) against transmission, infection, and hospitalisation wane at the same rate and follow a logistic function parameterized so that after 6 months vaccine-induced protection is reduced by 50% and reduced by 100% after 1 year (assuming no additional doses are received). Vaccine effectiveness estimates vary by dose and vaccine product.

### Waning immunity

#### Details of waning protection against infection (e.g., distribution used)

Waning of immunity from natural infection are assumed to follow an Erlang distribution, where k = 4.

#### Waning protection against severe disease

We do not explicitly include waning natural immunity against severe disease; however, we do include waning vaccine-induced protection against severe disease, modeled as a logistic function parameterized so that after 6 months vaccine-induced protection is reduced by 50% and reduced by 100% after 1 year (assuming no additional doses are received).

## Additional assumptions

### Number/type of immune classes considered

We have 6 types of immune classes, one for unvaccinated individuals and then a separate immune class for each vaccine dose (1 to 5). To slow waning immunity, we also include 3 additional immune classes of each type before an individual reaches the corresponding susceptible compartment.

#### Initial distribution of susceptibility

##### Proportion of people that are naïve at start of projection (not vaccinated or infected)

FILL (if applicable)

##### Other

FILL (if applicable)

### Seasonality implementation

To account for the seasonal pattern of SARS-CoV-2 transmission, we define the transmission rate at time t as a sinusoidal function of seasonality.

### Contact rate and/or behaviour assumptions

#### Non-pharmaceutical interventions

We assume contact patterns consistent with pre-COVID times, as mesured in the Netherlands in April 2017. 

#### Behaviour in response to case notification rates

FILL (if applicable)

### Other

FILL
