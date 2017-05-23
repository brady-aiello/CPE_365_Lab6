-- bbaiello Brady Aiello

-- Q1: Find all airports with exactly 17 outgoing flights. Report airport code
--     and the full name of the airport sorted in alphabetical order by the
--     code.

SELECT ap.Code, ap.Name
    FROM airports ap, flights f
    WHERE 
        f.Source = ap.Code
    GROUP BY ap.Code
        HAVING COUNT(*) = 17
    ORDER BY ap.Code;

-- Q2: Find the number of airports from which airport ANP can be reached with
--     exactly 1 transfer.  (make sure to exclude ANP itself from the count).
--     Report just the number.

SELECT COUNT(DISTINCT f1.Source)
    FROM flights f1, flights f2
    WHERE
        f2.Destination = 'ANP' AND f2.Source = f1.Destination
        AND f1.Source <> 'ANP' AND f1.Destination <> 'ANP';
 
-- Q3: Find the number of airports from which airport ATE can be reached with
--     AT MOST one transfer. (make sure to exclude ATE itself from the count)

SELECT COUNT(DISTINCT f1.Source)
    FROM flights f1, flights f2
    WHERE
        f2.Destination = 'ATE' 
        AND (f2.Source = f1.Destination AND f1.Source <> 'ATE' 
            AND f1.Destination <> 'ATE')
        OR (f1.Destination = 'ATE')
    ORDER BY f1.Source;
 
-- Q4: For each airline report the total number of airports from which it has
--     at least one outgoing flight. Report the full name of the airline and
--     the number of airports computed. Report the results sorted by the 
--     number of airports in descending order.

SELECT DISTINCT al.Name, COUNT(DISTINCT f.Source)
    FROM airlines al, airports ap, flights f
    WHERE f.Airline = al.Id
        AND ap.Code = f.Source
    GROUP BY al.Id
        HAVING COUNT(DISTINCT f.Source) > 0;
