FROM openjdk:8-jre-slim

RUN apt-get update && \
    apt-get -y install xz-utils bzip2 unzip curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR "/rlcraft"

RUN curl -L --output forge-1.12.2-14.23.5.2860-installer.jar \
  https://maven.minecraftforge.net/net/minecraftforge/forge/1.12.2-14.23.5.2860/forge-1.12.2-14.23.5.2860-installer.jar

RUN java -jar forge-1.12.2-14.23.5.2860-installer.jar --installServer && \
  rm forge-1.12.2-14.23.5.2860-installer.jar && \
  rm forge-1.12.2-14.23.5.2860-installer.jar.log

RUN curl -L --output RLCraft+Server+Pack+1.12.2+-+Release+v2.9.1c.zip \
  https://media.forgecdn.net/files/3655/676/RLCraft+Server+Pack+1.12.2+-+Release+v2.9.1c.zip

RUN echo "eula=true" > eula.txt

RUN timeout 5s java -jar minecraft_server.1.12.2.jar || true

RUN unzip -o RLCraft+Server+Pack+1.12.2+-+Release+v2.9.1c.zip && \
  rm RLCraft+Server+Pack+1.12.2+-+Release+v2.9.1c.zip

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

VOLUME ["/rlcraft"]

# Default JVM Options (Set default memory limit to 8G)
ENV JAVA_TOOL_OPTIONS "-Xmx8G -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M"

CMD ["/rlcraft/entrypoint.sh"]
