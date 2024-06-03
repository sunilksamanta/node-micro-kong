#!/bin/bash

# Base directory containing services
services_dir="services"

# Find all directories inside the services directory
service_dirs=$(find "$services_dir" -maxdepth 1 -mindepth 1 -type d)

# Loop through each service directory and run npm install
for service in $service_dirs; do
  echo "Running npm install in $service..."
  (cd $service && npm install)
  if [ $? -ne 0 ]; then
    echo "npm install failed in $service"
    exit 1
  fi
done

echo "npm install completed in all services."
