#!/bin/bash
# Dotfiles Management Script

# Configuration
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_FILES=(
    ".wezterm.lua"
    ".zshrc"
    ".gitconfig"
    ".bashrc"
)

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Utility function for logging
log() {
    local color="$1"
    local message="$2"
    echo -e "${color}${message}${NC}"
}

# Check if Git is installed
check_git() {
    if ! command -v git &> /dev/null; then
        log "$RED" "Git is not installed. Please install Git first."
        exit 1
    fi
}

# Initialize dotfiles repository
init_repo() {
    if [ ! -d "$DOTFILES_DIR/.git" ]; then
        log "$YELLOW" "Initializing Git repository in $DOTFILES_DIR"
        cd "$DOTFILES_DIR" || exit
        git init
        
        echo "# Ignore sensitive or machine-specific files" > .gitignore
        echo ".DS_Store" >> .gitignore
        echo "*.local" >> .gitignore
        
        git add .
        git commit -m "Initial commit: Setup dotfiles repository"
        
        log "$GREEN" "Git repository initialized successfully"
    else
        log "$YELLOW" "Git repository already exists in $DOTFILES_DIR"
    fi
}

# Create symlinks for configuration files
create_symlinks() {
    log "$YELLOW" "Creating symlinks..."
    
    for config in "${CONFIG_FILES[@]}"; do
        if [[ -z "$config" ]]; then
            continue
        fi
        
        # Copy config file to dotfiles if it exists in home directory but not in dotfiles
        if [ ! -f "$DOTFILES_DIR/$config" ] && [ -f "$HOME/$config" ]; then
            log "$YELLOW" "Copying $config to dotfiles directory"
            cp "$HOME/$config" "$DOTFILES_DIR/$config"
        fi
        
        if [ ! -f "$DOTFILES_DIR/$config" ]; then
            log "$RED" "Warning: $config not found in $HOME or $DOTFILES_DIR"
            continue
        fi
        
        # Remove existing file/link if it exists
        rm -f "$HOME/$config"
        
        # Create symlink
        ln -s "$DOTFILES_DIR/$config" "$HOME/$config"
        log "$GREEN" "Symlinked $config"
    done
}

# Setup remote repository
setup_remote() {
    cd "$DOTFILES_DIR" || exit
    
    if git remote | grep -q origin; then
        log "$YELLOW" "Remote repository already configured"
        return
    fi
    
    read -p "Enter your GitHub username: " github_username
    read -p "Enter the name for your dotfiles repository (e.g., dotfiles): " repo_name
    
    remote_url="https://github.com/${github_username}/${repo_name}.git"
    
    git remote add origin "$remote_url"
    git branch -M main
    
    read -p "Would you like to push your dotfiles to GitHub? (y/n): " push_choice
    if [[ "$push_choice" =~ ^[Yy]$ ]]; then
        git push -u origin main
        log "$GREEN" "Dotfiles pushed to GitHub successfully"
    else
        log "$YELLOW" "Skipped pushing to GitHub"
    fi
}

# Main script execution
main() {
    mkdir -p "$DOTFILES_DIR"
    check_git
    
    case "$1" in
        init)
            init_repo
            setup_remote
            create_symlinks
            ;;
        link)
            create_symlinks
            ;;
        remote)
            setup_remote
            ;;
        *)
            echo "Usage: $0 {init|link|remote}"
            exit 1
            ;;
    esac
}

# Run the main function with arguments
main "$@"