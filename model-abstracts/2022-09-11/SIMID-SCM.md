# Modeller commentary

## Summary comments on results Round 3
FILL

## Comments on observed dynamics given model assumptions
FILL

# Model assumptions

## Round 3 scenarios

### Vaccination campaigns

#### Vaccination uptake in 60+ and <60 age groups 
75% for 60+, 15% for 20-59
Vaccination campaign over 3 months: 1st month 70+, 2nd month 60+, 3rd month 20+, starting September 15 or March 15
The current planed campaign in Belgium is (almost) similar to this scenario
If individuals are not eligible for vaccination (infected or non-waining state due to recent vaccination/infection), their vaccination is delayed are administered later

#### Assumptions on next generation vaccines
VE (infection and severe case) similar to initial booster vs delta variant (vs VOCs >6months)

#### Any variation from the scenarios as specified

### New variants

#### Any variation from the scenarios as specified

## Additional assumptions

### Waning immunity 
Continuous decrease using exponential law according to optimistic scenario of Round 1 (-60% over 8 months for infection, -20% over 3 months for severe disease)

### Vaccine effectiveness
Vaccine type | Alpha Infection | Alpha severe | Delta Infection | Delta severe | Omicron Infection | Omicron severe
:---: | :---: | :---: | :---: | :---: | :---: | :---: | 
Adeno: 1st dose | 49% | 76% | 43% | 76% | 18% | 65%
Adeno: 2nd dose | 74% | 86% | 83% | 95% | 49% | 81%
mRNA: 1st dose | 48% | 83% | 72% | 79% | 32% |65%
mRNA: 2nd dose | 94% | 95% | 91% | 99% | 66% | 81%
Booster (mRNA) | - | - | 95% | 99% | 67% | 90%
2nd Booster before September 2022 (mRNA) | - | - | 95% | 99% | 67% | 90%
Next generation after September 2022 (unless immunity reduction)  | - | - | 95% | 99% | 95% | 90%

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
Contact matrices and transmission are based each year on previous contact matrices (CoMix study) and previous estimated transmission related to each CoMix matrices:
- for January to August: reference contact matrices are the ones from January to August 2022 
- for September to December: since estimated transmission for Omicron-type variant is lacking for this period, contact matrices and transmission from June to March 2022 are considered backward as a proxy (to simulate variations and seasonality)

#### Non-pharmaceutical interventions
No new NPI considered here.

#### Behaviour in response to case notification rates
Not considered.

### Other
