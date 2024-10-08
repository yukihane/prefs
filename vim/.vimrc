" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
"Plug 'rust-lang/rust.vim'
"Plug 'racer-rust/vim-racer'
call plug#end()

" https://github.com/rust-lang/rust.vim
let g:rustfmt_autosave = 1
" https://github.com/racer-rust/vim-racer

" https://qiita.com/morikooooo/items/9fd41bcd8d1ce9170301
" setting
"文字コードをUFT-8に設定
set encoding=utf-8
set fileencodings=utf-8,cp932
" バックアップファイルを作らない
" set nobackup
" スワップファイルを作らない
" set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
" set autoread
" バッファが編集中でもその他のファイルを開けるように
" set hidden
" 入力中のコマンドをステータスに表示する
set showcmd


" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
" set cursorline
" 現在の行を強調表示（縦）
" set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
" set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk


" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
" set list listchars=tab:\▸\-
set list
set listchars=tab:^\-,trail:-,extends:^,precedes:<
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" https://blog.odoruinu.net/2014/01/29/how-to-turn-off-paste-mode-when-becoming-normal-mode-on-vim/
" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" https://github.com/rust-lang/rust.vim
let g:rustfmt_autosave = 1
let g:rust_clip_command = 'xclip -selection clipboard'
" https://github.com/racer-rust/vim-racer
set hidden
let g:racer_experimental_completer = 1

" https://stackoverflow.com/a/55979801
set mouse=
