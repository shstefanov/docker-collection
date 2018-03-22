FROM orbits-base-image

# Install PostgreSQL
RUN apt-get install -y postgresql-9.6


CMD chown postgres:postgres /var/lib/postgresql/9.6/main && service postgresql start && bash
