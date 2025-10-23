# =========[ Custom T-header (logo with figlet) Setup ]=========

# Only run if interactive
if status is-interactive

    # Check required commands
    if type -q boxes; and type -q figlet; and type -q tput

        set TMP_BANNER (mktemp)
        function cleanup_banner --on-event fish_exit
            rm -f $TMP_BANNER
        end

        function banner
            clear

            set CONFIG "$HOME/.config/theader/theader.cfg"
            set LOGO_DIR "$HOME/.config/theader/logo"

            # Print box frame
            printf "%s" (set_color blue)
            tput cup 0 0
            echo -e "" | boxes -a c -s (printf "%sx10" $COLUMNS) -d ansi-heavy
            printf "%s" (set_color normal)

            # Load config values
            set title (grep '^title=' $CONFIG | cut -d'=' -f2-)
            if test -z "$title"
                set title "tyro 2.0"
            end

            # Print figlet title
            tput cup 4 0
            figlet -f pixelfont -c -t -p -w (math $COLUMNS + 17) "$title" | lolcat -f

            set logo_file (grep '^logo=' $CONFIG | cut -d'=' -f2)
            set indent_size (grep '^indent=' $CONFIG | cut -d'=' -f2)
            if test -z "$indent_size"
                set indent_size 2
            end

            set indent (string repeat -n $indent_size " ")

            # Print logo if exists
            tput cup 1 0
            if test -n "$logo_file"; and test -f "$LOGO_DIR/$logo_file"
                sed "s/^/$indent/" "$LOGO_DIR/$logo_file"
            end

            # Draw left bar
            tput cup 1 0
            tput setaf 4
            for i in (seq 1 8)
                printf "┃\n"
            end

            tput cup 10 0
            tput cnorm
        end

        banner >>$TMP_BANNER
        cat $TMP_BANNER
    end
end

