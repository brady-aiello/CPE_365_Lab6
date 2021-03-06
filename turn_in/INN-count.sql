-- bbaiello Brady Aiello

-- Q1: For each room report the total revenue for all stays and the average
--     revenue per stay generated by stays in the room that originated in
--     the months of Sept, Oct, and Nov. Sort output in desc. order by total
--     revenue.

SELECT rooms.RoomCode, rooms.RoomName, 
        ROUND(SUM((res.Checkout - res.CheckIn) * res.Rate), 2)
            AS 'total revenue', 
        ROUND(AVG((res.Checkout - res.CheckIn) * res.Rate), 2)
            AS 'avg revenue' 
    FROM rooms, reservations res
    WHERE res.Room = rooms.RoomCode
    AND MONTH(res.CheckIn) IN (9, 10, 11)
    GROUP BY res.Room
    ORDER BY SUM((res.Checkout - res.CheckIn) * res.Rate) DESC;
 
-- Q2: Report the total number of reservations that commenced on Fridays
--     and the total revenue they brought in. (Hint: look up the date of 
--     the first Friday on the calendar).

SELECT COUNT(*) AS 'friday reservations', 
    SUM((res.Checkout - res.CheckIn) * res.Rate) AS 'total revenue'
    FROM rooms, reservations res
    WHERE res.Room = rooms.RoomCode
        AND DATE_FORMAT(res.CheckIn, '%a') = 'Fri'
    ORDER BY res.Checkin;

-- Q3: For each day of the week, report the total number of reservations
--     commenced on it and the total revenue these reservations brought.
--     Report days of week as Monday, Tuesday, etc.

SELECT DATE_FORMAT(res.CheckIn, '%a') AS' day', COUNT(*) AS 'reservations', 
    ROUND(SUM((res.Checkout - res.CheckIn) * res.Rate), 2) AS 'total revenue'
    FROM rooms, reservations res
    WHERE res.Room = rooms.RoomCode
    GROUP BY DATE_FORMAT(res.CheckIn, '%a')
    ORDER BY FIELD(day, '%a', 'Mon', 'Tue', 'Wed', 
            'Thu', 'Fri', 'Sat', 'Sun');
 
-- Q4: For each room report the highest markup against the base price and
--     the smallest markup (i.e., largest markdown). Report markups and
--     markdowns in absolute terms (absolute difference between the base
--     price and the rate). Sort output in descending order by the absolute
--     value of the largest markup. Report full names of the rooms.

SELECT rooms.RoomName,
        ROUND(ABS(MAX(res.Rate - rooms.basePrice)), 2) AS 'Max Mark up',
        ROUND(ABS(MAX(rooms.basePrice - res.Rate)), 2) AS 'Max Mark down'
    FROM rooms, reservations res
    WHERE res.Room = rooms.RoomCode
    GROUP BY rooms.RoomCode
    ORDER BY ABS(MAX(res.Rate - rooms.basePrice)) DESC;

-- Q5: For each room report how many nights in 2010 the room was occupied.
--     Report the room code, the full name of the room and the number of
--     occupied nights. Sort in descending order by occupied nights. (Note:
--     it has to be number of nights in 2010 - the last reservation in each
--     room may and will can go beyond December 31, 2010, so the ”extra”
--     nights in 2011 need to be deducted).

SELECT rooms.RoomName,
        SUM(1 + (LEAST(res.Checkout, DATE('2010-12-31')) - 
        GREATEST(res.Checkin, DATE('2010-01-01')))) as 'nights occupied 2010' 
    FROM rooms, reservations res
    WHERE res.Room = rooms.RoomCode
    GROUP BY rooms.RoomCode
    ORDER BY 
        SUM(1 + (LEAST(res.Checkout, DATE('2010-12-31')) - 
        GREATEST(res.Checkin, DATE('2010-01-01')))) DESC; 
