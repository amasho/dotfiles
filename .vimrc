" .vimrc

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

"let twitvim_count = 100TERMの文字コード
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


"listで表示される文字のフォーマットを指定する
set listchars=eol:<,tab:\|>,extends:<

"タブ文字、行末など不可視文字を表示する
set nolist

"タブが２つ以上になったらタブバーを表示
set showtabline=1

"クリップボード連携
set clipboard=unnamed
vmap <silent> <Leader>y "*y
if has('gui') | set clipboard= | endif

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
set ttyfast

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
  autocmd WinEnter,BufRead * set cursorline
augroup END

"インデント周り
set noet ts=4 sw=4 sts=4
autocmd FileType vim,sh,html,xhtml,javascript,coffee,perl,ruby,eruby,scala,lua setlocal et ts=2 sw=2 sts=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle
"
set nocompatible
filetype off
if has('vim_starting')
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim
  call neobundle#rc(expand($HOME.'/.vim/bundle/'))
endif

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-session'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc', {
  \   'build' : {
  \     'mac'  : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \   }}
NeoBundle 'Shougo/neocomplcache', {
  \  'autoload' : {
  \    'insert' : 1,
  \  }}

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'basyura/jslint.vim'
NeoBundle 'basyura/unite-rails', {
  \ 'autoload' : {
  \   'filetypes': ['ruby', 'eruby', 'haml']
  \ }}

NeoBundle 'mattn/zencoding-vim'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'kana/vim-fakeclip'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'tell-k/vim-browsereload-mac'
NeoBundle 'kchmck/vim-coffee-script'

NeoBundle 'vim-ruby/vim-ruby', {
  \  'autoload' : {
  \    'filetypes': ['ruby', 'eruby', 'haml']
  \  }}

NeoBundle 'skwp/vim-rspec', {
  \  'autoload': {
  \    'filetypes': ['ruby', 'eruby', 'haml']
  \  }}

NeoBundle 'ruby.vim', {
  \  'autoload' : {
  \    'filetypes': ['ruby', 'eruby', 'haml']
  \  }}

NeoBundle 'rails.vim', {
  \  'autoload' : {
  \    'filetypes': ['ruby', 'eruby', 'haml']
  \  }}

NeoBundle 'surround.vim'
NeoBundle 'vcscommand.vim'
NeoBundle 'taglist.vim'
NeoBundle 'YankRing.vim'
NeoBundle 'matchit.zip'
NeoBundle 'ruby-matchit'

" Google Reader
NeoBundle "mattn/googlereader-vim"
source $HOME/.vim/googlereader_accounts.vim

" Twitter
NeoBundle "TwitVim"
source $HOME/.vim/twitter_account.vim

filetype plugin indent on
filetype indent on

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
" キーマップ 
"
" 次のバッファ
nmap K :<C-u>bn!<Enter>
" 前のバッファ
nmap J :<C-u>bp!<Enter>
" ESC 2回でハイライト消去
nmap <silent> <ESC><ESC> :<C-u>nohlsearch<Enter>
" C-tころす
nnoremap <C-t> <silent>
" 入力モードでの行頭行末移動
inoremap <C-a> <Home>
inoremap <C-e> <End>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" コード補完
"
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType php :set dictionary=$HOME/.vim/dict/php.dict
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType perl :set dictionary=$HOME/.vim/dict/perl.dict
"autocmd FileType c set omnifunc=ccomplete#Complete
"autocmd FileType java :setlocal omnifunc=javacomplete#Complete
"autocmd FileType java :setlocal completefunc=javacomplete#CompleteParamsInfo
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
"autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
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
"バッファ切替と同時にディレクトリ移動
"
autocmd BufRead * execute ":lcd " . expand("%:p:h")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PerlのSyntaxチェック
"
augroup perl_lint
  autocmd!
  function! PerlLint()
    let result = system( 'perl' . ' -c ' . bufname(""))
    if result !~ '.* syntax OK'
      echohl ErrorMsg | echomsg result | echohl None
    endif
  endfunction
  autocmd BufWritePost *.pl,*.pm call PerlLint()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PHPのSyntaxチェック
"
augroup php_lint
  autocmd!
  function! PHPLint()
    let result = system( 'php' . ' -l ' . bufname(""))
    if result !~ '^No.*' | echohl ErrorMsg | echomsg result | echohl None | endif
  endfunction
  autocmd BufWritePost *.php,*.inc call PHPLint()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RubyのSyntaxチェック
