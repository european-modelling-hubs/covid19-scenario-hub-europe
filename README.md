# European COVID-19 Scenario Hub

> ### Round 1
> Following completion of the pilot round we are now welcoming modelling contributions to round 1. For the full scenario specifications in this round, applied to the [32 countries](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/blob/main/data-locations/locations_eu.csv) of the Hub, see:
> - [Scenario details: Round 1](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/wiki/Round-1)
>
>  For updates, please [request to join the mailing list](https://groups.google.com/u/0/g/euro-covid19-scenario-hub) including your name/introduction.

---

## Background

Scenario models for COVID-19 aim to bound the uncertainty around future outcomes over some time frame. Each potential scenario is composed of one or more variables (which could be, for example, biological parameters such as the rate of immunity waning, or assumed future changes in contact behaviours) deemed plausible. The scenario models encode the influence of these variables on COVID-19 outcomes, and results from scenario models show possible outcomes within the given timeframe assuming that present causal relationships hold in the future. The definition of scenario variables and values depends on the intended use of scenario results. One purpose of scenario modelling is to support comparisons of possible actions taken in the present with long term effects. Separately, scenarios can also be used to understand the sensitivity of future outcomes to varying parameter conditions. 

Each single model provides a framework for estimating the upper and lower limits of uncertainty in COVID-19 outcomes corresponding to each scenario. However, there is no objectively best framework for modelling the transmission of SARS-CoV-2 and resulting dynamics of COVID-19, meaning the true range of uncertainty may be most appropriately expressed by results from multiple alternative models.

We aim to create a European Scenario Hub that brings together scenario modellers for the purpose of better understanding possible COVID-19 futures in a way that informs short-term policy strategies for managing COVID-19 across Europe. This follows previous work to produce collaborative forecasts and scenarios in Europe and the United States (<https://covid19forecasthub.org/>, <https://github.com/KITmetricslab/covid19-forecast-hub-de>, <https://covid19scenariomodelinghub.org/>). The following text aims to ensure transparent principles and criteria to guide all participants in the Hub and interpretation of Hub results.

## Aims

The short-term goals of the European Scenario Hub are:

1. Creation and visualisation of open access scenario projections
2. Collaboration among hub participants (that improves the quality of projections)
3. Identifiable potential for use of results in policy decision-making
4. Ethical communication of scenario projections to the public; 
5. Secondary analysis of scenario hub projections including 
    * Degree of agreement between different models for the same scenario
    * Understanding the impact of choices of model structure and complexity on projected futures
    * Methods for combining scenario results

Long term goals include:

6. Creating an open database of standardised, comparable scenario projections that are easily accessible for secondary analyses by the wider research community
7. Identifying benefits or drawbacks of collaborative improve real-time scenario modelling with implications for future work
8. creating a self-sustaining community of European scenario modellers

This protocol addresses the first four of the short-term aims of the Scenario Hub.

## Procedure

### Identifying scenarios and setting parameters

We will create scenarios at 4-8 week intervals with each set of scenarios (a round) projecting over a future 3-12 months. As a starting point, our framework for setting scenarios in each round is a 2x2 matrix composed of two variables, each with optimistic and pessimistic parameter values for its influence on COVID-19 outcomes. 

#### Variables

We aim to include one variable that is biologically intrinsic to COVID-19, and one variable that can be influenced extrinsically by national-level policy action. For each variable we will identify one or more observable parameters that represent the causal pathway from the variable to the outcome. 

For each scenario round, we will collaborate with the ECDC to define the extrinsic variable, based on their interactions with national policy-makers and assessment of possible policy options. We will draw on the epidemiology of COVID-19 in Europe to suggest themes for the biologically intrinsic variable. After an initial consultation with the ECDC, we will share and seek suggestions for the scenario variables from participating teams. 

#### Parameters

Each of the two variables can be expressed using one or multiple parameters representing an observable value on the causal pathway between the variable and outcome. We can explore the uncertain impact of each parameter by identifying the two most plausible parameter values that would create either the best possible (optimistic) or worst possible (pessimistic) COVID-19 outcome.

Modelling teams do not have to include the underlying variables in their model, but the model structure should be able to include each explicit parameter value. Additional implicit parameters may be relevant to each variable but not quantitatively specified in the scenario definition.  Whether these parameters are included in a model is at each teams’ discretion.

For each scenario round, after defining the variables we will collaborate with teams to define which parameters are explicitly specified and at what value. Teams must be able to include the explicit parameters, and we do not specify any other restrictions on the type or structure of models that teams use.


### Contributing and combining scenario projections

We focus on weekly incident targets, for any of the following COVID-19 outcomes: infections, cases, and deaths. To align with other Hubs we ask for quantile intervals at 0.01, 0.025, 0.05, every 5% to 0.95, 0.975, and 0.99. Inclusion in ensemble models requires a full set of quantiles from 0.01 to 0.99. We will collect metadata from teams in the form of a structured abstract. This will vary slightly with each round of scenarios. See the [technical Wiki](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/wiki) for more details on the submission process and requirements.

We will create ensembles from the individual models for each scenario round separately. As an initial choice we will create a median ensemble by taking the median of the given predictive quantiles of the different models for each scenario. Other ensemble choices will be considered and differences between outcomes presented by different models discussed with the modellers in order to avoid hiding differences from structural or parametric assumptions by taking the ensemble.  


### Reporting and interpreting projections

For each scenario round, we will create a standardised visualisation allowing all models’ scenario projections to be compared. This will be presented on the website and we will follow this with a narrative summary of model results, including information taken from model abstracts to demonstrate differences between teams’ approach to and results from scenarios.

We aim to choose plausible scenarios that can inform policy but do not expect any of them to be an exact characterisation of the future. We therefore do not expect data to align with any one model result. Moreover, observed data would not align with any scenario output if the scenarios excluded a parameter that operated within the relevant timeframe and had substantial confounding effects across all of the scenarios.
