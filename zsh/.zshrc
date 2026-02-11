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
unalias rm
# git で ^ が使えない対策
unsetopt extended_glob
# *(wildcard)でドットファイルも対象にする
setopt GLOB_DOTS
# linux で mac の pbcopy みたいなものを実現
alias pbcopy='xsel --clipboard --input'
