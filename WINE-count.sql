-- bbaiello Brady Aiello

-- Q1: For each wine score value above 88, report average price, the cheapest
--     price and the most expensive price for a bottle of wine with that score
--     (for all vintage years combined), the total number of wines with that
--     score and the total number of cases produced. Sort by the wine score.

-- SELECT w.Score, AVG(w.Price), MIN(w.Price), MAX(w.Price), COUNT(*),
--     SUM(w.Cases)
--     FROM wine w
--     WHERE w.Score > 88
--     GROUP BY w.Score
--     ORDER BY w.Score;
 
-- Q2: For each year, report the total number of red Sonoma County wines
--     whose scores are 90 or above. Output in chronological order.

-- SELECT wine.Vintage, Count(*)
--     FROM wine, appellations ap, grapes g
--     WHERE wine.Appellation = ap.Appellation
--     AND wine.Grape = g.Grape AND g.Color = 'red'
--     AND ap.County = 'Sonoma' AND wine.Score >= 90
--     GROUP BY wine.Vintage
--     ORDER BY wine.Vintage;

-- Q3: For each appellation that produced more than two Cabernet Sauvingnon
--     wines in 2007 report its name and county, the total number of Cabernet
--     Sauvingnon wines produced in 2008, the average price of a bottle
--     of Cabernet Sauvingnon from that vintage, and the total (known)
--     number of bottles produced. Sort output in descending order by the
--     number of wines.

SELECT
    FROM wine, appellations ap
    WHERE wine.Appellation = ap.Appellation

