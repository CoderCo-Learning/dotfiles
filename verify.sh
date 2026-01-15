#!/bin/bash
# ============================================================================
# CoderCo Setup Verification Script
# Run this to check your development environment is ready
# ============================================================================

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

PASS=0
FAIL=0
WARN=0

echo ""
echo "============================================================================"
echo "  CoderCo Environment Verification"
echo "============================================================================"
echo ""

check_tool() {
    local name=$1
    local cmd=$2
    local version_cmd=${3:-"--version"}
    
    printf "  %-20s" "$name:"
    
    if command -v "$cmd" &> /dev/null; then
        version=$($cmd $version_cmd 2>&1 | head -1 | cut -c 1-50)
        echo -e "${GREEN}OK${NC}  $version"
        ((PASS++))
        return 0
    else
        echo -e "${RED}NOT INSTALLED${NC}"
        ((FAIL++))
        return 1
    fi
}

echo -e "${BLUE}Core Tools${NC}"
check_tool "Git" "git" "--version"
check_tool "Docker" "docker" "--version"
check_tool "VS Code" "code" "--version"

echo ""
echo -e "${BLUE}Cloud & Infrastructure${NC}"
check_tool "AWS CLI" "aws" "--version"
check_tool "Terraform" "terraform" "-version"

echo ""
echo -e "${BLUE}Kubernetes Tools${NC}"
check_tool "kubectl" "kubectl" "version --client --short 2>/dev/null || kubectl version --client 2>&1 | head -1"
check_tool "Helm" "helm" "version --short"
check_tool "k9s" "k9s" "version --short 2>/dev/null || k9s version 2>&1 | head -1"

echo ""
echo -e "${BLUE}Utilities${NC}"
check_tool "jq" "jq" "--version"
check_tool "yq" "yq" "--version"
check_tool "make" "make" "--version"
check_tool "curl" "curl" "--version"

echo ""
echo "============================================================================"
echo ""

echo ""
echo -e "${BLUE}System Status${NC}"

# Check Docker daemon
printf "  %-20s" "Docker daemon:"
if command -v docker &> /dev/null && docker info &> /dev/null; then
    echo -e "${GREEN}RUNNING${NC}"
else
    if command -v docker &> /dev/null; then
        echo -e "${YELLOW}NOT RUNNING${NC} (start Docker Desktop)"
    else
        echo -e "${YELLOW}NOT RUNNING${NC} (Docker not installed)"
    fi
    ((WARN++))
fi

# Check CoderCo dotfiles
printf "  %-20s" "Dotfiles:"
if [ -f "${HOME}/.coderco-dotfiles/coderco.sh" ]; then
    echo -e "${GREEN}INSTALLED${NC}"
else
    echo -e "${YELLOW}NOT INSTALLED${NC}"
    echo -e "    ${YELLOW}Run: ~/.coderco-dotfiles/install.sh${NC}"
    ((WARN++))
fi

echo ""
echo "============================================================================"
echo -e "Summary: ${GREEN}${PASS} installed${NC}, ${RED}${FAIL} missing${NC}, ${YELLOW}${WARN} warnings${NC}"
echo "============================================================================"
echo ""

if [ $FAIL -eq 0 ] && [ $WARN -eq 0 ]; then
    echo -e "${GREEN}Your environment is ready!${NC}"
    echo "All required tools are installed and configured."
elif [ $FAIL -eq 0 ]; then
    echo -e "${YELLOW}Almost ready!${NC}"
    echo "All required tools are installed, but check the warnings above."
else
    echo -e "${RED}Some tools are missing.${NC}"
    echo "Install missing tools to get started. Check the README for instructions."
fi

echo ""
