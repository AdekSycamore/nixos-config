mkcd() {
  if [ -z "$1" ]; then
    echo "Usage: mkcd <dir>"
    return 1
  fi
  mkdir -p -- "$1" && cd -- "$1"
}   

extract() {
  if [ -z "$1" ]; then
    echo "Usage: extract <archive>"
    return 1
  fi
  case "$1" in
    *.tar.bz2)  tar xjf "$1"    ;;
    *.tar.gz)   tar xzf "$1"    ;;
    *.tar.xz)   tar xf  "$1"    ;;
    *.tar)      tar xf  "$1"    ;;
    *.tgz)      tar xzf "$1"    ;;
    *.zip)      unzip "$1"      ;;
    *.rar)      command -v unrar >/dev/null 2>&1 && unrar x "$1" || echo "install unrar";;
    *.7z)       command -v 7z >/dev/null 2>&1 && 7z x "$1" || echo "install p7zip";;
    *)          echo "Unsupported archive: $1"; return 2 ;;
  esac
}

up() {
  local n=${1:-1}
  if ! [[ $n =~ ^[0-9]+$ ]]; then
    echo "Usage: up <num>"
    return 1
  fi
  while [ $n -gt 0 ]; do
    cd .. || return
    n=$((n-1))
  done
}

pathadd() {
  for p in "$@"; do
    [ -d "$p" ] || continue
    case ":$PATH:" in
      *":$p:"*) ;;
      *) PATH="$p:$PATH" ;;
    esac
  done
  export PATH
}

zsh_reload() {
  source ~/.config/zsh/.zshrc
}