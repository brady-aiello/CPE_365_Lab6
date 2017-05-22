-- bbaiello Brady Aiello

-- Q1: For each pastry flavor which is found in more than 3 types of pastries
--     sold by the bakery, report the avg price of an item of this flavor and
--     the total nuber of different pastries of this flavor on the menu. Sort
--     the output in asc. order by avg. price.

SELECT Flavor, AVG(Price), COUNT(*)
    FROM goods
    GROUP BY Flavor
    HAVING COUNT(*) > 3
    ORDER BY AVG(Price);

-- Q2: Find the total amount of $ the bakery earned Oct 2007 from eclairs.

SELECT SUM(g.Price) AS 'OCT 2007 Eclair Revenue'
    FROM goods g, receipts r, items i
    WHERE
        i.Receipt = r.RNumber
        AND i.Item = g.Gid
        AND MONTH(r.SaleDate) = 10
        AND YEAR(r.SaleDate) = 2007
        AND g.Food = 'Eclair'
        ORDER BY r.SaleDate;

-- Q3: For each purchase made by NATACHA STENZ output the receipt number, the
--     date of purchase, total number of items purchased, and the amount paid.
--     Sort in desc. order of amount paid.

SELECT r.RNumber, r.SaleDate, COUNT(*) AS 'items', SUM(g.Price) AS 'total'
    FROM goods g, receipts r, items i, customers c
    WHERE 
        i.Receipt = r.RNumber
        AND i.Item = g.Gid
        AND r.Customer = c.CId
        AND c.LastName = 'STENZ'
        AND c.FirstName = 'NATACHA'
    GROUP BY r.RNumber
    ORDER BY SUM(g.Price) DESC;

-- Q4: For each day of the week of Oct 8 (Mon - Sun) report the tot. num
--     purchases(receipts) , tot pastries purchased, and overal daily revenue.
--     Report results in chron. order and include both the day of the week
--     and the date.

SELECT DATE_FORMAT(r.SaleDate, '%a') AS 'day', r.SaleDate AS 'date', 
    COUNT(*) AS 'purchases', SUM(g.Price) AS 'revenue'
    FROM goods g, receipts r, items i, customers c
    WHERE 
        i.Receipt = r.RNumber
        AND i.Item = g.Gid
        AND r.Customer = c.CId
        AND r.SaleDate BETWEEN '2007-10-08' AND '2007-10-14'
    GROUP BY r.SaleDate;

-- Q5: Report all day on which more than 10 tarts were purchased, sorted in
--     chrono. order.

SELECT r.SaleDate
    FROM goods g, receipts r, items i, customers c
    WHERE 
        i.Receipt = r.RNumber
        AND i.Item = g.Gid
        AND r.Customer = c.CId
        AND g.Food = 'Tart'
    GROUP BY r.SaleDate
        HAVING COUNT(*) > 10;
