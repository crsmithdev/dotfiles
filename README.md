# dotfiles

Development environment configuration managed by [chezmoi](https://www.chezmoi.io/).

## Quick Start

```bash
# Clone and apply dotfiles
chezmoi init https://github.com/crsmithdev/dotfiles
chezmoi apply

# Or if already cloned
chezmoi apply

# Verify installation
ls -la ~/{.claude,.tmux.conf,.ssh/config}
```

## What's Included

### Shell Environment
- **Bash** (`.bashrc`): Comprehensive configuration with aliases, functions, PATH management
- **ZSH** (`.zshrc`): Oh-My-Zsh integration with plugins and modern tools
- **Starship**: Universal prompt with Catppuccin Frappé theme (works on all shells)
- Modern CLI aliases: eza (ls), bat (cat), zoxide (cd), ripgrep, fzf

### Version Control
- **Git** (`.gitconfig`): Extensive aliases, sensible defaults, platform-specific settings
- **Global gitignore**: Comprehensive patterns for OS files, IDEs, build artifacts
- **SSH config**: GitHub/GitLab integration
- **Git credential helpers**: Platform-specific (WSL, macOS, Linux)

### Editor & IDE
- **Neovim**: Full Lua configuration with LSP, Treesitter, completion
  - Plugin manager: lazy.nvim
  - LSP servers: rust-analyzer, pyright, tsserver, gopls, lua_ls
  - Theme: Catppuccin Frappé
  - File explorer, fuzzy finder (Telescope), Git signs
- **EditorConfig**: Universal style enforcement across all editors

### Language Tooling
- **Node.js** (`.npmrc`): Performance optimizations, security settings
- **Rust** (`.cargo/config.toml`): Fast linker setup, profile optimization, aliases
- **Python**: pyenv integration, development environment
- **Go**: GOPATH and bin directory setup
- **Version pins**: `.tool-versions`, `.node-version`, `.python-version`
- **ripgrep** (`.ripgreprc`): Smart defaults with color themes

### Terminal & Multiplexer
- **Tmux** (`.tmux.conf`): Catppuccin Frappé theme, sensible keybindings
- **Windows Terminal**: Theme and font configuration (Hack Nerd Font)
- **PowerShell**: oh-my-posh integration, bash-like keybindings

### Claude Code Integration
- **Commands**: 18+ custom slash commands (ship, audit, check, batch, etc.)
- **Scripts**: 12 helper scripts (git-cache, session, meta, state, status)
- **Settings**: Permissions, plugins, hooks, model configuration
- **OpenSpec**: AI-native development workflow system

### Platform Support
- **WSL**: Credential helper, Docker integration, systemd support
- **macOS**: Homebrew integration, keychain credential helper
- **Linux**: XDG directories, apt/dnf package manager compatibility
- **Windows**: AppData configs, PowerShell profile

### Documentation
- **Setup guides**: Platform-specific instructions (WSL, macOS, Linux)
- **Tool references**: Installation and configuration guides
- **Troubleshooting**: Common issues and solutions

## Directory Structure

```
dotfiles/
├── .claude/              # Claude Code commands and scripts
│   ├── commands/         # Custom slash commands (18+)
│   ├── scripts/          # Helper scripts (git-cache, session, batch, etc.)
│   ├── CLAUDE.md         # Project-specific AI instructions
│   └── settings.json     # Permissions, plugins, hooks
├── .config/              # XDG config directory
│   ├── nvim/             # Neovim configuration (Lua)
│   └── starship/         # Starship prompt theme
├── .ssh/                 # SSH configuration
├── AppData/              # Windows-specific configs
├── Documents/            # Windows PowerShell profile
├── bin/                  # Executable scripts
├── docs/                 # Documentation
│   ├── SETUP.md          # Complete setup guide
│   └── setup-wsl.md      # WSL-specific guide
├── dot_bashrc            # Bash configuration
├── dot_zshrc             # ZSH configuration
├── dot_gitconfig.tmpl    # Git configuration template
├── dot_gitignore_global  # Global gitignore patterns
├── dot_editorconfig      # Universal editor configuration
├── dot_npmrc             # Node.js/npm configuration
├── dot_cargo/            # Rust/Cargo configuration
├── dot_tool-versions     # asdf version pins
├── chezmoi.toml          # Chezmoi configuration
├── README.md             # This file
└── wsl.conf              # WSL system configuration
```

## Installation

### Quick Install

```bash
# Install chezmoi and apply dotfiles in one command
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply crsmithdev/dotfiles
```

### Detailed Setup

For complete installation instructions including tool installation and platform-specific setup:

**[📖 Complete Setup Guide](docs/SETUP.md)**

Platform-specific guides:
- [WSL Setup](docs/setup-wsl.md)
- [macOS Setup](docs/setup-macos.md) *(coming soon)*
- [Linux Setup](docs/setup-linux.md) *(coming soon)*

### Manual Installation

1. **Install chezmoi**:
   ```bash
   curl -sSL https://get.chezmoi.io | bash
   ```

2. **Initialize and apply dotfiles**:
   ```bash
   chezmoi init https://github.com/crsmithdev/dotfiles
   chezmoi apply
   ```

3. **Configure user data** (edit `~/.config/chezmoi/chezmoi.toml`):
   ```toml
   [data]
       username = "Your Name"
       email = "your.email@example.com"
   ```

4. **Reapply with user data**:
   ```bash
   chezmoi apply
   ```

5. **Install recommended tools**:
   ```bash
   # Install Starship prompt
   curl -sS https://starship.rs/install.sh | sh

   # Install modern CLI tools (see docs/SETUP.md for full list)
   # macOS: brew install eza bat ripgrep fd zoxide fzf
   # Linux: See platform-specific guide
   ```

### After Installation

Reload shell configuration:
```bash
source ~/.bashrc  # or ~/.zshrc
```

Verify installation:
```bash
# Check shell config
echo $SHELL

# Check Starship prompt
starship --version

# Check Neovim
nvim --version

# Check Claude Code
ls -la ~/.claude/commands/
```

## Common Tasks

### Update dotfiles from source
```bash
chezmoi update
```

### Make local changes (don't commit)
```bash
chezmoi edit ~/.tmux.conf
chezmoi apply  # Apply to actual file
```

### See what chezmoi would change
```bash
chezmoi diff
```

### Add new file to dotfiles
```bash
chezmoi add ~/.config/nvim
git -C ~/.local/share/chezmoi add ...
git -C ~/.local/share/chezmoi commit -m "add nvim config"
```

## Configuration

### Chezmoi
- **Source directory**: `~/.local/share/chezmoi`
- **Config file**: `chezmoi.toml`
- **Docs**: https://www.chezmoi.io/reference/

### Python Development
- **Style guide**: `config/python-style.md`
- **Tool config**: `config/pyproject.toml`
- **Pre-commit**: `config/.pre-commit-config.yaml`

### Claude Code
- **Commands**: `~/.claude/commands/`
- **Scripts**: `~/.claude/scripts/`

## Platform-Specific Notes

### Windows + WSL
- AppData configs are symlinked from Windows home directory
- `wsl.conf` configures WSL behavior
- VS Code and Windows Terminal settings sync automatically

### macOS
- Ensure Homebrew is installed for tool installation
- SSH keys should have correct permissions (`chmod 600`)

### Linux
- Ensure `~/.ssh/` directory has correct permissions (`chmod 700`)
- Install `tmux` if not present: `sudo apt-get install tmux`

## Contributing

When modifying dotfiles:
1. Test changes locally with `chezmoi diff` and `chezmoi apply`
2. Commit to git in the source directory: `git -C ~/.local/share/chezmoi commit`
3. Push: `git -C ~/.local/share/chezmoi push`

## Secrets Management

**IMPORTANT**: Never commit private SSH keys, API keys, or credentials.

- `.gitignore` prevents accidental commits of `.ssh/*` (except config)
- Sensitive configuration should use environment variables
- Use `.env` or `.env.local` for development secrets (not in git)

## Support

- Chezmoi docs: https://www.chezmoi.io/
- Issue tracker: https://github.com/crsmithdev/dotfiles/issues
