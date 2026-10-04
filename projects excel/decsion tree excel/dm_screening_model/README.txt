SCREENING FOR UNDIAGNOSED TYPE 2 DIABETES: DECISION TREE MODEL
================================================================

A cost-effectiveness decision tree in Excel comparing three strategies
for adults aged 35 to 70 with no diabetes diagnosis:

  1. No screening
  2. HbA1c screening only for people with BMI >= 25
  3. HbA1c screening for everyone

The prevalence and test accuracy inputs come from public NHANES data
(August 2021 to August 2023), prepared with R and SQL.


HOW TO FOLLOW THE PROJECT
-------------------------

Open the files in the "scripts" folder in this order:

  Step 1   scripts/01_get_data.R
           Downloads the NHANES files and saves them as CSV in data/raw.

  Step 2   scripts/02_SQL.sql
           Joins the tables, keeps the eligible people and creates
           Main_table (saved as data/Main_table.csv, 1,610 people).

  Step 3   scripts/03_dm_screening_decision_tree.xlsx
           The model. Read the sheets from left to right:
             NHANES_DATA      the table from step 2
             1_plan           decision problem, assumptions, limitations
             2_Parameters     inputs, sources and 2x2 tables
             3_Decsion Tree   the tree
             4_Results        costs, QALYs and ICERs


FOLDERS
-------

  data/raw                  NHANES files as downloaded (.xpt and .csv)
  data/Main_table.csv       analysis table used by the model
  data/data_dictionary.csv  variable names and labels
  scripts/                  the three numbered files above


RESULT
------

Screening people with BMI >= 25 costs 13,440 pounds per QALY gained
compared with no screening. Screening everyone costs 148,061 pounds per
QALY gained compared with screening BMI >= 25.

All inputs, sources, assumptions and limitations are in the Excel file.


DATA SOURCE
-----------

National Health and Nutrition Examination Survey (NHANES), CDC National
Center for Health Statistics. https://wwwn.cdc.gov/nchs/nhanes/
