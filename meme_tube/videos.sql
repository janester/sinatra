create table videos
  (
    id serial4 primary key,
    name varchar(200) not null,
    description varchar(500),
    url varchar(150),
    genre varchar(100)
    );