"
" vimrc
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 日本語入力に関する設定:
"
if has('multi_byte_ime') || has('xim')
    " IME ON時のカーソルの色を設定(設定例:紫)
    highlight CursorIM guibg=Purple guifg=NONE
    " 挿入モード・検索モードでのデフォルトのIME状態設定
    set iminsert=0 imsearch=0
    if has('xim') && has('GUI_GTK')
        " XIMの入力開始キーを設定:
        " 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
        "set imactivatekey=s-space
    endif
    " 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
    "inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 個別設定
"
"シンタックス・ハイライトをON
syntax on

"set autochdir
set directory=~

"検索結果をハイライト
set hlsearch

"TITLEを表示する
set title
set titlestring=

"入力中のコマンドを表示
set showcmd

"zshっぽい補完に
set wildmode=longest,list

"長い行は折り返さない
set nowrap

"検索をファイルの先頭へループしない
set nowrapscan

"日本語対応
"set encoding=japan

"TERMの文字コード
set termencoding=utf-8

"デフォルト文字コード
set fileencoding=utf-8

"文字コード
set fileencodings=utf-8,euc-jp,jis,sjis,ucs-bom,iso-2022-jp,utf-16,cp932,latin1

"他で編集したら自動再読み込み
set autoread

"デフォルトファイルフォーマット
set fileformat=unix

"改行コード
set fileformats=unix,dos,mac

"特殊文字対策(Unicodeのときのみ有効)
set ambiwidth=double

"新しい行のインデントを現在行と同じにする
set autoindent

"新しい行を作ったときに高度な自動インデントを行う
"コピペしたときとかうっとおしいのでやらない
set smartindent

"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab

"タブをスペースに置き換える
"set expandtab

"
set viminfo=

"ルーラー表示
set ruler

"行番号を表示
"set number

"編集時のバックアップを生成しない
set nobackup

"編集時のスワップファイルを生成しない
set noswapfile

"ファイル名の展開にスラッシュを使う。
set shellslash

"ファイル内の <Tab> が対応する空白の数
set tabstop=4
"set softtabstop=4

"シフト移動幅
set shiftwidth=4

"listで表示される文字のフォーマットを指定する
set listchars=eol:<,tab:\|>,extends:<

"タブ文字、行末など不可視文字を表示する
set nolist

"タブが２つ以上になったらタブバーを表示
set showtabline=1

"クリップボードをWindowsと連携
set clipboard=unnamed

" ポップアップメニューをよしなに
set completeopt=menu,preview,longest,menuone

" 補完候補の設定
set complete=.,w,b,u,k

"Vi互換をオフ
set nocompatible

" 大文字/小文字を区別しない
set ignorecase

" 検索語句に大文字が含まれている場合のみ大文字/小文字を区別する
set smartcase

"GREP時に使うプログラム
set grepprg=internal

"ステータス行を常に表示
set laststatus=2

