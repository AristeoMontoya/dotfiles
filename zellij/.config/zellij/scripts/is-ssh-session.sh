#!/bin/sh
# Exit 0 if this zellij session's server process was started from an SSH
# connection (i.e. zellij is running on a host we SSH'd into). Used by
# zellij-boot-evaluator to move the status bar to the top, mirroring
# tmux.remote.conf's `if-shell 'test -n "$SSH_CLIENT"'` trick.
test -n "$SSH_CLIENT"
