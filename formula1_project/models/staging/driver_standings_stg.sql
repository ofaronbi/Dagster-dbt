WITH driver_standings_stg AS (
    SELECT
        CAST(driverStandingsId AS UNSIGNED) AS driverStandingsId,
        CAST(raceId AS UNSIGNED) AS raceId,
        CAST(driverId AS UNSIGNED) AS driverId,
        CAST(points AS DECIMAL(5,2)) AS points,
        CAST(position AS UNSIGNED) AS position,
        CAST(positionText AS CHAR(10)) AS positionText,
        CAST(wins AS UNSIGNED) AS wins,
        CURRENT_TIMESTAMP AS created_date
    FROM {{ source('formula1', 'driver_standings') }}
),
final AS (
    SELECT * FROM driver_standings_stg
)
SELECT * FROM final