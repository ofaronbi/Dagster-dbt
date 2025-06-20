WITH constructor_standings_stg AS (
    SELECT
        CAST(constructorStandingsId AS UNSIGNED) AS constructorStandingsId,
        CAST(raceId AS UNSIGNED) AS raceId,
        CAST(constructorId AS UNSIGNED) AS constructorId,
        CAST(points AS DECIMAL(5,2)) AS points,
        CAST(position AS UNSIGNED) AS position,
        CAST(positionText AS CHAR(10)) AS positionText,
        CAST(wins AS UNSIGNED) AS wins,
        CURRENT_TIMESTAMP AS created_date
    FROM {{ source('formula1', 'constructor_standings') }}
),
final AS (
    SELECT * FROM constructor_standings_stg
)
SELECT * FROM final
