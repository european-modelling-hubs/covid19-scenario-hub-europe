## (a) Modeller commentary

- #### Summary comments on results

Results concern scenario-based projections in Belgium.

Infections, and therefore hospital admissions and deaths, typically reach a long term equilibrium which is dependent on the assumed waning rate. This equilibrium is temporary disturbed each time a change in contacts/transmission is assumed.

- #### Comments on observed dynamics given model assumptions

The hypothesis on the waning rate has an important impact of the level of the equilibrium. Each time a change in contact behaviour/seasonality is assumed, there is a temporary divergence form the equilibrium during 2-4 months.

Under the Pessimistic fast immune waning assumption, a small new wave appear during summer due to the waning from the last omicron waves. Such summer wave is not present with the Optimistic slow immune waning.

Each scenario project a small temporary increase of transmission in September-October, which depends on the level reached during summer (increased set of susceptibles).

## (b) Model assumptions

### Round 1 scenarios

- #### Second booster campaign

Uptake based on Belgium data up to May 21 2022, then performing a campaign as in scenarios up to 50% of the uptake for 1st booster as on May 21 2022

   - ##### _if applicable:_ Any variation from the scenarios as specified

   - ##### Vaccine effectiveness assumptions

Vaccine type | Alpha Infection | Alpha severe | Delta Infection | Delta severe | Omicron Infection | Omicron severe
:---: | :---: | :---: | :---: | :---: | :---: | :---: | Adeno: 1st dose | 49% | 76% | 43% | 76% | 18% | 65%Adeno: 2nd dose | 74% | 86% | 83% | 95% | 49% | 81%mRNA: 1st dose | 48% | 83% | 72% | 79% | 32% |65%mRNA: 2nd dose | 94% | 95% | 91% | 99% | 66% | 81%Booster (mRNA) | - | - | 95% | 99% | 67% | 90%
2nd Booster | - | - | 95% | 99% | 67% | 90%

- #### Waning immunity 

   - ##### Details of waning protection against infection (e.g., distribution used)
   
   Continuous decrease using exponential law according to scenarios
   
   - ##### Waning protection against severe disease
   
    Continuous decrease using exponential law according to scenarios (using monthly conversion)

### Additional assumptions

- #### Number/type of immune classes considered

Immune classes are the following ones: previously infected, 1st dose vaccinated (Adeno, mRNA), 2nd dose vaccinated (Adeno, mRNA), Booster vaccinated (only mRNA) and "vaccinated and previously infected".

The administration of a second booster dose is considered by taking an individual back to the booster vaccinated class with full protection restarted (according to the table).

All 1st dose, 2nd dose and booster dose classes are merged into a single classe "vaccinated and previously infected" after an infection, with no distinction on the number of doses.

   - ##### _if applicable:_ Initial distribution of susceptibility

Derived from the evolution from March 2020

- #### Seasonality implementation

 	A reduction in contacts (social contact matrices) and transmission (proportionality q-parameters) is performed during the period July-August 2022 according to the current contacts and estimated transmission (Omicron variant) as base level, using the relative reduction observed during the period July-August 2021 (delta variant) in comparison to the contacts and transmission observed during the period September-October 2021 (also delta variant).

- #### Contact rate and/or behaviour assumptions

Cf. Seasonality implementation

   - ##### Non-pharmaceutical interventions
   
   No new NPI considered here.

   - ##### _if applicable:_ Behaviour in response to case notification rates
   
   Not considered.
