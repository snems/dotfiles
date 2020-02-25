#!/usr/bin/env bash
#
# Rofi script to load and attach tmux session using tmux-sessions utility.
#
SESSIONS_DIR=~/.tmux/sessions/
TERMINAL_CMD="kitty -e"

# Default settings
_rofi () {
    rofi -regex -tokenize -i -lines 30 -width 1500 -no-levenshtein-sort "$@"
}

if [[ ! -x "$(command -v tmux-sessions)" ]]; then
    echo "tmux-sessions: command not found"
    exit 1
fi

# Handle argument
if [ -n "$@" ]; then
    SESSIONS_DIR="${SESSIONS_DIR}/$@"
fi

# If argument is not directory
if [ ! -d "${SESSIONS_DIR}" ]; then
    if [ -x "${SESSIONS_DIR}" ]; then
        coproc ( "${SESSIONS_DIR}" & > /dev/null 2>&1 )
        exec 1>&-
        exit;
    elif [ -f "${SESSIONS_DIR}" ]; then
        coproc ( ${EDITOR} "${SESSIONS_DIR}" &> /dev/null  2>&1 )
        exit;
    fi
    exit;
fi

if [ -n "${SESSIONS_DIR}" ]; then
    SESSIONS_DIR=$(readlink -e "${SESSIONS_DIR}")
    pushd "${SESSIONS_DIR}" >/dev/null
fi

select=$(ls --group-directories-first --color=never --indicator-style=slash -t | _rofi -dmenu -mesg "tmux session" -p "> ")

tmux_session=$SESSIONS_DIR/$select
if [ ! -f $note ] && [[ ! $tmux_session =~ .*.yaml$ ]]; then
    tmux_session=$SESSIONS_DIR/${select///}.md
fi

if [[ $tmux_session != "" ]]; then
    $TERMINAL_CMD tmux-sessions load $tmux_session
fi
