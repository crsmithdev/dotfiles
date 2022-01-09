# dotfiles - personal dotfiles

## Background

This repostitory stores dotfiles in a git repository shared publicly on Github.  This method grants all the benefits of source control to system and application configuration and makes setting them up on new hosts quick and straightforward.

Relevant reading:

- [The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles).
- [The Bare Repo Approach to Storing Home Directory Config Files (Dotfiles) in Git using Bash, Zsh, or Powershell](https://dev.to/bowmanjd/store-home-directory-config-files-dotfiles-in-git-using-bash-zsh-or-powershell-the-bare-repo-approach-35l3).

...and [many other](https://www.google.com/search?client=firefox-b-1-d&q=dotfiles+bare+git+) resources.

## Installation

Because the repo doesn't exist yet locally, you'll have to get and run the appropriate script from the repository, and run it manually.  Download [`bin/dotfiles-init.sh`](https://raw.githubusercontent.com/crsmithdev/dotfiles/main/bin/dotfiles-init.sh) if creating a dotfiles repo for the first time, or [`bin/dotfiles-restore.sh`](https://raw.githubusercontent.com/crsmithdev/dotfiles/main/bin/dotfiles-restore.sh) if restoring dotfiles to a new environment.

The quick, one-line way to do this, by example:

`` bash -i <(curl -Ls https://raw.githubusercontent.com/crsmithdev/dotfiles/main/bin/dotfiles-restore.sh)``

Alternatively, download the appropriate raw script file and run it with `sh <path/to/dotfiles-script.sh>`.

You may run into conflicts if restoring, as in:

```
error: The following untracked working tree files would be overwritten by checkout:
        .gitconfig
        bin/dotfiles-init.sh
        bin/dotfiles-restore.sh
        ...
```

In this case, delete or move the existing files, follow the instructions and run `dotfiles checkout` to finish the checkout, and then manually merge any committed files with their local versions, if needed.
