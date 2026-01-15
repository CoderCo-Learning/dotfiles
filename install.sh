#!/bin/bash
# ============================================================================
# CoderCo Dotfiles Installer
# https://github.com/Coderco-Learning/dotfiles
# ============================================================================

set -euo pipefail

DOTFILES_DIR="${HOME}/.coderco-dotfiles"
CODERCO_SH="${DOTFILES_DIR}/coderco.sh"

# Colours
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo "============================================================================"
echo "  CoderCo Dotfiles Installer"
echo "  https://skool.io/coderco"
echo "============================================================================"
echo ""

# Detect shell
detect_shell() {
    if [ -n "$ZSH_VERSION" ]; then
        echo "zsh"
    elif [ -n "$BASH_VERSION" ]; then
        echo "bash"
    else
        basename "$SHELL"
    fi
}

CURRENT_SHELL=$(detect_shell)
echo -e "Detected shell: ${YELLOW}${CURRENT_SHELL}${NC}"

# Determine RC file
case "$CURRENT_SHELL" in
    zsh)
        RC_FILE="${HOME}/.zshrc"
        ;;
    bash)
        if [[ "$OSTYPE" == "darwin"* ]]; then
            RC_FILE="${HOME}/.bash_profile"
        else
            RC_FILE="${HOME}/.bashrc"
        fi
        ;;
    *)
        RC_FILE="${HOME}/.bashrc"
        ;;
esac

echo -e "RC file: ${YELLOW}${RC_FILE}${NC}"
echo ""

# Get script directory (if running from repo)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd 2>/dev/null || pwd)"

# Check if dotfiles directory exists
if [ -d "$DOTFILES_DIR" ]; then
    echo -e "${YELLOW}Existing installation found. Updating...${NC}"
    cd "$DOTFILES_DIR"
    if [ -d ".git" ]; then
        git pull origin main 2>/dev/null || echo -e "${YELLOW}Could not update via git${NC}"
    fi
else
    echo "Creating dotfiles directory..."
    mkdir -p "$DOTFILES_DIR"
fi

# Copy the dotfiles (if running from repo)
if [ -f "${SCRIPT_DIR}/coderco.sh" ] && [ "$SCRIPT_DIR" != "$DOTFILES_DIR" ]; then
    echo "Copying dotfiles from local repository..."
    cp "${SCRIPT_DIR}/coderco.sh" "${DOTFILES_DIR}/"
    [ -f "${SCRIPT_DIR}/verify.sh" ] && cp "${SCRIPT_DIR}/verify.sh" "${DOTFILES_DIR}/"
fi

# Download if not available locally
if [ ! -f "$CODERCO_SH" ]; then
    echo -e "${YELLOW}Downloading from GitHub...${NC}"
    if ! curl -fsSL https://raw.githubusercontent.com/Coderco-Learning/dotfiles/main/coderco.sh -o "$CODERCO_SH"; then
        echo -e "${RED}Failed to download coderco.sh${NC}"
        exit 1
    fi
    # Also download verify.sh if not present
    if [ ! -f "${DOTFILES_DIR}/verify.sh" ]; then
        curl -fsSL https://raw.githubusercontent.com/Coderco-Learning/dotfiles/main/verify.sh -o "${DOTFILES_DIR}/verify.sh" 2>/dev/null || true
    fi
fi

# Make scripts executable
chmod +x "$CODERCO_SH" 2>/dev/null || true
[ -f "${DOTFILES_DIR}/verify.sh" ] && chmod +x "${DOTFILES_DIR}/verify.sh" || true

# Create RC file if it doesn't exist
if [ ! -f "$RC_FILE" ]; then
    echo "Creating ${RC_FILE}..."
    touch "$RC_FILE"
fi

# Check if already sourced
SOURCE_LINE="# CoderCo Dotfiles\n[ -f ${CODERCO_SH} ] && source ${CODERCO_SH}"
if grep -q "coderco.sh" "$RC_FILE" 2>/dev/null; then
    echo -e "${YELLOW}CoderCo dotfiles already configured in ${RC_FILE}${NC}"
    echo "To reinstall, remove the existing line and run again."
else
    echo "Adding CoderCo dotfiles to ${RC_FILE}..."
    echo "" >> "$RC_FILE"
    echo -e "$SOURCE_LINE" >> "$RC_FILE"
    echo -e "${GREEN}✓ Added to ${RC_FILE}${NC}"
fi

echo ""
echo "============================================================================"
echo -e "${GREEN}✓ Installation complete!${NC}"
echo "============================================================================"
echo ""
echo "Next steps:"
echo -e "  1. Restart your terminal, or run: ${YELLOW}source ${RC_FILE}${NC}"
echo -e "  2. Type ${YELLOW}aliases${NC} to see available shortcuts"
echo -e "  3. Run ${YELLOW}~/.coderco-dotfiles/verify.sh${NC} to check your setup"
echo ""
