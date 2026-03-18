#!/bin/bash

# Define keys to rotate (based on the Secrets section of .env)
KEYS=(
  "ANON_KEY"
  "SERVICE_ROLE_KEY"
  "JWT_SECRET"
  "SECRET_KEY_BASE"
  "VAULT_ENC_KEY"
  "PG_META_CRYPTO_KEY"
  "LOGFLARE_PUBLIC_ACCESS_TOKEN"
  "LOGFLARE_PRIVATE_ACCESS_TOKEN"
  "POOLER_TENANT_ID"
  "DB_ENC_KEY"
  "POSTGRES_PASSWORD"
  "DASHBOARD_PASSWORD"
)

# Rotate each key with openssl rand -hex 12
for KEY in "${KEYS[@]}"; do
  NEW_VALUE=$(openssl rand -hex 12)
  # Use sed to replace the value for the key. 
  # This matches the KEY= followed by anything until the end of the line.
  sed -i "s/^${KEY}=.*/${KEY}=${NEW_VALUE}/" .env
  echo "Updated ${KEY}"
done

echo "Secret rotation complete."
