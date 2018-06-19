# ===== Set powerline installation path ========================================
POWERLEVEL9K_INSTALLATION_PATH=$HOME/.antigen/bundles/ionsquare/powerlevel9k
export ANTIGEN_LOG=/tmp/antigen.log

# ===== Load Antigen ===========================================================
source ~/.antigen/antigen/antigen.zsh

# ===== Load oh-my-zsh library =================================================
antigen use oh-my-zsh

# ===== Plugins without special settings =======================================
antigen bundle sudo
antigen bundle zsh-completions
antigen bundle colored-man-pages
antigen bundle jocelynmallon/zshmarks
antigen bundle ssh://git@gitlab.com:22/ionsquare/zsh-plugins.git keybindings
type pygmentize >/dev/null && antigen bundle colorize
type composer   >/dev/null && antigen bundle composer
type docker     >/dev/null && antigen bundle docker
type ansible    >/dev/null && antigen bundle ansible
type kubectl    >/dev/null && antigen bundle kubectl
type git        >/dev/null && antigen bundle git
type tig        >/dev/null && antigen bundle tig

# ===== P9k-related ============================================================
type git     >/dev/null && antigen bundle ssh://git@gitlab.com:22/ionsquare/zsh-plugins.git p9k-git-branch-shortener
type kubectl >/dev/null && antigen bundle git@github.ibm.com:matthewh/zsh-plugins.git kubectl-config
antigen bundle ssh://git@gitlab.com:22/ionsquare/zsh-plugins.git p9k-prompt-switcher

# ===== IBM work-related plugins ===============================================
if [[ $user == 'matthewh' ]]; then
  antigen bundle git@github.ibm.com:matthewh/zsh-plugins.git cedp-bluegroups
fi
# TODO Find a way to access this on new systems
type gluster    >/dev/null && antigen bundle git@github.ibm.com:matthewh/zsh-plugins.git cedp-gluster

# ===== zsh-syntax-highlighting must be last ===================================
antigen bundle zsh-users/zsh-syntax-highlighting

# ===== Set theme ==============================================================
antigen theme ionsquare/powerlevel9k powerlevel9k

# ===== Apply Plugins ==========================================================
antigen apply



# ===== Syntax Highlighting (must be after `antigen apply`) ====================
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_STYLES[cursor]='bold'

ZSH_HIGHLIGHT_STYLES[alias]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green,bold'

ZSH_HIGHLIGHT_STYLES[path]='fg=159,underline'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=12'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=171'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=171'
ZSH_HIGHLIGHT_STYLES[assign]='fg=207'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=81'

# ===== Settings ===============================================================
export TERM="xterm-256color"
export EDITOR='vim'
# Fix some unreadable colours
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=91:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"


# DISABLE_UNTRACKED_FILES_DIRTY="true"  # Improve performance of git segment
DISABLE_AUTO_TITLE="true"               # Disable auto-setting terminal title.
COMPLETION_WAITING_DOTS="true"          # Display red dots whilst waiting for completion.
HIST_STAMPS="yyyy-mm-dd"                # Change the command execution timestamp in `history`
autoload -U compinit && compinit        # Load zsh-completions
setopt interactivecomments              # Allow comments in interactive shell
unsetopt HIST_VERIFY                    # Execute line on enter even if there are expansions

# ===== Aliases ================================================================
alias grep='\grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} --exclude ".*.sw[op]"'
alias ll='\ls -lp --group-directories-first --color=auto'
alias a=alsamixer
if [[ -d ~/.config/awesome ]]; then
  alias eA='cd ~/.config/awesome && vim rc.lua'
  alias cA='cd ~/.config/awesome'
fi
alias eZ='cd ~ && vim .zshrc'

# zshmarks aliases
alias j=jump
alias b=bookmark
alias s=showmarks

# Screenshot region to clipboard
alias scrotclip='scrot -s /tmp/scrotcliptemp.png --select && xclip -selection c -t image/png /tmp/scrotcliptemp.png && rm /tmp/scrotcliptemp.png'

# Override ghostscript command to do git status instead
alias gs='git status'

if type "task" > /dev/null; then
  alias ta='task add +work'
  alias tl='task log +work'
fi

if type "irssi" > /dev/null; then
  alias irssi='TERM=screen-256color irssi'
fi

if [[ -d "$HOME/.config/composer/vendor/bin" ]]; then
  export PATH="$HOME/.config/composer/vendor/bin:$PATH"
fi

if [[ -f $HOME/.env.zshrc ]]; then
  # Environment-dependent settings
  source $HOME/.env.zsh
fi

sssh(){
  # Keep trying to reconnect
  while true; do command ssh -o ConnectTimeout=10 "$@"; [ $? -eq 0 ] && break || sleep 1; done
}
