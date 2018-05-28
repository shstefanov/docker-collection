Needs docker and docker-compose installed, also root privileges to build images and run containers


Show application images, containers, networks:
```bash
  make status
```

Build application images:
```bash
  make images
```

Remove application images:
```bash
  make remove-images
```


Start application:
```bash
  make start [ config=./alternate_config_file.yml ]
```

Stop application:
```bash
  make stop
```

Attach to container (will prompt for container id or name):
```bash
  make attach
```

Execute command on running container (will prompt for container id or name):
```bash
  make exec
```