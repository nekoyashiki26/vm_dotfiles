#!/bin/bash

sudo apt update && sudo apt install -y \
        build-essential \
        libffi-dev \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        git

# Download pyenv
if [ ! -d ~/.pyenv ]; then
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi

sed -i "s/#export PYENV_ROOT=\"\$HOME\/.pyenv\"/export PYENV_ROOT=\"\$HOME\/.pyenv\"/g" ~/.dotfiles/.zshrc
sed -i "s/#export PATH=\"\$PYENV_ROOT\/bin:\$PATH\"/export PATH=\"\$PYENV_ROOT\/bin:\$PATH\"/g" ~/.dotfiles/.zshrc
sed -i "s/#eval \"\$(pyenv init -)\"/eval \"\$(pyenv init -)\"/g" ~/.dotfiles/.zshrc
exec $SHELL -l
pyenv -v

# Install Python and set default
pyenv install 3.7.0
pyenv global 3.7.0

# Install pipenv
pip install pipenv
echo "python 3.7.0 installed using pyenv"
