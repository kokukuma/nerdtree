" ============================================================================
" File:        vimdiff_menu.vim
"
" ============================================================================
if exists("g:loaded_nerdtree_bzr_log_file")
    finish
endif
let g:loaded_nerdtree_bzr_log_file = 1

call NERDTreeAddMenuItem({'text': '(b)zr log', 'shortcut': 'b', 'callback': 'NERDTreeUniteBzrLog'})

" FUNCTION: NERDTreeUniteBzrLog()
function! NERDTreeUniteBzrLog()
    let currentNode = g:NERDTreeFileNode.GetSelected()
    let confirmed = 1

    if currentNode.path.isDirectory
        let choice =input("Diff with the current node\n" .
                         \ "==========================================================\n" .
                         \ "STOP! Cannot diff with directory\n" .
                         \ "" . currentNode.path.str() . ": ")
        let confirmed = 0
    endif

    if confirmed
        try
            let g:unite_bzr_log_file = currentNode.path.str()
            execute 'wincmd p'
            execute 'Unite  bzr_log -direction=botright  -no-quit -start-insert -winheight=8 '

        catch /^NERDTree/
            call s:echoWarning("Could not execute bzr log")
        endtry
    else
        call s:echo("bzr_log aborted")
    endif

endfunction
