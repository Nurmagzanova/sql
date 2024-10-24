-- Вставка уникальных артистов
INSERT INTO Artists (artist)
SELECT DISTINCT artist
FROM cleaned_data
WHERE artist IS NOT NULL;

-- Вставка уникальных городов
INSERT INTO Cities (city)
SELECT DISTINCT cd."City"
FROM cleaned_data cd
WHERE cd."City" IS NOT NULL;

-- Вставка уникальных жанров
INSERT INTO Genres (genre)
SELECT DISTINCT genre
FROM cleaned_data
WHERE genre IS NOT NULL;

-- Вставка уникальных треков и жанров
INSERT INTO Tracks (track, genreid)
SELECT DISTINCT cd."Track", g.id
FROM cleaned_data cd
JOIN Genres g ON cd.genre = g.genre
WHERE cd."Track" IS NOT NULL;

-- Вставка уникальных пользователей и городов
INSERT INTO Users (CityID, userID)
SELECT DISTINCT c.ID, cd."userID"
FROM cleaned_data cd
JOIN Cities c ON cd."City" = c.city
WHERE cd."userID" IS NOT NULL;

-- Вставка уникальных дней
INSERT INTO Dayes (day)
SELECT DISTINCT TO_DATE(cd."Report_date", 'MM/DD/YYYY') 
FROM cleaned_data cd
WHERE cd."Report_date" IS NOT NULL;

-- Вставка данных о прослушивании
INSERT INTO Listening (userID, artistID, trackID, dayID, timme, report_date)
SELECT 
    u.ID, 
    a.ID AS artistID, 
    t.ID AS trackID, 
    d.ID AS dayID, 
    -- Преобразование времени
    (FLOOR(CAST(cd.time AS numeric)) || ':' || ((CAST(cd.time AS numeric) - FLOOR(CAST(cd.time AS numeric))) * 60)::integer || ':00')::time AS timme,
    TO_DATE(cd."Report_date", 'MM/DD/YYYY') AS report_date
FROM 
    cleaned_data cd
JOIN 
    Users u ON cd."userID" = u.userID  
JOIN 
    Artists a ON cd.artist = a.artist
JOIN 
    Tracks t ON cd."Track" = t.track
JOIN 
    Dayes d ON TO_DATE(cd."Report_date", 'MM/DD/YYYY') = d.day
WHERE 
    cd."userID" IS NOT NULL 
    AND cd.artist IS NOT NULL 
    AND cd."Track" IS NOT NULL 
    AND cd."Report_date" IS NOT NULL
    -- Условие на фильтрацию времени, исключающее некорректные значения
    AND cd.time ~ '^[0-9]+(\.[0-9]+)?$';

-- Выборка данных для проверки
SELECT * FROM Listening LIMIT 10;