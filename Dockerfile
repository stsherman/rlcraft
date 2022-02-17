FROM openjdk:8-jre-slim

RUN apt-get update && \
    apt-get -y install xz-utils bzip2 unzip curl && \
    rm -rf /var/lib/apt/lists/*

# Default JVM Options (Set default memory limit to 8G)
ENV JAVA_TOOL_OPTIONS "-Xmx8G -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M"

WORKDIR "/rlcraft"

COPY libraries.tar.xz .
COPY forge-1.12.2-14.23.5.2860.jar .
COPY minecraft_server.1.12.2.jar .
RUN curl 'https://media.forgecdn.net/files/3575/916/RLCraft+Server+Pack+1.12.2+-+Release+v2.9.zip' \
  -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:97.0) Gecko/20100101 Firefox/97.0' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Accept-Encoding: gzip, deflate, br' \
  -H 'Referer: https://www.curseforge.com/' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: cross-site' \
  -H 'DNT: 1' \
  -H 'Sec-GPC: 1' \
  --output RLCraft+Server+Pack+1.12.2+-+Release+v2.9.zip

RUN tar -xf libraries.tar.xz && rm libraries.tar.xz

RUN echo "eula=true" > eula.txt

RUN timeout 5s java -jar minecraft_server.1.12.2.jar || true

RUN unzip -o RLCraft+Server+Pack+1.12.2+-+Release+v2.9.zip && \
  rm RLCraft+Server+Pack+1.12.2+-+Release+v2.9.zip

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

VOLUME ["/rlcraft"]

CMD ["/rlcraft/entrypoint.sh"]
