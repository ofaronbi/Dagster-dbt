{# Qualifying consistency: Track driver/team performance across Q1, Q2, Q3 sessions. #}

WITH qualifying_consistency
AS(
    SELECT 
        c.const_name AS constructor_name,
        d.forename AS first_name,
        d.surname AS last_name,
        ROUND(AVG(CAST(q.q1 AS DECIMAL(6,3))), 3) AS avg_q1_time,
        ROUND(AVG(CAST(q.q2 AS DECIMAL(6,3))), 3) AS avg_q2_time,
        ROUND(AVG(CAST(q.q3 AS DECIMAL(6,3))), 3) AS avg_q3_time
    FROM {{ ref('qualifying_stg') }} q
    JOIN {{ ref('drivers_stg') }} d ON q.driverId = d.driverId
    JOIN {{ ref('constructors_stg') }} c ON q.constructorId = c.constructorId
    WHERE q.q1 IS NOT NULL AND q.q1 != '\\N'
    GROUP BY c.const_name, d.forename, d.surname
    ORDER BY avg_q1_time
),
final AS (
    SELECT * FROM qualifying_consistency
)
SELECT * FROM final