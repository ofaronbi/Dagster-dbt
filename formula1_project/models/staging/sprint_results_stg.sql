WITH sprint_results_stg AS (
    SELECT
        CAST(resultId AS UNSIGNED) AS sprint_resultId,
        CAST(raceId AS UNSIGNED) AS raceId,
        CAST(driverId AS UNSIGNED) AS driverId,
        CAST(constructorId AS UNSIGNED) AS constructorId,
        CASE 
            WHEN TRIM(`number`) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(`number` AS UNSIGNED) 
        END AS sprint_rst_number,
        CASE 
            WHEN TRIM(grid) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(grid AS UNSIGNED) 
        END AS grid,
        CASE 
            WHEN TRIM(position) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(position AS UNSIGNED) 
        END AS position,
        CAST(positionText AS CHAR(5)) AS positionText,
        CASE 
            WHEN TRIM(positionOrder) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(positionOrder AS UNSIGNED) 
        END AS positionOrder,
        CAST(points AS DECIMAL(5,2)) AS points,
        CASE 
            WHEN TRIM(laps) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(laps AS UNSIGNED) 
        END AS laps,
        CAST(`time` AS CHAR(25)) AS sprint_rst_time,
        CASE 
            WHEN TRIM(milliseconds) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(milliseconds AS UNSIGNED) 
        END AS milliseconds,
        CASE 
            WHEN TRIM(fastestLap) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(fastestLap AS UNSIGNED) 
        END AS fastestLap,
        CAST(fastestLapTime AS CHAR(25)) AS fastestLapTime,
        CASE 
            WHEN TRIM(statusId) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(statusId AS UNSIGNED) 
        END AS statusId,
        CURRENT_TIMESTAMP AS created_date
    FROM {{ source('formula1', 'sprint_results') }}
),
final AS (
    SELECT * FROM sprint_results_stg
)
SELECT * FROM final