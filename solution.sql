                           -- Lab | SQL Self and cross join
						   
-- In this lab, you will be using the Sakila database of movie rentals.
-- Instructions

    use sakila;


-- Get all pairs of actors that worked together
 
  select concat(ac.first_name, ' ', ac.last_name) as actor_1,
  	     concat(bc.first_name, ' ', bc.last_name) as actor_2
  from film_actor a
  join film_actor b
  	on a.film_id = b.film_id and a.actor_id <> b.actor_id
  join actor ac 
  	on a.actor_id = ac.actor_id
  join actor bc 
    on b.actor_id = bc.actor_id;
  
  
  
  
-- Get all pairs of customers that have rented the same film more than 3 times

  with film_rental as (
  select r.customer_id, i.film_id
  from sakila.rental r
  join sakila.inventory i on r.inventory_id = i.inventory_id
  )
  select r1.customer_id, r2.customer_id, count(*)
  from film_rental r1
  join film_rental r2 
  on (r1.film_id = r2.film_id) and r1.customer_id <> r2.customer_id
  group by r1.customer_id, r2.customer_id
  having count(*) >= 3
  order by count(*) desc;



-- Get all possible pairs of actors and films
 
 select count(*)from(select a.first_name,a.last_name,f.title
 from film f
 cross join actor a
 Order by a.first_name,f.title)a;
 

