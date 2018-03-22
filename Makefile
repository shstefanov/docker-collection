
APP_PREFIX    = orbits
BUILD_COMMAND = @sudo docker build -t

status:
	@echo "IMAGES:"
	@sudo docker images | grep $(APP_PREFIX)- || echo "No images to show"
	@echo "\n"
	@echo "RUNNING CONTAINERS: (TODO)"
	@sudo docker ps | grep $(APP_PREFIX)- || echo "No running containers"

images:
	$(BUILD_COMMAND) $(APP_PREFIX)-base-image   -f ./Dockerfiles/base-image.Dockerfile  .
	$(BUILD_COMMAND) $(APP_PREFIX)-nginx-entry  -f ./Dockerfiles/nginx-entry.Dockerfile .
	$(BUILD_COMMAND) $(APP_PREFIX)-php-entry    -f ./Dockerfiles/php-entry.Dockerfile   .
	$(BUILD_COMMAND) $(APP_PREFIX)-base-nodejs  -f ./Dockerfiles/base-nodejs.Dockerfile .
	$(BUILD_COMMAND) $(APP_PREFIX)-pgsql        -f ./Dockerfiles/pgsql.Dockerfile .

remove-images:
	@sudo docker rmi $(APP_PREFIX)-base-image    || echo "Can't find image $(APP_PREFIX)-base-image"
	@sudo docker rmi $(APP_PREFIX)-nginx-entry   || echo "Can't find image $(APP_PREFIX)-nginx-entry"
	@sudo docker rmi $(APP_PREFIX)-php-entry     || echo "Can't find image $(APP_PREFIX)-php-entry"
	@sudo docker rmi $(APP_PREFIX)-base-nodejs   || echo "Can't find image $(APP_PREFIX)-base-nodejs"
	@sudo docker rmi $(APP_PREFIX)-pgsql         || echo "Can't find image $(APP_PREFIX)-pgsql"


attach:
	@sudo docker exec -it $(target) bash || echo "Exit"


start:
	@sudo docker-compose up


clean:
	@sudo docker-compose down

