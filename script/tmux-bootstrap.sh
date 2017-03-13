#!/usr/bin/env bash -x

# clone if it doesn't exist yet
if cd ~/dev/gpakosz/.tmux; then git pull; else git clone git@github.com:gpakosz/.tmux.git ~/dev/gpakosz/.tmux; fi

# setup
cp ~/dev/gpakosz/.tmux/.tmux.conf ~/.tmux/.tmux.conf

cd ~/

ln -s -f .tmux/.tmux.conf

if [ ! -f ~/.tmux.conf.local ]; then
    echo "tmux.conf.local doesnt exist, creating"
    cp ~/dev/gpakosz/.tmux/.tmux.conf.local ~/.tmux.conf.local
fi
