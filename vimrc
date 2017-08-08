" dein.vim settings
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})
call dein#add('Shougo/vimshell.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler.vim')
"call dein#add('sudo.vim')
"call dein#add('cohama/lexima.vim')
call dein#add('editorconfig/editorconfig-vim')
"call dein#add('scrooloose/syntastic')
"call dein#add('pmsorhaindo/syntastic-local-eslint.vim')
call dein#add('tomasr/molokai')
call dein#add('mattn/emmet-vim')
call dein#add('itchyny/lightline.vim')
call dein#add('rhysd/vim-gfm-syntax')
call dein#add('mattn/benchvimrc-vim')
"call dein#add('MetalPhaeton/easybracket-vim')

call dein#end()

" 行番号表示
set number
" カーソル行の背景色を変える
"set cursorline
" カーソル位置のカラム背景色を変える
"set cursorcolumn
" ステータス行を常に表示
set laststatus=2
" メッセージ表示欄を2行確保
set cmdheight=2
" 対応括弧に不等号を追加
set matchpairs& matchpairs+=<:>
" 対応する括弧を強調表示
set showmatch
" 対応括弧強調を0.1秒にする
set matchtime=1
" 行列番号を右下に表示
"set ruler
" 行の折り返し
set wrap
" 不可視文字を表示
set list
" 不可視文字の表示記号指定
set listchars=tab:>.,extends:~ ",eol:$
" 全角空白の可視化
" 全角空白: 　
"highlight def ZenkakuSpace cterm=none ctermbg=red
highlight def link ZenkakuSpace Error
au VimEnter,BufNewFile,BufRead * match ZenkakuSpace /　/
" 行末空白の可視化
" 行末空白:
"highlight def HankakuSpace cterm=none ctermbg=red
highlight def link HankakuSpace LightlineLeft_normal_0_1
au VimEnter,BufNewFile,BufRead * match HankakuSpace / \+$/
" カーソル移動関連の設定
" BS の影響範囲に制限をしない
set backspace=indent,eol,start
" 行頭行末の左右移動で行をまたぐ
set whichwrap=b,s,h,l,<,>,[,]
" 上下5行の視界を確保
set scrolloff=4
" 左右16文字の視界を確保
set sidescrolloff=10
" 左右スクロールは一文字ずつ行う
set sidescroll=1
" ヤンクしたデータをクリップボードで使用、選択範囲自動コピー
"set clipboard=unnamed,autoselect

" ファイル処理関連の設定
" 終了前に未保存ファイルの保存確認
set confirm
" 未保存ファイルがあっても別のファイルを編集可能
"set hidden
" 外部からの変更を更新
set autoread
" ファイル保存時にバックアップファイルを作らない
"set nobackup
" ファイル編集中にスワップファイルを作らない
"set noswapfile

" 検索/置換の設定
" 検索文字列をハイライト
set hlsearch
" ESC 2回で検索ハイライトを消す
nnoremap <ESC><ESC> :nohlsearch<CR>
" 検索語が画面の真ん中にくるようにする
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
" インクリメンタルサーチ
set incsearch
" 大文字小文字区別しない
set ignorecase
" 大文字小文字混在の文字列で検索のときのみ大文字小文字区別する
set smartcase
" 最後尾まで検索し終えると次で先頭に戻る
set wrapscan
" 置換時 g オプションをデフォルトで有効
"set gdefault

" タブ/インデントの設定
" タブを空白に置き換え
set expandtab
" Tab 幅を2文字に
set tabstop=2
" 自動インデントでずれる幅
set shiftwidth=2
" インデントを shiftwidth の倍数に丸める
"set shiftround
" 連続空白に対するカーソルの動く幅
set softtabstop=2
" 改行でインデント継続
set autoindent
" 行末に合わせて次の行のインデントを増減
set smartindent

" マウス入力
"set mouse=a

" コマンドを画面最下部に表示
set showcmd

" +/- でインクリメント/デクリメント
nnoremap + <C-a>
nnoremap - <C-x>

" j 2回でインサートモードから抜ける
"inoremap <silent> jj <ESC>
" シェルライクなキーバインドに
" C-a で行頭
nnoremap <C-a> ^
inoremap <C-a> <ESC>^i
" C-e で行末
nnoremap <C-e> $
inoremap <C-e> <ESC>$i<RIGHT>
" C-c で終了
nnoremap <C-c> :q<CR>
inoremap <C-c> <ESC>:q<CR>

" 行末までヤンク
nnoremap Y y$

" color scheme settings
syntax enable
colorscheme molokai
set t_Co=256

" display too-long line instead of @
set display=lastline
" completion height
set pumheight=10

set keywordprg=ejdic

