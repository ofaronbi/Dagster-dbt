WITH race_stg AS (
    SELECT
        CAST(raceId AS UNSIGNED) AS raceId,
        CAST(`year` AS CHAR(50)) AS race_year,
        CAST(round AS SIGNED) AS round,
        CAST(circuitID AS SIGNED) AS circuitID,
        CAST(`name` AS CHAR(50)) AS race_name,
        CAST(`date` AS DATE) AS race_date,
        CAST(`time` AS CHAR(50)) AS race_time,
        CURRENT_TIMESTAMP AS created_date
    FROM {{ source('formula1', 'races') }}
),
final AS (
    SELECT * FROM race_stg
)
SELECT * FROM final