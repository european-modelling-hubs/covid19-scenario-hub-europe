As an expert in your own model, your qualitative commentary is a key to your quantitative results. Please include any information or comments that might be relevant to interpreting your model projections.

_Usage: Please copy this file and save in your team's `data-processed` folder, renaming the file as appropriate (`2022-05-22-Team-Model.md`). Add your team's comments and include when [submitting your results](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/wiki/Submission-via-GitHub)._

---

# Modeller commentary

## Summary comments on results

There was a lot of variability in model trajectories with some trajectories indicating multiple waves of disease outcomes between late summer 2022 and early summer 2023; however, the majority of trajectories showed a single wave of disease outcomes peaking in late fall 2022 or winter 2022/2023 (assuming no new variants emerge). Peak timing did not vary greatly between scenarios. Peak size was decreased when optimistic vaccine effectiveness (VE) estimates were assumed (scenarios A & B) compared to when pessimistic VE estimates were assume (scenarios C & D). There was little difference in incidence under pessimistic VE assumptions when boosting all adults compared to boosting only 60+ (mean peak reduction ~1.5-2.5%). We observed a decrease in disease outcomes when optimistic VE was assumed and all adults were boosted compared to just boosting 60+ (mean reduction in peak incidence ~5-7%).

## Comments on observed dynamics given model assumptions

A booster campaign in fall 2022 was not sufficient to prevent a wave of disease outcomes in late fall/winter. The increased protection conferred by boosting 50% of individuals 60 years and above or 50% of all adults was not enough to overcome the seasonal increase in transmissibility of the Omicron BA.4/BA.5 sub-variants. 

# Model assumptions

## Round 2 scenarios

### Second booster campaign

#### Any variation from the scenarios as specified

The Netherlands has already offered a second booster (4th dose) to individuals aged 60 years and above; therefore, for scenarios A and C we assume a third booster dose (5th dose) is offered in the fall booster campaign. For scenarios B and D we assume individuals aged 18-59 receive a second booster (4th dose) and indivudals aged 60 years and above receive a thrid booster (5th dose).

#### Vaccine effectiveness assumptions

We assume vaccine effectiveness (VE) against transmission and infection wanes following a logistic curve parameterized such that VE decreases by 25 percentage points within the first 6 months after vaccination (Higdon et al. 2022). We assume VE against hospitalisation also wanes following a logistic curve, but at a slower rate than VE against infection and transmission, specifically, that VE decreases by 10 percentage points in the first 6 months following vaccination (Higdon et al. 2022). VE estimates against the Omicron variant vary by age group, dose, and vaccine product. We assume booster doses are mRNA vaccines. 

### Waning immunity

#### Details of waning protection against infection (e.g., distribution used)

We assume waning immunity from natural infection follows an Erlang distribution parameterized such that there is a 60% reduction in immunity after 8 months following infection.

#### Waning protection against severe disease

We do not explicitly include waning natural immunity against severe disease; however, we do include waning vaccine-induced protection against severe disease (see above).

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

We assume contact patterns consistent with pre-COVID times, as measured in the Netherlands in April 2017. 

#### Behaviour in response to case notification rates

FILL (if applicable)

### Other

FILL
