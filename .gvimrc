"
" vimrc
"

" ���j���[���p��ɖ߂�
source $VIMRUNTIME/delmenu.vim
set langmenu=none
source $VIMRUNTIME/menu.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ���{����͂Ɋւ���ݒ�:
"
if has('multi_byte_ime') || has('xim')
    " IME ON���̃J�[�\���̐F��ݒ�(�ݒ��:��)
    highlight CursorIM guibg=Purple guifg=NONE
    " �}�����[�h�E�������[�h�ł̃f�t�H���g��IME��Ԑݒ�
    set iminsert=0 imsearch=0
    if has('xim') && has('GUI_GTK')
        " XIM�̓��͊J�n�L�[��ݒ�:
        " ���L�� s-space ��Shift+Space�̈Ӗ���kinput2+canna�p�ݒ�
        "set imactivatekey=s-space
    endif
    " �}�����[�h�ł�IME��Ԃ��L�������Ȃ��ꍇ�A���s�̃R�����g������
    "inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" �ʐݒ�
"
"�V���^�b�N�X�E�n�C���C�g��ON
syntax on

"font
set gfn=Ricty:h12

"window width
set columns=100

"window height
set lines=55

"set autochdir
set directory=~

"�������ʂ��n�C���C�g
set hlsearch

"TITLE��\������
set title
set titlestring=

"���͒��̃R�}���h��\��
set showcmd

"zsh���ۂ��⊮��
set wildmode=longest,list

"�����s�͐܂�Ԃ��Ȃ�
set nowrap

"�������t�@�C���̐擪�փ��[�v���Ȃ�
set nowrapscan

"���{��Ή�
set encoding=japan

"TERM�̕����R�[�h
set termencoding=utf-8

"�f�t�H���g�����R�[�h
set fileencoding=utf-8

"�����R�[�h
set fileencodings=utf-8,euc-jp,jis,sjis,ucs-bom,iso-2022-jp,utf-16,cp932,latin1

"���ŕҏW�����玩���ēǂݍ���
set autoread

"�f�t�H���g�t�@�C���t�H�[�}�b�g
set fileformat=unix

"���s�R�[�h
set fileformats=unix,dos,mac

"���ꕶ���΍�(Unicode�̂Ƃ��̂ݗL��)
set ambiwidth=double

"�V�����s�̃C���f���g�����ݍs�Ɠ����ɂ���
set autoindent

"�V�����s��������Ƃ��ɍ��x�Ȏ����C���f���g���s��
"�R�s�y�����Ƃ��Ƃ������Ƃ������̂ł��Ȃ�
set smartindent

"�s���̗]������ Tab ��ł����ނƁA'shiftwidth' �̐������C���f���g����B
set smarttab

"�^�u���X�y�[�X�ɒu��������
set expandtab

"
set viminfo=

"���[���[�\��
set ruler

"�s�ԍ���\��
set number

"�ҏW���̃o�b�N�A�b�v�𐶐����Ȃ�
set nobackup

"�ҏW���̃X���b�v�t�@�C���𐶐����Ȃ�
set noswapfile

"�t�@�C�����̓W�J�ɃX���b�V�����g���B
set shellslash

"�t�@�C������ <Tab> ���Ή�����󔒂̐�
set tabstop=4
set softtabstop=4

"�V�t�g�ړ���
set shiftwidth=4

"list�ŕ\������镶���̃t�H�[�}�b�g���w�肷��
set listchars=eol:<,tab:\|>,extends:<

"�^�u�����A�s���ȂǕs��������\������
set nolist

"�^�u���Q�ȏ�ɂȂ�����^�u�o�[��\��
set showtabline=1

"�N���b�v�{�[�h��Windows�ƘA�g
set clipboard=unnamed

" �|�b�v�A�b�v���j���[���悵�Ȃ�
set completeopt=menu,preview,longest,menuone

" �⊮���̐ݒ�
set complete=.,w,b,u,k

"Vi�݊����I�t
set nocompatible

" �啶��/����������ʂ��Ȃ�
set ignorecase

" �������ɑ啶�����܂܂�Ă���ꍇ�̂ݑ啶��/����������ʂ���
set smartcase

"GREP���Ɏg���v���O����
set grepprg=internal

"�X�e�[�^�X�s����ɕ\��
set laststatus=2

"�X�e�[�^�X�s�Ɂu�t�@�C���G���R�[�h�v�Ɓu���s�R�[�h(fileformat)�v��\��
set statusline=%<%f\ %m%r%h%w%y\ %{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"Ctrl-X + Ctrl-U��syntax�⊮�ACtrl-X + Ctrl-O��Omni�⊮
set completefunc=syntaxcomplete#Complete

"�R���\�[���ł��}�E�X�@�\��
set mouse=a
" screen�Ή�
if &term == "screen"
    set ttymouse=xterm-256color
endif

set guioptions-=T

" �^�O�t�@�C��
set tags=~/.tags

"C/Migemo
if has('migemo')
    set migemo
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" �L�[�}�b�v 
"
" J��5�s����
:map J 5<C-d>
" K��5�s���
:map K 5<C-u>
" Alt+n��Next Tab
":map <C-n> gt
" Alt+p��Prev Tab
":map <C-p> gT
"
" t��:tabnew����
:map t :tabnew 
" Ctrl+n�Ŏ��̃o�b�t�@�Ɉړ�
:map <C-n> :bn!<CR>
" Ctrl+p�őO�̃o�b�t�@�Ɉړ�
:map <C-p>  :bp!<CR>

" Buffer�̈ړ�
:nmap B :ls<CR>:buf! 

" VCS Command
nmap ,cd :VCSDiff<CR>
nmap ,cv :VCSVimDiff<CR>

"���̓��[�h���A�X�e�[�^�X���C���̃J���[��ύX
"augroup InsertHook
"autocmd!
"autocmd InsertEnter * highlight StatusLine cterm=underline,bold ctermfg=White ctermbg=Magenta
"autocmd InsertLeave * highlight StatusLine cterm=underline,bold ctermfg=White ctermbg=DarkBlue
"augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ���[�h
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
" �R�[�h�⊮
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
" ����/�N�H�[�g�������⊮
"
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap < <><LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" �F�̐ݒ�
"
"256�F�\��
set t_Co=256

highlight Normal guifg=Black guibg=White
highlight NonText guifg=White
highlight Directory gui=bold guifg=206
highlight Cursor guifg=White guibg=Cyan
highlight CursorIM guifg=0 guibg=206
highlight Comment guifg=120
highlight String guifg=198
highlight Constant guifg=6
highlight Keyword guifg=202
highlight Statement gui=bold guifg=255
highlight Identifier guifg=222
highlight Visual gui=bold guibg=Gold
highlight Special guifg=255
highlight Search gui=none guifg=88 guibg=211
highlight StatusLine gui=bold guifg=White guibg=Blue
highlight LineNr gui=none guifg=Black
highlight Pmenu gui=none guifg=Black guibg=200
highlight PmenuSel gui=bold guifg=Black guibg=21
highlight Include gui=bold guifg=White
highlight Define gui=bold guifg=14
highlight Macro gui=bold guifg=14
highlight PreCondit gui=bold guifg=21

" �擪�̃X�y�[�X���J���[�\��
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
" neocomplcache.vim�̐ݒ�
let g:neocomplcache_enable_at_startup = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Session.vim�̐ݒ�
" �I������session�ۑ��ƋN������autoload
"
function! ExitVimFuncSession()
    SaveSession
endfunction
command! ExitVimFuncSession call ExitVimFuncSession()

" �N������Session��ǂݍ���
let g:session_autoload = 1
"Session�t�@�C�����𕷂�������ɓǂݏ�������
let g:session_autosave = 1
augroup MySession
    "Vim�I������Sassion��ۑ�����
    au VimLeave * ExitVimFuncSession
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"�o�b�t�@�ؑւƓ����Ƀf�B���N�g���ړ�
"
au BufRead * execute ":lcd " . expand("%:p:h")


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PHP��Syntax�`�F�b�N
"
function PHPLint()
    let result = system( 'php' . ' -l ' . bufname(""))
    echo result
endf
autocmd FileType php,inc  :nmap ,l :call PHPLint()<CR>

