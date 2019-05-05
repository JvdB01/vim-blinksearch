let hlstate=0

nnoremap <silent> n   n:call BlinkNext(0.4)<cr>
nnoremap <silent> N   N:call BlinkNext(0.4)<cr>
nnoremap <Leader>/ :if (hlstate%2 != 0) \| set nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<cr>
cnoremap <silent> <expr> <enter> FirstBlink()

function! BlinkNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('error', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

function! FirstBlink()
    if getcmdtype() == '/'
        return "\<cr>:call BlinkNext(0.4)\<cr>"
    else
        if getcmdtype() == '?'
            return "\<cr>:call BlinkNext(0.4)\<cr>"
        else
            return "\<cr>"
        endif
    endif
endfunction
