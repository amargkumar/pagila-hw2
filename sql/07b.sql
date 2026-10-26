/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */


SELECT DISTINCT f.title
FROM film f
JOIN inventory i USING (film_id)
LEFT JOIN (
    SELECT DISTINCT inv.film_id
    FROM inventory inv
    JOIN rental r USING (inventory_id)
    JOIN customer cu USING (customer_id)
    JOIN address a USING (address_id)
    JOIN city ci USING (city_id)
    JOIN country co USING (country_id)
    WHERE co.country = 'United States'
) us ON f.film_id = us.film_id
WHERE us.film_id IS NULL
ORDER BY f.title;
