function set_font {
    osascript -e "tell application \"Terminal\" to set the font name of window 1 to \"$1\""
    osascript -e "tell application \"Terminal\" to set the font size of window 1 to $2"
}


# tell application "iTerm2"
#   tell current window
#     create tab with default profile
#   end tell
# end tell

# http://apple.stackexchange.com/questions/103621/run-applescript-from-bash-script
# osascript <<'END'
# set x to "a"
# say x
# END

osascript <<'END'
say "Welcome to AppleScript!"
END
