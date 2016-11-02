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
sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
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

### Docker ###
${BREWCMD} install docker
${BREWCMD} install docker-machine

### Cask ###
${BREWCMD} tap caskroom/versions
${BREWCMD} cask install google-japanese-ime
${BREWCMD} cask install google-chrome
${BREWCMD} cask install google-drive
${BREWCMD} cask install firefox
${BREWCMD} cask install alfred
${BREWCMD} cask install karabiner
${BREWCMD} cask install virtualbox
${BREWCMD} cask install dropbox
${BREWCMD} cask install evernote
${BREWCMD} cask install skype
${BREWCMD} cask install slack
${BREWCMD} cask install gyazo
${BREWCMD} cask install charles
${BREWCMD} cask install sequel-pro
${BREWCMD} cask install coccinellida
${BREWCMD} cask install android-studio
${BREWCMD} cask install coteditor
${BREWCMD} cask install hyperswitch

### Silver Searcher ###
${BREWCMD} install ag

### peco ###
${BREWCMD} install peco

### Ricty ###
${BREWCMD} install fontforge
${BREWCMD} install automake
${BREWCMD} install pkg-config
${BREWCMD} tap sanemat/font
${BREWCMD} cask install xquartz
${BREWCMD} install ricty

### fontpatch ###
${GITCMD} clone https://github.com/Lokaltog/vim-powerline.git
fontforge -lang=py -script ./vim-powerline/fontpatcher/fontpatcher /usr/local/Cellar/ricty/3.2.4/share/fonts/Ricty*.ttf
mv ./Ricty*.ttf ${HOME}/Library/Fonts
fc-cache -fv
rm -rf ./vim-powerline.git

### vim ###
${BREWCMD} install mercurial
${BREWCMD} install vim
mkdir -p ${HOME}/.vim ${HOME}/.vim/dein ${HOME}/.vim/tmp/plugin ${HOME}/.vim/tmp/plugin/.unite
# dein.vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ${HOME}/.vim/dein/ && rm -f installer.sh
ln -s ${HOME}/dotfiles/.vimrc ${HOME}/.vimrc
VIMCMD=`which vim`
${VIMCMD} -c "call dein#install()" -c exit

### neovim ###
${BREWCMD} tap neovim/neovim
${BREWCMD} install neovim
mkdir -p ${HOME}/.config/nvim
ln -s ${HOME}/dotfiles/.vim ${HOME}/.config/nvim/
ln -s ${HOME}/dotfiles/.nvimrc ${HOME}/.config/nvim/init.vim

### tmux ###
${BREWCMD} install tmux
ln -s ${HOME}/dotfiles/.tmux.conf ${HOME}/.tmux.conf

### reattach-to-user-namespace ###
${BREWCMD} install reattach-to-user-namespace

### hub ###
${BREWCMD} install hub

### tig ###
${BREWCMD} install tig
ln -s ${HOME}/dotfiles/.tigrc ${HOME}/.tigrc

### gibo ###
${BREWCMD} install gibo

### heroku toolbelt ###
${BREWCMD} install heroku-toolbelt

### ctags ###
${BREWCMD} install ctags
ln -s ${HOME}/dotfiles/.ctags ${HOME}/.ctags

### Tomorrow Theme ###
${GITCMD} clone https://github.com/chriskempson/tomorrow-theme /tmp/tomorrow-theme
ls -l /tmp/tomorrow-theme/iTerm2
echo "Import iTerm2 color scheme"

### nodebrew ###
curl -L git.io/nodebrew | perl - setup

### gvm ###
/usr/local/bin/zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

### rbenv & ruby-build ###
${GITCMD} clone https://github.com/sstephenson/rbenv.git ${HOME}/.rbenv
${GITCMD} clone https://github.com/sstephenson/ruby-build.git ${HOME}/.rbenv/plugins/ruby-build

### pyenv ###
${GITCMD} clone https://github.com/yyuu/pyenv.git ${HOME}/.pyenv
${GITCMD} clone https://github.com/yyuu/pyenv-virtualenv.git ${HOME}/.pyenv/plugins/pyenv-virtualenv

