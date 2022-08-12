# Modeller commentary

All results concern the simulations of epidemic in Austria under the assumption that no new variant will takeover (all infections are Omicron BA.2 infections).

The simulated scenarios were made as a direct followup of a study made for the Austrian Ministry of Health. The study with focus on immunity will be published in a few days on http://www.dexhelpp.at/de/news/. The study uses sligtly different assumptions (see below). 

## Summary comments on results

In all four scenarios (Scenario A-D), a high Omicron BA.2 wave occurs in November. At least in Austria this idea might already been outdated, since BA.4/5 is already responsible for almost 10% of the cases by start of June.
    The height of the wave is almost independent of the chosen vaccination strategy. It has a minor impact on the peak of the occupancy numbers though. Finally, the optimistic waning rate reduces the first peak in November by about 30% and visibly delays the second peak in spring.

## Explanation of observed dynamics given model assumptions

In general, the impact of the additional ~1Mio booster vaccines has a comparably low impact. Primarily this is due to the fact that a very high percentage of the vaccinated cohort, i.e. boostered persons with 60+, is already immunized. In addition with comparably low effectiveness (80%) and fast waning (to 40% in 3 and 8 months, respectively) of the vaccine against infection with BA.2 the immunity level cannot be increased by much. The reduction and delay of the peaks when comparing the different waning rates is quite self explanatory.

# Model assumptions

## Round 1 scenarios

### Second booster campaign

We assumed a booster effectiveness of 80% against infection with BA.2 and Weibull(140,1.5)/ Weibull(376,1.5) distributed waning time, whereas all values larger than 90/240 days are set to infinity. This guarantees 60% reduction of effectiveness after the specified time period

### Waning immunity

See, Chapter Second booster campaign for wanig after vaccination. Effectiveness after recovery from BA.2 variant are modeled with 100% effectiveness and equivalent waning rates as vaccination.
   
### Scenarios for the Austrian Ministry of Health

I contrast to the assumptions used here, the scenarios for the Austrian Ministry of health do not consider, that immunization events always converge towards 40% effectiveness, but use a classic Weibull distribution.
   
## Additional assumptions

### Number/type of immune classes considered

The model does not classify immune classes. Every agent has its own unique immunization profile which depends on all agent recoveries, recovery dates, vaccinations and vaccination dates. The model is calibrated and simulated from the beginning of the pandemics in 2020. The immune profile at the start of the scenarios emerges naturally

### Seasonality implementation

Seasonalty parameters for 2021 were calibrated using information about NPIs, variants and case numbers and afterwards used for 2022 and 2023

### Contact rate and/or behaviour assumptions

We do not regard any changes of NPIs. Currently, testing/isolate as well as moderate hygiene policies via face mask wearing are implemented in Austria.

### Scenarios for the Austrian Ministry of Health

In addition to modelling solely the impact of BA.2 in, scenarios with different hypothetical future evolutionary advantageous variants were simulated. Moreover, a slightly different hospitalization model was used.
