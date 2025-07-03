{# Constructor rankings: Based on constructorStandings or constructorResults. #}

WITH constructor_insights
AS(
    SELECT 
        cs.constructorId,
        c.const_name AS constructor_name,
        r.race_year,
        SUM(cs.points) AS total_points,
        SUM(cs.wins) AS total_wins
    FROM {{ ref('constructor_standings_stg') }} cs
    JOIN {{ ref('constructors_stg') }} c ON cs.constructorId = c.constructorId
    JOIN {{ ref('race_stg') }} r ON cs.raceId = r.raceId
    GROUP BY cs.constructorId, c.const_name, r.race_year
    ORDER BY r.race_year, total_points DESC
),
final AS (
    SELECT * FROM constructor_insights
)
SELECT * FROM final

