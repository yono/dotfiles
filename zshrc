##############################
# .zshrc
# UTF-8
#

#文字コードの設定
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

#emacslikeのキーバインドを有効に
bindkey -e

# undo
bindkey "^u" undo

#ヒストリの設定
HISTFILE=~/.histfile
HISTSIZE=10000000
SAVEHIST=10000000

#履歴ファイルに時刻を記録
setopt extended_history

#historyコマンドは履歴に登録しない
setopt hist_no_store

#補完するかの質問は画面を超える時にのみ行う。
LISTMAX=0

#複数のzshを同時に使う時など historyファイルに上書きせず追加
setopt append_history

#補完キー(Tab, Ctrl+I)を連打するだけで順に補完候補を自動で補完
setopt auto_menu autolist correct nobeep nonomatch
setopt listtypes pushdsilent

#カッコの対応などを自動的に補完
setopt auto_param_keys

#ディレクトリ名の補完で末尾の / を自動的に不可し、次の補完に備える
setopt auto_param_slash

#ビープ音を鳴らさないようにする
setopt No_beep

#直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups

#重複したヒストリは追加しない
setopt hist_ignore_all_dups

#ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify

#auto_list の補完候補一覧で、ls -Fのようにファイルの種別をマーク表示する
setopt list_types

#コマンドラインの引数で --prefix=/usrなどの = 以降でも補完できる
setopt magic_equal_subst

#ファイル名の展開でディレクトリにマッチした場合、尾に/を不可する
setopt mark_dirs

#8ビット目を通すようになり、日本語のファイル名を表示可能に
setopt print_eightbit

#シェルのプロセスごとに履歴を共有
setopt share_history

#ディレクトリスタックを有効にする
setopt auto_pushd
setopt pushd_ignore_dups

# グロッビング
setopt extended_glob

#Ctrl+wで直前の/までを削除する
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

#ディレクトリを水色にする
export LS_COLORS='di=01;36'
export LSCOLORS=gxfxxxxxBx

#ファイルリスト補完でもlsと同様に色をつける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#補完リストを矢印キーで選択
zstyle ':completion:*:default' menu select true

#今いるディレクトリを補完候補から外す
zstyle ':completion:*' ignore-parents parent pwd .

#COLOR
DEFAULT=$'%{\e[0;m%}'
GREEN=$'%{\e[1;32m%}'
YELLOW=$'%{\e[1;33m%}'
BLUE=$'%{\e[1;34m%}'
PURPLE=$'%{\e[1;34m%}'
RED=$'%{\e[1;31m%}'
BLACK=$'{%{\e[1;30m%}'
CYAN=$'%{\e[1;36m%}'

#プロンプト設定
unsetopt promptcr # 改行のない出力をプロンプトで上書きするのを防ぐ
setopt prompt_subst

autoload -Uz add-zsh-hook
autoload -Uz colors ; colors
autoload -Uz vcs_info

# vcs 設定
function _update_vcs_info_msg() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

PROMPT="${USER}@%m%  ${CYAN}[%~]${DEFAULT}
$ "

# ssh で remotehost を補完
function print_known_hosts (){
    if [ -f $HOME/.ssh/known_hosts ]; then
        cat $HOME/.ssh/known_hosts | tr ',' ' ' | cut -d' ' -f1
    fi
}
_cache_hosts=($( print_known_hosts ))

compctl -k _cache_hosts ssh_screen

typeset -ga precmd_functions
typeset -ga preexec_functions

autoload bashcompinit
bashcompinit

#zmv
alias rename="noglob zmv -W"

#webserver
alias servethis="python -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'"

### time
REPORTTIME=8
TIMEFMT="\
	The name of this job.             :%J
	CPU seconds spent in user mode.   :%U
	CPU seconds spent in kernel mode. :%S
	Elapsed time in seconds.          :%E
	The CPU percentage.               :%P"

#パスの設定
PATH=/usr/bin:/bin:/usr/sbin:/sbin
PATH=/usr/local/bin:$PATH
PATH=/usr/local/sbin:$PATH
PATH=.:$PATH
PATH=$HOME/bin:$PATH
PATH=$HOME/bin/fast-export:$PATH
PATH=$HOME/Dropbox/bin:$PATH
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

export MANPATH=/usr/local/man:/usr/share/man
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export EDITOR=vi
export PKG_CONFIG_PATH=/usr/lib/pkgconfig
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/Library/Frameworks/Mono.framework/Versions/Current/lib/pkgconfig:$PKG_CONFIG_PATH

# ls に色付け、ディレクトリは最後に / を付ける
alias ls='gls -F --color'
alias ll="ls -l"
alias la="ls -a"

#sudo でも補完の対象
zstyle ':complition:*:sudo:*' command-path /opt/local/bin/ /usr/local/sbin /usr/local/bin /usr /sbin /usr/bin /sbin /bin

# rbenv 利用設定
if [ -e $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Extra zshrc
[[ -e "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# hub
function git(){hub "$@"}

if [ -e /usr/local/bin/src-hilite-lesspipe.sh ]; then
  export LESS='-R'
  export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
fi

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

if [ -x "`which go`" ]; then
      export GOROOT=`go env GOROOT`
      export GOPATH=$HOME/code/go-local
      export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

fpath=(/usr/local/share/zsh/site-functions $fpath)

# brew install zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# brew install zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#autoload
autoload -U zmv
autoload -U compinit && compinit && compinit -i

# ghq
alias g='cd $(ghq root)/$(ghq list | fzf)'
