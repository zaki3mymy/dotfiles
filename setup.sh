#!/bin/bash

set -eux pipefail

function log () {
  echo [`date -Ins`] $1
}

function initialize () {
  apt update -y
  apt upgrade -y
}

function set_locale () {
  apt install -y language-pack-ja
  locale-gen ja_JP.UTF-8
}

function install_tools () {
  apt install -y git curl zip unzip jq tmux
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

function install_github_cli () {
  (type -p wget >/dev/null || (apt update && apt install wget -y)) \
	  && mkdir -p -m 755 /etc/apt/keyrings \
	  && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	  && cat $out | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	  && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	  && mkdir -p -m 755 /etc/apt/sources.list.d \
	  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	  && apt update \
	  && apt install gh -y
}

function install_neovim () {
  # https://github.com/neovim/neovim/blob/master/INSTALL.md#linux
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
  rm -rf /opt/nvim-linux-x86_64
  tar -C /opt -xzf nvim-linux-x86_64.tar.gz
  rm -f nvim-linux-x86_64.tar.gz

  echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.bashrc
  echo "alias vi='nvim'" >> ~/.bashrc

  # telescope.nvim の live_grep を使うためにインストール
  apt install -y ripgrep
}

function install_volta () {
  # https://volta.sh/
  curl https://get.volta.sh | bash
  ~/.volta/bin/volta install node@latest
}

function main () {
  log "セットアップを開始します。"
  initialize
  log "ロケールの設定をします。"
  set_locale

  log "コマンド群をインストールします。"
  install_tools

  log "設定ファイルをインストールします。"
  initialize_dotfiles

  log "git-secrets をインストールします。"
  install_git_secrets

  log "uv をインストールします。"
  install_uv

  log "GitHub CLI をインストールします。"
  install_github_cli

  log "neovim をインストールします。"
  install_neovim

  log "Volta, Node.js, npm をインストールします。"
  install_volta
}

main
source ~/.bashrc

log "インストールが完了しました。\`gh auth login\`を実行してセットアップを完了してください。"
