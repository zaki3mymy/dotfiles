#!/usr/bin/env bash
# Claude Code クラウド環境のセットアップスクリプトから呼び、flake.nix を持つリポジトリの
# devShell のツールを Nix ストアに取得する。
# PATH などの環境変数の設定は、各リポジトリの SessionStart フックに任せる。
#
# 使い方:
#   setup-nix-devshells.sh          # カレントディレクトリと、その直下のディレクトリが対象
#   setup-nix-devshells.sh DIR...   # 指定したディレクトリが対象
#
# 環境変数:
#   SETUP_NIX_TIMEOUT  1リポジトリあたりの制限秒数
#   SETUP_NIX_BIN      nix コマンドのパス

# set -e にしないのは、失敗するとクラウドセッション自体が起動しなくなるため
set -uo pipefail

# 環境のキャッシュはセットアップが約5分以内に終わったときだけ作られる
readonly TIMEOUT_SECONDS="${SETUP_NIX_TIMEOUT:-240}"
readonly GCROOTS_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/setup-nix-devshells"
# main で設定する
NIX=()
SYSTEM=""

main() {
  local nix_bin
  nix_bin="$(find_nix)"
  if [ -z "$nix_bin" ]; then
    log "nix が見つからないため何もしません"
    return 0
  fi
  # nix.conf で flakes が有効かどうかに依存しないようにする
  NIX=("$nix_bin" --extra-experimental-features "nix-command flakes")

  if ! SYSTEM="$("${NIX[@]}" eval --impure --raw --expr builtins.currentSystem 2>/dev/null)"; then
    log "nix が動かないため何もしません"
    return 0
  fi

  local -a targets=()
  if [ "$#" -gt 0 ]; then
    targets=("$@")
  else
    # セットアップスクリプトはリポジトリの1つ上のディレクトリで始まる
    local dir
    for dir in . ./*/; do
      [ -f "$dir/flake.nix" ] && targets+=("$dir")
    done
  fi
  if [ "${#targets[@]}" -eq 0 ]; then
    log "flake.nix のあるディレクトリが無いため何もしません"
    return 0
  fi

  mkdir -p "$GCROOTS_DIR" || true
  local target
  for target in "${targets[@]}"; do
    fetch_devshell "$target"
  done
  return 0
}

log() { printf '[setup-nix-devshells] %s\n' "$*" >&2; }

find_nix() {
  if [ -n "${SETUP_NIX_BIN:-}" ]; then
    [ -x "$SETUP_NIX_BIN" ] && printf '%s\n' "$SETUP_NIX_BIN"
    return
  fi
  # セットアップスクリプトの PATH に Nix のプロファイルが入っているとは限らない
  command -v nix 2>/dev/null && return
  local candidate
  for candidate in /nix/var/nix/profiles/default/bin/nix "$HOME/.nix-profile/bin/nix"; do
    if [ -x "$candidate" ]; then
      printf '%s\n' "$candidate"
      return
    fi
  done
}

fetch_devshell() {
  local target="$1"
  if [ ! -f "$target/flake.nix" ]; then
    log "$target: flake.nix が無いためスキップします"
    return
  fi
  local abs name
  abs="$(cd "$target" && pwd -P)"
  name="$(basename "$abs")"

  # devShell が無い flake で nix develop を実行すると packages.default のビルドに
  # フォールバックしてしまうので、先に有無を確かめる
  local has_shell eval_err
  eval_err="$(mktemp)"
  # 標準エラーを混ぜないのは、git の "dirty" 警告などが結果に入ってしまうため
  if ! has_shell="$("${NIX[@]}" eval --raw "$abs#devShells" \
    --apply "shells: if shells ? \"$SYSTEM\" && shells.\"$SYSTEM\" ? default then \"yes\" else \"no\"" \
    2>"$eval_err")"; then
    if grep -q 'does not provide attribute' "$eval_err"; then
      has_shell=no
    else
      log "$name: flake の評価に失敗したためスキップします: $(grep -m1 'error:' "$eval_err")"
      rm -f "$eval_err"
      return
    fi
  fi
  rm -f "$eval_err"
  if [ "$has_shell" != yes ]; then
    log "$name: devShells.$SYSTEM.default が無いためスキップします"
    return
  fi

  log "$name: devShell のツールを取得します"
  # --profile で GC ルートを作り、取得したものがガベージコレクションで消えないようにする
  if timeout "$TIMEOUT_SECONDS" \
    "${NIX[@]}" develop "$abs" --profile "$GCROOTS_DIR/$name" --command true; then
    log "$name: 完了"
  else
    log "$name: 失敗しました (終了コード $?)。セッションの起動は続けます"
  fi
}

main "$@"
exit 0
