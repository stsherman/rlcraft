FROM openjdk:8-jre

RUN apt-get update && \
    apt-get -y install wget python3 xz-utils && \
    rm -rf /var/lib/apt/lists/*

# Default JVM Options (Set default memory limit to 1G)
ENV JAVA_TOOL_OPTIONS "-Xmx8G -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M"

# Add Minecraft user
WORKDIR "/rlcraft"

COPY libraries.tar.xz .
COPY forge-1.12.2-14.23.5.2860.jar .
COPY minecraft_server.1.12.2.jar .
COPY entrypoint.sh .

RUN tar -xf libraries.tar.xz

RUN echo "eula=true" > eula.txt

RUN timeout 5s java -jar minecraft_server.1.12.2.jar || true

COPY RLCraft+Server+Pack+1.12.2+-+Release+v2.9 .
# RUN cp -r RLCraft+Server+Pack+1.12.2+-+Release+v2.9/* .

RUN chmod +x entrypoint.sh

CMD ["/rlcraft/entrypoint.sh"]
