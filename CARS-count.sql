-- bbaiello Brady Aiello

-- Q1: For each Japanese car maker (rep by their short name) report the best
--     mpg of a car produced by it and the avg accel. Sort desc. by best
--     mileage.

SELECT cm.Maker, MAX(MPG), AVG(Accelerate)
    FROM countries c, carmakers cm, models mo, makes ma, cardata cd
    WHERE 
        cd.Id = ma.Id AND ma.Model = mo.model
        AND mo.Maker = cm.Id
        AND cm.Country = c.Id
        AND c.Name = 'japan'
    GROUP BY cm.Maker
    ORDER BY MAX(MPG) DESC;

-- Q2: For each US car makers (reported by their short name), report the
--     number of 4-cylinder cars that are lighter than 4000 lbs with 0-60
--     mph accel better than 14 seconds. Sort in desc order by number of
--     cars reported.

SELECT cm.Maker, COUNT(*) AS 'cars'
    FROM countries c, carmakers cm, models mo, makes ma, cardata cd
    WHERE 
        cd.Id = ma.Id AND ma.Model = mo.model
        AND mo.Maker = cm.Id AND cm.Country = c.Id
        AND c.Name = 'usa' AND cd.Weight < 4000 
        AND cd.Accelerate < 14 AND cd.Cylinders = 4
    GROUP BY cm.Maker
    ORDER BY COUNT(*) DESC;

-- Q3: For each year in which honda produced more than 2 models, report the
--     best, worst, and average mpg of a toyota vehicle. Report results in
--     chrono. order.

SELECT cdh1.Year AS 'Year', MAX(cdt.MPG), MIN(cdt.MPG), AVG(cdt.MPG)
    FROM carmakers cmh,
    makes mah1, models moh1, cardata cdh1, 
    makes mah2, models moh2, cardata cdh2,
    makes mah3, models moh3, cardata cdh3,

    carmakers cmt, models mot, makes mat, cardata cdt
    WHERE 
            cdh1.Id = mah1.Id AND mah1.Model = moh1.model 
        AND moh1.Maker = cmh.Id AND cmh.Maker = 'honda'

        AND cdh2.Id = mah2.Id AND mah2.Model = moh2.model 
        AND moh2.Maker = cmh.Id AND cmh.Maker = 'honda'

        AND cdh3.Id = mah3.Id AND mah3.Model = moh3.model 
        AND moh3.Maker = cmh.Id AND cmh.Maker = 'honda'

        AND mah1.Id < mah2.Id AND mah1.Id < mah3.Id AND mah2.Id < mah3.Id
        AND cdh2.Year = cdh3.Year AND cdh1.Year = cdh2.Year
        
        AND cdt.Id = mat.Id AND mat.Model = mot.model 
        AND mot.Maker = cmt.Id AND cmt.Maker = 'toyota'
        AND cdh1.Year = cdt.Year
    ORDER BY cdh1.Year;

 
-- Q4: For each year when US-manufactured cars avg'd < 100 horsepower, report
--     the highest and lowest engine displacement number. Sort chrono.

SELECT cd.Year, MAX(cd.EDispl), MIN(cd.EDispl)
   FROM cardata cd, carmakers cm, countries co, makes ma, models mo
   WHERE
        cd.Id = ma.Id
        AND ma.Model= mo.model
        AND mo.Maker = cm.Id
        AND cm.Country = co.Id
        AND co.Name = 'usa'
   GROUP BY cd.Year
        HAVING AVG(cd.Horsepower) < 100
   ORDER BY cd.Year;
    
