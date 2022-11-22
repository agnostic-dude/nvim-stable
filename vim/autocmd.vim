function LastMod()
    if line("$") > 20
        let l = 20
    else
        let l = line("$")
    endif
    exe "1," .. l .. "g/Last Modified: /s/Last Modified: .*/Last Modified: " .. strftime("%d %B %Y")
endfunction

autocmd BufWritePre,FileWritePre *.py ks|call LastMod()|'s
