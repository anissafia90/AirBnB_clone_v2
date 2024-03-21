#!/usr/bin/env bash

# Define default values for environment variables
HBNB_ENV='dev'
HBNB_TYPE_STORAGE='db'
HBNB_MYSQL_USER='hbnb_dev'
HBNB_MYSQL_HOST='localhost'
HBNB_MYSQL_DB='hbnb_dev_db'

# Function to prompt user for input if not provided as arguments
prompt_input() {
    local var_name="$1"
    local prompt_message="$2"
    local default_value="$3"
    read -p "$prompt_message [$default_value]: " -r "$var_name"
    if [[ -z "${!var_name}" ]]; then
        eval "$var_name=$default_value"
    fi
}

# Get the application or command to run
if [[ -n "$1" && -x "$1" ]]; then
    APP_FILE="$1"
    shift
else
    echo -e "\e[31mError:\e[0m No executable file provided"
    echo 'Usage: ./run.bash file|command [environment] [storage]'
    exit 1
fi

# Get the application environment
if [[ -n "$1" ]]; then
    HBNB_ENV="$1"
    shift
else
    prompt_input HBNB_ENV 'Environment' "$HBNB_ENV"
fi

# Get the storage mechanism
if [[ -n "$1" ]]; then
    HBNB_TYPE_STORAGE="$1"
    shift
else
    prompt_input HBNB_TYPE_STORAGE 'Storage Type' "$HBNB_TYPE_STORAGE"
fi

# Set MySQL credentials if storage type is 'db'
if [[ "$HBNB_TYPE_STORAGE" == 'db' ]]; then
    prompt_input HBNB_MYSQL_USER 'User' "$HBNB_MYSQL_USER"
    prompt_input HBNB_MYSQL_HOST 'Host' "$HBNB_MYSQL_HOST"
    prompt_input HBNB_MYSQL_DB 'Database' "$HBNB_MYSQL_DB"
    read -sr -p 'Enter DB password: ' HBNB_MYSQL_PWD
fi

# Display information and run the application
echo -e "Running \e[34m[$APP_FILE]\e[0m"
env HBNB_MYSQL_USER="$HBNB_MYSQL_USER" \
  HBNB_MYSQL_HOST="$HBNB_MYSQL_HOST" \
  HBNB_MYSQL_DB="$HBNB_MYSQL_DB" \
  HBNB_ENV="$HBNB_ENV" \
  HBNB_TYPE_STORAGE="$HBNB_TYPE_STORAGE" \
  HBNB_MYSQL_PWD="$HBNB_MYSQL_PWD" \
  "$APP_FILE" "$@"
