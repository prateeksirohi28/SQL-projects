use movie_dataset;

# i. Write a SQL query to find when the movie 'American Beauty' released. Return movie release year.
Select * from movie;
select mov_title, mov_year as release_year from movie where mov_title ='American Beauty';

# ii. Write a SQL query to find those movies, which were released before 1998. Return movie title.
select mov_title from movie where mov_dt_rel < 1998;

# iii. Write a query where it should contain all the data of the movies which were released after 1995 and their movie duration was greater than 120.
select * from movie where mov_year > '1995' and mov_time >'120';

#iv. Write a query to determine the Top 7 movies which were released in United Kingdom. Sort the data in ascending order of the movie year.
select * from movie;
select * from ratings;
select * from movie m inner join ratings r using (mov_id) where mov_rel_country ='UK' order by rev_stars desc limit 7;

#v. Set the language of movie language as 'Chinese' for the movie which has its existing language as Japanese and the movie year was 2001.
update movie set mov_lang = 'Chinese' where mov_lang = 'Japanese';

# vi. Write a SQL query to find name of all the reviewers who rated the movie 'Slumdog Millionaire'.
select * from reviewer;
select * from ratings;
select * from movie;
select rev_name  from (
select * from reviewer r inner join ratings ra using (rev_id) inner join  movie m using (mov_id) where mov_title = 'Slumdog Millionaire') as t;

# vii. Write a query which fetch the first name, last name & role played by the actor where output should all exclude Male actors.
select * from cast;
select * from actor;
select act_fname, act_lname, role from cast c inner join actor a using ( act_id) where act_gender ='F';

# viii. Write a SQL query to find the actors who played a role in the movie 'Annie Hall'.
#Fetch all the fields of actor table. (Hint: Use the IN operator).
select * from movie;
select * from actor;
select * from cast;
select act_fname, act_lname from actor where act_id in(select a.act_id 
 from movie m inner join cast c using (mov_id) inner join actor a using ( act_id) where mov_title ='Annie Hall');
 select *  from movie m inner join cast c using (mov_id) inner join actor a using ( act_id) where mov_title ='Annie Hall';
 
 # ix. Write a SQL query to find those movies that have been released in countries other than the United Kingdom.
 #eturn movie title, movie year, movie time, and date of release, releasing country.
select * from movie where mov_rel_country != 'UK';

# x. Print genre title, maximum movie duration and the count the number of movies in each genre. (HINT: By using inner join)
select  gen_title, max(mov_time), count(mov_title)
 from genres g inner join movie_genres using (gen_id) inner join movie using (mov_id ) group by gen_title;
 
 # xi. Create a view which should contain the first name, last name, title of the movie & role played by particular actor.
 create view view_movie as (select act_fname, act_lname, mov_title , mov_year , role from 
 movie m inner join cast c using (mov_id) inner join actor a using ( act_id) );
 
 select * from view_movie;
 
 # xii. Write a SQL query to find the movies with the lowest ratings
  select mov_title , rev_stars from movie m inner join ratings r using (mov_id) order by rev_stars ;
 