# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/dev/behanceops"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "basic-local"

# Split window into panes.
split_h 50
split_v 30

select_pane 0

# # Run commands.
# select_pane 3
#
# # Split window into panes.
# split_v 20
# run_cmd "watch -t date"
# split_h 60
#
# # Set active pane.
# select_pane 0
