APP_PREFIX    = orbits
BUILD_COMMAND = @sudo docker build -t
config=docker-compose.yml





# Helpers:

# Reads input from keyboard when used
C_ID_INPUT    = $(shell bash -c 'read -p "Container name or ID: " target; echo $$target')

show-containers:
	@sudo docker ps | grep $(APP_PREFIX)-








status:
	@echo "IMAGES:"
	@sudo docker images | grep $(APP_PREFIX)- || echo "No images to show"
	@echo "\n"
	@echo "RUNNING CONTAINERS:"
	@sudo docker ps | grep $(APP_PREFIX)- || echo "No running containers"
	@echo "\n"
	@echo "To attach to running container, use: 'make attach'"

images: Dockerfiles/*.Dockerfile
	touch images
	$(BUILD_COMMAND) $(APP_PREFIX)-base-image    -f ./Dockerfiles/base-image.Dockerfile    .
	$(BUILD_COMMAND) $(APP_PREFIX)-nginx-entry   -f ./Dockerfiles/nginx-entry.Dockerfile   .
	$(BUILD_COMMAND) $(APP_PREFIX)-php-entry     -f ./Dockerfiles/php-entry.Dockerfile     .
	$(BUILD_COMMAND) $(APP_PREFIX)-laravel-entry -f ./Dockerfiles/laravel-entry.Dockerfile .
	$(BUILD_COMMAND) $(APP_PREFIX)-base-nodejs   -f ./Dockerfiles/base-nodejs.Dockerfile   .
	$(BUILD_COMMAND) $(APP_PREFIX)-pgsql         -f ./Dockerfiles/pgsql.Dockerfile         .

remove-images:
	rm images
	@sudo docker rmi $(APP_PREFIX)-base-image    || echo "Can't find image $(APP_PREFIX)-base-image"
	@sudo docker rmi $(APP_PREFIX)-nginx-entry   || echo "Can't find image $(APP_PREFIX)-nginx-entry"
	@sudo docker rmi $(APP_PREFIX)-php-entry     || echo "Can't find image $(APP_PREFIX)-php-entry"
	@sudo docker rmi $(APP_PREFIX)-laravel-entry || echo "Can't find image $(APP_PREFIX)-laravel-entry"
	@sudo docker rmi $(APP_PREFIX)-base-nodejs   || echo "Can't find image $(APP_PREFIX)-base-nodejs"
	@sudo docker rmi $(APP_PREFIX)-pgsql         || echo "Can't find image $(APP_PREFIX)-pgsql"


attach:  show-containers
	@sudo docker exec -it $(C_ID_INPUT) bash || echo "Exit"

start: images
	@touch start
	@sudo docker-compose --file $(config) up -d


stop:
	@rm start || exit 0
	@sudo docker-compose down

logs:
	sudo watch -n 1 docker-compose logs

test:
	@echo "Make test"

pg: show-containers
	@sudo docker exec -it $(C_ID_INPUT) su - postgres -c \
		'psql -c \\l && psql -d `read -p "Enter database name: " db_name; echo $$db_name`'

pg-setup: show-containers
	@echo "\n"
	@echo "Creating users and databases for application"
	@echo "Please, select container to apply ./data/setup.sql to it's PostgreSQL database"
	@sudo docker exec -it $(C_ID_INPUT) su - postgres -c 'psql -f /srv/setup.sql'|| echo "Exit"

pg-drop: show-containers
	@echo "\n"
	@echo "Creating users and databases for application"
	@echo "Please, select container to apply ./data/setup.sql to it's PostgreSQL database"
	@sudo docker exec -it $(C_ID_INPUT) su - postgres -c 'psql -f /srv/drop.sql'|| echo "Exit"

pg-rebuild: pg-drop pg-setup









# su - postgres -c 'psql -f /srv/db_setup.sql'

# sql:
# 	@sudo docker exec -it $(target) su - postgres -c 'psql -f /srv/db_setup.sql'

