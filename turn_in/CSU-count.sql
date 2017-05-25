-- bbaiello Brady Aiello

-- Q1: For each campus that avg'd more than $2500 in fees between 2000 and
--     2005, report the total cost of fees for this 5-year period. Sort in
--     ascending order by fee.

SELECT c.Campus, SUM(f.fee)
    FROM campuses c, fees f
    WHERE f.CampusId = c.Id
    AND f.Year BETWEEN 2000 AND 2005
    GROUP BY c.Id
        HAVING AVG(f.fee) > 2500
    ORDER BY SUM(f.fee);

-- Q2: For each campus for which data exists for more than 60 years, report
--     avg, max, min enrollment for all years. Sort by avg enrollment.

SELECT c.Campus, AVG(e.Enrolled), MAX(e.Enrolled), MIN(e.Enrolled)
    FROM campuses c, enrollments e
    WHERE e.CampusId = c.Id
    GROUP BY c.Id
        HAVING MAX(e.Year) + 1 - MIN(e.Year) > 60
    ORDER BY AVG(e.Enrolled);

-- Q3: For each campus in LA and Orange counties report the total number of
--     degrees granted between 1998 and 2002. Sort output in desc. order by
--     the number of degrees.

SELECT c.Campus, c.County, SUM(d.degrees) AS 'total degrees'
    FROM campuses c, degrees d
    WHERE d.CampusId = c.Id 
    AND c.County IN ('Los Angeles', 'Orange')
    AND d.year BETWEEN 1998 AND 2002
    GROUP BY c.Campus
    ORDER BY SUM(d.degrees) DESC;

-- Q4: For each campus that had more than 20000 enrolled students in 2004 
--     report the number of disciplines for which the campus had non-zero
--     graduate enrollment. Sort the output in alphabetical order by the name
--     of the campus.

SELECT c.Campus, COUNT(*) AS 'disciplines with grad students'
    FROM campuses c, discEnr den, enrollments e
    WHERE 
        den.CampusId = c.Id AND e.CampusId = c.Id AND e.Year = den.year
        AND den.year = 2004 AND den.Gr > 0 AND e.Enrolled > 20000
    GROUP BY c.Id
    ORDER BY c.Campus;
