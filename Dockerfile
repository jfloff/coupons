FROM jfloff/heroku-rails:latest

ENV WORKDIR_PATH /app/user/spec/dummy

RUN set -ex ;\
    echo "$WORKDIR_PATH/bin/rake db:migrate" > $POST_RUN_SCRIPT_PATH/setup.sh ;\
    chmod +x $POST_RUN_SCRIPT_PATH/setup.sh

WORKDIR $WORKDIR_PATH