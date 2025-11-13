function DotfilesFn {git --git-dir=$HOME/.dotfiles --work-tree=$HOME @Args}

Set-Alias -Name dotfiles -Value DotfilesFn

oh-my-posh init pwsh --config "C:\Users\crsmi\AppData\Local\Programs\oh-my-posh\themes\catppuccin_frappe.omp.json" | Invoke-Expression

# PSReadLine Configuration for bash-like behavior
Import-Module PSReadLine

# Set editing mode to Emacs (bash-like)
Set-PSReadLineOption -EditMode Emacs

# History search (existing)
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Tab completion settings
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key Shift+Tab -Function TabCompletePrevious

# Enable case-insensitive completion like bash
Set-PSReadLineOption -CompletionQueryItems 100

# Bash-like completion behavior
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Show tooltips for completions
Set-PSReadLineOption -ShowToolTips

# Bell settings (like bash)
Set-PSReadLineOption -BellStyle Visual

# History settings
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -MaximumHistoryCount 4000

# Additional bash-like key bindings
Set-PSReadLineKeyHandler -Key Ctrl+a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Key Ctrl+e -Function EndOfLine
Set-PSReadLineKeyHandler -Key Ctrl+k -Function ForwardDeleteLine
Set-PSReadLineKeyHandler -Key Ctrl+u -Function BackwardDeleteLine
Set-PSReadLineKeyHandler -Key Ctrl+w -Function BackwardDeleteWord
Set-PSReadLineKeyHandler -Key Alt+d -Function DeleteWord
Set-PSReadLineKeyHandler -Key Ctrl+LeftArrow -Function BackwardWord
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord
Set-PSReadLineKeyHandler -Key Ctrl+r -Function ReverseSearchHistory

# Enable inline help/suggestions
Set-PSReadLineKeyHandler -Key F1 -Function ShowCommandHelp

# Bash-like word movement with Alt+b and Alt+f
Set-PSReadLineKeyHandler -Key Alt+b -Function BackwardWord
Set-PSReadLineKeyHandler -Key Alt+f -Function ForwardWord

$env:RUST_BACKTRACE = "full"
$env:RUST_LOG = "debug"
$env:CARGO_INCREMENTAL = "1"
$env:CARGO_TARGET_DIR = "target"    

if ($env:TERM_PROGRAM -eq "vscode") { . "$(code --locate-shell-integration-path pwsh)" }
