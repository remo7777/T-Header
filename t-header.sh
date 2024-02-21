#!/bin/bash
if [[ "$1" == "--remove" ]]; then
	rm -rf ~/.oh-my-zsh ~/.plugins;
	rm -rf ~/.bashrc;
	chsh -s bash;
	termux-reload-settings;
	kill -9 $PPID
fi
spin () {

local pid=$!
local delay=0.25
local spinner=( '█■■■■' '■█■■■' '■■█■■' '■■■█■' '■■■■█' )

while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do

for i in "${spinner[@]}"
do
	tput civis
	echo -ne "\033[34m\r[*] Downloading..please wait.........\e[33m[\033[32m$i\033[33m]\033[0m   ";
	sleep $delay
	printf "\b\b\b\b\b\b\b\b";
done
done
printf "   \b\b\b\b\b"
tput cnorm
printf "\e[1;33m [Done]\e[0m";
echo "";

}
COPY_FILES() {
	version=`getprop ro.build.version.release | sed -e 's/\.//g' | cut -c1`
	version1=`getprop ro.build.version.release`
        rm -rf ~/.draw ~/.termux/*
        cp .object/.draw .object/.bashrc ~/;
	rm -rf ~/.termux;
        mkdir -p ~/.termux/;
        if [[ "$version" -le 7 ]]; then
                rm -rf $PREFIX/share/figlet/ASCII-Shadow.flf
                cp .object/color*.*  ~/.termux/
                cp .object/termux.properties2 ~/.termux/termux.properties
                cp .object/ASCII-Shadow.flf $PREFIX/share/figlet/
		cp .banner.sh ~/
		termux-reload-settings

        else
                rm -rf $PREFIX/share/figlet/ASCII-Shadow.flf
                cp .object/color*.*  ~/.termux/;
                cp .object/ASCII-Shadow.flf $PREFIX/share/figlet/
                cp .object/termux.properties ~/.termux/
		cp .banner.sh ~/
		termux-reload-settings
        fi
	if [[ "$version1" -eq 10 ]] || [[ "$version1" -eq 11 ]]; then
		rm -rf $PREFIX/share/figlet/ASCII-Shadow.flf
		cp .object/color*.*  ~/.termux/;
		cp .object/termux.properties ~/.termux/
		cp .object/ASCII-Shadow.flf $PREFIX/share/figlet/
		cp .banner.sh ~/
		termux-reload-settings
	fi
}
rubygem_d () {
dpkg -s ruby2 &> /dev/null
if [[ $? -eq 0 ]]; then
	apt install --reinstall ruby -y;
	gem install lolcat*.gem &> /dev/null
else
	apt install --reinstall ruby -y;
	gem install lolcat*.gem &> /dev/null
fi
	
}
# note this is only print 7 charecters
echo "";
echo -e "\e[1;34m[*] \e[32minstall packages....\e[0m";
echo "";
(apt update -y && apt upgrade -y) &> /dev/null;
apt install figlet pv ncurses-utils binutils coreutils wget git zsh termux-api procps gawk termux-tools -y &> /dev/null;
rubygem_d &> /dev/null
termux-wake-lock;
if [ -e $PREFIX/share/figlet/Remo773.flf ]; then
	echo -e "\e[1;34m[*] \033[32mRemo773.flf figlet font is present\033[0m";
	sleep 4
else
wget https://raw.githubusercontent.com/remo7777/REMO773/master/Remo773.flf &> /dev/null;
sleep 3
cp Remo773.flf $PREFIX/share/figlet/Remo773.flf;
cp ASCII-Shadow.flf $PREFIX/share/figlet/ASCII-Shadow.flf;
sleep 3
rm Remo773.flf
fi
THEADER () 
{
clear;
echo -e "\033[01;32m
Remo773 (2020)
		
	menu
+---------------------------*/
.......Terminal-Header......
+---------------------------*/
oh-my-zsh users only....
\033[0m";
ok=0
while [ $ok = 0 ];
do
	echo ""
tput setaf 3
read -p "Pleas enter Name : " PROC
tput sgr 0
if [[ ${#PROC} -gt 8 ]]; then
	echo -e "\e[1;34m[*] \033[32mToo long  characters You have input...\033[0m"
	echo ""
	echo -e "\033[32mPlz enter less than \033[33m9 \033[32mcharacters Name\033[0m" | pv -qL 10;
	echo ""
	sleep 4
	clear
echo -e "\033[01;32m
Remo773 (2020)

	menu
+---------------------------*/
.......Terminal-Header......
+---------------------------*/
oh-my-zsh users only....
\033[0m";
	echo ""
	echo -e "\e[1;34m \033[32mPlease enter less than 9 characters...\033[0m"
	echo ""
else
	ok=1
fi
done
clear
#echo "NAME=$PROC" > ~/.username
TNAME="$PROC";
col=$(tput cols)
echo ;
#figlet -f ASCII-Shadow "$PROC" | lolcat;
bash ~/T-Header/.banner.sh ${col} ${TNAME}
echo "";
echo -e '\e[0;35m+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[00m';
echo -e '\033[1;43;30m### HIẾU ❤️ LINH ### \033[0m';
echo -e '\e[0;35m+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[00m';
echo "";
#echo -e "
#\033[0;31m┌─[\033[1;34m$TNAME\033[1;33m@\033[1;36mtermux\033[0;31m]─[\033[0;32m~${PWD/#"$HOME"}\033[0;31m]
#\033[0;31m└──╼ \e[1;31m❯\e[1;34m❯\e[1;90m❯\033[0m "

echo -e "
\e[1;34m┌──[\e[1;32mHiếu ❣️ Linh \e[1;34m\e[0m-\e[1;34m[\e[33m$(date +'%A %d/%m/%Y')\e[1;34m]\e[0m-\e[1;34m[\e[33m$(date +'%l:%M:%S %p')\e[1;34m]
\e[1;34m├──[\033[0;32m${PWD/#"$HOME"}\e[1;34m]
\e[1;34m└────╼\e[1;31m❯\e[1;33m❯\e[1;90m❯\033[0m ";

tput setaf 3
read -p  "Do you want to setup this ? (y/n) " PROC32
tput sgr 0
if [[ ${PROC32} == [Y/y] ]]; then
	if [ -e $HOME/t-header.txt ]; then
		rm $HOME/t-header.txt;
	fi

	if [ -d $HOME/T-Header ]; then
	cd $HOME/T-Header
	fi
#if [ -e $HOME/.zshrc ]; then
#	rm -rf ~/.zshrc
#else
cat >> ~/.zshrc <<-EOF
tput cnorm
clear
## terminal banner
#figlet -f ASCII-Shadow.flf "$PROC" | lolcat;
echo
## cursor
printf '\e[4 q'
## prompt
TNAME="$PROC"
#setopt prompt_subst

#PROMPT=$'
#%{\e[0;31m%}┌─[%{\e[1;34m%}%B%{\${TNAME}%}%{\e[1;33m%}@%{\e[1;36m%}termux%b%{\e[0;31m%}]─[%{\e[0;32m%}%(4~|/%2~|%~)%{\e[0;31m%}]%b
#%{\e[0;31m%}└──╼ %{\e[1;31m%}%B❯%{\e[1;34m%}❯%{\e[1;90m%}❯%{\e[0m%}%b '

PROMPT=$'
%{\e[1;34m%}%B┌──[%b%{\e[0m%}%{\e[1;32m%}Hiếu ❣️ Linh %{\e[0;34m%}%B]%b%{\e[0m%}-%{\e[0;34m%}%B[%b%{\e[0;33m%}$(get_date)%{\e[0;34m%}%B]%b%{\e[0m%}-%{\e[0;34m%}%B[%b%{\e[1;33m%}$(get_time)%{\e[0;34m%}%B]%b%{\e[1;34m%}
%{\e[1;34m%}%B├──%{\e[0;34m%}%B[%b%{\e[1;33m%}%(4~|/%2~|%~)%{\e[0;34m%}%B]%b%{\e[0m%} $(git_prompt_info)%{\e[0m%}%b
%{\e[1;34m%}└────╼%{\e[1;31m%}%B❯%{\e[1;33m%}❯%{\e[1;90m%}❯%{\e[0m%}%b '

# git theming

function get_date() { echo "$(date +'%A %d/%m/%Y')"}
function get_time() { echo "$(date +'%l:%M:%S %p')" }
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg_no_bold[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[blue]%})"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[yellow]%}⚡%{$fg_bold[blue]%})"

export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'


## Replace 'ls' with 'exa' (if available) + some aliases.
if [ -n "\$(command -v exa)" ]; then
        alias l='exa'
        alias ls='exa'
        alias l.='exa -d .*'
        alias la='exa -a'
        alias ll='exa -Fhl'
        alias ll.='exa -Fhl -d .*'
else
        alias l='ls --color=auto'
        alias ls='ls --color=auto'
        alias l.='ls --color=auto -d .*'
        alias la='ls --color=auto -a'
        alias ll='ls --color=auto -Fhl'
        alias ll.='ls --color=auto -Fhl -d .*'
fi

## Safety.
alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'
alias rm='rm -i'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=39'
ZSH_HIGHLIGHT_STYLES[comment]=fg=226,bold
cols=\$(tput cols)
bash ~/.banner.sh \${cols} \${TNAME}
EOF
#fi
COPY_FILES
chsh -s zsh;
source ~/.zshrc;
else
	echo -e "\033[32mHope you like my work..\033[0m"
fi
exit
}

clear;
echo -e "\033[31m$(figlet -f Remo773 "T- Header")\e[0m"
echo -e "\e[1;32m
+----------------------------------*/
Remo773 : (\e[33m14.4.2021\e[32m)

1. Oh-my-zsh
2. Zsh-syntax-highlight (\e[33mplugins\e[01;32m)
3. Zsh-command-autosuggest (\e[33mplugins\e[01;32m)
4. Terminal-Header
5. Custom PS1 prompt ( \e[33mBest one\e[1;32m )
+----------------------------------*/
\033[0m";
tput setaf 3;
read -p  "Do you want to setup this ? (y/n) " PROC33

tput sgr 0
if [[ ${PROC33} == [Y/y] ]]; then


ozsh=0
if [ -d $HOME/.oh-my-zsh ]; then
	(rm -rf $HOME/.oh-my-zsh/) &> /dev/null
	(rm $HOME/.zshrc) &> /dev/null
elif [ -d $HOME/.zsh ]; then
	(rm -rf $HOME/.zsh) &> /dev/null
else
	echo -e "\e[1;34m[*] \e[32mYou hvnt oh-my-zsh...\e[0m";
fi
while [ $ozsh = 0 ];
do
	echo -e "\e[1;34m[*] \e[32mOh-my-zsh new setup....\e[0m";
	echo "";

	( rm -rf ~/.zshrc;git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh;cp "$HOME/.oh-my-zsh/templates/zshrc.zsh-template" "$HOME/.zshrc";termux-wake-unlock; ) &> /dev/null & spin;
	chsh -s zsh;
if [ -d $HOME/.oh-my-zsh ];
then
	ozsh=1
else
	echo -e "\e[1;34m[*] \e[32mdownload fail no.2..i ll try again..\e[0m";

fi
done

echo -e "\e[1;34m[*] \e[32mZsh-autosuggestion plugins setup..\e[0m";

zshau=0
(rm -rf ~/.plugins) &> /dev/null

mkdir -p ~/.plugins/zsh-autosuggestions
mkdir -p ~/.plugins/zsh-syntax-highlighting
#cd $HOME/.plugins/

while [ $zshau = 0 ];
do
	( git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.plugins/zsh-autosuggestions; echo "source ~/.plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> $HOME/.zshrc; ) &> /dev/null & spin
	if [ -d $HOME/.plugins/zsh-autosuggestions ];
then
	zshau=1

else

echo -e "\e[1;34m[*] \e[32mdownload fail..i ll try again..\e[0m";

fi
done
zshsyx=0

#cd $HOME/.plugins/

while [ $zshsyx = 0 ];
do
echo -e "\e[1;34m[*] \e[32mZsh-syntax-highlighter setup....\e[0m";
	( git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.plugins/zsh-syntax-highlighting; echo "source ~/.plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> $HOME/.zshrc; ) &> /dev/null & spin

if [ -d $HOME/.plugins/zsh-syntax-highlighting ];then
	zshsyx=1
else
	echo -e "\e[1;34m[*] \e[32mdownload fail..i ll try again..\e[0m";

fi
done




	THEADER
	
	
else
	echo -e "\e[1;34m[*] \033[32mHope you like my work..\033[0m"
	exit
fi
exit 0
