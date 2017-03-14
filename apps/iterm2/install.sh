 #!/usr/bin/env bash
# ===============================================================================
# This is an install script that handles the macos default terminal -
# and the newly installed iterm 2.
# Installs a customised set of preferences for iterm 2.
# Adds the Atom theme as default (Subject to change) in addition to a modified
# Solarised theme to both iterm 2 and Terminal.
# ===============================================================================
source ./config/echos.sh

# ===============================================================================
bot "Terminal & iTerm2"
# ===============================================================================
action "Setting up Better Terminal Defaults.."

running "Use a modified version of the Atom theme by default in Terminal.app"
TERM_PROFILE='Atom';
CURRENT_PROFILE="$(defaults read com.apple.terminal 'Default Window Settings')";
if [ "${CURRENT_PROFILE}" != "${TERM_PROFILE}" ]; then
   open "./apps/terminal/themes/${TERM_PROFILE}.terminal";
   sleep 1; # Wait a bit to make sure the theme is loaded
   defaults write com.apple.terminal 'Default Window Settings' -string "${TERM_PROFILE}";
   defaults write com.apple.terminal 'Startup Window Settings' -string "${TERM_PROFILE}";
fi;ok

running "Enable “focus follows mouse” for Terminal.app and all X11 apps"
# i.e. hover over a window and start `typing in it without clicking first
defaults write com.apple.terminal FocusFollowsMouse -bool true;ok
#defaults write org.x.X11 wm_ffm -bool true;ok

action "Setting up Better iTerm 2 Defualts.."

# Symlink preferences
running "Symlink modified iterm 2 preferences.."
ln -s ./apps/iterm2/com.googlecode.iterm2.plist  ~/Library/Preferences/com.googlecode.iterm2.plist;ok
running "Installing the Solarized Light theme for iTerm (opening file)"
open "./apps/iterm2/themes/Solarized Light.itermcolors";ok
running "Installing the Solarized Dark theme for iTerm (opening file)"
open "./apps/iterm2/themes/Solarized Dark.itermcolors";ok
running "Installing the Atom theme for iTerm (opening file)"
open "./apps/iterm2/themes/Atom.itermcolors";ok
# would add more in the future.
sudo -v
running "Don’t display the annoying prompt when quitting iTerm"
defaults write com.googlecode.iterm2 PromptOnQuit -bool false;ok
running "hide tab title bars"
defaults write com.googlecode.iterm2 HideTab -bool true;ok
running "set system-wide hotkey to show/hide iterm with ^\`"
defaults write com.googlecode.iterm2 Hotkey -bool true;ok
running "hide pane titles in split panes"
defaults write com.googlecode.iterm2 ShowPaneTitles -bool false;ok
running "animate split-terminal dimming"
defaults write com.googlecode.iterm2 AnimateDimming -bool true;ok
defaults write com.googlecode.iterm2 HotkeyChar -int 96;
defaults write com.googlecode.iterm2 HotkeyCode -int 50;
defaults write com.googlecode.iterm2 FocusFollowsMouse -int 1;
defaults write com.googlecode.iterm2 HotkeyModifiers -int 262401;
running "Make iTerm2 load new tabs in the same directory"
/usr/libexec/PlistBuddy -c "set \"New Bookmarks\":0:\"Custom Directory\" Recycle" ~/Library/Preferences/com.googlecode.iterm2.plist;ok
running "setting fonts"
defaults write com.googlecode.iterm2 "Normal Font" -string "Hack-Regular 12";
defaults write com.googlecode.iterm2 "Non Ascii Font" -string "RobotoMonoForPowerline-Regular 12";
ok
running "reading iterm settings"
defaults read -app iTerm > /dev/null 2>&1;
ok

