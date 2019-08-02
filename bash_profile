export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH:$HOME/bin"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export EDITOR=vi

c_cyan=`tty -s && tput setaf 6`
c_red=`tty -s && tput setaf 1`
c_green=`tty -s && tput setaf 2`
c_sgr0=`tty -s && tput sgr0`

parse_git_branch ()
{
  if git rev-parse --git-dir >/dev/null 2>&1
  then
      gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  else
      return 0
  fi
  echo -e [$gitver]
}

branch_color ()
{
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    color=""
    if git diff --quiet 2>/dev/null >&2
    then
      color="${c_green}"
    else
      color=${c_red}
    fi
  else
    return 0
  fi
 echo -ne $color
}

PS1='\u@\h:\w \[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]\$ '
PROMPT_COMMAND='echo -ne "\033]0; ${PWD}\007"'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
