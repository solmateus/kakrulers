set-face global rulers_line default,rgb:2a2b3c
set-face global rulers_column default,rgb:2a2b3c
set-face global rulers_wrapcolumn default,rgb:2a2b3c

declare-option int kakrulers_wrapcolumn 80
declare-option -hidden bool highlight_current_line false
declare-option -hidden str highlight_current_line_hook_cmd "nop"
declare-option -hidden bool highlight_current_column false
declare-option -hidden str highlight_current_column_hook_cmd "nop"
declare-option -hidden bool highlight_wrap_column false
declare-option -hidden str highlight_wrap_column_hook_cmd "nop"

define-command -hidden rulers-highlight-line -docstring "Highlight current line." %{
    try %{ remove-highlighter window/rulers-line }
    try %{ add-highlighter window/rulers-line line %val{cursor_line} rulers_line }
}

define-command -hidden rulers-highlight-column -docstring "Highlight current column." %{
    try %{ remove-highlighter window/rulers-column }
    try %{ add-highlighter window/rulers-column column %val{cursor_display_column} rulers_column }
}

define-command -hidden rulers-highlight-wrapcolumn -docstring "Highlight wrap column." %{
    try %{ remove-highlighter window/rulers-wrapcolumn }
    try %{ add-highlighter window/rulers-wrapcolumn column %opt{kakrulers_wrapcolumn} rulers_wrapcolumn }
}

define-command -hidden rulers-update %{
    evaluate-commands %{
    %opt(highlight_current_line_hook_cmd)
    %opt(highlight_current_column_hook_cmd)
    %opt(highlight_wrap_column_hook_cmd)
}}

define-command -hidden -docstring "Update hooks for highlighters." \
rulers-change-hooks %{
    evaluate-commands %sh{
        # set actions
        if [ "$kak_opt_highlight_current_line" = true ]; then
            printf "%s\n" "set-option global highlight_current_line_hook_cmd rulers-highlight-line"
        else
            printf "%s\n" "try %(remove-highlighter window/rulers-line)"
            printf "%s\n" "set-option global highlight_current_line_hook_cmd nop"
        fi
        if [ "$kak_opt_highlight_current_column" = true ]; then
            printf "%s\n" "set-option global highlight_current_column_hook_cmd rulers-highlight-column"
        else
            printf "%s\n" "try %(remove-highlighter window/rulers-column)"
            printf "%s\n" "set-option global highlight_current_column_hook_cmd nop"
        fi
        if [ "$kak_opt_highlight_wrap_column" = true ]; then
            printf "%s\n" "set-option global highlight_wrap_column_hook_cmd rulers-highlight-wrapcolumn"
        else
            printf "%s\n" "try %(remove-highlighter window/rulers-wrapcolumn)"
            printf "%s\n" "set-option global highlight_wrap_column_hook_cmd nop"
        fi
        # set hook
        if [ "$kak_opt_highlight_current_column" = true ] || [ "$kak_opt_highlight_current_line" = true ] || [ "$kak_opt_highlight_wrap_column" = false ]; then
            printf "%s\n" "hook global -group rulers RawKey .+ rulers-update"
        else
            printf "%s\n" "remove-hooks global rulers"
        fi
    }
}

define-command rulers -docstring "Toggle Rulers highlighting." %{
    evaluate-commands %sh{
        if [ "$kak_opt_highlight_current_column" = true ] && [ "$kak_opt_highlight_current_line" = true ] && [ "$kak_opt_highlight_wrap_column" = true ]; then
            printf "%s\n" "set-option global highlight_current_line false"
            printf "%s\n" "set-option global highlight_current_column false"
            printf "%s\n" "set-option global highlight_wrap_column false"
        else
            printf "%s\n" "set-option global highlight_current_line true"
            printf "%s\n" "set-option global highlight_current_column true"
            printf "%s\n" "set-option global highlight_wrap_column true"
        fi
    }
    rulers-change-hooks
    rulers-update
}

define-command ruler_line -docstring "Toggle Highlighting for current line." %{
    evaluate-commands %sh{
        if [ "$kak_opt_highlight_current_line" = true ] ; then
            printf "%s\n" "set-option global highlight_current_line false"
        else
            printf "%s\n" "set-option global highlight_current_line true"
        fi
    }
    rulers-change-hooks
    rulers-update
}

define-command ruler_column -docstring "Toggle highlighting for current column." %{
    evaluate-commands %sh{
        if [ "$kak_opt_highlight_current_column" = true ] ; then
            printf "%s\n" "set-option global highlight_current_column false"
        else
            printf "%s\n" "set-option global highlight_current_column true"
        fi
    }
    rulers-change-hooks
    rulers-update
}

define-command ruler_wrapcolumn -docstring "Toggle highlighting for wrap column." %{
    evaluate-commands %sh{
        if [ "$kak_opt_highlight_wrap_column" = true ] ; then
            printf "%s\n" "set-option global highlight_wrap_column false"
        else
            printf "%s\n" "set-option global highlight_wrap_column true"
        fi
    }
    rulers-change-hooks
    rulers-update
}
