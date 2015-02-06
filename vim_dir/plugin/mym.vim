" File: mym.vim
" Author: Alfred Jen-Chieh Huang
" Version: 0.0.1
" Last Modified: Aug 16, 2012
" The purpose of this script is designed for the stack behaviors of the GTAGS related operations 

if exists("loaded_mym")
    finish
endif

let s:my_trace = []
let s:my_trace_idx = -1
let s:my_trace_line = []
let s:my_trace_line_idx = -1

let s:my_prev_trace = []
let s:my_prev_trace_idx = -1
let s:my_prev_trace_line = []
let s:my_prev_trace_line_idx = -1

let s:current_action    = -1
let s:ca_go_prev        =  1
let s:ca_go_next        =  2
let s:ca_no_action      = -1
 
"
" Display error message.
"
function! s:M_Err(msg)
    echohl WarningMsg |
           \ echomsg 'Error: ' . a:msg |
           \ echohl None
endfunction

"------------------------------------------------------------------------------
function! s:MYM_trace_push (fn)
    if (s:my_trace_idx < -1)
        call s:M_Err ('Index error @ s:MYM_trace_push')
        return -1
    endif    

    if (len (s:my_trace) > s:my_trace_idx + 1)
        let s:my_trace_idx = s:my_trace_idx + 1
        let s:my_trace[s:my_trace_idx] = a:fn
    else
        call add (s:my_trace, a:fn)
        let s:my_trace_idx = s:my_trace_idx + 1
    endif
endfunction

function! s:MYM_trace_push_line (ln)
    if (s:my_trace_line_idx < -1)
        call s:M_Err ('Index error @ s:MYM_trace_push')
        return -1
    endif    

    if (len (s:my_trace_line) > s:my_trace_line_idx + 1)
        let s:my_trace_line_idx = s:my_trace_line_idx + 1
        let s:my_trace_line[s:my_trace_line_idx] = a:ln
    else
        call add (s:my_trace_line, a:ln)
        let s:my_trace_line_idx = s:my_trace_line_idx + 1
    endif
endfunction

function! s:MYM_trace_pop ()
    if (s:my_trace_idx < 0)
        call s:M_Err ('Attempt to pop an empty stack @ MYM_trace_pop')
        return -1
    endif

    if (len (s:my_trace) > 0)
        let l:rc = s:my_trace[s:my_trace_idx]
        let s:my_trace_idx = s:my_trace_idx - 1
        return l:rc
    else
        return -1;
    endif
endfunction

function! s:MYM_trace_line_pop ()
    if (s:my_trace_line_idx < 0)
        call s:M_Err ('Attempt to pop an empty stack @ MYM_trace_pop')
        return -1
    endif

    if (len (s:my_trace_line) > 0)
        let l:rc = s:my_trace_line[s:my_trace_line_idx]
        let s:my_trace_line_idx = s:my_trace_line_idx - 1
        return l:rc
    else
        return -1;
    endif
endfunction

function! s:MYM_glance_trace_top ()
    if (s:my_trace_idx < 0)
        call s:M_Err ('Attempt to glance at an empty stack @ MYM_glance_trace_top')
        return -1
    endif 

    if (len (s:my_trace) > 0)
        return s:my_trace[s:my_trace_idx]
    else
        return -1;
    endif
endfunction

function! s:MTM_trace_clear ()
    let s:my_trace_idx = -1
    let s:my_trace = []
endfunction
"------------------------------------------------------------------------------


"------------------------------------------------------------------------------
function! s:MYM_prev_push (fn)

    if (s:my_prev_trace_idx < -1)
        call s:M_Err ('Index error @ s:MYM_trace_push')
        return -1
    endif

    if (len (s:my_prev_trace) > s:my_prev_trace_idx + 1)
        let s:my_prev_trace_idx = s:my_prev_trace_idx + 1
        let s:my_prev_trace[s:my_prev_trace_idx] = a:fn
    else
        call add (s:my_prev_trace, a:fn)
        let s:my_prev_trace_idx = s:my_prev_trace_idx + 1
    endif
endfunction

function! s:MYM_prev_line_push (fn)

    if (s:my_prev_trace_line_idx < -1)
        call s:M_Err ('Index error @ s:MYM_trace_push')
        return -1
    endif

    if (len (s:my_prev_trace_line) > s:my_prev_trace_line_idx + 1)
        let s:my_prev_trace_line_idx = s:my_prev_trace_line_idx + 1
        let s:my_prev_trace_line[s:my_prev_trace_line_idx] = a:fn
    else
        call add (s:my_prev_trace_line, a:fn)
        let s:my_prev_trace_line_idx = s:my_prev_trace_line_idx + 1
    endif
