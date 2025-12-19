# Dotfiles Setup Guide

Complete setup instructions for deploying these dotfiles across different platforms.

## Quick Start

```bash
# Install chezmoi and initialize dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply crsmithdev/dotfiles
```

Or if you already have chezmoi installed:

```bash
chezmoi init crsmithdev/dotfiles
chezmoi apply
```

## Platform-Specific Setup

- [macOS Setup](./setup-macos.md)
- [Linux Setup](./setup-linux.md)
- [WSL Setup](./setup-wsl.md)

## Post-Installation

### 1. Shell Configuration

**For Bash users:**
```bash
source ~/.bashrc
```

**For ZSH users:**
```bash
# Install Oh My Zsh if not already installed
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install recommended plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

source ~/.zshrc
```

### 2. Install Starship Prompt

```bash
# macOS
brew install starship

# Linux
curl -sS https://starship.rs/install.sh | sh

# Windows (PowerShell)
scoop install starship
```

### 3. Install Modern CLI Tools

These tools are referenced in the dotfiles for enhanced developer experience:

```bash
# macOS
brew install \
  eza \          # Modern ls replacement
  bat \          # Cat with syntax highlighting
  ripgrep \      # Fast grep
  fd \           # Fast find
  zoxide \       # Smart cd
  fzf \          # Fuzzy finder
  lazygit \      # Git UI
  gh             # GitHub CLI

# Ubuntu/Debian
sudo apt install \
  bat \
  ripgrep \
  fd-find \
  fzf

# Install eza (not in apt)
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install eza

# Install zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```

### 4. Neovim Setup

```bash
# Install Neovim (>= 0.9.0)
# macOS
brew install neovim

# Ubuntu/Debian (use AppImage for latest version)
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

# First launch will install plugins automatically
nvim

# Inside Neovim, install language servers:
:Mason
```

### 5. Language Environments

**Node.js (via fnm - Fast Node Manager):**
```bash
# Install fnm
curl -fsSL https://fnm.vercel.app/install | bash

# Install Node.js
fnm install 20
fnm use 20
fnm default 20
```

**Python (via pyenv):**
```bash
# Install pyenv
curl https://pyenv.run | bash

# Install Python
pyenv install 3.12.0
pyenv global 3.12.0
```

**Rust:**
```bash
# Install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

**Go:**
```bash
# macOS
brew install go

# Linux
wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
```

### 6. Git Configuration

The `.gitconfig` template uses chezmoi variables. Update `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
    username = "Your Name"
    email = "your.email@example.com"
```

Then reapply:
```bash
chezmoi apply
```

### 7. SSH Keys

Generate SSH keys for GitHub/GitLab:

```bash
# Generate key
ssh-keygen -t ed25519 -C "your.email@example.com"

# Start SSH agent
eval "$(ssh-agent -s)"

# Add key
ssh-add ~/.ssh/id_ed25519

# Copy public key
cat ~/.ssh/id_ed25519.pub
# Add to GitHub: Settings → SSH Keys
```

## Updating Dotfiles

```bash
# Pull latest changes
chezmoi update

# Or manually
cd ~/.local/share/chezmoi
git pull
chezmoi apply
```

## Local Overrides

Create local override files for machine-specific customizations:

- `~/.bashrc.local`
- `~/.zshrc.local`
- `~/.gitconfig.local`

These files are sourced automatically and ignored by git.

## Troubleshooting

### Chezmoi apply fails

```bash
# Check what would change
chezmoi diff

# Dry run
chezmoi apply --dry-run

# Force apply
chezmoi apply --force
```

### Shell changes not taking effect

```bash
# Reload shell config
source ~/.bashrc  # or ~/.zshrc
```

### Git credential issues on WSL

Make sure `.gitconfig` includes WSL credential helper (automatically configured).

### Neovim plugins not installing

```bash
# Inside Neovim
:Lazy sync
:Mason
```

## Additional Resources

- [Chezmoi Documentation](https://www.chezmoi.io/)
- [Starship Documentation](https://starship.rs/)
- [Neovim Documentation](https://neovim.io/doc/)
