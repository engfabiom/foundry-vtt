FROM node:22-alpine

ENV APP_HOME=/home/foundry/app \
    DATA_HOME=/home/foundry/data \
    FOUNDRY_URL=""

RUN apk add --no-cache curl unzip \
 && deluser --remove-home node || true \
 && delgroup node || true \
 && addgroup -S -g 1000 foundry \
 && adduser  -S -D -H -u 1000 -G foundry foundry \
 && mkdir -p "$APP_HOME" "$DATA_HOME" \
 && chown -R foundry:foundry /home/foundry


WORKDIR $APP_HOME
USER foundry
EXPOSE 30000
VOLUME ["/home/foundry/data"]

CMD ["/bin/sh", "-lc", \
"if [ -f ./main.js ]; then exec node ./main.js --headless --dataPath=\"$DATA_HOME\"; fi; test -n \"$FOUNDRY_URL\" || { echo FOUNDRY_URL vazio; exit 2; }; curl -IfsS --max-time 10 \"$FOUNDRY_URL\" >/dev/null || { echo URL inválida ou indisponível; exit 3; }; curl -fsSL \"$FOUNDRY_URL\" -o f.zip || { echo Falha no download; exit 4; }; unzip -q f.zip -d . && rm -f f.zip || { echo Falha ao extrair; exit 5; }; exec node ./main.js --headless --dataPath=\"$DATA_HOME\""]
