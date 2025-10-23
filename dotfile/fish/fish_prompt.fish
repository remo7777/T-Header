function fish_prompt
    # Load username from config
    set -l config_file ~/.config/theader/theader.cfg
    set -l TNAME (whoami)
    if test -f $config_file
        set -l name_from_cfg (string match -r '^TNAME=.*' (cat $config_file) | cut -d'=' -f2-)
        if test -n "$name_from_cfg"
            set TNAME $name_from_cfg
        end
    end

    # Colors
    set -l cyan (set_color cyan)
    set -l gray (set_color brblack)
    set -l red (set_color red)
    set -l blue (set_color blue)
    set -l yellow (set_color yellow)
    set -l green (set_color green)
    set -l reset (set_color normal)
    set -l bold (set_color --bold)

    # Current directory
    set -l cwd (prompt_pwd)

    # Left prompt using printf for newline
    printf "\n%s┌─[%s%s%s@%stermux%s]─[%s%s%s]\n%s└──╼ %s%s %s" \
        $red $blue $bold$TNAME $yellow $bold$cyan $red $green $cwd $red \
    $red $blue $gray $reset
end
