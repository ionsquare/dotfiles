This project now lives at [gitlab](https://gitlab.com/ionsquare/dotfiles)
# Installation

```bash
# Clone repo with submodules
cd ~
git init
git remote add origin https://gitlab.com/ionsquare/dotfiles.git
git pull origin master
git submodule update --init --recursive

# Install vundle plugins
vim +PluginInstall

# Install zsh plugins
zsh

# Set zsh as default shell
sudo chsh -s /usr/bin/zsh username
```
