#!/bin/zsh
# 새 맥에서 Homebrew를 설치한 뒤 한 번 실행합니다: ./configs/install.sh
# Brewfile 설치, 설정 파일 복사(내용이 다른 기존 파일은 .backup-날짜 사본을 남김), VS Code 확장, Java 등록, 맥 설정까지 합니다.
set -e
cd "${0:A:h}"

echo "==> Homebrew 패키지"
brew bundle --file Brewfile

echo "==> 설정 파일 복사"
put() {
  mkdir -p "${2:h}"
  if [[ -f $2 ]] && ! cmp -s "$1" "$2"; then
    local backup
    backup="$2.backup-$(date +%Y%m%d%H%M%S)"
    cp "$2" "$backup" && echo "  기존 파일 보관: $backup"
  fi
  cp "$1" "$2" && echo "  $2"
}
put zsh/.zshrc "$HOME/.zshrc"
put git/.gitconfig "$HOME/.gitconfig"
put vim/.vimrc "$HOME/.vimrc"
put starship/starship.toml "$HOME/.config/starship.toml"
put fastfetch/config.jsonc "$HOME/.config/fastfetch/config.jsonc"
put ghostty/config.ghostty "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
put vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"

echo "==> VS Code 확장"
code=$(command -v code || echo "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code")
if [[ -x $code ]]; then
  while read -r ext; do
    "$code" --install-extension "$ext" >/dev/null && echo "  $ext"
  done < vscode/extensions.txt
else
  echo "  VS Code가 없어 건너뜀 (configs/apps.md 보고 설치한 뒤 다시 실행)"
fi

echo "==> Java (jenv)"
# enable-plugin은 jenv init이 만드는 셸 함수가 있어야 동작합니다 (실행 파일은 jenv-sh-enable-plugin만 있음).
eval "$(jenv init -)"
mkdir -p "$HOME/.jenv/versions"
for v in 21 25; do
  jenv add "/Library/Java/JavaVirtualMachines/amazon-corretto-$v.jdk/Contents/Home" >/dev/null || true
done
jenv global 21
jenv enable-plugin export >/dev/null
jenv rehash

echo "==> 맥 설정"
zsh macos/defaults.sh

echo "끝. 새 터미널을 열면 적용됩니다. 다크 모드는 다시 로그인하면 적용됩니다."
