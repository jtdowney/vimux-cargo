# vimux-cargo

Run `cargo` commands in vim.

## Usage

This plugin assumes you have a module named `tests` in the current file and that
modules are not nested.

Add this to your .vimrc or inside .vim/ftplugin/rust.vim if you want only use
this mapping with files that have the rust filetype.

```vim
map <Leader>rc :wa<CR> :CargoRun<CR>
map <Leader>ra :wa<CR> :CargoTestAll<CR>
map <Leader>rb :wa<CR> :CargoUnitTestCurrentFile<CR>
map <Leader>rf :wa<CR> :CargoUnitTestFocused<CR>
```

* **CargoRun** - run the project, currently this assumes there is only one
binary
* **CargoTestAll** - run all tests
* **CargoUnitTestCurrentFile** - run the whole test module in the current file
* **CargoUnitTestFocused** - find the first test above your current line and run
that test

This plugin assumes you have a module named `test` in the current file and that
modules are not nested.
