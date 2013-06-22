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
# z.sh & auto-fu.zsh
mkdir -p ${HOME}/.zsh/z/ ${HOME}/.zsh/auto-fu/
${GITCMD} clone https://github.com/rupa/z/ ${HOME}/.zsh/z/
${GITCMD} clone https://github.com/hchbaw/auto-fu.zsh ${HOME}/.zsh/auto-fu/
# brew completion
ln -s /usr/local/Library/Contributions/brew_zsh_completion.zsh ${HOME}/.zsh/_brew

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
mkdir -p ${HOME}/local/bin && echo "PATH=${HOME}/local/bin:${PATH}" >> ${HOME}/.zshrc
git clone git://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard.git
cd tmux-MacOSX-pasteboard
make reattach-to-user-namespace
cp reattach-to-user-namespace ${HOME}/local/bin
rm -rf reattach-to-user-namespace

### tig ###
${BREWCMD} install tig
ln -s ${HOME}/dotfiles/.tigrc ${HOME}/.tigrc

### ctags ###
${BREWCMD} install ctags
ln -s ${HOME}/dotfiles/.ctags ${HOME}/.ctags
