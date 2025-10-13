#!/bin/bash

set -eux pipefail

function initialize () {
  apt update -y
  apt upgrade -y
}

function set_locale () {
  apt install -y language-pack-ja
  locale-gen ja_JP.UTF-8
}

function install_tools () {
  apt install -y git vim curl zip unzip jq tmux
}

function initialize_dotfiles () {
  # install chezmoi
  local bin_dir="${HOME}/.local/bin"
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "${bin_dir}"
  local chezmoi_cmd="${bin_dir}/chezmoi"

  # install dotfiles
  ${chezmoi_cmd} init zaki3mymy --branch main
  ${chezmoi_cmd} apply

  # remove chezmoi binary
  rm -f ${chezmoi_cmd}
}

function install_git_secrets () {
  apt install -y build-essential make

  local cwd=`pwd`
  cd /tmp
  
  git clone https://github.com/awslabs/git-secrets.git
  cd git-secrets
  make install
  git secrets --register-aws --global
  cd .. && rm -rf git-secrets

  cd $cwd
}

function install_uv () {
  curl -LsSf https://astral.sh/uv/install.sh | sh
  echo 'eval "$(uv generate-shell-completion bash)"' >> ~/.bashrc
}

function main () {
  initialize
  set_locale

  install_tools

  initialize_dotfiles

  install_git_secrets

  install_uv
}

main
source ~/.bashrc

