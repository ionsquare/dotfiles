source ~/.antigen/antigen/antigen.zsh
antigen use oh-my-zsh

# ===== Powerlevel9k ===========================================================
function p9kdefaults(){
  unset POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR
  unset POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR

  # Segments
  POWERLEVEL9K_MODE="nerdfont-complete"
  POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"

  #POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator context dir vcs)
  #POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs vi_mode time)
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time root_indicator context $kubectl dir $vcs background_jobs status command_execution_time vi_mode)
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

  POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{cyan}\u256D\u2500%f"
  POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{cyan}\u2570\uF460%f "

  POWERLEVEL9K_SHORTEN_STRATEGY=truncate_with_package_name
  POWERLEVEL9K_DIR_PACKAGE_FILES=(powerlevel9k.json .powerlevel9k.json composer.json)
  POWERLEVEL9K_SHORTEN_DIR_LENGTH=50

  # Colours and format
  POWERLEVEL9K_PROMPT_ON_NEWLINE=true

  DEFAULT_USER=matthewh
  POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='black'
  POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='71'    # green
  POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND='yellow'
  POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND='red'

  POWERLEVEL9K_DIR_HOME_FOREGROUND='38'
  POWERLEVEL9K_DIR_HOME_BACKGROUND='black'
  POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='38'
  POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='black'
  POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='202'
  POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='black'

  POWERLEVEL9K_TIME_BACKGROUND='clear'
  POWERLEVEL9K_TIME_FOREGROUND='28'
  POWERLEVEL9K_TIME_ICON=''

  POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='black'
  POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='yellow'
  POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=1

  POWERLEVEL9K_STATUS_ERROR_BACKGROUND='black'
  POWERLEVEL9K_STATUS_ERROR_FOREGROUND='red'

  POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='101'
  POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='0'

  POWERLEVEL9K_VI_INSERT_MODE_STRING=''
  POWERLEVEL9K_VI_COMMAND_MODE_STRING='VICMD'
  POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='blue'
}

# ===== Git-related (+P9k) =====================================================
if type git >/dev/null; then
  antigen bundle git
  type tig        >/dev/null && antigen bundle tig

  vcs=vcs
  # ===== Custom shortening of git branch ==========
  function +vi-git-modbranch() {
    local branch
    branch=$hook_com[branch]
    branch=$(echo $branch | sed 's@matthewh/\([^/]*\)/.*@\1@g')
    if [[ $hook_com[branch] != "$branch" ]]; then
      hook_com[branch]="[$branch]"
    fi
  }

  POWERLEVEL9K_VCS_GIT_HOOKS=(git-modbranch vcs-detect-changes git-untracked git-aheadbehind git-stash git-remotebranch git-tagname)
fi

