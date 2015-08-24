# vimux-cargo

Run [cargo](https://github.com/rust-lang/cargo) commands in vim and tmux using
[vimux](https://github.com/benmills/vimux).

## Usage

This plugin currently assumes you have a module named `tests` in the current
file and that modules are not nested.

Add something like this to your `~/.vimrc` or inside `~/.vim/ftplugin/rust.vim`
if you want only use this mapping with files that have the rust filetype.

```vim
map <Leader>rc :wa<CR> :CargoRun<CR>
map <Leader>ra :wa<CR> :CargoTestAll<CR>
map <Leader>rb :wa<CR> :CargoUnitTestCurrentFile<CR>
map <Leader>rf :wa<CR> :CargoUnitTestFocused<CR>
```

### Commands

* **CargoRun** - run the project, currently this assumes there is only one
binary
* **CargoTestAll** - run all tests
* **CargoUnitTestCurrentFile** - run the whole test module in the current file
* **CargoUnitTestFocused** - find the first test above your current line and run
that test

## See Also

* [The Rust Programming Language: Testing](https://doc.rust-lang.org/stable/book/testing.html)
