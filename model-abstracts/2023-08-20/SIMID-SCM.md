# Modeller commentary

## Summary comments on results
Projections are performed from June 28th, 2023 due to a lack of reliable data in Belgium (shift to sentinel surveillance). Those projections try to simulate regular changes in contact patterns and seasonality, resulting in successive potential small waves.
Projected vaccination campaigns starting in October are too late to have a impact on a potential wave in September-October, as protected by the model.
Projected vaccination campaigns have a stronger impact with projections using the pessimistic waning assumption.
Projected vaccination campaigns using the optimistic assumption have a counterbalanced effet starting from March 2024.
Optimistic vaccination scenarios seems to lead to a double benefice than pessimistic vaccination scenarios. The benefice from Upper boundary vaccination seems more marginal.

## Comments on observed dynamics given model assumptions
The main noticeable difference between assumptinos is that, if the benefice from the vaccination campaign on the projections using the pessimistic waning assumption is always positive, the benefice from the vaccination campaign on the projections using the optimistic waning assumption is positive during the period November 2023-February 2024 but negative during the period March 2024-April 2024. This might be due to a lower circulation during the first period leading to a weaker total protection during the second period, or to the differences in the dynamics coming from the calibration using this assumption as detailed in the "Optimistic waning of protection against infection" section (as higher numbers of infection, more immune evasion or co-circulation of different variants as estimated by the model).

# Model assumptions

## Round 5 scenarios

### Waning of protection against infection
Waning is performed as a constant rate stochastic transfert from full protection compartments to waning compartments, with log(2)/180 rate (per day), which corresponds to 6 months median.

#### Optimistic waning of protection against infection 
Remarks: The optimistic waning assumption implies a quite low pool of susceptible since the omicron period. We have observed the following elements:
- The calibration is a bit more difficult during the omicron period and especially for the period around the BQ.1 variant. In order to have a sufficient number of infections and hospitalisations, the model increase the transmission and the immune evasion of the new variants, but this is less in accordance to the relative prevalence of the new variant as observed in Belgium. It is also more difficult to reach the exact peak of the waves around this period.
- The number of infections is clearly higher than with the pessimistic waning: this is logical since the protection vs severe form is stronger and the model need more infections to fit the same hospitalisation data.
- With the optimistic waning, the effect of the vaccination campaign is relatively less important.
- With the optimistic waning, the model projects a potential combined circulation of current and previous variants in the future (starting near December 2023) or even a return to the BQ.1 variant. This is probably a consequence of the high immune evasion/transmission estimated for BQ.1, and could implies that the long term effect of vaccination is more incertain in the model.

#### Pessimistic waning of protection against infection
Remark: This hypothesis seems more in line with previous waves/variants than the optimistic waning hypothesis. The remarks concerning the optimistic waning assumption are not present.

#### Any variation from the scenarios as specified
The hub scenarios assumptions on waning are only performed since Omicron variant. For alpha and delta variants, literature is used.
The waning concerning protection after vaccination is performed as specified in the scenarios. Since the model considers a 100% protection after infection, the waning after infection is performed such that the remaining protection is similar to the protection after waning from a vaccinatino. This avoids potential problems in the long term protection concerning (re)vaccination of previously infected individuals. Cf. the Vaccine effectiveness section for details.
The data used are up to June 27th, 2023 since Belgium entered into sentinel surveillance after this date. Projection are performed form June 28th, 2023.
The data used are the one provided by Sciensano, the health institute for Belgium. Those data are similar to the one collected by ECDC, excepted some retrospective error corrections in past periods. 

### Vaccination

#### Any variation from the scenarios as specified
Only individuals in waning states are vaccinated. Remaining doses are delayed, which could result in an effective end of the vaccination campaign slightly later than the expected end.

## Additional assumptions

### Age groups 
The model accounts for 10 years age groups, converted for the output into 0-17, 18-59, 60+.

### Vaccination
According to data available on August 16 from Sciensano, Belgian Scientific Institute of Public Health. The latest vaccination campaign takes into account old vaccines and new bivariant vaccines, which are incorporated in the model.

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
Immune classes are the following ones: previously infected previous variant, previously infected current variant, 1st dose vaccinated Adeno, 1st dose vaccinated mRNA, 2nd dose vaccinated Adeno, 2nd dose vaccinated mRNA, Booster vaccinated (only mRNA), extra Booster vaccinated without updated vaccine, extra Booster vaccinated with updated vaccine with the previous variant, extra Booster vaccinated with updated vaccine with the current variant vaccinated and previously infected by the previous variant" and  vaccinated and previously infected by the current variant.

All 1st dose, 2nd dose and booster dose classes are merged into a single classe "vaccinated and previously infected" after a vaccination and an infection, with no distinction on the number of doses.

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
Social contact data are estimated from July 1, 2023 as similar to the social contact data of the latest known CoMiX survey corresponding to the same period of a previous year, with a smoothing procedure of 15 days, in order to reproduce changes in contact patterns and closures due to holidays. The transmissions parameters on top of contact matrices (age-specific q proportionality factors) are estimated using the relative changes between May 2022 and the corresponding period last year applied to the estimated parameters of May 2023. In details, the baseline proportionality factors are q_May2023 corresponding to the May2023 contact matrice and the proportionality factors at a time T are q_May2023*q_Tlastyear/q_May2022. Therefore similar seasonal variations are considered but applied to the estimated proportionality factors of May 2023 in order to preserve the specificities of the current variant captured by the q parameters from May 2023.

#### Non-pharmaceutical interventions
No new NPI considered here.

#### Behaviour in response to case notification rates
Not considered.

### Other
