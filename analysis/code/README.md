### Guide to code

See the [results Rmarkdown](../output/output-rmd.Rmd) for a fully documentation implementation.

Summary:
- Load multiple model projections from up to 100 sample simulations
   - [import-results.R](import-results.R)
   - [format-results.R](format-results.R)
- Create three ensembles: 1) taking quantiles from raw samples, 2) summarising each model's samples into quantiles, then taking the median average across quantiles; 3) weight each sample by its performance against observed data, then ensemble as in (1).
   - [create-ensembles.R](create-ensembles.R)
      - [score-samples.R](score-samples.R)
   - [compare-ensembles.R](compare-ensembles.R)
- Plot each ensemble for a given target
   - [plot.R](plot.R)

