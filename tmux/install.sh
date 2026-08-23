#!/bin/bash
#
# Tmux Configuration Setup Script
# 
# This script sets up the tmux configuration with automatic TPM and plugin management.
# Designed for easy deployment to new systems, including omarchy instances.
#

set -e

echo "🚀 Setting up Tmux Configuration..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check if tmux is installed
if ! command -v tmux &> /dev/null; then
    print_error "tmux is not installed. Please install tmux first."
    echo "  On macOS: brew install tmux"
    echo "  On Ubuntu/Debian: sudo apt-get install tmux"
    echo "  On CentOS/RHEL: sudo yum install tmux"
    exit 1
fi

# Check if git is installed
if ! command -v git &> /dev/null; then
    print_error "git is not installed. Please install git first."
    exit 1
fi

# Create tmux config directory
CONFIG_DIR="$HOME/.config/tmux"
print_status "Creating tmux config directory: $CONFIG_DIR"
mkdir -p "$CONFIG_DIR"

# Copy tmux.conf if we're running from the repo directory
if [ -f "tmux.conf" ]; then
    print_status "Installing tmux.conf..."
    cp tmux.conf "$CONFIG_DIR/"
else
    print_warning "tmux.conf not found in current directory."
    print_warning "Make sure you're running this script from the tmux config repository."
    exit 1
fi

# Install TPM (Tmux Plugin Manager)
TPM_DIR="$CONFIG_DIR/plugins/tpm"
if [ -d "$TPM_DIR" ]; then
    print_warning "TPM already exists, updating..."
    cd "$TPM_DIR"
    git pull
    cd - > /dev/null
else
    print_status "Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

# Install plugins automatically
print_status "Installing tmux plugins..."
"$TPM_DIR/bin/install_plugins"

# Set up symlink for traditional path (for compatibility)
if [ ! -L "$HOME/.tmux" ] && [ ! -d "$HOME/.tmux" ]; then
    print_status "Creating compatibility symlink..."
    ln -sf "$CONFIG_DIR" "$HOME/.tmux"
fi

print_status "Setup complete!"
echo ""
echo "📋 Next steps:"
echo "  1. Start tmux: tmux"
echo "  2. If this is a fresh install, plugins will auto-install"
echo "  3. Use prefix key (Ctrl+Space) + I to manually install plugins if needed"
echo ""
echo "🔧 Plugin management:"
echo "  • Install new plugins: prefix + I"
echo "  • Update plugins: prefix + U" 
echo "  • Remove unused plugins: prefix + Alt + u"
echo ""
echo "✨ Enjoy your configured tmux environment!"