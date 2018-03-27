
CREATE TABLE users (
	user_id SERIAL UNIQUE,
	name   varchar(40) NOT NULL CHECK (name <> ''),
	email   varchar(40) NOT NULL CHECK (email <> ''),
	password   varchar(40) NOT NULL CHECK (password <> '')
);
