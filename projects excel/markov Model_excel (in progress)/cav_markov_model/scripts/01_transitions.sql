DROP TABLE IF EXISTS cav_ordered;

CREATE TABLE  cav_ordered AS
SELECT *, 
		ROW_NUMBER() OVER (PARTITION BY PTNUM ORDER BY years) AS visit_no
 FROM cav 
;
----------------------------
DROP TABLE IF EXISTS transitions;

CREATE TABLE transitions AS
SELECT a.PTNUM,
       a.visit_no,
       a.state     AS from_state,
       b.state     AS to_state,
       a.statemax  AS from_statemax,
       b.statemax  AS to_statemax,
       b.years - a.years AS gap
FROM cav_ordered a
JOIN cav_ordered b
  ON a.PTNUM = b.PTNUM
 AND b.visit_no = a.visit_no + 1; 
 
 /* (line 17) this part CLAUD AI  helped me to do   */
 ---------
DROP TABLE IF EXISTS transition_counts;

CREATE TABLE transition_counts AS
SELECT from_statemax AS from_state,
       to_statemax   AS to_state,
       COUNT(*)      AS n
FROM transitions
GROUP BY from_statemax, to_statemax
ORDER BY from_statemax, to_statemax;

SELECT * from transition_counts ;

-- Save the counts as a 4x4 matrix (one row per "from" state), ready for Excel
DROP TABLE IF EXISTS transition_matrix;

CREATE TABLE transition_matrix AS
SELECT from_state,
       SUM(CASE WHEN to_state = 1 THEN n ELSE 0 END) AS to_1,
       SUM(CASE WHEN to_state = 2 THEN n ELSE 0 END) AS to_2,
       SUM(CASE WHEN to_state = 3 THEN n ELSE 0 END) AS to_3,
       SUM(CASE WHEN to_state = 4 THEN n ELSE 0 END) AS to_4
FROM transition_counts
GROUP BY from_state;

SELECT * FROM transition_matrix;
 /* (line 38 to 50) this part CLAUD AI  helped me to do   */
----------------------------
-- Query 4: cohort characteristics for the model

-- Mean age at transplant and share of men (transplant records only)
CREATE TABLE cohort_characteristics AS
SELECT COUNT(*)                                          AS patients,
       ROUND(AVG(age), 1)                                AS mean_age_at_transplant,
       MIN(age)                                          AS min_age,
       MAX(age)                                          AS max_age,
       ROUND(AVG(CASE WHEN sex = 0 THEN 1.0 ELSE 0 END), 3) AS share_male
FROM cav
WHERE firstobs = 1;

-- Time between consecutive visits (tests the "one year per cycle" assumption)

CREATE TABLE cohort_characteristics_2 AS
SELECT ROUND(AVG(gap), 2)                              AS mean_gap_years,
       ROUND(MIN(gap), 2)                              AS min_gap,
       ROUND(MAX(gap), 2)                              AS max_gap,
       SUM(CASE WHEN gap > 1.5 THEN 1 ELSE 0 END)      AS gaps_over_1_5_years,
       COUNT(*)                                        AS all_gaps
FROM transitions;