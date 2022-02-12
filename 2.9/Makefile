MOUNT_PATH := $(shell pwd)/rlcraft
$(shell mkdir -p $(MOUNT_PATH))


build:
	sudo docker build -t rlcraft:2.9 .

run:
	# Create the volume
	sudo docker volume create -d local -o o=bind -o device=$(MOUNT_PATH) rlcraft-2_9 -o type=none
	sudo docker run -p 25565:25565 -v rlcraft-2_9:/rlcraft rlcraft:2.9
