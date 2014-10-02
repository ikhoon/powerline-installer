#!/bin/bash 
# 2014.09.30 by !h, tmux powerline installation script on osx.

# Install Brew
if [ -z "`which brew`" ]; then 
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi 
 
# Install Dependencies

## python 2.6 or later
brew install python

## coreutils(for genv)
brew install coreutils

## cmake
brew install cmake

## socat 
brew install socat

## psutil - python package
pip install psutil

## mercurial - python package
pip install mercurial

## libgit2
brew install libgit2

## pygit2 - python package
pip install pygit2

## bzr - python package
pip install bzr

## pyuv - python package
pip install pyuv

## i3-py - python package
pip install i3-py

# Install powerline & tmux

## powerline - python package hosted by github
pip install git+git://github.com/Lokaltog/powerline

## tmux
brew install tmux

## copy default config file
PYTHON=$(brew --prefix)/bin/python
mkdir -p ~/.config/powerline

# PYTHON_SITE_PACKAGE=$(pip show powerline | grep Location | awk '{ print $2 }')
PYTHON_SITE_PACKAGE=$(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")
cp -R $PYTHON_SITE_PACKAGE/powerline/config_files/* ~/.config/powerline

## add configuration into .tmux.conf
echo "run-shell 'powerline-daemon -q'" >> ~/.tmux.conf
echo "source '$PYTHON_SITE_PACKAGE/powerline/bindings/tmux/powerline.conf'" >> ~/.tmux.conf

## font fatch
RAND_POSTFIX=$(cat /dev/urandom | env LC_CTYPE=C tr -dc a-zA-Z0-9 | head -c 6)
git clone https://github.com/Lokaltog/powerline-fonts.git /tmp/powerline-fonts.$RAND_POSTFIX
find -E /tmp/powerline-fonts.$RAND_POSTFIX/ -regex ".*\.(ttf|otf|ttc)" -exec cp {} /Library/Fonts/ \;

echo
echo "You can apply patched 'Powerline Font' in ..."
echo "- iTerm.app : Preferences > Profiles > Text > Regular Font & Non-ASCII Font"
echo


