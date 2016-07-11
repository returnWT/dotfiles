" Vim indent file
" Language: CFScript
" Last Change:  2014 February 12
" Version: 1.0
" License: Same as Vim.
" Gutted version of the Java.vim file. Quick and dirty, but it works.

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

" Set the function to do the work.
setlocal indentexpr=GetCFScriptIndent()

let b:undo_indent = "set cin< cino< indentkeys< indentexpr<"

" Only define the function once.
if exists("*GetCFScriptIndent")
  finish
endif
let s:keepcpo= &cpo
set cpo&vim

function! SkipCFScriptBlanksAndComments(startline)
  let lnum = a:startline
  while lnum > 1
    let lnum = prevnonblank(lnum)
    if getline(lnum) =~ '\*/\s*$'
      while getline(lnum) !~ '/\*' && lnum > 1
        let lnum = lnum - 1
      endwhile
      if getline(lnum) =~ '^\s*/\*'
        let lnum = lnum - 1
      else
        break
      endif
    elseif getline(lnum) =~ '^\s*//'
      let lnum = lnum - 1
    else
      break
    endif
  endwhile
  return lnum
endfunction

function GetCFScriptIndent()

  " CFScript is just like Java/C; use the built-in C indenting and then correct a few
  " specific cases.
  let theIndent = cindent(v:lnum)

  " If we're in the middle of a comment then just trust cindent
  if getline(v:lnum) =~ '^\s*\*'
    return theIndent
  endif

  return theIndent
endfunction

let &cpo = s:keepcpo
unlet s:keepcpo

" vi: sw=2 et
