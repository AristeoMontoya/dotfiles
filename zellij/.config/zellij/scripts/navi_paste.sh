#!/bin/sh
# Runs inside a floating pane: pick a snippet with navi and paste it into the
# pane that was focused before the popup opened.
cmd=$(navi --print) || exit 0
[ -n "$cmd" ] || exit 0

# ZELLIJ_PANE_ID is the popup's own id, not the origin's. The origin keeps its
# is_focused flag while the popup is on top, but that flag is tracked per tab and layer,
# hence the tab and floating filters.
origin=$(
	zellij action list-panes -a -j | jq -r --argjson me "$ZELLIJ_PANE_ID" '
		(.[] | select(.id == $me and (.is_plugin | not)) | .tab_id) as $tab
		| .[] | select(.is_focused and (.is_floating | not) and (.is_plugin | not) and .tab_id == $tab)
		| .id
	'
)
[ -n "$origin" ] && zellij action paste --pane-id "$origin" "$cmd"
