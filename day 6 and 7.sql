
-- Q1. Get the first name, last name and email 
-- of all customers who are active (active = 1)
-- ordered by last name A to Z
select c.first_name , c.last_name , c.email  
from customer c 
where active = 1
order by last_name asc;

-- Q2. How many films are in each rating category?
-- (G, PG, PG-13, R, NC-17)
-- Show rating and total count
-- Order by total films highest first
select rating ,count(*)as total_film
from film
where rating in ('G', 'PG', 'PG-13', 'R', 'NC-17')
GROUP BY rating
order by total_film desc;

-- Q3. What is the average rental rate for all films?
-- Round to 2 decimal places

select avg(round(rental_rate ))
from film



-- Q4. Get all films that have a rental rate 
-- greater than the average rental rate
-- Show title and rental rate
-- Order by rental rate DESC
-- (HINT: use a subquery for average)

select *
from film f
where rental_rate > (select avg(rental_rate)from film f)
order by f.rental_rate desc


-- Q5. List all customers from store 1
-- Show first name, last name, email
-- Order by last name
select * from customer;
select first_name, last_name, email
from customer 
where store_id = 1 
order by last_name;


-- Q6. How many customers does each store have?
-- Show store_id and customer count 

select store_id , count(*) as total_customer
from customer c 
group by store_id 
order by total_customer desc;


-- Q7. Get all unique film ratings available
-- in the database
-- (use DISTINCT)

select distinct (rating)
from film

-- Q8. Show the top 10 most expensive films to rent
-- Show title and rental_rate
-- Order by rental_rate DESC

select title , rental_rate
from film f   
order by rental_rate desc
limit 10;


-- Q9. How many films have a rental duration 
-- of more than 5 days?

select count (*)
from film
where rental_duration > 5;

-- Q10. Get all customers whose first name 
-- starts with 'A'
-- Order by first name

select * 
from customer c 
where first_name like  'A%'
order by first_name;


-- ============================================
-- MEDIUM (Questions 11-22)
-- Multiple concepts combined
-- ============================================

-- Q11. Find the total amount paid by each customer
-- Show customer_id, first name, last name, total paid
-- Only show customers who paid more than ₹150 total
-- Order by total paid DESC
-- (HINT: JOIN customer + payment, GROUP BY, HAVING)

select c.customer_id, c.first_name , c.last_name name,  sum(amount) as total_paid
from customer c 
inner join payment p on c.customer_id = p.customer_id
group by c.customer_id,c.first_name, 
    c.last_name
    having sum(p.amount )> 150
order by total_paid desc;

-- Q12. Which film category has the most films?
-- Show category name and film count
-- Show only top 3 categories

select c.name as category_name, count(c.category_id) as film_count
from category c
inner join film_category fc  on c.category_id = fc.category_id
group by c.name  
order by film_count desc
limit 3;

select * from category ;


-- Q13. Get all films that have NEVER been rented
-- Show film title
-- (HINT: LEFT JOIN film → inventory → rental, 
--  look for NULL)

select * from film;
select * from inventory;
select * from rental;

select f.title  
from film f 
left join inventory i on f.film_id = i.film_id 
left join rental r on i.inventory_id = r.inventory_id 
where r.rental_id = null 
;


-- Q14. Find all customers who have rented 
-- more than 30 films total
-- Show first name, last name, total rentals
select * from customer;
select * from rental;

select c.first_name, c.last_name, count(r.rental_id ) as total_rentals
from customer c 
inner join rental r on c.customer_id = r.customer_id 
GROUP BY 
    c.customer_id, 
    c.first_name, 
    c.last_name
   having count(rental_id) > 30
   order by total_rentals;


-- Q15. Show all staff members and the total 
-- amount of payments they processed
-- Show staff first name, last name, total amount

select * from staff s ;
select * from payment p ;

select s.first_name , s.last_name , sum(p.amount ) as total_amount
from staff s 
inner join payment p on s.staff_id = p.staff_id
group by s.first_name , s.last_name;

-- Q16. Using UNION, combine a list of:
-- - All customer first names from store 1
-- - All customer first names from store 2
-- Remove duplicates
-- Order alphabetically
select * from store s ;


select first_name 
from customer c  
where store_id = 1
union 
select first_name
from customer c 
where store_id = 2
;


-- Q17. Using UNION ALL, combine:
-- - First and last name of all customers
-- - First and last name of all staff
-- Keep duplicates, label each row with 
-- 'customer' or 'staff'
	-- (HINT: add a literal column 'customer' 
	--  and 'staff')

select first_name, last_name, 'Customer' as person_type
from customer c 

union all

select first_name, last_name, 'staff' as person_type
from staff s 

-- Q18. Find films that are in BOTH the 
-- 'Action' AND 'Drama' categories
-- (HINT: use INTERSECT or subquery)

SELECT f.title 
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action'

INTERSECT

SELECT f.title 
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Drama';



-- Q19. Using EXCEPT, find customers who 
-- have made a rental but have NOT made 
-- any payment
-- (HINT: SELECT customer_id FROM rental
--  EXCEPT SELECT customer_id FROM payment) 


























