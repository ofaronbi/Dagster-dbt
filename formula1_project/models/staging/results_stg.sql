WITH results_stg AS (
    SELECT
        CAST(resultId AS UNSIGNED) AS resultId,
        CAST(raceId AS UNSIGNED) AS raceId,
        CAST(driverId AS UNSIGNED) AS driverId,
        CAST(constructorId AS UNSIGNED) AS constructorId,
        CASE 
            WHEN TRIM(`number`) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(`number` AS UNSIGNED) 
        END AS results_number,
        CASE 
            WHEN TRIM(grid) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(grid AS UNSIGNED) 
        END AS grid,
        CASE 
            WHEN TRIM(position) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(position AS CHAR(25)) 
        END AS position,
        CAST(positionText AS CHAR(5)) AS positionText,
        CASE 
            WHEN TRIM(positionOrder) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(positionOrder AS UNSIGNED) 
        END AS positionOrder,
        CASE 
            WHEN TRIM(laps) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(laps AS UNSIGNED) 
        END AS laps,
        CAST(points AS DECIMAL(5,2)) AS points,
        CASE 
            WHEN TRIM(`time`) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(`time` AS CHAR(25)) 
        END AS results_time,
        CASE 
            WHEN TRIM(milliseconds) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(milliseconds AS CHAR(25)) 
        END AS milliseconds,
        CASE 
            WHEN TRIM(fastestLap) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(fastestLap AS CHAR(25)) 
        END AS fastestLap,
        CASE 
            WHEN TRIM(`rank`) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(`rank` AS CHAR(25)) 
        END AS results_rank,
        CASE 
            WHEN TRIM(fastestLapTime) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(fastestLapTime AS CHAR(25)) 
        END AS fastestLapTime,
        CASE 
            WHEN TRIM(fastestLapSpeed) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(fastestLapSpeed AS CHAR(25)) 
        END AS fastestLapSpeed,
        CASE 
            WHEN TRIM(statusId) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(statusId AS CHAR(25)) 
        END AS statusId,
        CURRENT_TIMESTAMP AS created_date
    FROM {{ source('formula1', 'results') }}
),
final AS (
    SELECT * FROM results_stg
)
SELECT * FROM final