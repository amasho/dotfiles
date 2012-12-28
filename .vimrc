"
" vimrc
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
"
"シンタックス・ハイライトをON
syntax on
hi clear

"leaderを変更
let mapleader = ","

"set autochdir
set directory=$HOME

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

"検索をファイルの先頭へループ
set wrapscan

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

set viminfo=

"ルーラー表示
set ruler

"行番号を表示
set number

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

"クリップボード連携
set clipboard=unnamed
vmap <silent> <Leader>y "*y

"ポップアップメニューをよしなに
set completeopt=menu,preview,longest,menuone

"補完候補の設定
set complete=.,w,b,u,k

"Vi互換をオフ
set nocompatible

"大文字/小文字を区別しない
set ignorecase

"検索語句に大文字が含まれている場合のみ大文字/小文字を区別する
set smartcase

"GREP時に使うプログラム
set grepprg=internal

"ステータス行を常に表示
set laststatus=2

"ステータス行に「ファイルエンコード」と「改行コード(fileformat)」を表示
"set statusline=%<%f\ %m%r%h%w%y\ %{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"Ctrl-X + Ctrl-Uでsyntax補完、Ctrl-X + Ctrl-OでOmni補完
set completefunc=syntaxcomplete#Complete

"タグファイル
set tags=$HOME/.tags

"コマンド実行中は再描画しない
set lazyredraw

"高速ターミナル接続を行う
"set ttyfast

"コンソールでもマウス機能を
set mouse=a
set guioptions+=a
"screen対応
if &term == "screen" | set ttymouse=xterm-256color | endif

"C/Migemo
if has('migemo') | set migemo | endif

"コマンド行の高さ
set cmdheight=1

"Backspace
set backspace=indent,eol,start

"行番号とカーソル行をハイライト(カレントバッファウィンドウだけ)
augroup cursor_line
	autocmd!
	autocmd WinLeave * set nocursorline
	autocmd WinEnter * set number
	autocmd WinEnter,BufRead * if &filetype == 'vimfiler' || &filetype == 'vimshell' || &filetype == 'taglist' | set nonumber | else | set cursorline | endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI用設定
"
if has('gui_running')
	set antialias
	set transparency=15
	set guifont=Ricty:h12
	set guioptions+=i
	set guioptions-=l
	set guioptions-=L
	set guioptions-=r
	set guioptions-=R
	set guioptions-=T

	nnoremap <C-f> <C-d>
	nnoremap <C-b> <C-u>

	augroup focus_group
		autocmd!
		autocmd FocusGained * call <SID>MyHighlight_Colors()
		autocmd FocusGained * set transparency=15
		autocmd FocusLost * set transparency=50
	augroup END
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle
"
set nocompatible
filetype off
if has('vim_starting')
    set runtimepath+=$HOME/.vim/bundle/neobundle.vim
    call neobundle#rc(expand($HOME.'/.vim/bundle/'))
endif

NeoBundle 'Shougo/vimproc', {'build' : {'mac' : 'make -f make_mac.mak', }, }
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-rails'
NeoBundle 'mattn/gist-vim'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'honza/snipmate-snippets'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'tacroe/unite-mark'
NeoBundle 'basyura/jslint.vim'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'kana/vim-fakeclip'
NeoBundle 'vim-scripts/javacomplete'
NeoBundle 'vim-scripts/SQLUtilities'
NeoBundle 'surround.vim'
NeoBundle 'ruby.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'L9'
NeoBundle 'taglist.vim'

filetype plugin indent on
filetype indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" キーマップ 
"
" Jで5行下へ
map J 5<C-d>
" Kで5行上へ
map K 5<C-u>

" VCS Command
nmap <Leader>cd :VCSDiff<CR>
nmap <Leader>cv :VCSVimDiff<CR>

