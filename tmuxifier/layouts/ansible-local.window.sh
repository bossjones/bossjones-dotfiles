# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/dev/behanceops/ansible"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "local"

# Split window into panes.
split_h 50
split_v 30

# Run commands.
select_pane 3
