#----------zsh plugin----------
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
fi
source $HOME/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# コマンド履歴から推測し、候補として表示するプラグイン。
zinit light 'zsh-users/zsh-autosuggestions'
# Zshの候補選択を拡張するプラグイン。
zinit light 'zsh-users/zsh-completions' 
# cdの拡張
zinit light "b4b4r07/enhancd" 
# プロンプトのコマンドを色づけするプラグイン
zinit light "zsh-users/zsh-syntax-highlighting"
# theme
zinit light "agkozak/agkozak-zsh-theme"
#zinit light 'yous/lime'
#zinit light 'sindresorhus/pure'
# シェルの設定を色々いい感じにやってくれる。
zinit light 'yous/vanilli.sh' 
zinit light 'zsh-users/zsh-history-substring-search'

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# プロンプトの右側(RPROMPT)にメソッドの結果を表示させる
# Customize to your needs...
export LANG=en_US.UTF-8

# pipen 
export PIPENV_VENV_IN_PROJECT=true

# 補完候補のカーソル選択を有効にする設定
zstyle ':completion:*:default' menu select=1

# コマンドエラーの修正
setopt nonomatch

#補完を大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# パスを追加したい場合
export PATH="$HOME/bin:$PATH"

# 色を使用
autoload -Uz colors
colors

# グローバルエイリアス
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'
alias -g GI='| grep -ri'

# エイリアス
alias l='ls --color=auto -ltr'
alias la='ls --color=auto -la'
alias ls='ls --color=auto -l'
alias c='clear'
alias load='exec $SHELL -l'
alias sudo='sudo -E '
alias reboot='sudo reboot'
alias aptu='sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y'
alias vi='vim'
alias vz='vim ~/.zshrc'
alias sl='sl'
# historyに日付を表示
alias h='fc -lt '%F %T' 1'
alias cp='cp -i'
alias rm='rm -rf'
alias diff='diff -U1'

# backspace,deleteキーを使えるように
stty erase ^H
bindkey "^[[3~" delete-char 

# 補完後、メニュー選択モードになり左右キーで移動が出来る
zstyle ':completion:*:default' menu select=2

# mkdirとcdを同時実行
function mkcd() {
  if [[ -d $1 ]]; then
    echo "$1 already exists!"
    cd $1
  else
    mkdir -p $1 && cd $1
  fi
}

function all-kill(){
  if [[ -n $1 ]]; then
    ps aux | grep $1 | grep -v grep | awk '{ print "kill -9", $2 }' | zsh
  else
    echo 'not found process name'
  fi
}

zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

HISTFILE=~/.zsh_historyx
HISTSIZE=10000
SAVEHIST=10000

## 補完候補をキャッシュする。
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zsh/cache
## 詳細な情報を使わない
zstyle ':completion:*' verbose no

## sudo の時にコマンドを探すパス
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

setopt no_beep  # 補完候補がないときなどにビープ音を鳴らさない。
setopt no_nomatch # git show HEAD^とかrake foo[bar]とか使いたい
setopt prompt_subst  # PROMPT内で変数展開・コマンド置換・算術演算を実行
setopt transient_rprompt  # コマンド実行後は右プロンプトを消す
# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# 古いコマンドと同じものは無視 
setopt hist_save_no_dups
setopt hist_reduce_blanks
setopt hist_no_store
setopt hist_verify
setopt share_history  # シェルのプロセスごとに履歴を共有
setopt extended_history  # 履歴ファイルに時刻を記録
setopt append_history  # 複数の zsh を同時に使う時など history ファイルに上書きせず追加
setopt auto_list  # 補完候補が複数ある時に、一覧表示
setopt auto_menu  # 補完候補が複数あるときに自動的に一覧表示する
unsetopt list_beep
setopt complete_in_word  # カーソル位置で補完する。

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
### End of Zinit's installer chunk

# pyenv起動設定
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