" ESC 2回でハイライト消去
nmap <silent> <ESC><ESC> :<C-u>nohlsearch<Enter>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" モード
"
filetype plugin indent on
autocmd! BufRead,BufNewFile *.(sh|bash) set filetype=sh
autocmd! BufRead,BufNewFile *.php[34]? set filetype=php
autocmd! BufRead,BufNewFile *.inc set filetype=php
autocmd! BufRead,BufNewFile *.phtml set filetype=php
autocmd! BufRead,BufNewFile *.html set filetype=html
autocmd! BufRead,BufNewFile *.(t|pl|pm) set filetype=perl
autocmd! BufRead,BufNewFile *.(js|as|json|jsn) set filetype=javascript
autocmd! BufRead,BufNewFile *.tpl set filetype=smarty
autocmd! BufRead,BufNewFile *.java set filetype=java

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" コード補完
"
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType php :set dictionary=$HOME/.vim/dict/php.dict
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType perl :set dictionary=$HOME/.vim/dict/perl.dict
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java :setlocal omnifunc=javacomplete#Complete
autocmd FileType java :setlocal completefunc=javacomplete#CompleteParamsInfo
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

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
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" snippets
"
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
    set conceallevel=2 concealcursor=i
endif
let g:neosnippet#snippets_directory=$HOME.'/.vim/bundle/snipmate-snippets/snippets'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fugitiveの設定
"
nnoremap <Leader>gd :<C-u>Gdiff<Enter>
nnoremap <Leader>gs :<C-u>Gstatus<Enter>
nnoremap <Leader>gl :<C-u>Glog<Enter>
nnoremap <Leader>ga :<C-u>Gwrite<Enter>
nnoremap <Leader>gc :<C-u>Gcommit<Enter>
nnoremap <Leader>gC :<C-u>Git commit --amend<Enter>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 終了時のSession保存と起動時のautoload
"
augroup SessionAutocommands
	autocmd!

	autocmd VimEnter * nested call <SID>RestoreSessionWithConfirm()
	autocmd VimEnter * nested call <SID>MyHighlight_Colors()
	autocmd VimLeave * execute 'SaveSession'
augroup END

command! RestoreSession :source $HOME/.vim/.session
command! SaveSession    :mksession! $HOME/.vim/.session

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
autocmd BufRead * execute ":lcd " . expand("%:p:h")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PHPのSyntaxチェック
"
augroup php_lint
	autocmd!
	function! PHPLint()
		let result = system( 'php' . ' -l ' . bufname(""))
		if result !~ '^No.*' | echomsg result | endif
	endfunction
	autocmd FileType php,inc :nmap <Leader>l :call PHPLint()<CR>
	autocmd BufWritePost *.php,*.inc call PHPLint()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RubyのSyntaxチェック
"
augroup ruby_lint
	autocmd!
	function! RubyLint()
		let result = system( 'ruby' . ' -c ' . bufname(""))
		if result !~ '^Syntax OK.*' | echomsg result | endif
	endfunction
	autocmd FileType rb :nmap <Leader>c :call RubyLint()<CR>
	autocmd BufWritePost *.rb call RubyLint()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" javascriptのSyntaxチェック
" - jslint
"
function! s:javascript_filetype_settings()
	autocmd BufLeave     <buffer> call jslint#clear()
	autocmd BufWritePost <buffer> call jslint#check()
	autocmd CursorMoved  <buffer> call jslint#message()
endfunction
autocmd FileType javascript call s:javascript_filetype_settings()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" javaの保存時コンパイル
"
function! s:java_compile()
	let path = expand("%")
	let ret = system("/usr/bin/javac -J-Dfile.encoding=UTF8 " . path)
	if ret != ""
		echohl ErrorMsg | echomsg "Failure:" . ret | echohl None
	endif
endfunction
autocmd BufWritePost *.java call s:java_compile()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unite
"
" コンフィグ用ディレクトリ
let g:unite_data_directory = expand($HOME.'/.vim/tmp/plugin/.unite')
" 入力モードで開始する
let g:unite_enable_start_insert=1

