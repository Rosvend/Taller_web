create table if not exists users (
    id serial primary key,
    email varchar(255) not null unique,
    password varchar(255) not null
);      

delete from users where email = 'user@example.com';
insert into users (email, password) values ('user@test.com', '$2b$12$OoRVq7E.AIconoV3VJHBL.T9vVBWx8GAvJ7BwWR8KZ9qMG7PrVZKW');

select * from users;