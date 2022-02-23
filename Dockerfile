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

RUN curl -L --output OptiFine_1.12.2_HD_U_G5.jar \
  https://optifine.net/downloadx\?f\=OptiFine_1.12.2_HD_U_G5.jar\&x\=36b6e0afcff06e04bcfe50f4ece98972 && \
  mv OptiFine_1.12.2_HD_U_G5.jar mods

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

VOLUME ["/rlcraft"]

# Default JVM Options (Set default memory limit to 8G)
ENV JAVA_TOOL_OPTIONS "-Xmx8G -XX:+UseConcMarkSweepGC -XX:+CMSIncrementalMode -XX:-UseAdaptiveSizePolicy -Xmn128M"

CMD ["/rlcraft/entrypoint.sh"]