" 常用セット
nnoremap <silent> <C-l> :<C-u>Unite buffer file file_mru vimshell/history<CR>
inoremap <silent> <C-l> <ESC>:<C-u>Unite buffer file file_mru vimshell/history<CR>
" バッファ一覧
nnoremap <silent> B :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> <Leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> <Leader>ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> <Leader>um :<C-u>Unite file_mru<CR>
" 全部乗せ
nnoremap <silent> <Leader>ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" Bookmark
nnoremap <silent> <Leader>ub :<C-u>Unite bookmark<CR>

" Unite Help
nnoremap <silent> <Leader>uh :Unite help<Enter>
" Unite Outline
nnoremap <silent> <Leader>uo :Unite outline<Enter>
" Unite Mark
nnoremap <silent> <S-m> :Unite mark<Enter>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-ref
"
let g:ref_phpmanual_path = $HOME.'/Dropbox/manual/php-chunked-xhtml'
nnoremap <Leader>php :Unite ref/phpmanual<Enter>
nnoremap <Leader>pl :Unite ref/perldoc<Enter>
nnoremap <Leader>py :Unite ref/pydoc<Enter>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VimFiler
"
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
nnoremap <silent> fv :VimFiler -split -toggle -simple -winwidth=35 -no-quit<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VimShell
"
let g:vimshell_editor_command='/Applications/MacVim/MacVim.app/Contents/MacOS/Vim --servername=VIM --remote-tab-wait-silent'
let g:vimshell_prompt = '$ '
autocmd FileType vimshell
\  call vimshell#altercmd#define('la', 'ls -la')
\| call vimshell#altercmd#define('g', 'git')
\| call vimshell#altercmd#define('gd', 'git diff ')
\| call vimshell#altercmd#define('gst', 'git status -s -b')

nnoremap <silent> vs :VimShell<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-quickrun
"
let g:quickrun_config = {}
let g:quickrun_config['_'] = {}
let g:quickrun_config['_']['runner'] = 'vimproc'
let g:quickrun_config['_']['runner/vimproc/updatetime'] = 100

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open-blowser.vim
"
" カーソル下のURLをブラウザで開く
nmap <Leader>fu <Plug>(openbrowser-open)
vmap <Leader>fu <Plug>(openbrowser-open)
" カーソル下のキーワードをググる
nnoremap <Leader>fs :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>
" エイリアス
nnoremap <Leader>ob :<C-u>OpenBrowser http://
nnoremap <Leader>obs :<C-u>OpenBrowserSearch 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" taglist.vim
"
" ctagsのパス
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
" タグリストを開いた時にフォーカスを移す
let Tlist_GainFocus_On_ToggleOpen = 1 
" 余分な情報や空白を表示しない
let Tlist_Compact_Format = 1
" タグリストをハイライト
let Tlist_Auto_Highlight_Tag = 1
" 現在編集中のソースのタグしか表示しない
let Tlist_Show_One_File = 1
" taglistのウィンドーが最後のウィンドーならばVimを閉じる
let Tlist_Exit_OnlyWindow = 1
" 折りたたみ
let Tlist_Enable_Fold_Column = 0
" 自動表示
let Tlist_Auto_Open = 1
" 新しくファイル開いた時は更新
let Tlist_Auto_Update = 1
" 横幅
let Tlist_WinWidth = 35
" taglistを開くショットカットキー
map <silent> <leader>tl :Tlist<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-powerline
"
let g:Powerline_symbols='fancy'
let g:Powerline_mode_n = 'NORMAL'
call Pl#Hi#Allocate({
  \ 'black'          : 16,
  \ 'white'          : 231,
  \
  \ 'darkestgreen'   : 22,
  \ 'darkgreen'      : 28,
  \
  \ 'darkestcyan'    : 21,
  \ 'mediumcyan'     : 117,
  \
  \ 'darkestblue'    : 24,
  \ 'darkblue'       : 31,
  \
  \ 'darkestred'     : 52,
  \ 'darkred'        : 88,
  \ 'mediumred'      : 124,
  \ 'brightred'      : 160,
  \ 'brightestred'   : 196,
  \
  \ 'darkestyellow'  : 59,
  \ 'darkyellow'     : 100,
  \ 'darkestpurple'  : 57,
  \ 'mediumpurple'   : 98,
  \ 'brightpurple'   : 189,
  \
  \ 'brightorange'   : 208,
  \ 'brightestorange': 214,
  \
  \ 'gray0'          : 233,
  \ 'gray1'          : 235,
  \ 'gray2'          : 236,
  \ 'gray3'          : 239,
  \ 'gray4'          : 240,
  \ 'gray5'          : 241,
  \ 'gray6'          : 244,
  \ 'gray7'          : 245,
  \ 'gray8'          : 247,
  \ 'gray9'          : 250,
  \ 'gray10'         : 252,
  \ })