endfunction

function! s:MYM_prev_pop ()

    if (s:my_prev_trace_idx < 0)
        call s:M_Err ('Attempt to pop an empty stack @ MYM_trace_pop')
        return -1
    endif

    if (len (s:my_prev_trace) > 0)
        let l:rc = s:my_prev_trace[s:my_prev_trace_idx]
        let s:my_prev_trace_idx = s:my_prev_trace_idx - 1
        return l:rc
    else
        return -1;
    endif
endfunction

function! s:MYM_prev_line_pop ()

    if (s:my_prev_trace_line_idx < 0)
        call s:M_Err ('Attempt to pop an empty stack @ MYM_trace_pop')
        return -1
    endif

    if (len (s:my_prev_trace_line) > 0)
        let l:rc = s:my_prev_trace_line[s:my_prev_trace_line_idx]
        let s:my_prev_trace_line_idx = s:my_prev_trace_line_idx - 1
        return l:rc
    else
        return -1;
    endif
endfunction

function! s:MYM_glance_prev_top ()

    if (s:my_prev_trace_idx < 0)
        call s:M_Err ('Attempt to glance at an empty stack @ MYM_glance_trace_top')
        return -1
    endif

    if (len (s:my_prev_trace) > 0)
        return s:my_prev_trace[s:my_prev_trace_idx]
    else
        return -1;
    endif
endfunction

function! s:MYM_prev_clear ()
    let s:my_prev_trace_idx = -1
    let s:my_prev_trace = []
endfunction
"------------------------------------------------------------------------------

function! s:Mym_jump_to_prev ()
    " Check if the stack is empty
    if (len (s:my_trace) <= 1)
        return
    endif    

    " No previous at all
    if (s:my_trace_idx <= 0)
        return
    endif

    " Check the file and line number sync
    if (s:my_trace_idx != s:my_trace_line_idx)
        return
    endif

    " Retrieve the element from the trace stack, and push back to prev stack 
    let l:rc = s:MYM_trace_pop ()
    call s:MYM_prev_push (l:rc)

    let l:lnc = s:MYM_trace_line_pop ()
    call s:MYM_prev_line_push (l:lnc)

    " jump to the prev buffer
    let s:current_action = s:ca_go_prev
    let l:rc = s:MYM_glance_trace_top ()
    execute ":buffer " . l:rc
    execute ":" . l:lnc
    return

endfunction

function! s:Mym_jump_to_next ()
    " Check if the stack is empty
    if (len (s:my_prev_trace) == 0)
        return
    endif

    if (s:my_prev_trace_idx < 0)
        return
    endif

    if (s:my_prev_trace_idx != s:my_prev_trace_line_idx)
        return
    endif

    let l:rc = s:MYM_prev_pop ()
    call s:MYM_trace_push (l:rc)

    let l:lnc = s:MYM_prev_line_pop ()
    call s:MYM_trace_push_line (l:lnc)
    
    " jump to the prev buffer
    let s:current_action = s:ca_go_next
    execute ":buffer ".l:rc
    execute ":".l:lnc
    return
    
endfunction

" called when leaving current buffer
function! s:Mym_onOpenBuf ()

    let l:bnr = bufnr ('%')
    let l:b_name = bufname ('%')

    " a trick here - we will skipp the [QuickFix List]
    if (l:b_name == '[quickfix]')
        return
    endif

    " the quickfix is nothing here
    if (l:b_name == '')
        return
    endif

    " main logic
    if (s:current_action != s:ca_no_action)
        let s:current_action = s:ca_no_action
        return
    else
        let l:lnc = line (".")
        call s:MYM_trace_push (l:bnr)
        call s:MYM_trace_push_line (l:lnc)
    endif

    return

endfunction

" Define the set of Gtags commands
" command! -nargs=0 Mpush call s:Mym_onBufLeave()
command! -nargs=0 Mprv call s:Mym_jump_to_prev()
command! -nargs=0 Mnxt call s:Mym_jump_to_next()

" Config autocmd
:autocmd! BufEnter * call s:Mym_onOpenBuf()

" set module loaded
let loaded_mym = 1
