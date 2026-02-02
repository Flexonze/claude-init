#!/usr/bin/env bash

# claude-init installer
# https://github.com/Flexonze/claude-init

set -e

# Colors (only if stdout is a terminal)
if [ -t 1 ]; then
    BLUE='\033[0;34m'
    GREEN='\033[0;32m'
    RED='\033[0;31m'
    BOLD='\033[1m'
    NC='\033[0m'
else
    BLUE=''
    GREEN=''
    RED=''
    BOLD=''
    NC=''
fi

info() {
    printf "${BLUE}${BOLD}==>${NC} ${BOLD}%s${NC}\n" "$1"
}

success() {
    printf "${GREEN}${BOLD}==>${NC} ${BOLD}%s${NC}\n" "$1"
}

error() {
    printf "${RED}${BOLD}Error:${NC} %s\n" "$1" >&2
    exit 1
}

main() {
    info "Installing claude-init..."

    COMMANDS_DIR="$HOME/.claude/commands"
    TARGET_FILE="$COMMANDS_DIR/claude-init.md"
    SOURCE_URL="https://raw.githubusercontent.com/Flexonze/claude-init/main/claude-init.md"

    # Check for curl or wget
    if command -v curl &> /dev/null; then
        DOWNLOADER="curl"
    elif command -v wget &> /dev/null; then
        DOWNLOADER="wget"
    else
        error "curl or wget is required but neither was found"
    fi

    # Create directory
    info "Creating $COMMANDS_DIR..."
    mkdir -p "$COMMANDS_DIR" || error "Failed to create directory"

    # Download file
    info "Downloading claude-init.md..."
    if [ "$DOWNLOADER" = "curl" ]; then
        curl -fsSL "$SOURCE_URL" -o "$TARGET_FILE" || error "Failed to download claude-init.md"
    else
        wget -qO "$TARGET_FILE" "$SOURCE_URL" || error "Failed to download claude-init.md"
    fi

    echo ""
    success "/claude-init installed successfully!"
    echo ""
    printf "${BLUE}╭─────────────────────────────────╮${NC}\n"
    printf "${BLUE}│${NC}  ${BOLD}Usage:${NC}                         ${BLUE}│${NC}\n"
    printf "${BLUE}│${NC}    cd path/to/your/project      ${BLUE}│${NC}\n"
    printf "${BLUE}│${NC}    claude /claude-init          ${BLUE}│${NC}\n"
    printf "${BLUE}╰─────────────────────────────────╯${NC}\n"
    echo ""
}

main
