#!/bin/bash

PROJECT_NAME="project"
DOMAIN="www.example.com"
HOME_ROOT="/data/projects"
SOURCE_DIR=$HOME_ROOT"/source"
PROJECT_DIR=$SOURCE_DIR"/"$PROJECT_NAME
WEB_ROOT="/data/htdocs/"$DOMAIN
LOG_DIR=$HOME_ROOT"/logs/"$PROJECT_NAME

GIT_HOST=${GIT_HOST-"git host"}
GIT_PORT=${GIT_PORT-git port}
GIT_USER=${GIT_USER-"git user"}

GROUP="www"
USER="www"

ACTION=$1
shift

args_count=$#
args_count=`expr $args_count - 1`
OPTION=""
i=0

while test $i -le $args_count ;
do
    OPTION=$OPTION" "$1
    shift
    i=`expr $i + 1`
done

case "$ACTION" in
    release)
        bash ./release.sh release -p="$PROJECT_NAME" --project-dir="$PROJECT_DIR" --web-root="$WEB_ROOT" --git-protocol="ssh" --git-host="$GIT_HOST" --git-port=$GIT_PORT --git-user="$GIT_USER" --group="$GROUP" --user="$USER" --log-dir="$LOG_DIR"
        ;;
    rollback)
        bash ./release.sh rollback -p="$PROJECT_NAME" --project-dir="$PROJECT_DIR" --web-root="$WEB_ROOT" --group="$GROUP" --user="$USER" --log-dir="$LOG_DIR" $OPTION
        ;;
    *)
        bash ./release.sh --help
        ;;
esac

exit 0