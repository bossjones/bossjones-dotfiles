# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/Documents/Repos/behanceops/ansible"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "remote"

# Split window into panes.
split_h 50
split_v 30

# Run commands.
select_pane 1
run_cmd "ssh to"     # runs in active pane
run_cmd "cd code/behanceops/ansible/"     # runs in active pane
run_cmd ". behance-openrc.sh"     # runs in active pane
select_pane 2
run_cmd "ssh to"     # runs in active pane
run_cmd "cd code/behanceops/ansible/"     # runs in active pane
run_cmd ". behance-openrc.sh"     # runs in active pane
select_pane 3
run_cmd "ssh to"     # runs in active pane
run_cmd "cd code/behanceops/ansible/"     # runs in active pane
run_cmd ". behance-openrc.sh"     # runs in active pane
run_cmd "watch 'nova list --all-tenants --fields \"name,status,flavor,OS-EXT-SRV-ATTR:hypervisor_hostname\"| grep \"prenetlb\|benetlb\"'"

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "date" 1 # paste into pane 1
