/*
 * Compute the total revenue for each film.
 * The output should include a new column "rank" that shows the numerical rank
 *
 * HINT:
 * You should use the `rank` window function to complete this task.
 * Window functions are conceptually simple,
 * but have an unfortunately clunky syntax.
 * You can find examples of how to use the `rank` function at
 * <https://www.postgresqltutorial.com/postgresql-window-function/postgresql-rank-function/>.
 */

SELECT rank() OVER (ORDER BY revenue DESC) AS rank, title, revenue
FROM (
    SELECT f.title, coalesce(sum(p.amount), 0.00) AS revenue
    FROM film f
    LEFT JOIN inventory i USING (film_id)
    LEFT JOIN rental r USING (inventory_id)
    LEFT JOIN payment p USING (rental_id)
    GROUP BY f.film_id, f.title
) t
ORDER BY rank, title;
