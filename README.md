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

### Development Tools
- **Claude Code**: Commands (ship, check, new, quick, batch) and scripts (git cache, session manager)
- **Git**: SSH config, global ignore patterns
- **Tmux**: Terminal multiplexer config with Catppuccin Frappé theme
- **Python**: Ruff, mypy, pytest, pre-commit hook configurations
- **Shell**: Aliases, functions, PATH setup for development

### Configuration Files
- `.claude/` - Claude Code commands and helper scripts
- `.ssh/config` - SSH key and hostname configuration
- `.tmux.conf` - Tmux keybindings and theme
- `config/` - Tool configurations (ruff, mypy, pytest, pre-commit, VS Code, Windows Terminal)
- `bin/` - Utility scripts (claude wrapper for session restart)
- `wsl.conf` - WSL Ubuntu configuration

## Directory Structure

```
dotfiles/
├── .claude/              # Claude Code commands and scripts
│   └── scripts/          # Helper scripts (git-cache.sh, session.sh, batch.sh)
├── .ssh/                 # SSH configuration
├── AppData/              # Windows-specific configs (symlinked from Windows)
├── Documents/            # Windows PowerShell profile
├── bin/                  # Executable scripts
├── config/               # Tool configurations (ruff, pyproject.toml, etc.)
├── chezmoi.toml          # Chezmoi configuration
├── README.md             # This file
└── wsl.conf              # WSL Ubuntu system configuration
```

## Installation

### New System Setup

1. **Install chezmoi** (if not already installed):
   ```bash
   curl -sSL https://get.chezmoi.io | bash
   ```

2. **Initialize dotfiles**:
   ```bash
   chezmoi init https://github.com/crsmithdev/dotfiles
   ```

3. **Preview changes**:
   ```bash
   chezmoi diff
   ```

4. **Apply dotfiles**:
   ```bash
   chezmoi apply
   ```

5. **WSL-specific setup** (if on Windows Subsystem for Linux):
   ```bash
   sudo cp ~/dotfiles/wsl.conf /etc/wsl.conf
   wsl --shutdown  # Restart WSL to apply changes
   ```

### After Installation

Reload shell configuration:
```bash
source ~/.bashrc
# or
exec bash
```

Verify installation:
```bash
# Check Claude Code
ls -la ~/.claude/

# Check git SSH
cat ~/.ssh/config

# Check tmux
tmux list-keys | head
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
