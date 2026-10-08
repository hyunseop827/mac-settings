#!/bin/zsh
# 기본값에서 바꾼 맥 설정. 몇 번을 실행해도 결과는 같습니다.

# Dock: 아이콘 크기 33, 마우스를 올리면 74로 확대, 최근 앱 숨김
defaults write com.apple.dock tilesize -int 33
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 74
defaults write com.apple.dock show-recents -bool false

# Finder: 목록 보기, 새 창은 홈 폴더, 파일 확장자 항상 표시
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
defaults write com.apple.finder NewWindowTarget -string PfHm
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# 트랙패드: 탭으로 클릭, 세 손가락으로 드래그
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerDragGesture -bool true
# 세 손가락 드래그를 켜면 세 손가락 쓸어넘기기는 꺼짐 (시스템 설정이 저장하는 값과 같게)
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerVertSwipeGesture -int 0

# 다크 모드 (다시 로그인하면 적용)
defaults write NSGlobalDomain AppleInterfaceStyle -string Dark

# Rectangle: 대체 단축키, 메뉴 막대 아이콘 숨김, 로그인 시 실행, Todo 모드 끔
# 실행 중이면 끝날 때 설정을 덮어쓰므로 먼저 종료합니다.
osascript -e 'quit app "Rectangle"' 2>/dev/null
defaults write com.knollsoft.Rectangle alternateDefaultShortcuts -bool true
defaults write com.knollsoft.Rectangle allowAnyShortcut -bool true
defaults write com.knollsoft.Rectangle hideMenubarIcon -bool true
defaults write com.knollsoft.Rectangle launchOnLogin -bool true
defaults write com.knollsoft.Rectangle subsequentExecutionMode -int 1
defaults write com.knollsoft.Rectangle windowSnapping -int 2
defaults write com.knollsoft.Rectangle todo -int 2
# 자동 업데이트 확인 끔 (첫 실행 허가 창도 안 뜸)
defaults write com.knollsoft.Rectangle SUEnableAutomaticChecks -bool false
for key in maximizeHeight nextDisplay previousDisplay restore; do
  defaults write com.knollsoft.Rectangle $key -dict
done

killall Dock Finder 2>/dev/null
[[ -d /Applications/Rectangle.app ]] && open -a Rectangle || true  # Rectangle이 없을 수 있음
