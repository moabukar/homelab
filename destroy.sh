#!/bin/bash

# Stop all running instances
echo "Stopping all Multipass instances..."
multipass stop --all

# Delete all instances
echo "Deleting all Multipass instances..."
multipass delete --all

# Purge all deleted instances
echo "Purging all deleted instances..."
multipass purge

# List remaining instances (should be empty)
echo "Remaining instances:"
multipass list

# Remove any leftover Multipass-related files
echo "Cleaning up Multipass-related files..."
rm -rf ~/.multipass

echo "Cleanup complete!"
