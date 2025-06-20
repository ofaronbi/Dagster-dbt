WITH lap_times_stg AS (
    SELECT
        CAST(raceId AS UNSIGNED) AS raceId,
        CAST(driverId AS UNSIGNED) AS driverId,
        CAST(lap AS UNSIGNED) AS lap,
        CAST(position AS UNSIGNED) AS position,
        CAST(`time` AS CHAR(25)) AS lap_time,
        CAST(milliseconds AS UNSIGNED) AS milliseconds,
        CURRENT_TIMESTAMP AS created_date
    FROM {{ source('formula1', 'lap_times') }}
),
final AS (
    SELECT * FROM lap_times_stg
)
SELECT * FROM final
