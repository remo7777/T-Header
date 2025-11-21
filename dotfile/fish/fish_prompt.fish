function fish_prompt
    set -l config_file ~/.config/theader/theader.cfg
    set -l TNAME (whoami)
    if test -f $config_file
        set -l name_from_cfg (string match -r '^TNAME=.*' (cat $config_file) | cut -d'=' -f2-)
        if test -n "$name_from_cfg"
            set TNAME $name_from_cfg
        end
    end

    set -l ZWS_START "\001"
    set -l ZWS_END "\002"

    # Define colors by wrapping the set_color output with the markers.
    set -l red $ZWS_START(set_color red)$ZWS_END
    set -l blue $ZWS_START(set_color blue)$ZWS_END
    set -l yellow $ZWS_START(set_color yellow)$ZWS_END
    set -l green $ZWS_START(set_color green)$ZWS_END
    set -l gray $ZWS_START(set_color brblack)$ZWS_END
    set -l reset $ZWS_START(set_color normal)$ZWS_END
    set -l bold $ZWS_START(set_color --bold)$ZWS_END
    
    set -l cwd (prompt_pwd)
    
    # --- HYBRID PROMPT STRUCTURE ---
    
    # 1. First Line: Using stable ASCII characters (+- and -)
    set -l prompt_line1 (string join "" "\n" $red "┏━[" $blue $bold $TNAME $yellow "@" $gray "termux" $red "]-[" $green $cwd $red "]" $reset)

    # 2. Second Line Prefix: Using stable ASCII prefix (\>)
    set -l prompt_line2_prefix (string join "" "\n" "$red┗━" $red "━" $reset " ") 

    # 3. Symbols: Keeping the essential Nerd Font icons ()
    # This structure is the only part of the Nerd Font style that didn't break the prompt.
    set -l prompt_symbols (string join "" $red $bold "" $blue "" $gray "" " " $reset)

    # Combine all parts
    set -l prompt_str (string join "" $prompt_line1 $prompt_line2_prefix $prompt_symbols)

    # FINAL FIX: Use printf "%b" to process all escapes correctly.
    printf "%b" $prompt_str
end
