-- bbaiello Brady Aiello

-- Q1: For each performer (use first name) report how many times she sang
--     lead vocals on a song. Sort output in descending order by the number
--     of leads.

SELECT Band.Firsname, COUNT(*) AS 'times singing lead'
    FROM Vocals, Band
    WHERE Vocals.Bandmate = Band.Id
        AND Vocals.VocalType = 'lead'
    GROUP BY Band.Id
    ORDER BY COUNT(*) DESC;

-- Q2: Report how many different unique instruments each performer plays
--     on songs from ’Le Pop’. Sort the output by the first name of the
--     performers.

SELECT b.FirsName, COUNT(DISTINCT i.Instrument) AS 'instruments'
    FROM Songs, Albums a, Instruments i, Band b, Tracklists tl
    WHERE
        i.Song = Songs.SongId
        AND i.Bandmate = b.Id
        AND tl.Song = Songs.SongId
        AND tl.Album = a.AId
        AND a.Title = 'Le Pop'
    GROUP BY b.Id
    ORDER BY b.FirsName;

-- Q3: Report the number of times Turid stood at each stage position when
--     performing live. Sort output in ascending order of the number of times
--     she performed in each position.

SELECT p.StagePosition, COUNT(*) AS 'times in pos.'
    FROM Performance p, Band b
    WHERE p.Bandmate = b.Id
        AND b.FirsName = 'Turid'
    GROUP BY p.StagePosition
    ORDER BY COUNT(*);

-- Q4: Report how many times each of the remaining peformers played bass
--     balalaika on the songs where Anne-Marit was positioned on the left
--     side of the stage. Sort output alphabetically by the name of the 
--     performer.

SELECT br.FirsName, COUNT(pr.Song) AS 'songs'
    FROM Performance pam, Performance pr, Band bam, Band br, Instruments i
    WHERE pam.Bandmate = bam.Id
        AND pam.StagePosition = 'left'
        AND bam.FirsName = 'Anne-Marit'
        AND pam.Song = pr.Song
        AND pr.Bandmate <> pam.Bandmate
        AND pr.Bandmate = br.Id
        AND i.Bandmate = pr.Bandmate
        AND pr.Song = i.Song
        AND i.Instrument = 'bass balalaika'
    GROUP BY br.Id
    ORDER BY br.FirsName;

-- Q5:  Report all instruments (in alphabetical order) that were played by
--      three or more people.

SELECT DISTINCT i.Instrument
    FROM Instruments i, Band
    WHERE i.Bandmate = Band.Id
    GROUP BY i.Instrument
        HAVING COUNT(i.Bandmate) >= 3
    ORDER BY i.Instrument;
 
-- Q6: For each performer, report the number of times they played more than
--     one instrument on the same song. Sort output in alphabetical order
--     by first name of the performer.

SELECT b.FirsName, COUNT(*) AS 'times played > 1 instrument on 1 song'
    FROM Band b, Instruments i1, Instruments i2
    WHERE
        i1.Bandmate = b.Id AND i2.Bandmate = b.Id
        AND i1.Instrument < i2.Instrument
        AND i1.Song = i2.Song
    GROUP BY b.Id
    ORDER BY b.FirsName;
