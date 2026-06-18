"set mouse=a

GuiFont Fira Code:h12

"" Set Editor Font
"if exists(':GuiFont')
"    " Use GuiFont! to ignore font errors
"    GuiFont {font_name}:h{size}
"endif

"if exists(':GuiPopupmenu')
"    GuiPopupmenu 0
"endif

if exists(':GuiAdaptiveColor')
    GuiTabline 0
    GuiScrollBar 1
    GuiAdaptiveColor 1
    GuiAdaptiveFont 1
    GuiRenderLigatures 1
    
    "set winbar=%{expand('%:p')}

    "" Right Click Context Menu (Copy-Cut-Paste)
    nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
    inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
    xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
    snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
endif

