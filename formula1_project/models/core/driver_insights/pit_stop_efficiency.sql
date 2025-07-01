{# Pit Stop Efficiency; Average duration of pit stops per driver #}

WITH pit_stop_efficiency
AS (
    SELECT 
        d.forename AS first_name,
        d.surname AS last_name,
        ROUND(AVG(p.milliseconds), 2) AS avg_pit_duration_ms
    FROM {{ ref('pit_stops_stg') }} p
    JOIN {{ ref('drivers_stg') }} d ON p.driverId = d.driverId
    GROUP BY d.forename, d.surname
    ORDER BY avg_pit_duration_ms
),
final AS (
    SELECT * FROM pit_stop_efficiency
)
SELECT * FROM final
