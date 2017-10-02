" .vimrc
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc "
"シンタックス・ハイライトをON
syntax on
syntax enable
hi clear

set synmaxcol=300
" set foldmethod=indent foldlevel=1 foldnestmax=2

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
"set clipboard=unnamed
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
set cmdwinheight=1

"Backspace
set backspace=indent,eol,start

"行番号とカーソル行をハイライト(カレントバッファウィンドウだけ)
augroup cursor_line
  autocmd!
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

"インデント周り
set et ts=4 sw=4 sts=4
autocmd FileType vim,html,xhtml,javascript,coffee,typescript,css,sass,scss,pug,ruby,eruby,scala,lua setlocal et ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.ctp setlocal et ts=2 sw=2 sts=2

inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>
inoremap (<Enter> ()<Left><CR><ESC><S-o>))}}

" terminal
noremap <silent> <C-[> <C-\><C-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI用設定
"
if has('gui') || has('gui_macvim') || has('gui_vimr')
  set antialias
  set transparency=0
  set guifont=Ricty-Regular:h15
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
    autocmd FocusGained * set transparency=0
    autocmd FocusLost * set transparency=50
  augroup END
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"バッファ切替と同時にディレクトリ移動
"
au BufRead * execute ":lcd " . expand("%:p:h")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 行末のハイライト
"
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline ctermbg=136
  autocmd InsertLeave * match TrailingSpaces /\s\+$/
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python3設定
"
let g:python3_host_prog = expand($HOME . '/.pyenv/shims/python3')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" dein.vim
"
filetype off
if &compatible
  set nocompatible
endif

let s:cache_home = empty($XDG_CACHE_HOME) ? expand($HOME . '/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir . ',' . &runtimepath
" let s:toml_file = fnamemodify(expand('<sfile>'), ':h') . '/dein.toml'
let s:toml_file = '~/.config/nvim/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" キーマップ
"
" clipboardへコピー
vmap <silent> <Leader>y "*y
" バッファの行き来
nmap <C-j> <C-^>
" ESC 2回でハイライト消去
nmap <silent> <ESC><ESC> :<C-u>nohlsearch<Enter>
" :wする
nmap <silent> <SPACE><SPACE> :<C-u>w<Enter>

" :poをre-asignするためにC-tを潰す
" map <C-t> :<Backspace>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Twitvim
"
let twitvim_enable_python = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline
"
let g:lightline = {
  \ 'colorscheme': 'Tomorrow_Night_Eighties',
  \   'component': {
  \     'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
  \     'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
  \   },
  \   'component_visible_condition': {
  \     'readonly': '(&filetype!="help"&& &readonly)',
  \     'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
  \   },
  \   'separator': {
  \     'left': '⮀', 'right': '⮂'
  \   },
  \   'subseparator': {
  \     'left': '⮁', 'right': '⮃'
  \   }
  \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips
"
let g:UltiSnipsExpandTrigger="<C-s>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vaffle
"
nmap <silent> <Leader>v :<C-u>Vaffle .<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Denite
"
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nogroup', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'default_opts', ['--follow', '--no-group', '--no-color'])

nnoremap <silent> <C-k><C-b> :<C-u>Denite buffer<CR>
nnoremap <silent> <C-k><C-d> :<C-u>Denite file_rec<CR>
nnoremap <silent> <C-k><C-g> :<C-u>Denite grep<CR>
nnoremap <silent> <C-k><C-k> :<C-u>Denite ghq<CR>
nnoremap <silent> <C-k><C-l> :<C-u>Denite file_mru<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VimShell
"
let g:vimshell_popup_command = "split"
let g:vimshell_popup_height = 10
let g:vimshell_environment_term = "xterm-256color"
let g:vimshell_editor_command = '/Applications/MacVim/MacVim.app/Contents/MacOS/Vim --servername=VIM --remote-tab-wait-silent'
let g:vimshell_prompt = '$ '
autocmd FileType vimshell
\  call vimshell#altercmd#define('la', 'ls -la')
\| call vimshell#altercmd#define('g', 'git')
\| call vimshell#altercmd#define('gd', 'git diff ')
\| call vimshell#altercmd#define('gst', 'git status -s -b')
nnoremap <silent> ,sv :VimShellPop<Enter>

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-quickrun
"
let g:quickrun_config = {}
let g:quickrun_config['_'] = {}
let g:quickrun_config['_']['runner'] = 'vimproc'
let g:quickrun_config['_']['runner/vimproc/updatetime'] = 100

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" emmet.vim
"
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
let g:user_emmet_mode = 'a'
let g:user_emmet_leader_key = '<C-y>'
let g:user_emmet_settings = {
  \   'lang' : 'ja',
  \   'html' : {
  \     'filters' : 'html',
  \     'indentation' : '  '
  \   },
  \   'css' : {
  \     'filters' : 'fc',
  \   },
  \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-easymotion
"
" let g:EasyMotion_keys = ';HJKLASDFGYUIOPQWERTNMZXCVB'
let g:EasyMotion_keys = ';hjklasdfgyuiopqwertnmzxcvb'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
nmap s <Plug>(easymotion-sn)
hi EasyMotionTarget ctermfg=yellow guifg=yellow

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-indent-guides
"
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_color_change_percent=20
let g:indent_guides_guide_size=1
let g:indent_guides_space_guides=1
hi IndentGuidesOdd  ctermbg=235
hi IndentGuidesEven ctermbg=237
nmap <silent><Leader>ig <Plug>IndentGuidesToggle

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-fugitive
"
nnoremap <Leader>gs :<C-u>Gstatus<Enter>
nnoremap <Leader>gl :<C-u>Glog<Enter>
nnoremap <Leader>gd :<C-u>Gdiff<Enter>
nnoremap <Leader>ga :<C-u>Gwrite<Enter>
nnoremap <Leader>gc :<C-u>Gcommit<Enter>
nnoremap <Leader>gC :<C-u>Git commit --amend<Enter>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntastic
"
let g:syntastic_mode_map = { 'mode': 'passive',
  \ 'active_filetypes': [
  \   'javascript',
  \   'coffee',
  \   'typescript',
  \   'scss',
  \   'go',
  \   'ruby',
  \   'python',
  \   'php',
  \ ]}
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_coffee_checkers = ['coffeelint']
let g:syntastic_typescript_checkers = ['eslint', 'tslint', 'tsc']
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_go_checkers = ['golint', 'gofmt', 'gotype']
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_php_checkers = ['phplint']
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_check_on_wq = 0
hi SyntasticErrorSign ctermfg=160
hi SyntasticWarningSign ctermfg=220"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-coffee-script
"
nnoremap <Leader>cfm :<C-u>CoffeeMake<Enter>
nnoremap <Leader>cfr :<C-u>CoffeeRun<Enter>
nnoremap <Leader>cfc :<C-u>CoffeeCompile<Enter>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" jasmine.vim
"
function! JasmineSetting()
  au BufRead,BufNewFile *Helper.js,*Spec.js  set filetype=jasmine.javascript
  au BufRead,BufNewFile *Helper.coffee,*Spec.coffee  set filetype=jasmine.coffee
  au BufRead,BufNewFile,BufReadPre *Helper.coffee,*Spec.coffee  let b:quickrun_config = {'type' : 'coffee'}
  call jasmine#load_snippets()
  map <buffer> <leader>m :JasmineRedGreen<CR>
  command! JasmineRedGreen :call jasmine#redgreen()
  command! JasmineMake :call jasmine#make()
endfunction
au BufRead,BufNewFile,BufReadPre *.coffee,*.js call JasmineSetting()
au BufCreate *.ts :TSSstarthere

au BufRead,BufNewFile *.es6 setfiletype javascript
au BufNewFile,BufRead *.tag setlocal ft=javascript

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-go.vim
"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" swift quickrun
"
if has("mac")
  autocmd BufRead,BufNewFile *.swift set filetype=swift
  let g:quickrun_config['swift'] = {
    \   'command': 'xcrun',
    \   'cmdopt': 'swift',
    \   'exec': '%c %o %s',
    \ }
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruby
"
au FileType ruby,eruby set omnifunc=rubycomplete#Complete
au FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
au FileType ruby,eruby let g:rubycomplete_rails = 1
au FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

au BufRead,BufNewFile *.gradle set filetype=groovy
au BufRead,BufNewFile *.js set tags+=$HOME/js.tags
au BufRead,BufNewFile *.coffee set tags+=$HOME/coffee.tags
au BufRead,BufNewFile *.ts set tags+=$HOME/ts.tags
au BufRead,BufNewFile *.java set tags+=$HOME/java.tags
au BufRead,BufNewFile *.scala set tags+=$HOME/scala.tags
au BufRead,BufNewFile *.php,*.inc set tags+=$HOME/php.tags

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Perl Syntax
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
" 色の設定
"
autocmd VimEnter,GUIEnter * nested call <SID>MyHighlight_Colors()
function! s:MyHighlight_Colors()

  hi clear CursorLine

  if has('gui') || has('gui_macvim')
    "GUI用設定
    hi Normal guifg=#FFFFFF guibg=#252525
    hi NonText guifg=#FFFFFF guibg=#252525
    hi Directory gui=bold guifg=#FF5FD7
    hi Cursor guifg=#FFFFFF guibg=#00FFFF
    hi CursorIM guifg=#000000 guibg=#FF5FD7
    hi CursorLine gui=none
    hi Comment guifg=#87FF87
    hi String guifg=#FF0087
    hi Constant guifg=#FFFFFF guibg=#252525
    hi Keyword guifg=#FF5F00
    hi Statement gui=bold guifg=#D7AF87
    hi Identifier guifg=#FFD787
    hi Visual guibg=#AF8700
    hi Special guifg=#FFFFFF guibg=#252525
    hi Search gui=bold guifg=#000000 guibg=#FF87AF
    hi LineNr gui=none guifg=#626262 guibg=#252525
    hi CursorLineNr gui=bold guifg=#D7005F guibg=#252525
    hi Pmenu gui=none guifg=#FFFFFF guibg=#FF00D7
    hi PmenuSel gui=bold guifg=#FFFFFF guibg=#FF00D7
    hi Include gui=bold guifg=#FF0000
    hi Define gui=bold guifg=Cyan
    hi Macro gui=bold guifg=Cyan
    hi PreCondit gui=bold guifg=#0000FF
    hi diffAdded guifg=#000000  guibg=#0000FF
    hi ColorColumn guibg=#252525

    hi VertSplit gui=none guifg=#000000 guibg=#626262
    hi StatusLineNC gui=none guifg=#000000 guibg=#626262
    hi MBENormal gui=none guifg=#626262 guibg=#252525
    hi MBEVisibleNormal gui=none guifg=#626262 guibg=#252525
    hi MBEVisibleActive gui=bold,underline guifg=#D7005F guibg=#252525
  elseif &term =~ "xterm-256color" || &term =~ "nvim"
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
    hi Pmenu cterm=none ctermfg=255 ctermbg=238
    hi PmenuSel cterm=none ctermfg=190 ctermbg=32
    hi PmenuSbar cterm=bold ctermfg=255 ctermbg=28
    hi Include cterm=bold ctermfg=9
    hi Define cterm=bold ctermfg=14
    hi Macro cterm=bold ctermfg=14
    hi PreCondit cterm=bold ctermfg=21
    hi diffAdded ctermfg=21
    hi Folded ctermfg=15 ctermbg=199

    hi VertSplit cterm=none ctermfg=0 ctermbg=239
    hi StatusLineNC cterm=none ctermfg=0 ctermbg=241
    hi MBENormal cterm=none ctermfg=241 ctermbg=0
    hi MBEVisibleNormal cterm=none ctermfg=241 ctermbg=0
    hi MBEVisibleActive cterm=bold,underline ctermfg=161 ctermbg=0
  else
    syntax off
  endif
endfunction

