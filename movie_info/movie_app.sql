create table movies
  (
    id serial4 primary key,
    title varchar(1000),
    poster text,
    year varchar(4),
    rated varchar(10),
    released varchar (25),
    runtime varchar(25),
    genre varchar(250),
    director varchar(250),
    writers varchar(250),
    actors varchar(300),
    plot text
    );