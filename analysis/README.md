
## Characterising information loss due to aggregating epidemic model outputs

This work aims to demonstrate what information is lost in the process of summarising model output in quantiles when contributing to a multi-model epidemic modelling hub, in terms of key epidemic characteristics; summarising uncertainty using an ensemble; and exploring performance against observed data. See the [Abstract](#abstract).

Work led by Kath Sherratt on behalf of the European Scenario Modelling Hub (Round 2). See [authors](#authors).

Read the [current draft under co-author review](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/blob/analysis/analysis/output/Co-author%20review_%20Characterising%20information%20loss%20due%20to%20aggregating%20epidemic%20model%20outputs.pdf). All [code](code) and [data](data) are available: the best place to start is the [results Rmarkdown document](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/blob/analysis/analysis/output/output-rmd.rmd).

---

#### Current status

- We are currently at pre-submission stage
   - A full working draft is under review by co-authors
   - See [current draft (pdf)](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/blob/analysis/analysis/output/Co-author%20review_%20Characterising%20information%20loss%20due%20to%20aggregating%20epidemic%20model%20outputs.pdf)
- Next steps will be to add to medRxiv and submit to Epidemics

#### Development

- Code
   - Results are generated from an [Rmd document](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/blob/analysis/analysis/output/output-rmd.rmd)
   - All comments and feedback, as well as requests for guidance on using the code, are very welcome - please [open an Issue](https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/issues) or contact [Kath Sherratt](https://github.com/kathsherratt)
- Analysis
   - Write up is currently in a [Google doc](https://docs.google.com/document/d/1Kh_vvFbWwnLhfChRS-yMyARCnkL0ttAvDXsJQIwwFcY/edit)
   - The results section is also available in [html](https://htmlpreview.github.io/?https://raw.githubusercontent.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/analysis/analysis/output/output-rmd.html)

---

#### Authors

Katharine Sherratt 1, Ajitesh Srivastava 2, Kylie Ainslie 3, David E. Singh 4, Aymar Cublier 4, Miguel Guzman Merino 4, Maria Cristina Marinescu 5, Jesus Carretero 4, Alberto Cascajo Garcia 4, Nicolas Franco 6, Lander Willem 7, Steven Abrams 8, Christel Faes 8, Philippe Beutels 8, Niel Hens 8, Sebastian Müller 9, Billy Charlton 9, Ricardo Ewert 9, Sydney Paltra 9, Christian Rakow 9, Jakob Rehmann 9, Tim Conrad 10, Christof Schütte 10, Kai Nagel 9, Rok Grah 11, Rene Niehus 11, Bastian Prasse 11, Frank Sandmann 11, Sebastian Funk 1

_1 London School of Hygiene and Tropical Medicine, London, UK; 2 University of Southern California, Los Angeles, USA; 3 RIVM, Bilthoven, Netherlands; 4 Universidad Carlos III de Madrid, Madrid, Spain; 5 Barcelona Supercomputing Center, Barcelona, Spain; 6 University of Namur (Belgium), Namur, Belgium; 7 University of Antwerp (Belgium), Antwerp, Belgium; 8 University of Hasselt (Belgium), Hasselt, Belgium; 9 TU Berlin, Berlin, Germany; 10 ZIB Berlin, Berlin, Germany; 11 ECDC, Stockholm, Sweden_

#### Abstract

Background. Epidemic modelling projections, and particularly comparisons between multiple models, are increasingly seen as a reliable source of policy-relevant evidence during epidemic outbreaks. Results from multiple models are typically collected by asking modellers to summarise a distribution of results using descriptive statistics. Here we look at information loss from this method, compared to collecting a subsample of underlying model simulations. We explored information losses in terms of key epidemic quantities, uncertainty in an ensemble, and evaluating performance over time.

Methods. We compared projections from Round 2 of the European COVID-19 Scenario Modelling Hub. We asked modellers to model a set of pre-specified scenarios, and from each team collected up to 100 simulations for each projection target. First, we used all simulations to compare key epidemic characteristics including peak times and cumulative totals. Second, to recreate current practice, we drew a set of standard quantiles from the submitted simulations for each model, and followed the widely used ensemble method of taking a median average across models at each quantile. We compared this to an ensemble created by drawing probabilistic quantiles from all available simulations at each time step. Third, we compared each simulation to observed data using mean average error. We used this to weight each simulation in a weighted median ensemble of all simulations.

Results. We found that by collecting simulations we were able to show trajectory shapes, peaks, and cumulative total burden. The sample of simulations contained a right-skewed distribution which was poorly summarised by an ensemble of quantile intervals. As expected, we observed wide variation in the forecasting performance of each simulation. An ensemble weighted by predictive performance substantially narrowed the range of plausible future incidence and excluded some epidemic shapes altogether. 

Conclusions. Understanding the potential sources of information loss in collecting multiple model projections may support improving the accuracy, reliability, and communication of collaborative infectious disease modelling efforts. 
