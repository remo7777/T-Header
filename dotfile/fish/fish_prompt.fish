function fish_prompt
    set -l config_file ~/.config/theader/theader.cfg
    set -l TNAME (whoami)
    if test -f $config_file
        set -l name_from_cfg (string match -r '^TNAME=.*' (cat $config_file) | cut -d'=' -f2-)
        if test -n "$name_from_cfg"
            set TNAME $name_from_cfg
        end
    end

    set -l red (set_color red)
    set -l blue (set_color blue)
    set -l yellow (set_color yellow)
    set -l green (set_color green)
    set -l gray (set_color brblack)
    set -l reset (set_color normal)
    set -l bold (set_color --bold)
    
    set -l cwd (prompt_pwd)
    set -l os "termux"

    # Prompt parts built into a single string
    set -l prompt_str ""
    
    # First line (starts with a newline)
    set prompt_str "$prompt_str\n$red┌─[$blue$bold$TNAME$yellow@$gray$os$red]─[$green$cwd$red]$reset"

    # Second line
    set prompt_str "$prompt_str$red\n└──╼ "

    # Third part (Symbols)
    set prompt_str "$prompt_str$red$bold$blue$gray $reset"

    # FIX: Use printf %b to interpret the \n character as a newline.
    printf "%b" $prompt_str
end
