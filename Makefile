APP_PREFIX    = orbits
BUILD_COMMAND = @sudo docker build -t





# Helpers:

# Reads input from keyboard when used
C_ID_INPUT = $(shell bash -c 'read -p "Container name or ID: " target; echo $$target')

show-containers:
	@sudo docker ps | grep $(APP_PREFIX)-

status:
	@echo "IMAGES:"
	@sudo docker images | grep $(APP_PREFIX)- || echo "No images to show"
	@echo "\n"
	@echo "RUNNING CONTAINERS: (TODO)"
	@sudo docker ps | grep $(APP_PREFIX)- || echo "No running containers"
	@echo "\n"
	@echo "To attach to running container, use: 'make attach target=container_name'"

images:
	$(BUILD_COMMAND) $(APP_PREFIX)-base-image    -f ./Dockerfiles/base-image.Dockerfile    .
	$(BUILD_COMMAND) $(APP_PREFIX)-nginx-entry   -f ./Dockerfiles/nginx-entry.Dockerfile   .
	$(BUILD_COMMAND) $(APP_PREFIX)-php-entry     -f ./Dockerfiles/php-entry.Dockerfile     .
	$(BUILD_COMMAND) $(APP_PREFIX)-laravel-entry -f ./Dockerfiles/laravel-entry.Dockerfile .
	$(BUILD_COMMAND) $(APP_PREFIX)-base-nodejs   -f ./Dockerfiles/base-nodejs.Dockerfile   .
	$(BUILD_COMMAND) $(APP_PREFIX)-pgsql         -f ./Dockerfiles/pgsql.Dockerfile         .

remove-images:
	@sudo docker rmi $(APP_PREFIX)-base-image    || echo "Can't find image $(APP_PREFIX)-base-image"
	@sudo docker rmi $(APP_PREFIX)-nginx-entry   || echo "Can't find image $(APP_PREFIX)-nginx-entry"
	@sudo docker rmi $(APP_PREFIX)-php-entry     || echo "Can't find image $(APP_PREFIX)-php-entry"
	@sudo docker rmi $(APP_PREFIX)-laravel-entry || echo "Can't find image $(APP_PREFIX)-laravel-entry"
	@sudo docker rmi $(APP_PREFIX)-base-nodejs   || echo "Can't find image $(APP_PREFIX)-base-nodejs"
	@sudo docker rmi $(APP_PREFIX)-pgsql         || echo "Can't find image $(APP_PREFIX)-pgsql"


attach:  show-containers
	@sudo docker exec -it $(C_ID_INPUT) bash || echo "Exit"

start:
	@sudo docker-compose up


clean:
	@sudo docker-compose down


test:
	@echo "Make test"

pg:
	@sudo docker exec -it $(APP_PREFIX)-pgsql su - postgres -c 'psql -c \\l && psql'  || echo "Exit"

pg-setup:
	@sudo docker exec -it $(target) su - postgres -c 'psql -f /srv/setup.sql'|| echo "Exit"









# su - postgres -c 'psql -f /srv/db_setup.sql'

# sql:
# 	@sudo docker exec -it $(target) su - postgres -c 'psql -f /srv/db_setup.sql'

