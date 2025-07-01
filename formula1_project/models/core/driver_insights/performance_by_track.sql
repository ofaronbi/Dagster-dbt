{# Performance by track: Which circuits each driver performs best or worst on #}

WITH Performance_by_track
AS (
    SELECT 
        d.forename AS first_name,
        d.surname AS last_name,
        c.circuit_name,
        ROUND(AVG(r.positionOrder), 2) AS avg_finish_position
    FROM {{ ref('results_stg') }} r
    JOIN {{ ref('drivers_stg') }} d ON r.driverId = d.driverId
    JOIN {{ ref('race_stg') }} ra ON r.raceId = ra.raceId
    JOIN {{ ref('circuits_stg') }} c ON ra.circuitId = c.circuitId
    GROUP BY d.forename, d.surname, c.circuit_name
    ORDER BY avg_finish_position 

),
final AS (
    SELECT * FROM Performance_by_track
)
SELECT * FROM final