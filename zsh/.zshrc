# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# install prezto
# https://github.com/sorin-ionescu/prezto

# ubuntuなら以下の設定もしておくとよいかもしれない
# sudo update-alternatives --config editor
# sudo update-alternatives --config vi
#
# デフォルトだとgitのエディタがnano
# https://yukihane.github.io/blog/201807/27/set-git-commit-editor/
export VISUAL=/usr/bin/nvim
export EDITOR=/usr/bin/nvim
# デフォルトで rm -i になっている
(( ${+aliases[rm]} )) && unalias rm
# git で ^ が使えない対策
unsetopt extended_glob
# *(wildcard)でドットファイルも対象にする
setopt GLOB_DOTS
# linux で mac の pbcopy みたいなものを実現
if [[ "$OSTYPE" == linux* ]] && grep -qi microsoft /proc/sys/kernel/osrelease 2>/dev/null; then
  alias pbcopy='clip.exe'
elif [[ "$OSTYPE" == linux* ]]; then
  alias pbcopy='xsel --clipboard --input'
fi

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

export PATH=$HOME/.local/bin:$PATH

alias vi=nvim
alias vim=nvim

