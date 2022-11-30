-- Raw master data

Select *
From MusicandMentalHealthSurveyResults..mxmh_survey_results$

-- To check for null values

Select COUNT(*) - COUNT(Timestamp) as TimestampNulls,
	   COUNT(*) - COUNT(Age) as AgeNulls,
	   COUNT(*) - COUNT([Primary streaming service]) as Nulls,
	   COUNT(*) - COUNT([Hours per day]) as HoursperDayNulls,
	   COUNT(*) - COUNT([While working]) as WhileWorkingNulls,
	   COUNT(*) - COUNT([Instrumentalist]) as InstrumentalistNulls,
	   COUNT(*) - COUNT([Fav genre]) as FavGenreNulls,
	   COUNT(*) - COUNT([Music effects]) as MusicEffectsNulls,
	   COUNT(*) - COUNT(Anxiety) as AnxietyNulls,
	   COUNT(*) - COUNT(Depression) as DepressionNulls,
	   COUNT(*) - COUNT(Insomnia) as InsomniaNulls,
	   COUNT(*) - COUNT(OCD) as OCDNulls,
	   COUNT(*) - COUNT([Foreign languages]) as ForeignLanguagesNulls
From MusicandMentalHealthSurveyResults..mxmh_survey_results$

-- To classify which streaming music used 

Select [Primary streaming service], COUNT([Primary streaming service]) as Total
From MusicandMentalHealthSurveyResults..mxmh_survey_results$
Where [Primary streaming service] is not null
Group by [Primary streaming service]
Order by Total desc 

-- To classify favourite genre

Select TOP (10) [Fav genre], COUNT([Fav genre]) as Total
From MusicandMentalHealthSurveyResults..mxmh_survey_results$
Group by [Fav genre]
Order by Total desc

-- To know does music effects on mental health

Select [Music effects], COUNT([Music effects]) as Total
From MusicandMentalHealthSurveyResults..mxmh_survey_results$
Where [Music effects] is not null
Group by [Music effects]
Order by Total desc

-- To know which age group has the most impact in improving

With AgeGroup(AgeGroup)
as
(
Select
CASE
	When Age < 18 Then 'Children'
	When Age between 18 and 60 then 'Adult'
	When Age > 60 then 'Elderly'
END as AgeGroup
From MusicandMentalHealthSurveyResults..mxmh_survey_results$
Where [Music effects] = 'Improve'
	and Age is not null
)
Select AgeGroup, COUNT(AgeGroup) as TotalImproving
From AgeGroup
Group by AgeGroup
Order by AgeGroup desc

-- To know which age group has the no effect in improving

With AgeGroup(AgeGroup)
as
(
Select
CASE
	When Age < 18 Then 'Children'
	When Age between 18 and 60 then 'Adult'
	When Age > 60 then 'Elderly'
END as AgeGroup
From MusicandMentalHealthSurveyResults..mxmh_survey_results$
Where [Music effects] = 'No effect'
	and Age is not null
)
Select AgeGroup, COUNT(AgeGroup) as TotalNoEffect
From AgeGroup
Group by AgeGroup
Order by AgeGroup desc

-- To know which age group has the worsen condition

With AgeGroup(AgeGroup)
as
(
Select
CASE
	When Age < 18 Then 'Children'
	When Age between 18 and 60 then 'Adult'
	When Age > 60 then 'Elderly'
END as AgeGroup
From MusicandMentalHealthSurveyResults..mxmh_survey_results$
Where [Music effects] = 'Worsen'
	and Age is not null
)
Select AgeGroup, COUNT(AgeGroup) as TotalWorsen
From AgeGroup
Group by AgeGroup
Order by AgeGroup desc

-- To calculate average listening hours per day

With Avg(Avg)
as
(
Select AVG([Hours per day]) as AverageHoursListen
From MusicandMentalHealthSurveyResults..mxmh_survey_results$
)
Select ROUND(Avg, 2) as AverageHoursListen
From Avg

-- To find out respondent anxiety condition

With AnxietyCondition(AnxietyCondition)
as
(
Select 
CASE 
	When Anxiety <= 5 then 'Mild'
	When Anxiety > 5 then 'Severe'
END as AnxietyConditions
From MusicandMentalHealthSurveyResults..mxmh_survey_results$
)
Select AnxietyCondition, COUNT(AnxietyCondition) as Total
From AnxietyCondition
Group by AnxietyCondition

-- To find out respondent depression condition

With DepressionCondition(DepressionCondition)
as
(
Select 
CASE 
	When Depression <= 5 then 'Mild'
	When Depression > 5 then 'Severe'
	Else 'Others'
END as Conditions
From MusicandMentalHealthSurveyResults..mxmh_survey_results$
)
Select DepressionCondition, COUNT(DepressionCondition) as Total
From DepressionCondition
Group by DepressionCondition

-- To find out respondent insomnia condition

With InsomniaCondition(InsomniaCondition)
as
(
Select 
CASE 
	When Insomnia <= 5 then 'Mild'
	When Insomnia > 5 then 'Severe'
	Else 'Others'
END as Conditions
From MusicandMentalHealthSurveyResults..mxmh_survey_results$
)
Select InsomniaCondition, COUNT(InsomniaCondition) as Total
From InsomniaCondition
Group by InsomniaCondition

-- To find out respondent OCD condition

With OCDCondition(OCDCondition)
as
(
Select 
CASE 
	When OCD <= 5 then 'Mild'
	When OCD > 5 then 'Severe'
	Else 'Others'
END as Conditions
From MusicandMentalHealthSurveyResults..mxmh_survey_results$
)
Select OCDCondition, COUNT(OCDCondition) as Total
From OCDCondition
Group by OCDCondition








