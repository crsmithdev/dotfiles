# WSL Setup Guide

Complete setup instructions for Windows Subsystem for Linux (WSL).

## Prerequisites

1. **Install WSL 2** (Windows 11 or Windows 10 version 2004+)

```powershell
# PowerShell (Admin)
wsl --install -d Ubuntu
wsl --set-default-version 2
```

2. **Update WSL kernel**

```powershell
wsl --update
```

## Install Dotfiles

```bash
# Inside WSL
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply crsmithdev/dotfiles
```

## WSL-Specific Configuration

### 1. Windows Terminal Integration

The dotfiles include Windows Terminal configuration in `AppData/Local/Packages/`.

Apply from Windows PowerShell:
```powershell
chezmoi apply
```

### 2. Docker Desktop Integration

Ensure Docker Desktop for Windows is installed and WSL 2 backend is enabled:

Settings → General → "Use the WSL 2 based engine"

The `.bashrc`/`.zshrc` automatically sets `DOCKER_HOST` for WSL.

### 3. Git Credential Manager

Git credentials are shared with Windows. The `.gitconfig` template automatically configures the Windows credential manager.

### 4. WSL Configuration

The dotfiles include `.wslconfig` for optimal WSL 2 settings.

## Recommended Tools

```bash
# Build essentials
sudo apt update
sudo apt install build-essential

# Modern CLI tools
sudo apt install \
  bat \
  ripgrep \
  fd-find \
  fzf

# Install eza
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install eza

# Starship prompt
curl -sS https://starship.rs/install.sh | sh

# Neovim (latest)
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
```

## WSL Tips

### Access Windows Files

```bash
cd /mnt/c/Users/YourUsername/
```

### Open Files in Windows Applications

```bash
# Open file with default Windows app
explorer.exe file.txt

# Open current directory in Windows Explorer
explorer.exe .

# Open URL in Windows browser
wslview https://example.com
```

### VS Code Integration

```bash
# Install VS Code Server (run from WSL)
code .
```

### Performance Optimization

1. **Place projects in WSL filesystem** (`~/projects`) for better performance
2. **Don't use `/mnt/c/` for development** - cross-filesystem operations are slow
3. **Configure `.wslconfig`** (included in dotfiles) to limit memory usage

### systemd Support

WSL 2 supports systemd (enabled in `.wslconfig`):

```bash
# Check systemd status
systemctl status

# Start services
sudo systemctl start docker
```

## Troubleshooting

### High memory usage

Edit `~/.wslconfig`:
```ini
[wsl2]
memory=8GB
processors=4
```

### Network issues

```bash
# Reset WSL network
wsl --shutdown
# Restart WSL
```

### File permissions

```bash
# Set default umask in .bashrc
umask 022
```

## Additional Resources

- [WSL Documentation](https://docs.microsoft.com/en-us/windows/wsl/)
- [WSL GitHub](https://github.com/microsoft/WSL)
