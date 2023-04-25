# Modeller commentary

## Summary comments on results
Important warning: Due to new hypotheses on round4 concerning waning speed (especially due to the use of a median time instead of a mean time), the calibration concerning the optimistic waning hypothesis was not completely successful. In particular, there is a lack of susceptible individuals during previous periods, resulting in a lower circulation of the virus in the past. However this previous lower circulation implies a higher circulation near the end of the calibration period (hence juste before the beginning of the projections) as a balance effect. This problem mainly happens before the start of the projections concerning infections and new hospitalisations, but due to the time delay it is still present in the projections concerning the mortality part. Therefore deaths are overestimated during the first weeks of the projections as a consequence of this anormal circulation. However, the projections for the Winter-Automn period seems not suffer from this problem and are more reliable.
This problem of calibration mostly affects the projections under the optimistic hypothesis (scenarios A and B). The pessimistic hypothesis (scenarios C and D) suffers less or not at all of this problem. Therefore, we could say that, according to our model, the current pessimistic waning hypothesis seems more in line with the reality.

The impact of the waning hypothesis concerning the percentage of protection vs infection is not really important at the level if infections. The reduction to 40% instead of 70% leads to a quite similar transmission in the long term (except the mentioned problem concerning the calibration of past periods). The speed of the waning is probably more important (but for this round this is identical for the 2 hypotheses).
The impact of the waning hypothesis concerning severe outcomes is more important and can be seen on hospitalisations and also on death projections during the period September-December 2023.

## Comments on observed dynamics given model assumptions
Comments concerning the calibration:
- The new waning hypotheses (especially using median instead of mean) provide slower waning. With the optimistic waning hypothesis, the remaining pool of susceptible is so low at some periods that the calibration is difficult.
- The new waning hypotheses imply an almost complete recalibration of the model. Since some of them were not successful, we only kept around 20 independent Markov chains. Hence the 100 runs provided are based on 20 independent calibrations times several stochastic realisations.
- The mortality rate seems not perfectly calibrated concerning the current variant, so the "inc death" projections are probably less trustable. 
- In general, the behaviour (and severity parameters) since the emergence of the last variant xbb1.5 in Belgium cannot be very perfectly captured since this variant is not present for a long time in the country. This particularly happens with the optimistic waning hypothesis.

Comment concerning the introduction of the new variant: from an artefact of the model, the introduction of a new variant in a quite short time frame introduces a temporary reduction of infections during some weeks in comparaison to the baseline, before the new variant becomes dominant (cf. later Remark).

Note: the model is mainly calibrated on new hospitalisations of people with covid, including individuals not hospitalised for covid (i.e. for other diseases). However, the output "inc hosp" is an estimation of the hospital admissions for covid only.

# Model assumptions

## Round 4 scenarios

### Waning of protection against infection
Continuous decrease using exponential law according to scenarios of Round 4.
For Round 4 the waning has been adjusted to cope with the median of the exponential law instead of the mean, which results in a slower waning.

#### Optimistic waning of protection against infection 
Remark: For the previous periods, optimistic waning results in a quite low pool of remaining susceptible, and the calibration is far more difficult.

#### Pessimistic waning of protection against infection
Remark: This hypothesis seems more in line with previous waves/variants than the optimistic waning hypothesis.

#### Any variation from the scenarios as specified

### New variants

#### Any variation from the scenarios as specified
Remark: Since the model only accounts for 2 variants at a time, there is each time a current variant (with less protection from old vaccines and previous infections) and a previous variant (with stronger protections). With the introduction of the new variant in scenarios B and D, the current variant is relegated to the status of previous variant, hence with better protection from previous immunity. Therefore, the model projects a slight decrease of the transmission of the previous variant once a new variant is introduced. This is an artefact coming from the current version of the model

## Additional assumptions

### Age groups 
The model accounts for 10 years age groups, converted into 0-17, 18-59, 60+.

### Vaccination
According to data available on March 14 from Sciensano, Belgian Scientific Institute of Public Health. The latest vaccination campaign takes into account old vaccines and new bivariant vaccines, which are incorporated in the model.

### Vaccine effectiveness
Fixed inputs on vaccine effectiveness
Vaccine type | Alpha Infection | Alpha severe | Delta Infection | Delta severe | Omicron Infection | Omicron severe
:---: | :---: | :---: | :---: | :---: | :---: | :---: | 
Adeno: 1st dose | 49% | 76% | 43% | 76% | 18% | 65%
Adeno: 2nd dose | 74% | 86% | 83% | 95% | 49% | 81%
mRNA: 1st dose | 48% | 83% | 72% | 79% | 32% |65%
mRNA: 2nd dose | 94% | 95% | 91% | 99% | 66% | 81%
Booster (mRNA) | - | - | 95% | 99% | 67% | 90%
2nd/3rd Booster original strain (mRNA) | - | - | 95% | 99% | 67% | 90%
2nd/3rd Booster bivariant (mRNA)  | - | - | 95% | 99% | 95% | 99%

New omicron variants (regrouped as ba4/ba5, bq1/ba2.75/xbb, xbb1.5) have their own reductions in vaccine effectiveness and protection from previous infections which are estimated by the model.

### Number/type of immune classes considered
Immune classes are the following ones: previously infected previous variant, previously infected current variant, 1st dose vaccinated (Adeno, mRNA), 2nd dose vaccinated (Adeno, mRNA), Booster vaccinated (only mRNA), extra Booster vaccinated without updated vaccine, extra Booster vaccinated with updated vaccine, "vaccinated and previously infected previous variant" and  "vaccinated and previously infected current variant".

All 1st dose, 2nd dose and booster dose classes are merged into a single classe "vaccinated and previously infected" after an infection, with no distinction on the number of doses.

#### Initial distribution of susceptibility 
Derived from the evolution from March 2020.

##### Proportion of people that are naïve at start of projection (not vaccinated or infected)
Derived from the evolution from March 2020.

#### Population ageing 
Not considered.

#### Assumptions on severity of infection of repeat infections
Not considered.

##### Other

### Seasonality implementation
Cf. contact rate

### Contact rate and/or behaviour assumptions
Contact matrices for the projection are based on contact matrices of the previous year at the same period (CoMix study in Belgium) in order to reproduce changes in contact patterns and closures due to holidays.
However, the transmissions parameters on top of contacts (proportionality factors) are kept for Round 4 as similar to the last period of calibration (February-March 2023) since they are mainly related to the current xbb1.5 variant and are very different than the ones estimated in 2022 for the initial omicron.

#### Non-pharmaceutical interventions
No new NPI considered here.

#### Behaviour in response to case notification rates
Not considered.

### Other