" 'n': normal mode
" 'i': insert mode
" 'v': visual mode
" 'r': replace mode
" 'N': not active
let g:Powerline#Colorschemes#my#colorscheme = Pl#Colorscheme#Init([
  \ Pl#Hi#Segments(['SPLIT'], {
    \ 'n': ['white', 'gray2'],
    \ 'N': ['gray0', 'gray0'],
    \ }),
  \
  \ Pl#Hi#Segments(['mode_indicator'], {
    \ 'i': ['darkestgreen', 'white', ['bold']],
    \ 'n': ['darkestcyan', 'white', ['bold']],
    \ 'v': ['darkestpurple', 'white', ['bold']],
    \ 'r': ['mediumred', 'white', ['bold']],
    \ 's': ['white', 'gray5', ['bold']],
    \ }),
  \
  \ Pl#Hi#Segments(['fileinfo', 'filename'], {
    \ 'i': ['white', 'darkestgreen', ['bold']],
    \ 'n': ['white', 'darkestcyan', ['bold']],
    \ 'v': ['white', 'darkestpurple', ['bold']],
    \ 'r': ['white', 'mediumred', ['bold']],
    \ 'N': ['gray0', 'gray2', ['bold']],
    \ }),
  \
  \ Pl#Hi#Segments(['branch', 'scrollpercent', 'raw', 'filesize'], {
    \ 'n': ['gray2', 'gray7'],
    \ 'N': ['gray0', 'gray2'],
    \ }),
  \
  \ Pl#Hi#Segments(['fileinfo.filepath', 'status'], {
    \ 'n': ['gray10'],
    \ 'N': ['gray5'],
    \ }),
  \
  \ Pl#Hi#Segments(['static_str'], {
    \ 'n': ['white', 'gray4'],
    \ 'N': ['gray1', 'gray1'],
    \ }),
  \
  \ Pl#Hi#Segments(['fileinfo.flags'], {
    \ 'n': ['white'],
    \ 'N': ['gray4'],
    \ }),
  \
  \ Pl#Hi#Segments(['currenttag', 'fileformat', 'fileencoding', 'pwd', 'filetype', 'charcode', 'currhigroup'], {
    \ 'n': ['gray9', 'gray4'],
    \ }),
  \
  \ Pl#Hi#Segments(['lineinfo'], {
    \ 'n': ['gray2', 'gray10'],
    \ 'N': ['gray2', 'gray4'],
    \ }),
  \
  \ Pl#Hi#Segments(['errors'], {
    \ 'n': ['white', 'gray2'],
    \ }),
  \
  \ Pl#Hi#Segments(['lineinfo.line.tot'], {
    \ 'n': ['gray2'],
    \ 'N': ['gray2'],
    \ }),
  \
  \ Pl#Hi#Segments(['paste_indicator', 'ws_marker'], {
    \ 'n': ['white', 'brightred', ['bold']],
    \ }),
  \
  \ Pl#Hi#Segments(['gundo:static_str.name'], {
    \ 'n': ['white', 'mediumred', ['bold']],
    \ 'N': ['brightred', 'darkestred', ['bold']],
    \ }),
  \
  \ Pl#Hi#Segments(['gundo:static_str.buffer'], {
    \ 'n': ['white', 'darkred'],
    \ 'N': ['brightred', 'darkestred'],
    \ }),
  \
  \ Pl#Hi#Segments(['gundo:SPLIT'], {
    \ 'n': ['white', 'gray2'],
    \ 'N': ['white', 'gray0'],
    \ }),
  \ ])
