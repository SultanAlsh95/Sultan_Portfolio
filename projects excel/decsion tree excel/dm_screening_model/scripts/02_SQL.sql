CREATE TABLE "Main_table" AS
SELECT "demo"."SEQN", "demo"."RIDAGEYR" AS 'Age' ,"demo"."RIAGENDR" AS 'sex', "bmx"."BMXBMI" AS 'Body_Mass_Index',"diq"."DIQ010" AS 'diagnosed_or_not', "ghb"."LBXGH" AS 'HbA1c', "glu"."LBXGLU" AS 'Fasting_Glucose' FROM "demo"
INNER JOIN "diq" on "diq"."SEQN" = "demo"."SEQN"
INNER JOIN "bmx" ON "bmx"."SEQN" = "demo"."SEQN"
INNER JOIN "ghb" ON "ghb"."SEQN" = "demo"."SEQN"
INNER JOIN "glu" ON "glu"."SEQN" = "demo"."SEQN"
WHERE "demo"."SEQN" IS NOT NULL
	AND "bmx"."BMXBMI" IS NOT NULL
	AND "ghb"."LBXGH"  IS NOT NULL
	AND "glu"."LBXGLU" IS NOT NULL
	AND "diq"."DIQ010" IS NOT NULL
	AND "demo"."RIDAGEYR" IS NOT NULL
	AND "demo"."RIDAGEYR" BETWEEN 35 AND 70
	AND "diq"."DIQ010" = 2
;
/*  "diq"."DIQ010" = 1 means Yes: told by a doctor they have diabetes
	"diq"."DIQ010" = 2 means No: never told they have diabetes
	"diq"."DIQ010" = 3 means Borderline: told they have borderline diabetes / prediabetes
	for our sample we are concerned WITH "diq"."DIQ010" = 2  
	*/
/* Who is elgibil?
	age 35–70 
	WITH "diq"."DIQ010" = 2 (never told they have diabetes)
	*/
select * from "Main_table"




