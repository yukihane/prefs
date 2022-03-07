# install prezto
# https://github.com/sorin-ionescu/prezto

# デフォルトだとgitのエディタがnano
# https://yukihane.github.io/blog/201807/27/set-git-commit-editor/
export VISUAL=/usr/bin/vim
export EDITOR=/usr/bin/vim
# デフォルトで rm -i になっている
unalias rm
# git で ^ が使えない対策
unsetopt extended_glob
# linux で mac の pbcopy みたいなものを実現
alias pbcopy='xsel --clipboard --input'
