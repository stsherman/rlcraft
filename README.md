Simple Docker based server for RLCraft starting from version 2.9. By using this Docker image, you are indicating your agreement to Minecraft's [EULA](https://account.mojang.com/documents/minecraft_eula).

## Building
If you have make installed, simply run `make build` to build the image locally.

Otherwise, run `docker build -t rlcraft:<TAG> .` to build the image and tag it with whatever you replace `<TAG>` with.

## Running
If you have make installed, run `make run` to run the image. This will expose port 25565 (default minecraft server port) and will create a volume called `rlcraft` in the working directory. Inside this volume will be all the files stored in the `/rlcraft` directory in the container. Here, you will find all the files used by the server. If you want to load an existing world, you can place it here.

Otherwise, run `docker run -p 25565:25565 rlcraft:<TAG>` to run the image you previously built and expose port 25565. If you do not provide a volume here, it will create one by default with an obscure name. You can find out where the volume is stored by running `docker inspect rlcraft:<TAG>` on your image.
