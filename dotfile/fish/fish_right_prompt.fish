function fish_right_prompt
    # Preserve last command’s exit status
    set -l last_status $status
    set normal (set_color normal)
    set magenta (set_color magenta)
    set yellow (set_color yellow)
    set green (set_color green)
    set red (set_color red)
    set gray (set_color -o black)

    # Colors
    set -l reset (set_color normal)
    set -l white_fg (set_color white)
    set -l black_fg (set_color black)
    set -l gray_fg (set_color brblack)
    set -l red_fg (set_color red)
    set -l text_fg (set_color "#2C3E50")
    set -l green_fg (set_color green)
    set -l blue_fg (set_color blue)
    set -l green_bg (set_color -b green)
    set -l gray_bg (set_color -b brblack)
    set -l bold (set_color --bold)

    # === 1. Background jobs indicator ===
    set -l bg_jobs ""
    if test (count (jobs -p)) -gt 0
        set bg_jobs (printf "%s%s " $green_fg $reset)
    end

    # === 2. Non-zero return indicator ===
    set -l error_icon ""
    if not test $last_status -eq 0
        set error_icon (printf "%s%s " $red_fg $reset)
    end

    # === 3. Git branch info ===
    set -l git_branch ""
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set branch_name (git rev-parse --abbrev-ref HEAD 2>/dev/null)
        if test -n "$branch_name"
            set git_branch (printf "%s%s%s %s%s%s%s " \
                (set_color brblack) \
                (set_color -b brblack) \
            #now change from here git_status or other symbols
                $bold(set_color white) $green_bg (fish_git_prompt) \
            #git status end frome here
                $reset(set_color green) $reset)
        end
    end

    # === 4. Date segment ===
    set -l cal_icon ""
    set -l date_str (date "+%d/%b/%y")
    set -l day (date "+%a")

    set -l start (printf "%s" $green_fg)
    set -l date_main (printf "%s%s%s %s%s%s " $green_bg $black_fg $cal_icon $white_fg $bold $date_str)
    set -l day_part (printf "%s %s%s%s" $gray_bg $bold $text_fg $day)
    set -l end (printf "%s%s " $reset $gray_fg)

    set -l date_seg "$start$date_main$day_part$end"

    # === Assemble right prompt ===
    printf "%s%s%s%s" $bg_jobs $error_icon $git_branch $date_seg
end

