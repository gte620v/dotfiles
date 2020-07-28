## source prezto ##
if [[ -s "${ZDOTDIR:-$HOME}/dotfiles/prezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/dotfiles/prezto/init.zsh"
fi


## theme ##
autoload -Uz promptinit
promptinit
prompt steeef

## set history size ##
HISTSIZE=100000
SAVEHIST=100000

## custom aliases ##
alias ll="ls -larth"
alias -s txt=less
alias df="df -h"
alias du="du -h"
alias grep="grep --color"
alias today="date +%F"
alias gl="git pull --rebase"
alias g=git
alias h=brew
alias c=conda
agr () { ag $1 --ignore="*.html" }

# get my IP
myip () { ifconfig | grep "inet " | awk '{ print $2 }' | grep -v "^127" }

# less for stderr
sess () { $1 2>&1 >/dev/null | less }

# update prezto
update_prezto() {
  cd $ZPREZTODIR
  git pull
  git submodule update --init --recursive
}

## set editors ##
export EDITOR=vim
# alias vim to neovim and old vim to shitvim
alias vim=nvim
alias shitvim=vim
harrass() {
  echo "you're fucking kidding, right?"
}
alias emacs=harrass

## utilities for random numbers ##
rand () {
  echo $(head -1 /dev/urandom | od -N 10 | awk '{print $2}')
}

gsl_rand() {
  export GSL_RNG_SEED=$(rand)
}

# syntax highlighting for less
LESSOPEN="|/usr/local/bin/lesspipe.sh %s"; export LESSOPEN  #(sh like shells)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

nag () {
  ag $1 --ignore="*.html" --ignore="*.ipynb"
}

# shell integration for zsh/iTerm2
source ~/.iterm2_shell_integration.zsh

# latexdiff two arbitrary commits
pdfdiff() {
  rm -f .pdfdiff_diff.tex .pdfdiff_old.tex .pdfdiff_new.tex
  if [ "$#" -eq 1 ]; then
    local OLD_COMMIT="HEAD^"
    local NEW_COMMIT="HEAD"
    elif [ "$#" -eq 3 ]; then
  elif [ "$#" -eq 3 ]; then
    local OLD_COMMIT=$2
    local NEW_COMMIT=$3
  else
    echo "usage: pdfdiff file.tex [old-commit] [new-commit]\n    by default, old-commit = HEAD^, new-commit = HEAD"
    exit 1
  fi
  local REF="$(git rev-parse --show-prefix)$1"
  echo "$OLD_COMMIT:$REF"
  git show "$OLD_COMMIT:$REF" > .pdfdiff_old.tex
  git show "$NEW_COMMIT:$REF" > .pdfdiff_new.tex
  latexdiff .pdfdiff_old.tex .pdfdiff_new.tex > .pdfdiff_diff.tex
  latexmk -xelatex -pvc .pdfdiff_diff.tex
}

alias nb=jupyter notebook
alias ip=ipython

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/bob/opt/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/bob/opt/miniconda/etc/profile.d/conda.sh" ]; then
        . "/Users/bob/opt/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/Users/bob/opt/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


alias idea="vim ~/projects/ideas/ideas.md"

app() {
  /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --app="$1"
}

jlab() {
  /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --app=http://localhost:8890
}
