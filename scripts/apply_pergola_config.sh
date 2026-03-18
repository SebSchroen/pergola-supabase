#!/bin/bash

# Apply the .env variables as configuration to Pergola for the 'dev' stage.
# Using 'supabase-config' as the name.
# Since 'pergola add config-data' expects '--env key=value' for variables,
# we parse the .env file and construct the command.

CONFIG_NAME="supabase-config"
STAGE="dev"
ENV_FILE=".env"
PROJECT="supapbase"

echo "Parsing $ENV_FILE and applying to Pergola config '$CONFIG_NAME' for stage '$STAGE'..."

# Build the command arguments
# We ignore lines starting with # and empty lines
ARGS=""
while IFS= read -r line || [[ -n "$line" ]]; do
  # Skip comments and empty lines
  [[ "$line" =~ ^#.*$ ]] && continue
  [[ -z "$line" ]] && continue
  
  # Append --env key=value
  ARGS="$ARGS --env $line"
done < "$ENV_FILE"

if [ -z "$ARGS" ]; then
  echo "No environment variables found in $ENV_FILE"
  exit 1
fi

# Execute the pergola command with all collected --env arguments
pergola add config-data "$CONFIG_NAME" -p "$PROJECT" -s "$STAGE" $ARGS

if [ $? -eq 0 ]; then
  echo "Configuration applied successfully."
else
  echo "Failed to apply configuration."
  exit 1
fi
