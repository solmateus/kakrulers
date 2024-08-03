# Kak Rulers


Options to highlight current line, current row, or the row of max characters per line before wrapping. A fork of @insipx's kak-crosshairs.
You can either map the commands to a key or enable a ruler by default on your config.

### Commands:
- `rulers` -> Toggle the highlighting of all of the rulers on and off.
- `ruler_line` -> Toggle the highlighting of the current line.
- `ruler_column` ->  Toggle the highlighting of the current column.
- `ruler_wrapcolumn` -> Toggle the highlighting of the wrap column. 

### Installation
###### With Plug.kak
```kak
# Enable line and wrap column highlighting by default
plug "solmateus/kakrulers" %{
  hook global WinCreate .* %{
    ruler_line
    ruler_wrapcolumn
  }
}

# Alternatively, mao to a key.
plug "solmateus/kakrulers"
map global user l ":ruler_line"
map global user w ":ruler_wrapcolumn"
map global user c ":ruler_column"
```

###### Manually
1. Download `kakrulers.kak`.
2. Create a folder under `kak_config_path/autoload`.
3. Place the file there!

### Thanks!
Special thanks to @insipx.

Sol, d:^).

