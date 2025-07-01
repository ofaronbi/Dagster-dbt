{# Fastest Lap Trends; Fastest lap per driver per race #}

WITH fastest_lap_trends
AS (
    SELECT 
        d.forename AS first_name,
        d.surname AS last_name,
        ra.race_year,
        ROUND(AVG(CAST(r.fastestLapSpeed AS DECIMAL(6,2))), 2) AS avg_fastest_lap_speed
    FROM {{ ref('results_stg') }} r
    JOIN {{ ref('drivers_stg') }} d ON r.driverId = d.driverId
    JOIN {{ ref('race_stg') }} ra ON r.raceId = ra.raceId
    WHERE r.fastestLapSpeed IS NOT NULL
    GROUP BY d.forename, d.surname, ra.race_year
    ORDER BY avg_fastest_lap_speed DESC

),
final AS (
    SELECT * FROM fastest_lap_trends
)
SELECT * FROM final