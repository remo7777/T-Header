#!/data/data/com.termux/files/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LIB_DIR="$SCRIPT_DIR/lib"
szf="File Size of"
tsize=$(stty size | cut -d ' ' -f 2)
pkgsize=$(apt-cache pkgnames | wc -l)

FILES=(pbanner progress fmenu confzsh)

for f in "${FILES[@]}"; do
  if [[ -f "$LIB_DIR/$f" ]]; then
    . "$LIB_DIR/$f"
  else
    echo "Warning: $LIB_DIR/$f not found"
  fi
done
# ===== Parse Termux color theme from ~/.termux/colors.properties =====
conf() {
  export FZF_DEFAULT_OPTS=""
  COLOR_FILE="$HOME/.termux/colors.properties"

  if [[ -f "$COLOR_FILE" ]]; then
    declare -A color
    while IFS='=' read -r key value; do
      [[ $key =~ ^#.*$ || -z $key ]] && continue
      color[$key]="$value"
    done <"$COLOR_FILE"

    export FZF_DEFAULT_OPTS="--color=fg:${color[foreground]},bg:${color[background]},hl:${color[color4]},fg+:${color[foreground]},bg+:${color[color0]},hl+:#98c379,prompt:#61afef,pointer:#e5c07b,marker:#56b6c2  --reverse --height=10 --no-info --pointer=' '"
  else
    export FZF_DEFAULT_OPTS="--color=hl+:#98c379,prompt:#61afef,pointer:#e5c07b,marker:#56b6c2 --reverse --height=10 --no-info --pointer=' '"
  fi
}

install_packages() {
  # package list
  packages=(curl fd figlet ruby boxes gum bat logo-ls eza zsh timg)

  echo -e "\n[🔧] Installing required packages...\n"

  for pkg in "${packages[@]}"; do
    if command -v "$pkg" >/dev/null 2>&1; then
      echo "[✔] $pkg already installed"
    else
      echo "[➕] Installing $pkg ..."
      pkg install -y "$pkg"
    fi
  done

  # Check for lolcat
  if command -v lolcat >/dev/null 2>&1; then
    echo "[✔] lolcat already installed"
  else
    echo "[➕] Installing lolcat via gem..."
    gem install lolcat
    if command -v lolcat >/dev/null 2>&1; then
      echo "[✔] lolcat installed successfully"
    else
      echo "[✘] lolcat installation failed"
    fi
  fi

  # Download custom figlet font (pixelfont)
  FONT_PATH="$PREFIX/share/figlet/pixelfont.flf"
  if [[ ! -f "$FONT_PATH" ]]; then
    echo "[➕] Downloading pixelfont.flf ..."
    curl -L \
      https://raw.githubusercontent.com/imegeek/figlet-fonts/master/pixelfont.flf \
      -o "$FONT_PATH"
    echo "[✔] Font saved to $FONT_PATH"
  else
    echo "[✔] pixelfont.flf already exists"
  fi

  # Install Nerd Font (UbuntuMono Nerd Font)
  nerdflink="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/UbuntuMono.zip"
  FONT_DIR="$HOME/.termux"
  mkdir -p "$FONT_DIR"
  TMPDIR=$(mktemp -d)

  echo "[➕] Downloading Nerd Font (UbuntuMono)..."
  curl -L "$nerdflink" -o "$TMPDIR/UbuntuMono.zip"

  echo "[🎨] Installing Nerd Font to $FONT_DIR/font.ttf ..."
  unzip -p "$TMPDIR/UbuntuMono.zip" "UbuntuMonoNerdFontMono-Regular.ttf" > "$FONT_DIR/font.ttf"

  rm -rf "$TMPDIR"

  echo "[✔] Nerd Font installed at $FONT_DIR/font.ttf"
  echo "[ℹ] Restart Termux app to apply new font."# Demo text with lolcat if available
  termux-reload-settings
  echo -e "\n[🎨] Demo text:\n"
  if command -v lolcat >/dev/null 2>&1; then
    echo "lolcat Installed!" | figlet -f pixelfont | lolcat
  else
    echo "lolcat not Installed!" | figlet -f pixelfont
  fi
  chsh -s zsh
}

# Run function
menu_main() {

  while true; do
    conf
    banner "${figftemp}" "${logotemp}" >>${user}
    cat "${user}"
    echo ""
    choice=$(
      printf "1. Install packages\n2. Setup\n3. Exit" |
        fzf --prompt="Use ↑/↓ to navigate, Enter to select: " --exit-0
    )

    case $choice in
      "1. Install packages")
        echo -e "\033[1;32m[✔] Installing packages...\033[0m"
        install_packages 
        sleep 1
        ;;
      "2. Setup")
        menu_setup
        ;;
      "3. Exit")
        echo -e "\033[1;31m[✘] Exiting...\033[0m"
        break
        ;;
      *)
        break
        ;;
    esac
  done
}