"
augroup ruby_lint
  autocmd!
  function! RubyLint()
    let result = system( 'ruby' . ' -c ' . bufname(""))
    if result !~ '^Syntax OK.*'
      echohl ErrorMsg | echomsg result | echohl None
    endif
  endfunction
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
" neocomplcache.vimの設定
"
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
  \   'default' : '',
  \   'vimshell' : $HOME.'/.vim/.vimshell_hist',
  \   'scheme' : $HOME.'/.vim/.gosh_completions'
  \ }
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-coffee-script
"
nnoremap <Leader>cfm :<C-u>CoffeeMake<Enter>
nnoremap <Leader>cfr :<C-u>CoffeeRun<Enter>
nnoremap <Leader>cfc :<C-u>CoffeeCompile<Enter>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vcscommand.vim
"
nnoremap <Leader>sa :<C-u>VCSAdd<Enter>
nnoremap <Leader>sc :<C-u>VCSCommit<Enter>
nnoremap <Leader>sd :<C-u>VCSDiff<Enter>
nnoremap <Leader>sv :<C-u>VCSVimDiff<Enter>
nnoremap <Leader>sr :<C-u>VCSRevert<Enter>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-fugitive
"
nnoremap <Leader>gd :<C-u>Gdiff<Enter>
nnoremap <Leader>gs :<C-u>Gstatus<Enter>
nnoremap <Leader>gl :<C-u>Glog<Enter>
nnoremap <Leader>ga :<C-u>Gwrite<Enter>
nnoremap <Leader>gc :<C-u>Gcommit<Enter>
nnoremap <Leader>gC :<C-u>Git commit --amend<Enter>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unite
"
" file_mru拡張
let g:unite_source_file_mru_limit = 200
" コンフィグ用ディレクトリ
let g:unite_data_directory = expand($HOME.'/.vim/tmp/plugin/.unite')
" 入力モードで開始する
let g:unite_enable_start_insert = 1
let g:unite_kind_openable_lcd_command = 1

" 常用セット
nnoremap <silent> <C-l> <ESC>:<C-u>Unite buffer file file_mru vimshell/history<Enter>
inoremap <silent> <C-l> <ESC>:<C-u>Unite buffer file file_mru vimshell/history<Enter>
" バッファ一覧
nnoremap <silent> B :<C-u>Unite buffer<Enter>
" ファイル一覧
nnoremap <silent> <Leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file<Enter>
" レジスタ一覧
nnoremap <silent> <Leader>ur :<C-u>Unite -buffer-name=register register<Enter>
" 最近使用したファイル一覧
nnoremap <silent> <Leader>um :<C-u>Unite file_mru<Enter>
" 全部乗せ
nnoremap <silent> <Leader>ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<Enter>
" Bookmark
nnoremap <silent> <Leader>ub :<C-u>Unite bookmark<Enter>

" Unite Session
if !argc()
  let g:unite_source_session_enable_auto_save = 1
  autocmd VimEnter,GUIEnter * nested UniteSessionLoad
  autocmd VimLeave * nested UniteSessionSave
endif

