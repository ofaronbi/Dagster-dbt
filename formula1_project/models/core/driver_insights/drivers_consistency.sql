{# Drivers consistency; How often a driver finishes vs. DNFs #}

WITH drivers_consistency
AS (
    SELECT 
        d.forename AS first_name,
        d.surname AS last_name,
        COUNT(*) AS total_races,
        COUNT(CASE WHEN s.status = 'Finished' THEN 1 END) AS finishes,
        COUNT(CASE WHEN s.status != 'Finished' THEN 1 END) AS dnfs,
        ROUND(COUNT(CASE WHEN s.status = 'Finished' THEN 1 END) * 100.0 / COUNT(*), 2) AS finish_rate
    FROM {{ ref('results_stg') }} r
    JOIN {{ ref('drivers_stg') }} d ON r.driverId = d.driverId
    JOIN {{ ref('status_stg') }} s ON r.statusId = s.statusId
    GROUP BY d.forename, d.surname
    ORDER BY finish_rate DESC

),
final AS (
    SELECT * FROM drivers_consistency
)
SELECT * FROM final