# ===== Custom kubectl segment to show active config (P9k) =====================
if type kubectl >/dev/null 2>&1; then
  kubectl=custom_kubectl_config

  # ===== Custom segment for showing config ========
  function zsh_kubectl_config(){
    if [[ -z $KUBECONFIG ]]; then
      return
    fi

    local a="${${KUBECONFIG#*co-creators/}%%/*}"
    if [[ -z $a ]]; then
      namespace=${KUBECONFIG##*/}
    else
      namespace=$a
    fi

    if [[ ${KUBECONFIG##*/} != "config" ]]; then
      namespace="${namespace}.${KUBECONFIG##*.}"
    fi
    #color='%F{magenta}'
    #echo -n "%{$color%}$namespace%{%f%}"
    echo -n "$namespace%{%f%}"
  }
  POWERLEVEL9K_CUSTOM_KUBECTL_CONFIG="zsh_kubectl_config"
  POWERLEVEL9K_CUSTOM_KUBECTL_CONFIG_BACKGROUND="black"
  POWERLEVEL9K_CUSTOM_KUBECTL_CONFIG_FOREGROUND="red"
  # ================================================
fi

# ===== Load P9k ===============================================================
p9kdefaults
export POWERLEVEL9K_INSTALLATION_PATH=$HOME/.antigen/bundles/ionsquare/powerlevel9k
antigen theme ionsquare/powerlevel9k powerlevel9k
# ===== IBM work-related plugins ===============================================
antigen bundle git@github.ibm.com:matthewh/zsh-plugins.git cedp-bluegroups
type gluster    >/dev/null && antigen bundle git@github.ibm.com:matthewh/zsh-plugins.git cedp-gluster

# ===== Plugins without special settings =======================================
antigen bundle sudo
antigen bundle zsh-completions
antigen bundle colored-man-pages
antigen bundle jocelynmallon/zshmarks
type pygmentize >/dev/null && antigen bundle colorize
type composer   >/dev/null && antigen bundle composer
type docker     >/dev/null && antigen bundle docker
type ansible    >/dev/null && antigen bundle ansible
type kubectl    >/dev/null && antigen bundle kubectl

# zsh-syntax-highlighting must be last
antigen bundle zsh-users/zsh-syntax-highlighting

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


# Disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Change the command execution timestamp in `history`
HIST_STAMPS="yyyy-mm-dd"

# Improve performance of git segment
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Load zsh-completions
autoload -U compinit && compinit # Load zsh-completions

# Allow comments in interactive shell
setopt interactivecomments

# Execute line on enter even if there are expansions
unsetopt HIST_VERIFY

# ===== Key Bindings ===========================================================
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "Oc" forward-word
bindkey "Od" backward-word
bindkey \^U backward-kill-line
bindkey '[1~' beginning-of-line
bindkey '[4~' end-of-line

# ===== Shell forward/backward functionality (ctrl+shift+arrow) ================
shell-backward-word() {
	emulate -L zsh
	local words word spaces
	words=(${(z)LBUFFER})
	word=$words[-1]
	spaces=-1
	while [[ $LBUFFER[$spaces] == " " ]]; do
			(( spaces-- ))
	done
	(( CURSOR -= $#word - $spaces - 1 ))
}
bindkey "[1;6D" shell-backward-word
zle -N shell-backward-word

shell-forward-word() {
	emulate -L zsh
	local words word spaces
	words=(${(z)RBUFFER})
	word=$words[1]
	spaces=1
	while [[ $RBUFFER[$spaces] == " " ]]; do
		(( spaces++ ))
	done
	(( CURSOR += $#word + $spaces - 1 ))
}
bindkey "[1;6C" shell-forward-word
zle -N shell-forward-word

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

# ===== Move this to its own plugin later ======================================

function p9kadd(){
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=($POWERLEVEL9K_LEFT_PROMPT_ELEMENTS $1)
  source $POWERLEVEL9K_INSTALLATION_PATH/powerlevel9k.zsh-theme
}
function p9kremove(){
  a=($POWERLEVEL9K_LEFT_PROMPT_ELEMENTS)
  a=("${(@)a:#$1}")
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=($a)

  echo $POWERLEVEL9K_LEFT_PROMPT_ELEMENTS

  source $POWERLEVEL9K_INSTALLATION_PATH/powerlevel9k.zsh-theme
}

# Change prompt theme
function chp(){
  # Set baseline values
  p9kdefaults
  
  # Change based on input
  case "$1" in
    paste)
      #POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR="#"
      #POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="#"
      POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR="»"
      POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=""

      #POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{cyan}#%f"
      #POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{cyan}$%f "
      POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{cyan}\u256D\u2500%f"
      POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{cyan}\u2570»%f "
      
      POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator context custom_kubectl_config dir)
      POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
      POWERLEVEL9K_HOME_ICON=''
      POWERLEVEL9K_HOME_SUB_ICON=''
      POWERLEVEL9K_FOLDER_ICON=''
      ;;
    limit)
      if [[ "$2" == [1-9] ]]; then
        POWERLEVEL9K_SHORTEN_DIR_LENGTH="$2"
      else
        POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
      fi
      POWERLEVEL9K_SHORTEN_STRATEGY="Default"
      ;;
    short)
      if [[ "$2" == [1-9] ]]; then
        POWERLEVEL9K_SHORTEN_DIR_LENGTH="$2"
      else
        POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
      fi
      ;;
    unique)
      POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
      ;;
    full)
      POWERLEVEL9K_SHORTEN_STRATEGY=None
      ;;
    normal)
      ;;
    *)
      echo "Options:"
      echo "  paste       Use minimal segments for easy pasting"
      echo "  limit [n]   Show only the last n directories (default 2)"
      echo "  short [n]   Shorten each dir to n characters (default 3)"
      echo "  unique      Set directory shortening strategy to unique"
      echo "  full        Reset to default long listing"
      echo "  normal      Reset to default long listing with project name root"
      return
      ;;
  esac

  source $POWERLEVEL9K_INSTALLATION_PATH/powerlevel9k.zsh-theme
}

sssh(){
  # Keep trying to reconnect
  while true; do command ssh -o ConnectTimeout=10 "$@"; [ $? -eq 0 ] && break || sleep 1; done
}
