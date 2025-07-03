{# Reliability analysis: Which constructors have the most mechanical failures or DNFs. #}

WITH reliability_analysis
AS(
    SELECT 
        c.const_name AS constructor_name,
        COUNT(*) AS total_races,
        COUNT(CASE WHEN s.status != 'Finished' THEN 1 END) AS dnfs,
        ROUND(COUNT(CASE WHEN s.status != 'Finished' THEN 1 END) * 100.0 / COUNT(*), 2) AS dnf_rate
    FROM {{ ref('results_stg') }} r
    JOIN {{ ref('status_stg') }} s ON r.statusId = s.statusId
    JOIN {{ ref('constructors_stg') }} c ON r.constructorId = c.constructorId
    GROUP BY c.const_name
    ORDER BY dnf_rate DESC
),
final AS (
    SELECT * FROM reliability_analysis
)
SELECT * FROM final