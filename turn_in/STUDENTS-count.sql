-- bbaiello Brady Aiello

-- Q1: Report the names of teachers who have 7-8 students students in their
--     classes. Sort output in alpha. order by teacher's last name.

SELECT t.First, t.Last
    FROM teachers t, list s
    WHERE
        s.classroom = t.classroom
    GROUP BY t.classroom
        HAVING COUNT(*) BETWEEN 7 AND 8
    ORDER BY t.Last;

-- Q2: For each grade, report the number of classrooms in which it is taught
--     and the total number of students in the grade.

SELECT s.Grade, COUNT(DISTINCT s.classroom) AS 'classrooms', 
    COUNT(*) AS 'students'
    FROM list s
    GROUP BY s.Grade
    ORDER BY s.Grade;

-- Q3: For each kindergarten classroom, report the total number of students.
--     Sort output in desc. order by num students.

SELECT s.classroom, COUNT(*) AS 'students'
    FROM list s
    WHERE s.grade = 0
    GROUP BY s.classroom;

-- Q4: For each 4th grade classroom, report the student (last name) who is 
--     last alpha on the class roster. Sort output by classroom.

SELECT DISTINCT s1.classroom, MAX(s1.LastName)
    FROM list s1
    WHERE 
        s1.grade = 4
    GROUP BY s1.classroom;
