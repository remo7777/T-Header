# =========[ logo-ls and eza aliases Setup ]=========

if type -q eza
    # echo "eza detected. Setting up eza aliases."
    alias l "logo-ls"
    alias ls "eza"
    alias l. "eza -d .*"
    alias la "eza -a"
    alias ll "eza -hl --icons=auto --color=auto --classify=auto"
    alias ll. "eza -hl --classify=auto -d .*"
else
    # echo "eza not found. Using default ls aliases."
    alias l "ls"
    alias ls "ls --color=auto"
    alias l. "ls --color=auto -d .*"
    alias la "ls --color=auto -a"
    alias ll "ls --color=auto -Fhl"
    alias ll. "ls --color=auto -Fhl -d .*"
end

# =========[ Replace cat with bat Setup ]=========
if type -q bat
    alias cat "bat --decorations=never --paging=never"
end

# =========[ Safety aliases ]=========
alias cp "cp -i"
alias ln "ln -i"
alias mv "mv -i"
alias rm "rm -i"

# =========[ Neovim Text Editor ]=========
if type -q nvim
    alias nv "nvim"
end

