-- create a join
select * from absenteeism_at_work a
left join compensation c on c.ID = a.ID
left join reasons r on a.`Reason for absence` = r.Number

-- find the healthiest employees for the bonus
select * from absenteeism_at_work
where `Social drinker`=0 and `Social smoker`=0 and `Body mass index`<25 and
`Absenteeism time in hours` < (select AVG(`Absenteeism time in hours`) from absenteeism_at_work)

-- total number of non-smokers
select count(*) as non_smokers from absenteeism_at_work
where `Social smoker` = 0

-- compensation rate increase for all non-smokers budget $983,221
-- 983221/(40*52*686) = 0.69
-- 0.69*(5*8*52) = $1435.2 increase per year assuming that employees work 8hrs/day and 5days/week for 52weeks/year

-- optimize this query
select a.ID, r.Reason, `Month of absence`, `Body mass index`,
case when a.`Body mass index` < 18.5 then 'Underweight'
  when a.`Body mass index` between 18.5 and 24.9 then 'Healthy Weight'
     when a.`Body mass index` between 25 and 29.9 then 'Overweight'
     when a.`Body mass index` >= 30 then 'Obese'
     else 'Unknown' end as BMI_category,
case when a.`Month of absence` IN (12,1,2) then 'Winter'
  when a.`Month of absence` IN (3,4,5) then 'Spring'
     when a.`Month of absence` IN (6,7,8) then 'Summer'
     when a.`Month of absence` IN (9,10,11) then 'Autumn/Fall'
     else 'Unknown' end as Season_name,
`Day of the week`, `Transportation expense`, Age, `Work load Average/day`, `Disciplinary failure`, Son,
`Social drinker`, `Social smoker`, `Absenteeism time in hours`   
from absenteeism_at_work a
left join compensation c on c.ID = a.ID
left join reasons r on a.`Reason for absence` = r.Number