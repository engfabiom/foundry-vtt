FROM node:22-alpine

ENV UID=1000 \
    GID=1000 \
    APP_HOME=/home/foundry/app \
    DATA_HOME=/home/foundry/data

RUN apk add --no-cache unzip \
 && deluser --remove-home node \
 && addgroup -g $GID foundry \
 && adduser -u $UID -G foundry -D foundry \
 && mkdir -p $APP_HOME $DATA_HOME \
 && chown -R foundry:foundry /home/foundry

USER foundry
WORKDIR $APP_HOME

COPY ./FoundryVTT.zip ./
RUN unzip FoundryVTT.zip -d . \
 && rm FoundryVTT.zip

EXPOSE 30000
CMD ["node", "./main.js", "--headless", "--dataPath=/home/foundry/data"]
