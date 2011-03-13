" Text to rtf
" Author: Kevin Fu (corntrace@gmail.com)
" Version: 1.0
" Date: 2011-03-14
"
" Usage: select your target codes and run :Tortf command

function! Tortf(line1, line2)

  " store old values and make sure to generate in the correct format
  let l:old_css = 0
  if exists('g:html_use_css')
    let l:old_css = g:html_use_css
  endif
  let l:old_number_lines = 1
  if exists('g:html_number_lines')
	  let l:old_number_lines = g:html_number_lines
  endif
  let g:html_use_css = 1
  let g:html_number_lines = 0

  " generate and insert custom css
  exec a:line1.','.a:line2.'TOhtml'
  %g/<style/normal jopre {font-family: monaco !important; font-size: 16px;}

  " save the file and convert to rtf
  w
  exec "!textutil -convert rtf " . expand("%") . " -stdout | pbcopy"

  " delete the html output file and buffer
  let l:filename = expand("%")
  bdelete
  exec "!rm " . l:filename

  " restore old setting
  let g:html_use_css = l:old_css
  let g:html_number_lines = l:old_number_lines
endfunction
command! -range=% Tortf :call Tortf(<line1>,<line2>)

