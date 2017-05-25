-- bbaiello Brady Aiello

-- Q1: For each wine score value above 88, report average price, the cheapest
--     price and the most expensive price for a bottle of wine with that score
--     (for all vintage years combined), the total number of wines with that
--     score and the total number of cases produced. Sort by the wine score.

SELECT w.Score, ROUND(AVG(w.Price), 2), MIN(w.Price), MAX(w.Price), 
    COUNT(*) AS 'num wines',
    SUM(w.Cases)
    FROM wine w
    WHERE w.Score > 88
    GROUP BY w.Score
    ORDER BY w.Score;
 
-- Q2: For each year, report the total number of red Sonoma County wines
--     whose scores are 90 or above. Output in chronological order.

SELECT wine.Vintage, Count(*) AS 'wines'
    FROM wine, appellations ap, grapes g
    WHERE wine.Appellation = ap.Appellation
        AND wine.Grape = g.Grape AND g.Color = 'red'
        AND ap.County = 'Sonoma' AND wine.Score >= 90
    GROUP BY wine.Vintage
    ORDER BY wine.Vintage;

-- Q3: For each appellation that produced more than two Cabernet Sauvingnon
--     wines in 2007 report its name and county, the total number of Cabernet
--     Sauvingnon wines produced in 2008, the average price of a bottle
--     of Cabernet Sauvingnon from that vintage, and the total (known)
--     number of bottles produced. Sort output in descending order by the
--     number of wines.

SELECT DISTINCT ap.Appellation, ap.County, COUNT(DISTINCT w8.WineId) 
        AS 'wines',
        AVG(w8.Price) AS 'Avg Price',
        FLOOR(SUM(w8.Cases * 12) / 
            COUNT(DISTINCT w1.WineId, w2.WineId, w3.WineId)) AS 'bottles'
    FROM wine w1, appellations ap, wine w2, wine w3, wine w8
    WHERE
        w1.Appellation = ap.Appellation
        AND w8.Grape = 'Cabernet Sauvingnon'
        AND w3.Grape = w8.Grape
        AND w1.Grape = w2.Grape AND w1.Grape = w8.Grape
        AND w1.Appellation = ap.Appellation
        AND w2.Appellation = ap.Appellation
        AND w3.Appellation = ap.Appellation
        AND w1.WineId < w2.WineId AND w2.WineId < w3.WineId
        AND w1.Vintage = 2007 AND w1.Vintage = w2.Vintage
        AND w3.Vintage = w1.Vintage
        AND w8.Vintage = 2008
        AND w8.Appellation = ap.Appellation
    GROUP BY ap.Appellation
    ORDER BY COUNT(DISTINCT w8.WineId)  DESC;

-- Q4: For each appellation inside Central Coast compute the total (known)
--     sales volume that it can generate for the wines produced in 2008. Sort
--     the output in descending order by the total sales volume. (Note: recall
--     what a case of wine is).

SELECT ap.Appellation, SUM(w.Price * w.Cases * 12) AS 'potential revenue'
    FROM
        appellations ap, wine w
    WHERE ap.Area = 'Central Coast'
        AND w.Appellation = ap.Appellation
        AND w.Vintage = 2008
    GROUP BY w.appellation
    ORDER BY SUM(w.Price * w.Cases * 12) DESC;

-- Q5: For each county in the database, report the score of the highest ranked
--     2009 red wine. Exclude wines that do not have a county of origin
--     (’N/A’). Sort output in descending order by the best score.

SELECT ap.County, MAX(w.Score) AS 'top score of 2009 red wine'
    FROM appellations ap, wine w, grapes g
    WHERE w.Appellation = ap.Appellation
        AND ap.County <> 'N/A'
        AND w.Vintage = 2009
        AND w.Grape = g.Grape
        AND g.Color = 'red'
    GROUP BY ap.County
    ORDER BY MAX(w.Score) DESC;

