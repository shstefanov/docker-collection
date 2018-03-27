
CREATE USER orbits_production_username WITH PASSWORD 'orbits_production_password';
CREATE DATABASE orbits_production;
GRANT ALL PRIVILEGES ON DATABASE orbits_production to orbits_production_username;
\c orbits_production; \i /srv/schema/index.sql;

CREATE USER orbits_dev_username WITH PASSWORD 'orbits_dev_password';
CREATE DATABASE orbits_dev;
GRANT ALL PRIVILEGES ON DATABASE orbits_dev to orbits_dev_username;
\c orbits_dev; \i /srv/schema/index.sql;


CREATE USER orbits_test_username WITH PASSWORD 'orbits_test_password';
CREATE DATABASE orbits_test;
GRANT ALL PRIVILEGES ON DATABASE orbits_test to orbits_test_username;
\c orbits_test; \i /srv/schema/index.sql;

