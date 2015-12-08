#!/bin/sh -x

BREWCMD=`which brew`;
if [ ${BREWCMD} eq "" ]; then
  echo "No such brew command";
  echo "Please retry after homebrew install.";
  exit 1;
fi

if [ `which git` eq "" ]; then
  echo "No such git command";
  ${BREWCMD} install git
fi

GITCMD=`which git`;
### zsh ###
${BREWCMD} install zsh
ln -s ${HOME}/dotfiles/.zshrc ${HOME}/.zshrc

# z.sh
mkdir -p ${HOME}/.zsh/z/
${GITCMD} clone https://github.com/rupa/z/ ${HOME}/.zsh/z/

# auto-fu.zsh
mkdir -p ${HOME}/.zsh/auto-fu/
${GITCMD} clone https://github.com/hchbaw/auto-fu.zsh ${HOME}/.zsh/auto-fu/

# pure
mkdir -p ${HOME}/.zsh/pure/
${GITCMD} clone https://github.com/sindresorhus/pure ${HOME}/.zsh/pure/
ln -s ${HOME}/.zsh/pure/pure.zsh ${HOME}/.zsh/pure/prompt_pure_setup
ln -s ${HOME}/.zsh/pure/async.zsh ${HOME}/.zsh/pure/async

# zsh-completions
${BREWCMD} install zsh-completions

### Ricty ###
${BREWCMD} install fontforge
${BREWCMD} install automake
${BREWCMD} install pkg-config
${BREWCMD} tap sanemat/font
${BREWCMD} install Caskroom/cask/xquartz
${BREWCMD} install ricty

### fontpatch ###
${GITCMD} clone https://github.com/Lokaltog/vim-powerline.git
fontforge -lang=py -script ./vim-powerline/fontpatcher/fontpatcher /usr/local/Cellar/ricty/3.2.4/share/fonts/Ricty*.ttf
mv ./Ricty*.ttf ${HOME}/Library/Fonts
fc-cache -fv

### vim ###
${BREWCMD} install mercurial
${BREWCMD} install vim
mkdir -p ${HOME}/.vim ${HOME}/.vim/bundle ${HOME}/.vim/tmp/plugin ${HOME}/.vim/tmp/plugin/.unite
# NeoBundle
${GITCMD} clone https://github.com/Shougo/neobundle.vim ${HOME}/.vim/bundle/neobundle.vim
ln -s ${HOME}/dotfiles/.vimrc ${HOME}/.vimrc
VIMCMD=`which vim`
${VIMCMD} -c NeoBundleInstall

### tmux ###
${BREWCMD} install tmux
ln -s ${HOME}/dotfiles/.tmux.conf ${HOME}/.tmux.conf

### reattach-to-user-namespace ###
${BREWCMD} install reattach-to-user-namespace

### tig ###
${BREWCMD} install tig
ln -s ${HOME}/dotfiles/.tigrc ${HOME}/.tigrc

### ctags ###
${BREWCMD} install ctags
ln -s ${HOME}/dotfiles/.ctags ${HOME}/.ctags

### Tomorrow Theme ###
${GITCMD} clone https://github.com/chriskempson/tomorrow-theme /tmp/tomorrow-theme
ls -l /tmp/tomorrow-theme/iTerm2
echo "Import iTerm2 color scheme"

