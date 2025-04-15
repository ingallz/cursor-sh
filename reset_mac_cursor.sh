#!/bin/bash
# Cursor Trial Reset Tool
#
# This script resets the device IDs in Cursor's configuration file to generate a new random device ID.
#
# Repository: https://github.com/ultrasev/cursor-reset
# Author: @ultrasev
# Created: 10/Dec/2024

# Define the storage file path for macOS
STORAGE_FILE="$HOME/Library/Application Support/Cursor/User/globalStorage/storage.json"
BACKUP_TIMESTAMP=$(date "+%Y%m%d_%H%M%S")
BACKUP_FILE="${STORAGE_FILE}.backup_${BACKUP_TIMESTAMP}"

# Create parent directories if they don't exist
mkdir -p "$(dirname "$STORAGE_FILE")"

# Backup the file if it exists
if [ -f "$STORAGE_FILE" ]; then
    cp "$STORAGE_FILE" "$BACKUP_FILE"
    echo "Created backup at $BACKUP_FILE"
fi

# Generate random IDs
# Using openssl for cryptographically secure random generation
MACHINE_ID=$(openssl rand -hex 32)
MAC_MACHINE_ID=$(openssl rand -hex 32)
DEV_DEVICE_ID=$(uuidgen)

# Read existing JSON or create new JSON
if [ -f "$STORAGE_FILE" ]; then
    # Ensure jq is installed
    if ! command -v jq &> /dev/null; then
        echo "Error: jq is required but not installed. Please install jq and try again."
        echo "You can install it with: brew install jq"
        exit 1
    fi
    
    # Update the values in the existing JSON
    jq --arg machineId "$MACHINE_ID" \
       --arg macMachineId "$MAC_MACHINE_ID" \
       --arg devDeviceId "$DEV_DEVICE_ID" \
       '.["telemetry.machineId"] = $machineId | 
        .["telemetry.macMachineId"] = $macMachineId | 
        .["telemetry.devDeviceId"] = $devDeviceId' \
       "$STORAGE_FILE" > "${STORAGE_FILE}.tmp" && mv "${STORAGE_FILE}.tmp" "$STORAGE_FILE"
else
    # Create a new JSON file with the required fields
    cat > "$STORAGE_FILE" << EOL
{
  "telemetry.machineId": "$MACHINE_ID",
  "telemetry.macMachineId": "$MAC_MACHINE_ID",
  "telemetry.devDeviceId": "$DEV_DEVICE_ID"
}
EOL
fi

# Success message
echo "🎉 Device IDs have been successfully reset. The new device IDs are: "
echo
echo "{
  \"machineId\": \"$MACHINE_ID\",
  \"macMachineId\": \"$MAC_MACHINE_ID\",
  \"devDeviceId\": \"$DEV_DEVICE_ID\"
}"

# Make the script executable
chmod +x "$0"