menu_setup() {
  choice=$(
    printf "1. Zsh\n2. Fish (coming soon)" |
      sed 's/2\. Fish (coming soon)/2. Fish \x1b[31m(\x1b[33mcoming soon\x1b[31m)\x1b[0m/' |
      fzf --prompt="Setup option ➤ " --ansi --exit-0
  )

  case $choice in
    "1. Zsh")
      menu_zsh_setup
      # echo -e "\033[1;34m[ℹ] Setting up Zsh...\033[0m"
      sleep 1
      ;;
    "2. Fish (coming soon)")
      echo -e "\033[1;33m[⚠] Fish setup is coming soon!\033[0m"
      sleep 1
      ;;
  esac
}

menu_zsh_setup() {
  # Check if oh-my-zsh is installed
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    # Not installed → only show setup option
    local subchoice
    subchoice=$(
      printf "1. Install Oh-my-zsh" |
        fzf --prompt="Zsh Setup ➤ " --ansi --exit-0
    )
    case $subchoice in
      "1. Install Oh-my-zsh")
        echo -e "\033[1;32m[✔] Installing Oh-my-zsh...\033[0m"
        install_oh_my_zsh
        ;;
    esac
  else
    # Already installed → show main options
    local main_options="1. Oh-my-zsh (Plugins Manager)\n2. Theader setup"

    local subchoice
    subchoice=$(
      printf "%b" "$main_options" |
        fzf --prompt="Zsh Options ➤ " --ansi --exit-0
    )

    case $subchoice in
      "1. Oh-my-zsh (Plugins Manager)")
        # Plugins Manager submenu
        local plugin_line
        plugin_line=$(sed -n 's/^plugins=(\(.*\))/\1/p' "$ZSHRC" | tr -d ' ')

        local pm_options="1. Add Zsh Plugins"
        # Show remove option only if plugins exist
        if [[ -n "$plugin_line" ]]; then
          pm_options+="\n2. Remove Plugins"
        fi

        local pm_choice
        pm_choice=$(
          printf "%b" "$pm_options" |
            fzf --prompt="Plugins Manager ➤ " --ansi --exit-0
        )

        case $pm_choice in
          "1. Add Zsh Plugins")
            echo -e "\033[1;34m[ℹ] Opening Add Plugins...\033[0m"
            fzf_add_plugin
            ;;
          "2. Remove Plugins")
            echo -e "\033[1;31m[⚠] Removing Zsh Plugins...\033[0m"
            remove_zsh_plugin
            ;;
        esac
        ;;
      "2. Theader setup")
        echo -e "\033[1;36m[ℹ] Running Theader setup...\033[0m"
        # Your Theader setup logic
        menu_theader_setup
        ;;
    esac
  fi
}

