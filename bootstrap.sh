#!/bin/sh

#-------------------------------------------------------------------------------
# Thanks Maxime Fabre! https://speakerdeck.com/anahkiasen/a-storm-homebrewin
# Thanks Mathias Bynens! https://mths.be/osx
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Set temporary variable
#-------------------------------------------------------------------------------

DOTFILES=$HOME/dotfiles

#-------------------------------------------------------------------------------
# Update dotfiles itself first
#-------------------------------------------------------------------------------

[ -d "$DOTFILES/.git" ] && git --work-tree="$DOTFILES" --git-dir="$DOTFILES/.git" pull origin master

#-------------------------------------------------------------------------------
# Check for Homebrew and install if we don't have it
#-------------------------------------------------------------------------------

if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

#-------------------------------------------------------------------------------
# Update Homebrew recipes
#-------------------------------------------------------------------------------

brew update

#-------------------------------------------------------------------------------
# Install all our dependencies with bundle (See Brewfile)
#-------------------------------------------------------------------------------

brew tap homebrew/bundle
brew bundle --file=$DOTFILES/Brewfile # Install binary & applications
brew cleanup
brew cask cleanup

#-------------------------------------------------------------------------------
# Launch sublime in command line
# Now this command is built-in
#-------------------------------------------------------------------------------

# ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

#-------------------------------------------------------------------------------
# Install global Git configuration
#-------------------------------------------------------------------------------

ln -nfs $DOTFILES/.gitconfig $HOME/.gitconfig
git config --global core.excludesfile $DOTFILES/.gitignore_global
git config --global user.name "jihwan""
git config --global user.email "zhwan.hwang@gmail.com"

#-------------------------------------------------------------------------------
# Make ZSH the default shell environment
#-------------------------------------------------------------------------------

chsh -s $(which zsh)

#-------------------------------------------------------------------------------
# Install Oh-my-zsh
#-------------------------------------------------------------------------------

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Install cobalt2 theme
# wget https://raw.githubusercontent.com/wesbos/Cobalt2-iterm/master/cobalt2.zsh-theme -O $HOME/.oh-my-zsh/themes/cobalt2.zsh-theme

# Install Powerline theme
#wget https://raw.githubusercontent.com/jeremyFreeAgent/oh-my-zsh-powerline-theme/master/powerline.zsh-theme -O $HOME/.oh-my-zsh/themes/powerline.zsh-theme
#git clone git@github.com:powerline/fonts.git && bash fonts/install.sh
#sleep 3
#rm -rf fonts

#-------------------------------------------------------------------------------
# Install & execute profile
#-------------------------------------------------------------------------------

# Always prefer dotfiles' .zshrc
# [ ! -f $HOME/.zshrc ] && ln -nfs $DOTFILES/.zshrc $HOME/.zshrc
ln -nfs $DOTFILES/.zshrc $HOME/.zshrc




# .bash_profile
ln -nfs $DOTFILES/.bash_profile $HOME/.bash_profile



#-------------------------------------------------------------------------------
# Install Mackup config
#-------------------------------------------------------------------------------

[ ! -f $HOME/.mackup.cfg ] && ln -nfs $DOTFILES/.mackup.cfg $HOME/.mackup.cfg

#-------------------------------------------------------------------------------
# Install .vimrc
#-------------------------------------------------------------------------------

#ln -nfs $DOTFILES/.vimrc $HOME/.vimrc

#-------------------------------------------------------------------------------
# Install .nanorc
#-------------------------------------------------------------------------------

#ln -nfs $DOTFILES/.nanorc $HOME/.nanorc

#-------------------------------------------------------------------------------
# Install Composer
#-------------------------------------------------------------------------------

#curl -sS https://getcomposer.org/installer | php
#sudo mv composer.phar /usr/local/bin/composer

#-------------------------------------------------------------------------------
# Install global Composer packages
#-------------------------------------------------------------------------------

#/usr/local/bin/composer global require laravel/installer laravel/envoy laravel/valet tightenco/jigsaw

#-------------------------------------------------------------------------------
# Install Laravel Valet
# IMPORTANT NOTE
# For valet to work correctly, php71 & nginx must be run as sudo privileges.
# # brew services start php71 && brew services nginx
#-------------------------------------------------------------------------------

#$HOME/.composer/vendor/bin/valet install
#cd $HOME/workspace && $HOME/.composer/vendor/bin/valet park

#-------------------------------------------------------------------------------
# Install Homestead Repo & Add vagrant box
# Commented out on behalf of Docker
#-------------------------------------------------------------------------------

# git clone git@github.com:laravel/homestead.git $HOME/Homestead
# cd $HOME/Homestead && bash ./init.sh
# [[ $(basename $(pwd)) != "Homestead" ]] && cd $HOME/Homestead; vagrant box add laravel/homestead

#-------------------------------------------------------------------------------
# Install global Node packages
#-------------------------------------------------------------------------------

#npm install gulp-cli gulp yo http-server nodemon yarn --global --save
# npm install gitbook-cli --global --save

#-------------------------------------------------------------------------------
# Install Rails & Jekyll
#-------------------------------------------------------------------------------

#gem install pry rails jekyll bundler

#-------------------------------------------------------------------------------
# Install AWS Shell
# Commented out because I prefer brew version of aws-cli
#-------------------------------------------------------------------------------

# pip install aws-shell

#-------------------------------------------------------------------------------
# Source profile
#-------------------------------------------------------------------------------

source $HOME/.zshrc

#-------------------------------------------------------------------------------
# Set OS X preferences
# We will run this last because this will reload the shell
#-------------------------------------------------------------------------------

source $DOTFILES/.osx
