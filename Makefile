.PHONY: list help

help:
	@echo "Convenience Make commands for provisioning a scarlett node"

list:
	@$(MAKE) -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$$)/ {split($$1,A,/ /);for(i in A)print A[i]}' | sort

backup-tmux-config:
	cp -p ~/.tmux.conf ~/.tmux.conf.`date +%F`
	cp -p ~/.tmux.conf.local ~/.tmux.conf.local.`date +%F`

setup-tmux-config: backup-tmux-config
	 bash ./script/tmux-bootstrap.sh

