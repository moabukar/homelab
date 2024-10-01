#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to check if a Multipass instance exists
instance_exists() {
    multipass info $1 &>/dev/null
}

# Function to create an instance
create_instance() {
    local name=$1
    local cpus=$2
    local memory=$3
    local disk=$4

    if instance_exists $name; then
        echo -e "${RED}Instance $name already exists. Skipping creation.${NC}"
    else
        echo -e "${GREEN}Creating instance $name...${NC}"
        multipass launch 22.04 --name $name --cpus $cpus --memory $memory --disk $disk
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Instance $name created successfully.${NC}"
        else
            echo -e "${RED}Failed to create instance $name.${NC}"
            exit 1
        fi
    fi
}

# Function to add SSH key to an instance
add_ssh_key() {
    local name=$1
    echo -e "${GREEN}Adding SSH key to $name...${NC}"
    multipass exec $name -- bash -c "echo '$(cat ~/.ssh/id_rsa.pub)' >> ~/.ssh/authorized_keys"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}SSH key added to $name successfully.${NC}"
    else
        echo -e "${RED}Failed to add SSH key to $name.${NC}"
        exit 1
    fi
}

# Create instances
create_instance k8s-master 2 2G 5G
create_instance k8s-worker1 1 1G 4G
create_instance k8s-worker2 1 1G 4G

# Add SSH keys
add_ssh_key k8s-master
add_ssh_key k8s-worker1
add_ssh_key k8s-worker2

# List all instances
echo -e "${GREEN}Listing all instances:${NC}"
multipass list

echo -e "${GREEN}Cluster setup complete!${NC}"
