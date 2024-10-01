.PHONY: help config master nodes post_install control_plane k8s_flush destroy

# Colors for terminal output
GREEN := \033[0;32m
NC := \033[0m # No Color

# Default target
all: config master nodes post_install control_plane

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  ${GREEN}help${NC}         : Show this help message"
	@echo "  ${GREEN}config${NC}       : Run basic configuration playbook"
	@echo "  ${GREEN}master${NC}       : Set up the Kubernetes master node"
	@echo "  ${GREEN}nodes${NC}        : Set up the Kubernetes worker nodes"
	@echo "  ${GREEN}post_install${NC} : Run post-installation tasks"
	@echo "  ${GREEN}control_plane${NC}: Set up the Kubernetes control plane"
	@echo "  ${GREEN}k8s_flush${NC}    : Flush Kubernetes settings"
	@echo "  ${GREEN}destroy${NC}      : Destroy the entire cluster"
	@echo "  ${GREEN}all${NC}          : Run all steps (config, master, nodes, post_install, control_plane)"

config:
	@echo "${GREEN}Running configuration playbook...${NC}"
	ansible-playbook playbooks/configuration.yaml

master:
	@echo "${GREEN}Setting up Kubernetes master node...${NC}"
	ansible-playbook playbooks/master.yaml

nodes:
	@echo "${GREEN}Setting up Kubernetes worker nodes...${NC}"
	ansible-playbook playbooks/nodes.yaml

post_install:
	@echo "${GREEN}Running post-installation tasks...${NC}"
	ansible-playbook playbooks/k8s_post.yaml

control_plane:
	@echo "${GREEN}Setting up Kubernetes control plane...${NC}"
	ansible-playbook playbooks/control_plane.yaml

k8s_flush:
	@echo "${GREEN}Flushing Kubernetes settings...${NC}"
	ansible-playbook playbooks/k8s_flush.yaml

destroy:
	@echo "${GREEN}Destroying the entire cluster...${NC}"
	./destroy.sh
