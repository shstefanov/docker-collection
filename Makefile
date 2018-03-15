
APP_PREFIX    = orbits
BUILD_COMMAND = @sudo docker build -t

status:
	@echo "IMAGES:"
	@sudo docker images | grep $(APP_PREFIX)_ || echo "No images to show"
	@echo "\n"
	@echo "RUNNING CONTAINERS: (TODO)"
	@sudo docker ps | grep $(APP_PREFIX)_ || echo "No running containers"

images:
	$(BUILD_COMMAND) $(APP_PREFIX)_base_image   -f ./Dockerfiles/base_image.Dockerfile .
	$(BUILD_COMMAND) $(APP_PREFIX)_nginx_entry  -f ./Dockerfiles/nginx_entry.Dockerfile .

remove-images:
	@sudo docker rmi $(APP_PREFIX)_base_image    || echo "Can't find image $(APP_PREFIX)_base_image"
	@sudo docker rmi $(APP_PREFIX)_nginx_entry   || echo "Can't find image $(APP_PREFIX)_nginx_entry"

attach:
	sudo docker exec -it $(target) bash || echo "Exit"

start:
	@sudo docker-compose up