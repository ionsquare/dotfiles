# Installation

```bash
# Clone repo with submodules
cd ~
git init
git remote add origin git@github.com:ionsquare/dotfiles.git
git pull origin master
git submodule update --init --recursive

# Install vundle plugins
vim +PlugInstall

# Install zsh plugins
zsh

# Set zsh as default shell
sudo chsh -s /usr/bin/zsh username
