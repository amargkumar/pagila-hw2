/*
 * Count the number of movies that contain each type of special feature.
 * Order the results alphabetically be the special_feature.
 */

SELECT sf AS special_features, count(*)
FROM film, unnest(special_features) AS sf
GROUP BY sf
ORDER BY sf;
