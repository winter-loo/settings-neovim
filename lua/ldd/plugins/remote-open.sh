#!/bin/bash

filename="$1"
line=${2:-"1"}
column=${3:-"1"}
# <c-\><c-n> to go back to normal mode
command="<C-\\><C-N>:edit $filename<CR>:call cursor($line,$column)<CR>"
set -x
# neovim exposes NVIM environment variable when open a terminal(:term)
nvim --server "$NVIM" --remote-send "$command"
