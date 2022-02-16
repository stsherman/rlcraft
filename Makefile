VOLUME_NAME = rlcraft-2_9
MOUNT_PATH := $(shell pwd)/rlcraft

build:
	docker build -t rlcraft:2.9 .

run:
	mkdir -p $(MOUNT_PATH)
	docker run -p 25565:25565 \
		-it \
		-e GID=`cat /etc/group | grep docker | cut -d: -f3` \
		--mount 'type=volume,src=$(VOLUME_NAME),dst=/rlcraft,volume-driver=local,volume-opt=o=bind,volume-opt=device=$(MOUNT_PATH),volume-opt=type=none' \
		rlcraft:2.9

push:
ifdef docker-username
	docker tag rlcraft:2.9 $(docker-username)/rlcraft:2.9
	docker push $(docker-username)/rlcraft:2.9
else
	@echo 'docker-username is required. Log in to docker and pass the docker username.'
	@echo '	USAGE: make push docker-username=<username>'
endif
