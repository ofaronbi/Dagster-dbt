{# Lap time patterns: Detect fastest laps per driver per race and consistency (lapTimes). #}

WITH lap_time_patterns
AS(
    SELECT 
        d.forename AS first_name,
        d.surname AS last_name,
        lt.raceId,
        MIN(lt.milliseconds) AS best_lap_time_ms
    FROM {{ ref('lap_times_stg') }} lt
    JOIN {{ ref('drivers_stg') }} d ON lt.driverId = d.driverId
    GROUP BY d.forename, d.surname, lt.raceId
    ORDER BY best_lap_time_ms ASC
),
final AS (
    SELECT * FROM lap_time_patterns
)
SELECT * FROM final