" unite-rails
nnoremap <silent> <Leader>vR :<C-u>Unite rails/view<Enter>
nnoremap <silent> <Leader>mR :<C-u>Unite rails/model<Enter>
nnoremap <silent> <Leader>cR :<C-u>Unite rails/controller<Enter>
nnoremap <silent> <Leader>sR :<C-u>Unite rails/spec<Enter>
nnoremap <silent> <Leader>CR :<C-u>Unite rails/config<Enter>
nnoremap <silent> <Leader>JR :<C-u>Unite rails/javascript<Enter>
nnoremap <silent> <Leader>SR :<C-u>Unite rails/stylesheet<Enter>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VimFiler
"
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_execute_file_list={}
let g:vimfiler_execute_file_list["_"]="vim"
let g:vimfiler_directory_display_top = 1
let g:vimfiler_safe_mode_by_default = 1
let g:vimfiler_enable_auto_cd = 1
nnoremap <silent> ,fv :VimFiler -quit<Enter>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VimShell
"
let g:vimshell_popup_command = "split"
let g:vimshell_popup_height = 30
let g:vimshell_editor_command = '/Applications/MacVim/MacVim.app/Contents/MacOS/Vim --servername=VIM --remote-tab-wait-silent'
let g:vimshell_prompt = '$ '
autocmd FileType vimshell
\  call vimshell#altercmd#define('la', 'ls -la')
\| call vimshell#altercmd#define('g', 'git')
\| call vimshell#altercmd#define('gd', 'git diff ')
\| call vimshell#altercmd#define('gst', 'git status -s -b')
nnoremap <silent> ,sv :VimShellPop<Enter>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-quickrun
"
let g:quickrun_config = {}
let g:quickrun_config['_'] = {}
let g:quickrun_config['_']['runner'] = 'vimproc'
let g:quickrun_config['_']['runner/vimproc/updatetime'] = 100

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" taglist.vim
"
" ctagsのパス
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
" タグリストを開いた時にフォーカスを移す
let Tlist_GainFocus_On_ToggleOpen = 0
" 余分な情報や空白を表示しない
let Tlist_Compact_Format = 1
" タグリストをハイライト
let Tlist_Auto_Highlight_Tag = 1
" 現在編集中のソースのタグしか表示しない
let Tlist_Show_One_File = 1
" taglistのウィンドーが最後のウィンドーならばVimを閉じる
let Tlist_Exit_OnlyWindow = 1
" 右側表示
let Tlist_Use_Right_Window = 0
" 折りたたみ
let Tlist_Enable_Fold_Column = 0
" 自動表示
let Tlist_Auto_Open = 1
" 新しくファイル開いた時は更新
let Tlist_Auto_Update = 1
" 横幅
let Tlist_WinWidth = 35
" taglistを開くショットカットキー
map <silent> <leader>tl :Tlist<Enter>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" zencoding.vim
"
let g:user_zen_mode='a'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-easymotion
"
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
let g:EasyMotion_leader_key="<Space>"
let g:EasyMotion_grouping=1
hi EasyMotionTarget ctermbg=none ctermfg=yellow guifg=yellow
hi EasyMotionShade  ctermbg=none ctermfg=cyan guifg=cyan

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-browsereload-mac
"
if has("mac")
  let g:returnAppFlag = 1
  if has('gui') || has('gui_macvim')
    let g:returnApp = "MacVim"
  else
    let g:returnApp = "iTerm"
  endif

  augroup browser_chrome_reload
    autocmd!
    nnoremap <silent> <Leader>cr :<C-u>ChromeReload<Enter>
  augroup END

  augroup browser_firefox_reload
    autocmd!
    nnoremap <silent> <Leader>fr :<C-u>FirefoxReload<Enter>
  augroup END
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" yankring.vim
"
let g:yankring_history_dir = "/tmp/"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TwitVim
"
let twitvim_count = 100
nnoremap <Leader>ft :<C-u>FriendsTwitter<Enter>
nnoremap <Leader>rt :<C-u>RepliesTwitter<Enter>
nnoremap <Leader>dt :<C-u>DMTwitter<Enter>
nnoremap <Leader>pt :<C-u>PosttoTwitter<Enter>
nnoremap <Leader>lt :<C-u>ListTwitter

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
autocmd VimEnter,GUIEnter * nested call <SID>MyHighlight_Colors()
function! s:MyHighlight_Colors()

  hi clear CursorLine

  if has('gui') || has('gui_macvim')
    "GUI用設定
    hi Normal guifg=#FFFFFF guibg=#000000
    hi NonText guifg=#FFFFFF guibg=#000000
    hi Directory gui=bold guifg=#FF5FD7
    hi Cursor guifg=#FFFFFF guibg=#00FFFF
    hi CursorIM guifg=#000000 guibg=#FF5FD7
    hi CursorLine gui=none
    hi Comment guifg=#87FF87
    hi String guifg=#FF0087
    hi Constant guifg=#FFFFFF guibg=#000000
    hi Keyword guifg=#FF5F00
    hi Statement gui=bold guifg=#D7AF87
    hi Identifier guifg=#FFD787
    hi Visual guibg=#AF8700
    hi Special guifg=#FFFFFF guibg=#000000
    hi Search gui=bold guifg=#000000 guibg=#FF87AF
    hi LineNr gui=none guifg=#626262 guibg=#000000
    hi CursorLineNr gui=bold guifg=#D7005F guibg=#000000
    hi Pmenu gui=none guifg=#FFFFFF guibg=#FF00D7
    hi PmenuSel gui=bold guifg=#FFFFFF guibg=#FF00D7
    hi Include gui=bold guifg=#FF0000
    hi Define gui=bold guifg=Yellow
    hi Macro gui=bold guifg=Yellow
    hi PreCondit gui=bold guifg=#0000FF
    hi diffAdded guifg=#000000  guibg=#0000FF

    hi StatusLineNC gui=none guifg=#000000 guibg=#626262
    hi MBENormal gui=none guifg=#626262 guibg=#000000
    hi MBEVisibleNormal gui=none guifg=#626262 guibg=#000000
    hi MBEVisibleActive gui=bold,underline guifg=#D7005F guibg=#000000
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
    hi CursorLine cterm=none
    hi Comment ctermfg=120
    hi String ctermfg=198
    hi Constant ctermfg=6
    hi Keyword ctermfg=202
    hi Statement cterm=bold ctermfg=180
    hi Identifier ctermfg=222
    hi Visual cterm=bold ctermbg=136
    hi Special ctermfg=255
    hi Search cterm=none ctermfg=88 ctermbg=211
    hi StatusLine cterm=bold ctermfg=255 ctermbg=21
    hi LineNr cterm=none ctermfg=241
    hi CursorLineNr cterm=bold ctermfg=161
    hi Pmenu cterm=none ctermfg=255 ctermbg=200
    hi PmenuSel cterm=bold ctermfg=255 ctermbg=21
    hi Include cterm=bold ctermfg=9
    hi Define cterm=bold ctermfg=14
    hi Macro cterm=bold ctermfg=14
    hi PreCondit cterm=bold ctermfg=21
    hi diffAdded ctermfg=21

    hi StatusLineNC cterm=none ctermfg=0 ctermbg=241
    hi MBENormal cterm=none ctermfg=241 ctermbg=0
    hi MBEVisibleNormal cterm=none ctermfg=241 ctermbg=0
    hi MBEVisibleActive cterm=bold,underline ctermfg=161 ctermbg=0
  else
    syntax off
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Marked
"
if has("mac")
  " markdownをMarked.appで開く
  autocmd FileType markdown :nnoremap <Leader>md :silent !open -a Marked.app '%:p'<Enter>:redraw!<Enter>
endif
