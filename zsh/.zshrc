#!/bin/sh
# zmodload zsh/zprof
export ZDOTDIR=$HOME/.config/zsh
HISTFILE=~/.zsh_history
setopt appendhistory

# Utility functions
source "$ZDOTDIR/zsh-functions"

# We'll need this for lazy loading
zsh_add_plugin "romkatv/zsh-defer"

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP

# Base16
BASE16_SHELL="$ZDOTDIR/plugins/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"

# complist is required for vim mode
zmodload zsh/complist
zsh_add_file "zsh-vim-mode"

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# Source env specific files
zsh_add_file "zsh-prepare-env"

# Source withouth checking, should be a bit faster.
# zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-completions"
zsh_add_file "zsh-exports"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-widgets"
zsh_add_file "zsh-fzf"

# Plugins
zsh_add_plugin "chriskempson/base16-shell"

## Lazy loaded
zsh-defer zsh_add_plugin "zdharma-continuum/fast-syntax-highlighting"
zsh-defer zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh-defer zsh_add_plugin "hlissner/zsh-autopair"
zsh-defer zsh_add_plugin "matthieusb/zsh-sdkman"
zsh_add_plugin "gradle/gradle-completion"
zsh-defer [ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

# Key-bindings
bindkey -s '^z' 'zi^M'
bindkey '^[[P' delete-char
bindkey -r "^u"
bindkey -r "^d"
bindkey '^p' fzf-bookmarks

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line

# Add bookmarks
if [ -d "$HOME/.bookmarks" ]; then
	alias goto="cd -P $HOME/.bookmarks/"
fi

# tmux over ssh
if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
	tmux attach || tmux new-session
fi

# Starship can be disabled by setting "DISABLE_STARSHIP" to any value
# The proper way to do this would be in one of the env specific files
if [[ $commands[starship] ]] && [[ -z "${DISABLE_STARSHIP+1}" ]]; then
	eval "$(starship init zsh)"
else
	zsh_add_file "zsh-prompt"
fi

# zprof
