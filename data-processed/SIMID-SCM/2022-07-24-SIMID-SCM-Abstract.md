## (a) Modeller commentary

- #### Summary comments on results Round 2

Results concern scenario-based projections in Belgium.

Important changes since Round 1:
- Due to the consideration of BA4.BA5 variants, the increase of cases is more important in September 2022 than estimated in Round 1.
- The behaviour/seasonal change is now not considered constant after September 2022, as explain in details in "Seasonality implementation", in order to mimic changes that occurred during last year. As a result, the model does not project stable equilibrium as long as changes like seasonality or holidays/schools opened provide perturbations.

- #### Comments on observed dynamics given model assumptions

According the the assumptions concerning behaviour/seasonality based on last year, the model projects potential new waves which could be at up to 6 months interval and could have a peak being similar to the first omicron wave in Belgium at the level of hospitalisations. However, those waves are less important concerning ICU burden.

However, those potential waves are clearly strongly dependent on the transmission and population behaviour during the year.

The impact of a vaccination campaign, especially with Optimistic vaccine effectiveness, is quite important but mostly in the subsequent waves and less in September-October 2022.

## (b) Model assumptions

### Round 2 scenarios

- #### Second booster campaign

Uptake based on Belgium data up to July 23 2022 (including 2nd booster already given), then performing a new extra booster campaign as in scenarios up to 50% of the uptake for 1st booster as on July 23 2022

   - ##### _if applicable:_ Any variation from the scenarios as specified

   - ##### Vaccine effectiveness assumptions

Vaccine type | Alpha Infection | Alpha severe | Delta Infection | Delta severe | Omicron Infection | Omicron severe
:---: | :---: | :---: | :---: | :---: | :---: | :---: | 
Adeno: 1st dose | 49% | 76% | 43% | 76% | 18% | 65%
Adeno: 2nd dose | 74% | 86% | 83% | 95% | 49% | 81%
mRNA: 1st dose | 48% | 83% | 72% | 79% | 32% |65%
mRNA: 2nd dose | 94% | 95% | 91% | 99% | 66% | 81%
Booster (mRNA) | - | - | 95% | 99% | 67% | 90%
2nd Booster before September 2022 | - | - | 95% | 99% | 67% | 90%
Extra Booster after September 2022 | scenario dependant

- #### Waning immunity 

   - ##### Details of waning protection against infection (e.g., distribution used)
   
   Continuous decrease using exponential law according to optimistic scenario of Round 1. For the extra booster dose, the final result after waning is the same as the situation after waning of the previous booster doses (i.e. not depending on scenario of Round 2).
   
   - ##### Waning protection against severe disease
   
    Continuous decrease using exponential law according to optimistic scenario of Round 1 (using monthly conversion).

### Additional assumptions

- #### Number/type of immune classes considered

Immune classes are the following ones: previously infected, 1st dose vaccinated (Adeno, mRNA), 2nd dose vaccinated (Adeno, mRNA), Booster vaccinated (only mRNA), extra Booster vaccinated (only mRNA) and "vaccinated and previously infected"

The administration of a second booster dose before September 2023 is considered by taking an individual back to the booster vaccinated class with full protection restarted (according to the table). The booster campaign of September 2022-December 2022 is entirely done inside the extra Booster classes, so being a 2nd booster for individuals without a 2nd booster yes, but a 3rd booster for individuals with a 2nd booster.

The "Optimistic and Pessimistic vaccine effectiveness" variations are only performed at the level of infection, the level of severe protection remaining the same as for the previous boosters.

All 1st dose, 2nd dose and booster dose classes are merged into a single classe "vaccinated and previously infected" after an infection, with no distinction on the number of doses.

   - ##### _if applicable:_ Initial distribution of susceptibility

Derived from the evolution from March 2020

- #### Seasonality implementation

From September 2022 to December 2022, contact matrices and transmission are considered as the ones during June 2022 before summer holidays (with BA4/BA5 already present) with a smooth transition during the first month. From January 2023 to July 2023, contact matrices and transmission are taken from the period January 2022 to July 2022 where omicron was already present (with transmission adapted to BA4/BA5 variants), in order to mimic behavioural and seasonal changes during the year. The period before January 2022 is not used because it correspond to the delta variant, which quite different transmission parameters.

- #### Contact rate and/or behaviour assumptions

Cf. Seasonality implementation

   - ##### Non-pharmaceutical interventions
   
   No new NPI considered here.

   - ##### _if applicable:_ Behaviour in response to case notification rates
   
   Not considered.
