function fish_user_key_bindings
    # Helix-style: / in normal mode opens the history pager
    bind -M default / history-pager
    # Restore the standard history pager in insert mode
    bind -M insert ctrl-r history-pager
end
