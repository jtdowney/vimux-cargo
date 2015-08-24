command! CargoRun :call CargoRun()
command! CargoTestAll :call CargoTestAll()
command! CargoUnitTestCurrentFile :call CargoUnitTestCurrentFile()
command! CargoUnitTestFocused :call CargoUnitTestFocused()

function! ShellCommandSeperator()
  if empty(matchstr($SHELL, 'fish'))
    return '&&'
  else
    return '; and'
  endif
endfunction

let s:separator = ShellCommandSeperator()

function! CargoRun()
  call VimuxRunCommand("clear " . s:separator . " cargo run")
endfunction

function! CargoTestAll()
  call VimuxRunCommand("clear " . s:separator . " cargo test")
endfunction

function! CargoUnitTestCurrentFile()
  let path = expand("%:r")
  if match(path, "^src/") != -1
    let parts = split(path, "/")
    let filtered_parts = filter(parts, 'v:val !~ "mod" && v:val !~ "src"')
    let module_path = join(filtered_parts, "::")

    if module_path == "lib" || module_path == "main"
      call VimuxRunCommand("clear " . s:separator . " cargo test tests::")
    else
      call VimuxRunCommand("clear " . s:separator . " cargo test " . module_path . "::tests::")
    endif
  endif
endfunction

function! CargoUnitTestFocused()
  let path = expand("%:r")
  if match(path, "^src/") != -1
    let parts = split(path, "/")
    let filtered_parts = filter(parts, 'v:val !~ "mod" && v:val !~ "src"')
    let module_path = join(filtered_parts, "::")
    let test_line = search("#[test", "bs")
    ''

    if test_line == 0
      return
    endif

    let line = getline(test_line + 1)
    let test_name_raw = split(line, " ")[1]
    let test_name = split(test_name_raw, "(")[0]

    if module_path == "lib" || module_path == "main"
      call VimuxRunCommand("clear " . s:separator . " cargo test tests::" . test_name)
    else
      call VimuxRunCommand("clear " . s:separator . " cargo test " . module_path . "::tests::" . test_name)
    endif
  endif
endfunction
