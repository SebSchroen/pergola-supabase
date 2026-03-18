#!/bin/bash

# Apply the .env file as configuration to Pergola for the 'dev' stage.
# Using 'supabase-config' as the name.

echo "Setting configuration 'supabase-config' for stage 'dev' using .env..."
pergola add config-data supabase-config  -p supabase -s dev --file .env

if [ $? -eq 0 ]; then
  echo "Configuration applied successfully."
else
  echo "Failed to apply configuration."
  exit 1
fi
