Thanks to:

* https://github.com/cpow/cpow-dotfiles.git
* https://www.josean.com/posts/how-to-setup-neovim-2024

Works best with neovim 0.9.5 and tmux 3.3

# prerequisites

* fzf
* ripgrep

# keymaps

|mode  |keys|function|
|------|----|--------|
|normal|gcc |linewise commenting|
|normal|gbc |blockwise commenting|
|normal|]h|go to next change|
|normal|[h|go to previous change|
|normal|\<leader\>hs|stage change|
|visual|\<leader\>hs|stage change|
|normal|\<leader\>hp|preview change in diff mode|
|normal|\<leader\>hb|blame line|
|normal|\<leader\>ee|toggle NvimTree|
|normal|\<leader\>ef|toggle file in NvimTree|
|normal|\<leader\>ec|collapse directory in NvimTree|
|normal|\<leader\>er|refresh files in NvimTree|
|normal|ys{motion}{char}|add surrounding `char` to the text object selcted with `motion`|
|normal|ds{char}|delete surrounding `char` from current text object|
|normal|cs{target}{replacement}|replace `target` char with `replacement` char in current text object|
|normal|\<leader\>ff|find files|
|normal|\<leader\>fr|find recent files|
|normal|\<leader\>fs|find string|
|normal|\<leader\>fc|find string under cursor|
|normal|\<leader\>ft|find todos|
|normal|]t|go to next todo comment|
|normal|[t|go to previous todo comment|
|normal|\<leader\>xx|toggle trouble list|
|normal|\<leader\>xw|open trouble workspace diagnostics|
|normal|\<leader\>xd|open trouble document diagnostics|
|normal|\<leader\>xq|open trouble quickfix list|
|normal|\<leader\>xl|open trouble location list|
|normal|\<leader\>xt|open todos in trouble list|
|normal|\<leader\>sm|maximize/minimize a split window|
|normal|\<leader\>nh|clear search highlights|
|normal|\<leader\>sv|split window vertically|
|normal|\<leader\>sh|split window horizontally|
|normal|\<leader\>se|make splits equal size|
|normal|\<leader\>sx|close current split|
|normal|\<leader\>to|open new tab|
|normal|\<leader\>tx|close current tab|
|normal|\<leader\>tn|go to next tab|
|normal|\<leader\>tp|go to previous tab|
|normal|<leader>tf|open current buffer in new tab|
|normal|gR|show definition, references|
|normal|gd|go to definition|
|normal|gD|go to declaration|
|normal|\<leader\>d|show line diagnostics|
|normal|\<leader\>D|show buffer diagnostics|
|normal|]d|go to next diagnostic|
|normal|[d|go to previous diagnostic|
|normal|K|show documentation for what is under cursor|
|normal|\<leader\>rs|restart lsp|
|normal|\<leader\>rn|smart rename what is under cursor|

# commands

- :Lazy
- :MarkdownPreview
- :Mason

## nvim-tree

- `a`: add a new file or directory. Directory is a file ending with '/'

- `r`: rename file or directory

- `ctrl+x`: open file in a split
