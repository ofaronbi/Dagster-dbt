WITH pit_stops_stg AS (
    SELECT
        CAST(raceId AS UNSIGNED) AS raceId,
        CAST(driverId AS UNSIGNED) AS driverId,
        CAST(`stop` AS UNSIGNED) AS pit_stop,
        CAST(lap AS UNSIGNED) AS lap,
        CAST(`time` AS CHAR(25)) AS pit_time,
        CAST(duration AS CHAR(25)) AS duration,
        CAST(milliseconds AS UNSIGNED) AS milliseconds,
        CURRENT_TIMESTAMP AS created_date
    FROM {{ source('formula1', 'pit_stops') }}
),
final AS (
    SELECT * FROM pit_stops_stg
)
SELECT * FROM final