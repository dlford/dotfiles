# Dotfiles

This is my consolidated config for Linux. Each branch is a different machine, default branch will always be my main workstation.

## Usage

Once the alias `dotfiles` is setup, you can use it instead of `git`, for example:

- `dotfiles status`
- `dotfiles add .zshrc`
- `dotfiles commit ...`
- `dotfiles push`

## Creating a New Empty Config

1. Create an empty git repo - `git init --bare $HOME/.dotfiles`
2. Alias the current session - `alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
3. Hide untracked files - `dotfiles config --local status.showUntrackedFiles no`
4. Don't forget to add the `dotfiles` alias from step 2 to your `.bashrc`/`.zshrc`/etc

- `echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc`

## Adding an Existing Config to a New Machine

1. Clone the repo - `git clone --bare https://github.com/USERNAME/dotfiles.git $HOME/.dotfiles`
2. Alias the current session - `alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
3. Checkout your branch if needed `dotfiles checkout BRANCH`
4. Checkout your files `dotfiles checkout`

- Note: This will fail if any files would be overwritten, you'll have to move or delete them.
