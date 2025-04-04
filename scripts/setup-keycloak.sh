#!/bin/bash

# Wait for Keycloak to be ready
echo "Waiting for Keycloak to start..."
while ! curl -s http://localhost:8080/health > /dev/null; do
    sleep 5
done

# Get admin token
echo "Getting admin token..."
ADMIN_TOKEN=$(curl -X POST http://localhost:8080/realms/master/protocol/openid-connect/token \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'username=admin' \
  -d 'password=admin' \
  -d 'grant_type=password' \
  -d 'client_id=admin-cli' | jq -r '.access_token')

# Create realm
echo "Creating realm..."
curl -X POST http://localhost:8080/admin/realms \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "realm": "myrealm",
    "enabled": true
  }'

# Create client
echo "Creating client..."
curl -X POST http://localhost:8080/admin/realms/myrealm/clients \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "clientId": "kong",
    "enabled": true,
    "protocol": "openid-connect",
    "publicClient": false,
    "redirectUris": ["*"],
    "clientAuthenticatorType": "client-secret",
    "secret": "your-client-secret"
  }'

echo "Keycloak setup completed!"
