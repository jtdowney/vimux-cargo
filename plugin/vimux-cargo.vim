command! CargoBuild :call CargoBuild()
command! CargoRun :call CargoRun()
command! CargoPromptArgs :call CargoPromptArgs()
command! CargoTestAll :call CargoTestAll()
command! CargoBenchAll :call CargoBenchAll()
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

function! CargoBuild()
  call VimuxRunCommand('clear ' . s:separator . ' cargo build')
endfunction

function! CargoRun()
  call VimuxRunCommand('clear ' . s:separator . ' cargo run')
endfunction

function! CargoPromptArgs()
  let l:args = input(VimuxOption('VimuxPromptString'))
  call VimuxRunCommand('clear ' . s:separator . ' cargo run -- ' . l:args)
endfunction

function! CargoTestAll()
  call VimuxRunCommand('clear ' . s:separator . ' cargo test')
endfunction

function! CargoBenchAll()
  call VimuxRunCommand('clear ' . s:separator . ' cargo bench')
endfunction

function! CargoUnitTestCurrentFile()
  call CargoRunTests('')
endfunction

function! CargoUnitTestFocused()
  let test_line = search('#[test', 'bs')

  if test_line ==# 0
      let test_line = search('#[tokio::test', 'bs')
      if test_line ==# 0
          return
      endif
  endif

  let line = getline(test_line + 1)
  let test_name_raw = split(line, ' fn ')[1]
  let test_name = split(test_name_raw, '(')[0]

  call CargoRunTests(test_name)
endfunction

function! CargoRunTests(test_name)
  let path = expand('%:r')
  if match(path, '^src/') != -1
    let parts = split(path, '/')
    let filtered_parts = filter(parts, 'v:val !~# "mod" && v:val !~# "src"')
    let module_path = join(filtered_parts, '::')

    if module_path ==# 'lib' || module_path ==# 'main'
      call VimuxRunCommand('clear ' . s:separator . ' cargo test tests::' . a:test_name)
    else
      call VimuxRunCommand('clear ' . s:separator . ' cargo test ' . module_path . '::tests::' . a:test_name)
    endif
  endif
endfunction
