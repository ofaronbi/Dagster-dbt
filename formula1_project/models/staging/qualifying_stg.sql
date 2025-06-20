WITH qualifying_stg AS (
    SELECT
        CAST(qualifyId AS UNSIGNED) AS qualifyId,
        CAST(raceId AS UNSIGNED) AS raceId,
        CAST(driverId AS UNSIGNED) AS driverId,
        CAST(constructorId AS UNSIGNED) AS constructorId,
        CAST(`number` AS UNSIGNED) AS qualifying_number,
        CAST(position AS UNSIGNED) AS position,
        CASE 
            WHEN TRIM(q1) IN ('\\N', '-', '') THEN NULL
                ELSE CAST(q1 AS CHAR(25))
                END AS q1,
        CASE 
            WHEN TRIM(q2) IN ('\\N', '-', '') THEN NULL
                ELSE CAST(q2 AS CHAR(25))
                END AS q2,
        CASE 
            WHEN TRIM(q3) IN ('\\N', '-', '') THEN NULL
                ELSE CAST(q3 AS CHAR(25))
                END AS q3,
        CURRENT_TIMESTAMP AS created_date
    FROM {{ source('formula1', 'qualifying') }}
),
final AS (
    SELECT * FROM qualifying_stg
)
SELECT * FROM final