let g:Powerline_colorscheme='my'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 色の設定
"
function! s:MyHighlight_Colors()

	hi clear CursorLine

	if has('gui') || has('gui_macvim')
		"GUI用設定
		hi Normal guifg=#FFFFFF guibg=#000000
		hi NonText guifg=#FFFFFF guibg=#000000
		hi Directory gui=bold guifg=#FF5FD7
		hi Cursor guifg=#FFFFFF guibg=#00FFFF
		hi CursorIM guifg=#000000 guibg=#FF5FD7
		hi CursorLine gui=underline
		hi Comment guifg=#87FF87
		hi String guifg=#FF0087
		hi Constant guifg=#FFFFFF guibg=#000000
		hi Keyword guifg=#FF5F00
		hi Statement gui=bold guifg=#FFFFFF
		hi Identifier guifg=#FFD787
		hi Visual guibg=#AF8700
		hi Special guifg=#FFFFFF guibg=#000000
		hi Search gui=bold guifg=#000000 guibg=#FF87AF
		hi LineNr gui=none guifg=#626262 guibg=#000000
		hi CursorLineNr gui=bold guifg=#D7005F guibg=#000000
		hi Pmenu gui=none guifg=#FFFFFF guibg=#FF00D7
		hi PmenuSel gui=bold guifg=#FFFFFF guibg=#FF00D7
		hi Include gui=bold guifg=#FFFFFF
		hi Define gui=bold guifg=Yellow
		hi Macro gui=bold guifg=Yellow
		hi PreCondit gui=bold guifg=#0000FF
		hi diffAdded guifg=#000000  guibg=#0000FF
	elseif &term =~ "xterm-256color"
		"256色
		set t_Co=256
		set t_Sf=[3%dm
		set t_Sb=[4%dm

		hi Normal ctermfg=255
		hi NonText ctermfg=255
		hi Directory cterm=bold ctermfg=206
		hi Cursor ctermfg=255 ctermbg=255
		hi CursorIM ctermfg=0 ctermbg=206
		hi CursorLine cterm=underline
		hi Comment ctermfg=120
		hi String ctermfg=198
		hi Constant ctermfg=6
		hi Keyword ctermfg=202
		hi Statement cterm=bold ctermfg=255
		hi Identifier ctermfg=222
		hi Visual cterm=bold ctermbg=136
		hi Special ctermfg=255
		hi Search cterm=none ctermfg=88 ctermbg=211
		hi StatusLine cterm=bold ctermfg=255 ctermbg=21
		hi LineNr cterm=none ctermfg=241 ctermbg=0
		hi CursorLineNr cterm=none ctermfg=161 ctermbg=0
		hi Pmenu cterm=none ctermfg=255 ctermbg=200
		hi PmenuSel cterm=bold ctermfg=255 ctermbg=21
		hi Include cterm=bold ctermfg=255
		hi Define cterm=bold ctermfg=14
		hi Macro cterm=bold ctermfg=14
		hi PreCondit cterm=bold ctermfg=21
		hi diffAdded ctermfg=21
	else
		set t_Co=16
		set t_Sf=[3%dm
		set t_Sb=[4%dm

		hi Normal ctermfg=255
		hi NonText ctermfg=255
		hi Directory cterm=bold ctermfg=206 ctermbg=0
		hi Cursor ctermfg=255 ctermbg=255
		hi Comment ctermfg=120 ctermbg=0
		hi String ctermfg=198 ctermbg=0
		hi Constant ctermfg=6 ctermbg=0
		hi Keyword ctermfg=202 ctermbg=0
		hi Statement cterm=bold ctermfg=255 ctermbg=0
		hi Identifier ctermfg=222 ctermbg=0
		hi Visual cterm=bold ctermbg=136
		hi Special ctermfg=255 ctermbg=0
		hi Search cterm=none ctermfg=88 ctermbg=211
		hi StatusLine cterm=bold ctermfg=255 ctermbg=21
	endif
endfunction
call <SID>MyHighlight_Colors()

