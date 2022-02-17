FROM openjdk:8-jre-slim

RUN apt-get update && \
    apt-get -y install xz-utils bzip2 && \
    rm -rf /var/lib/apt/lists/*

# Default JVM Options (Set default memory limit to 8G)
ENV JAVA_TOOL_OPTIONS "-Xmx8G -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M"

WORKDIR "/rlcraft"

COPY libraries.tar.xz .
COPY forge-1.12.2-14.23.5.2860.jar .
COPY minecraft_server.1.12.2.jar .
COPY RLCraft+Server+Pack+1.12.2+-+Release+v2.9.tar.xz .

RUN tar -xf libraries.tar.xz && rm libraries.tar.xz

RUN echo "eula=true" > eula.txt

RUN timeout 5s java -jar minecraft_server.1.12.2.jar || true

RUN tar -xf RLCraft+Server+Pack+1.12.2+-+Release+v2.9.tar.xz && \
  rm RLCraft+Server+Pack+1.12.2+-+Release+v2.9.tar.xz

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

VOLUME ["/rlcraft"]

CMD ["/rlcraft/entrypoint.sh"]
