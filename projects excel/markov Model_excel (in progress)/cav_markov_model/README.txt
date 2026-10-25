The work was done by Sultan; the note was written by AI

EVEROLIMUS VS AZATHIOPRINE AFTER HEART TRANSPLANT: MARKOV COHORT MODEL
======================================================================

A cost-effectiveness Markov cohort model in Excel comparing everolimus
with azathioprine (standard care) for preventing cardiac allograft
vasculopathy (CAV) in adult heart transplant recipients, from the UK
NHS perspective.

Health states:

  1  No CAV
  2  Mild or moderate CAV
  3  Severe CAV
  4  Death

The transition probabilities come from real patient data (the cav
dataset, 622 heart transplant recipients at Papworth Hospital),
prepared with SQL. The treatment effect comes from a published trial.


HOW TO FOLLOW THE PROJECT
-------------------------

Open the files in the "scripts" folder in this order:

  Step 1   scripts/01_transitions.sql
           Uses data/raw/cav.csv (the cav dataset from the R package
           msm). Orders each patient's angiograms, pairs consecutive
           visits and counts the moves between states. Also calculates
           the cohort characteristics and the mean time between visits.

  Step 2   scripts/02_cav_markov_model.xlsx
           The model. Read the sheets from left to right:
             1_plan           decision problem, assumptions, limitations
             2_Data           SQL results and ONS life tables
             3_Parameters     all inputs with sources
             4_Transitions    transition probabilities for both drugs
             5_Markov_SC      Markov trace, azathioprine
             6_Markov_EVE     Markov trace, everolimus
             7_Results        costs, QALYs, ICER, net monetary benefit,
                              charts
             8_DSA            one-way sensitivity analysis and tornado


MODEL AT A GLANCE
-----------------

  Cohort          1,000 people, mean age 47, 86% men
  Cycle           1 year, 30-year horizon
  Discounting     3.5% for costs and QALYs, half-cycle correction
  Mortality       ONS National Life Tables 2022-2024 as a floor
  Treatment       relative risk of CAV 0.68 for everolimus
                  (Eisen et al. 2003), applied to moves out of state 1


DATA SOURCES
------------

  cav dataset, R package msm (Jackson CH). Papworth Hospital data;
  Sharples LD et al. Transplantation 2003;76(4):679-682.
  https://cran.r-project.org/package=msm

  Eisen HJ et al. Everolimus for the prevention of allograft rejection
  and vasculopathy in cardiac-transplant recipients. N Engl J Med
  2003;349(9):847-858.

  Office for National Statistics. National Life Tables, United Kingdom,
  2022 to 2024.