"ステータス行に「ファイルエンコード」と「改行コード(fileformat)」を表示
set statusline=%<%f\ %m%r%h%w%y\ %{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"Ctrl-X + Ctrl-Uでsyntax補完、Ctrl-X + Ctrl-OでOmni補完
set completefunc=syntaxcomplete#Complete

"コンソールでもマウス機能を
set mouse=a
" screen対応
if &term == "screen"
    set ttymouse=xterm-256color
endif

set guioptions-=T

" タグファイル
set tags=~/.tags
autocmd FileType php :set tags+=~/.php_tags

"C/Migemo
if has('migemo')
    set migemo
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" キーマップ 
"
" Jで5行下へ
:map J 5<C-d>
" Kで5行上へ
:map K 5<C-u>
" Alt+nでNext Tab
":map <C-n> gt
" Alt+pでPrev Tab
":map <C-p> gT
"
" tで:tabnewする
:map t :tabnew 
" Ctrl+nで次のバッファに移動
:map <C-n> :bn!<CR>
" Ctrl+pで前のバッファに移動
:map <C-p>  :bp!<CR>

" Bufferの移動
:nmap B :ls<CR>:buf! 

" VCS Command
nmap ,cd :VCSDiff<CR>
nmap ,cv :VCSVimDiff<CR>

"入力モード時、ステータスラインのカラーを変更
"augroup InsertHook
"autocmd!
"autocmd InsertEnter * highlight StatusLine cterm=underline,bold ctermfg=White ctermbg=Magenta
"autocmd InsertLeave * highlight StatusLine cterm=underline,bold ctermfg=White ctermbg=DarkBlue
"augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" モード
"
filetype plugin indent on
autocmd! BufRead,BufNewFile *.(sh|bash) set filetype=sh
autocmd! BufRead,BufNewFile *.php[34]? set filetype=php
autocmd! BufRead,BufNewFile *.inc set filetype=php
autocmd! BufRead,BufNewFile *.phtml set filetype=php
autocmd! BufRead,BufNewFile *.html set filetype=php
autocmd! BufRead,BufNewFile *.(t|pl|pm) set filetype=perl
autocmd! BufRead,BufNewFile *.(js|as|json|jsn) set filetype=javascript
autocmd! BufRead,BufNewFile *.tpl set filetype=html

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" コード補完
"
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType perl :set dictionary=~/.vim/dict/perl.dict
autocmd FileType php :set dictionary=~/.vim/dict/php.dict
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java set omnifunc=javaccomplete#Complete

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 括弧/クォートを自動補完
"
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap < <><LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neocomplcache.vimの設定
"
let g:neocomplcache_enable_at_startup = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTreeの設定
"
"デフォルトで表示
"autocmd vimenter * if !argc() | NERDTree | endif    
nmap <F9> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fugitiveの設定
"
nnoremap ,gd :<C-u>Gdiff<Enter>
nnoremap ,gs :<C-u>Gstatus<Enter>
nnoremap ,gl :<C-u>Glog<Enter>
nnoremap ,ga :<C-u>Gwrite<Enter>
nnoremap ,gc :<C-u>Gcommit<Enter>
nnoremap ,gC :<C-u>Git commit --amend<Enter>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 終了時のSession保存と起動時のautoload
"
augroup SessionAutocommands
	autocmd!

	autocmd VimEnter * nested call <SID>RestoreSessionWithConfirm()
	autocmd VimLeave * execute 'SaveSession'
augroup END
	  
command! RestoreSession :source ~/.vim/.session
command! SaveSession    :mksession! ~/.vim/.session

"Restore session with confirm
function! s:RestoreSessionWithConfirm()
	let msg = 'Do you want to restore previous session?'

	if !argc() && confirm(msg, "&Yes\n&No", 1, 'Question') == 1
		execute 'RestoreSession'
	endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"バッファ切替と同時にディレクトリ移動
"
au BufRead * execute ":lcd " . expand("%:p:h")


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PHPのSyntaxチェック
"
function PHPLint()
    let result = system( 'php' . ' -l ' . bufname(""))
    echo result
endf
autocmd FileType php,inc  :nmap ,l :call PHPLint()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unite
"
let g:unite_data_directory = expand('~/.vim/tmp/plugin/.unite')

" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> <S-b> :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> <S-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" Outline
nnoremap <silent> ,uo :Unite outline<Enter>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 色の設定
"
if &term =~ "xterm-256color"
    "256色表示
    set t_Co=256

	highlight Normal ctermfg=255
	highlight NonText ctermfg=255
	highlight Directory cterm=bold ctermfg=206
	highlight Cursor ctermfg=255 ctermbg=255
	highlight CursorIM ctermfg=0 ctermbg=206
	highlight Comment ctermfg=120
	highlight String ctermfg=198
	highlight Constant ctermfg=6
	highlight Keyword ctermfg=202
	highlight Statement cterm=bold ctermfg=255
	highlight Identifier ctermfg=222
	highlight Visual cterm=bold ctermbg=136
	highlight Special ctermfg=255
	highlight Search cterm=none ctermfg=88 ctermbg=211
	highlight StatusLine cterm=bold ctermfg=255 ctermbg=21
	highlight LineNr cterm=none ctermfg=255
	highlight Pmenu cterm=none ctermfg=255 ctermbg=200
	highlight PmenuSel cterm=bold ctermfg=255 ctermbg=21
	highlight Include cterm=bold ctermfg=255
	highlight Define cterm=bold ctermfg=14
	highlight Macro cterm=bold ctermfg=14
	highlight PreCondit cterm=bold ctermfg=21
else
    highlight Normal ctermfg=255
    highlight NonText ctermfg=255
    highlight Directory cterm=bold ctermfg=206 ctermbg=0
    highlight Cursor ctermfg=255 ctermbg=255
    highlight Comment ctermfg=120 ctermbg=0
    highlight String ctermfg=198 ctermbg=0
    highlight Constant ctermfg=6 ctermbg=0
    highlight Keyword ctermfg=202 ctermbg=0
    highlight Statement cterm=bold ctermfg=255 ctermbg=0
    highlight Identifier ctermfg=222 ctermbg=0
    highlight Visual cterm=bold ctermbg=136
    highlight Special ctermfg=255 ctermbg=0
    highlight Search cterm=none ctermfg=88 ctermbg=211
    highlight StatusLine cterm=bold ctermfg=255 ctermbg=21
endif

" 先頭のスペースをカラー表示
function! SOLSpaceHilight()
    syntax match SOLSpace "^ \+" display containedin=ALL
"   highlight SOLSpace term=underline ctermbg=DarkGray
endf
if has("syntax")
    augroup invisible
    autocmd! invisible
    autocmd BufNew,BufRead * call SOLSpaceHilight()
    augroup END
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
"
set nocompatible
filetype off
set rtp+=~/.vim/vundle.git/
call vundle#rc()

Bundle "Shougo/neocomplcache"
Bundle "Shougo/unite.vim"
Bundle 'h1mesuke/unite-outline'''
Bundle "scrooloose/nerdtree"
Bundle "tpope/vim-fugitive"
filetype plugin indent on

