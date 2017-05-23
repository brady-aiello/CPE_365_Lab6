-- bbaiello Brady Aiello

-- Q1: For each gender/age group, report total number of runners in the group,
--     overall place of the best runner in the group, and overall place of 
--     worst runner in the group. Output result sorted by age group and sorted
--     by by gender (F followed by M) within each age group.

SELECT AgeGroup, Sex, COUNT(*) AS 'runners', MIN(m1.Place), MAX(m1.Place)
    FROM marathon m1
    GROUP BY AgeGroup, Sex
    ORDER BY AgeGroup, Sex;

-- Q2: Report the total number of gender/age groups for which both the 1st
--     and the 2nd place runners (within the group) hail from the same state.

SELECT COUNT(*)
    FROM marathon m1, marathon m2
    WHERE m1.AgeGroup = m2.AgeGroup
    AND m1.Sex = m2.Sex
    AND m1.State = m2.State
    AND m1.GroupPlace = 1 AND m2.GroupPlace = 2;
       
-- Q3: For each full minute, report the total number of runners whose pace was
--     between that number of minutes and the next (That is, how many runners
--     ran the marathon at a pace between 5 and 6 mins, how many at a pace of
--     6 - 7 min, and so on.

SELECT MINUTE(Pace) AS 'Pace(low)', MINUTE(Pace) + 1 AS 'Pace(high)', 
    Count(*) AS 'runners'
    FROM marathon
    GROUP BY MINUTE(Pace);
 
-- Q4: For each state, whose representatives participated in the marathon 
--     report the number of runners from it who finished in top 10 in their
--     gender-age group (if a state did not have runners in top 10s, do not
--     output info about that state). Output in desc. order by the computed
--     number.

SELECT State, COUNT(*)
    FROM marathon
    WHERE GroupPlace < 11
    GROUP BY State
        HAVING COUNT(*) > 0
    ORDER BY COUNT(*) DESC;
       
-- Q5: For each CT town with 3 or more participants in the race, report the
--     avg time of its resident runners in the race computed IN SECONDS.
--     Output the results sorted by the avg time (best avg time first).

SELECT Town, AVG(TIME_TO_SEC(RunTime))
    FROM marathon
    WHERE State = 'CT'
    GROUP BY Town
        HAVING COUNT(*) >= 3
    ORDER BY AVG(RunTime) DESC;
