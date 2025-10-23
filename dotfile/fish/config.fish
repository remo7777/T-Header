if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ────────────────────────────────
# Syntax highlighting colors
# ────────────────────────────────
set -g fish_greeting ""
set -g fish_color_command green
set -g fish_color_error red --bold
set -g fish_color_autosuggestion brblue
set -g fish_color_comment yellow --bold
set -g fish_color_param white --bold
set -g fish_color_operator white
set -g fish_color_quote yellow
set -g fish_color_escape cyan --dim

# ────────────────────────────────
# Git prompt
# ────────────────────────────────
set -g __fish_git_prompt_showcolorhints 1
set -g __fish_git_prompt_color_branch yellow
set -g __fish_git_prompt_color_branch_dirty blue
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_show_untrackedfiles 1
set -g __fish_git_prompt_show_upstream 'auto'
set -g __fish_git_prompt_char_cleanstate '✔'
set -g __fish_git_prompt_char_dirtystate ''
set -g __fish_git_prompt_char_untrackedfiles '…'
set -g __fish_git_prompt_char_conflictedstate '✖'
set -g __fish_git_prompt_color_cleanstate green
set -g __fish_git_prompt_color_dirtystate yellow --bold
set -g __fish_git_prompt_color_untrackedfiles blue --bold
set -g __fish_git_prompt_color_conflictedstate red

function !!
    eval (history --max=1 | string trim)
end
