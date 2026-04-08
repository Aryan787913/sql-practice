-- =============================================
-- DAY 05 — LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN
-- Database: dvdrental
-- Date: April 2026
-- =============================================

-- -----------------------------------------------
-- PART 1: LEFT JOIN
-- Returns ALL rows from left table + matching from right
-- -----------------------------------------------

-- Q1: Get all customers and their payments
-- (show customers even if they never paid)

select c.customer_id ,c.first_name , c.last_name ,p.amount , p.payment_date 
from customer c 
left join payment p on c.customer_id =  p.customer_id
order by c.customer_id 
limit 20;

-- Q2: Find customers who have NEVER made a payment
-- (NULL trick — very common in interviews)

select c.customer_id , c.first_name ,c.last_name 
from customer c 
left join payment p on c.customer_id = p.customer_id 
where p.customer_id is null

-- Q3: Get all films and how many times they were rented
-- (include films that were NEVER rented)

select f.film_id , f.title ,count(r.rental_id ) as total_rental
from film f
left join inventory i on f.film_id = i.film_id 
left join rental r on i.inventory_id = r.inventory_id 	
group by f.film_id , f.title 
order by total_rental asc
limit 20;

-- Q4: Find films that were NEVER rented

select f.title , r.rental_id 
from film f
left join inventory i on f.film_id = i.film_id 
left join rental r on i.inventory_id = r.inventory_id 
where r.rental_id is null
order by f.title ;


-- -----------------------------------------------
-- PART 2: RIGHT JOIN
-- Returns ALL rows from right table + matching from left
-- (less common — most people convert to LEFT JOIN)
-- -----------------------------------------------

-- Q5: Same as Q1 but written as RIGHT JOIN

select c.customer_id ,c.first_name , c.last_name ,p.amount , p.payment_date 
from  payment p
right join customer c on c.customer_id =  p.customer_id
order by c.customer_id 
limit 20;

-- Q6: Get all staff members and their rental transactions
-- (show staff even if they processed no rentals)

select s.staff_id , s.first_name , s.last_name , count(r.rental_id) as rentals_processed 
from rental r 
right join staff s  on s.staff_id = r.staff_id
group by s.staff_id 


-- -----------------------------------------------
-- PART 3: FULL OUTER JOIN
-- Returns ALL rows from BOTH tables
-- NULLs where there is no match on either side
-- -----------------------------------------------

-- Q7: Full outer join between customer and payment
-- Shows customers with no payments AND payments with no customer

select c.first_name , c.last_name , p.payment_id, p.amount 
from customer c 
full outer join payment p on c.customer_id = p.customer_id 
where c.customer_id is null or p.payment_id is null
limit 20;

-- Q8 (INTERVIEW): Which store has more customers?
-- Hint: JOIN customer with store, use COUNT and GROUP BY

select c.store_id , count(c.customer_id ) as total_customer
from customer c 
right join store s on c.store_id = s.store_id 
group by c.store_id 
order by total_customer desc


-- Q9 (INTERVIEW): List all categories and how many films
-- belong to each category — include categories with 0 films

select c.name as all_categories , count (fc.film_id ) as total_film 
from category c 
left join film_category fc on c.category_id = fc.category_id 
group by  c."name" 
order by total_film  desc

-- Q10 (INTERVIEW): Find customers who rented a film
-- but never made a payment

select c.customer_id ,c.first_name ,c.last_name 
from customer c 
inner join rental r on c.customer_id = r.customer_id 
left join payment p on r.rental_id = p.rental_id 
where p.payment_id is null

-- -----------------------------------------------
-- WHAT I LEARNED TODAY
-- -----------------------------------------------
-- LEFT JOIN  = all rows from left + matching from right
-- RIGHT JOIN = all rows from right + matching from left  
-- FULL OUTER = all rows from both tables
-- NULL trick = use WHERE right_table.id IS NULL 
--              to find non-matching rows
-- Most common in interviews: LEFT JOIN + NULL trick
-- =============================================










