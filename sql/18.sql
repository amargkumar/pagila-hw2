/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */

SELECT rank,
       title,
       revenue,
       "total revenue",
       to_char(100 * "total revenue" / (SELECT sum(revenue) FROM
            (SELECT coalesce(sum(p.amount),0) AS revenue
             FROM film f
             LEFT JOIN inventory i USING (film_id)
             LEFT JOIN rental r USING (inventory_id)
             LEFT JOIN payment p USING (rental_id)
             GROUP BY f.film_id) s), 'FM900.00') AS "percent revenue"
FROM (
    SELECT rank() OVER (ORDER BY revenue DESC) AS rank,
           title,
           revenue,
           sum(revenue) OVER (ORDER BY revenue DESC) AS "total revenue"
    FROM (
        SELECT f.title, coalesce(sum(p.amount), 0.00) AS revenue
        FROM film f
        LEFT JOIN inventory i USING (film_id)
        LEFT JOIN rental r USING (inventory_id)
        LEFT JOIN payment p USING (rental_id)
        GROUP BY f.film_id, f.title
    ) t
) u
ORDER BY rank, title;
