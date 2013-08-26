## Search numbers quickly with `*`

This Vim plugin makes normal mode mapping `*` match number representations such as `-123`, `12.5`, `10e5`, `0x10`.
I made this mapping because original `*` mapping can't match them and it's inconvenient when I want to search magic numbers in a file.

This plugin overrides `*`, `#`, `g*`, `g#` mappings in normal mode if `g:numberstar_no_default_mappings` is not equivalent to `1`.

This plugin is distributed under [the MIT License](http://opensource.org/licenses/MIT).