# t-header setup
menu_theader_setup() {
  local theader_dir="$HOME/.config/theader"

  # Check if Theader is installed (directory exists)
  if [[ ! -d "$theader_dir" ]]; then
    # Not installed → only show setup option
    local subchoice
    subchoice=$(
      printf "1. Setup Theader" |
        fzf --prompt="Theader Setup ➤ " --ansi --exit-0
    )
    case $subchoice in
      "1. Setup Theader")
        echo -e "\033[1;32m[✔] Setting up Theader...\033[0m"
        setup_theader
        ;;
    esac
  else
    # Already installed → show options
    local main_options="1. Change Logo\n2. Change Title\n3. Change Keyboard\n4. Change ZSH Theme\n5. Remove Theader"

    local subchoice
    subchoice=$(
      printf "%b" "$main_options" |
        fzf --prompt="Theader Options ➤ " --ansi --exit-0
    )

    case $subchoice in
      "1. Change Logo")
        echo -e "\033[1;34m[ℹ] Changing Logo...\033[0m"
        c_logo
        ;;
      "2. Change Title")
        echo -e "\033[1;34m[ℹ] Changing Title...\033[0m"
        type_title
        ;;
      "3. Change Keyboard")
        echo -e "\033[1;34m[ℹ] Changing Keyboard Layout...\033[0m"
        key_properties
        ;;
      "4. Change ZSH Theme")
        echo -e "\033[1;34m[ℹ] Changing ZSH Theme...\033[0m"
        c_theme
        ;;
      "5. Remove Theader")
        echo -e "\033[1;31m[⚠] Removing Theader...\033[0m"
        remove_theader
        ;;
    esac
  fi
}
# theader setup function
setup_theader() {
  theader_dir="$HOME/.config/theader"
  # ZSH="$HOME/.oh-my-zsh"
  # ZSHRC="$HOME/.zshrc"
  TEMPLATE="$ZSH/templates/zshrc.zsh-template"

  if [ -f "$ZSHRC" ]; then
    # line count check
    line_count=$(wc -l <"$ZSHRC")

    if [ "$line_count" -gt 104 ]; then
      echo "⚠️  .zshrc has $line_count lines, creating backup..."
      cp "$ZSHRC" "$ZSHRC.backup.$(date +%Y%m%d%H%M%S)"

      # plugins line extract
      old_plugins=$(grep "^plugins=" "$ZSHRC" | head -n1)

      # plugins line
      if [ -n "$old_plugins" ]; then
        echo "🔗 Found old plugins: $old_plugins"

        # template copy
        cp "$TEMPLATE" "$ZSHRC"

        # template plugins replace
        sed -i "s/^plugins=(git)/$old_plugins/" "$ZSHRC"
        echo "✅ New .zshrc created with preserved plugins"
      else
        echo "⚠️ No plugins line found in old .zshrc, using default"
        cp "$TEMPLATE" "$ZSHRC"
      fi
    else
      echo ".zshrc has only $line_count lines, no reset needed."
    fi
  else
    cp "$TEMPLATE" "$ZSHRC"
    sed -i 's/plugins=(git)/plugins=()/' "$ZSHRC"
    echo "✅ Default .zshrc created"
  fi
  create_custom_theme
  cp $SCRIPT_DIR/dotfile/.* $HOME/
  printf "HISTSIZE=100000\nSAVEHIST=100000\n# profile source\nsource \"\$HOME/.profile\"\nexport USER=\$(whoami)\nbanner >> \"\${user}\"\ncat \"\${user}\"" >>$HOME/.zshrc
  mkdir -p $theader_dir
  for d in bin logo tpt lib theader.cfg; do
    if [[ -e "$SCRIPT_DIR/$d" ]]; then 
      cp -r "$SCRIPT_DIR/$d" "$theader_dir/"
    else
      echo "Warning: missing $SCRIPT_DIR/$d"
    fi
  done
  if [[ -f $theader_dir/bin/theader ]]; then
    install -Dm700 $theader_dir/bin/theader "$PREFIX"/bin/theader
    for i in clogo ctitle ctpro cztheme; do
      ln -sfr "$PREFIX"/bin/theader "$PREFIX"/bin/$i
    done
    echo "theader installed successfully ✅"
  else
    echo "Error: $theader_dir/bin/theader not found!"
  fi

}
# checking screen size {column size must above 58}
if [ ${tsize} -lt 59 ]; then
  echo -ne "\033[31m\r[*] \033[4;32mTerminal column size above 59 \033[1;33m$(stty size) \033[4;32mrow column \e[0m\n"
  exit 1
fi
# packages list must above 2000
if [ ${pkgsize} -lt 2000 ]; then
  echo -ne "\033[31m\r[*] \033[4;32mPackage Update and Upgrade or change repo \e[0m\n"
  exit 1
fi
# ✅ Check fzf installed or not
if ! command -v fzf >/dev/null 2>&1; then
  echo -e "\033[31m\r[*] \033[4;32mfzf command not found!\033[0m"
  echo -e "\033[1;33mPlease install fzf:\033[0m pkg install fzf -y\n"
  exit 1
fi


# Run main menu
menu_main
