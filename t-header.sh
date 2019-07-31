#!/bin/bash

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


# note this is only print 7 charecters
echo "";
echo -e "\e[1;34m[*] \e[32minstall packages....\e[0m";
echo "";
apt update -y &> /dev/null;
apt install figlet pv ncurses-utils binutils coreutils wget git zsh termux-api procps gawk -y &> /dev/null;
termux-wake-lock;
if [ -e $PREFIX/share/figlet/Remo773.flf ]; then
	echo -e "\e[1;34m[*] \033[32mRemo773.flf figlet font is present\033[0m";
	sleep 4
else
wget https://raw.githubusercontent.com/remo7777/REMO773/master/Remo773.flf &> /dev/null;
sleep 3
cat Remo773.flf >> $PREFIX/share/figlet/Remo773.flf
sleep 3
rm Remo773.fif
fi
THEADER () 
{
clear;
echo -e "\033[01;32m
Remo773 (2018)
		
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
if [ ${#PROC} -gt 8 ]; then
	echo -e "\e[1;34m[*] \033[32mToo long  characters You have input...\033[0m"
	echo ""
	echo -e "\033[32mPlz enter less than \033[33m9 \033[32mcharacters Name\033[0m" | pv -qL 10;
	echo ""
	sleep 4
	clear
echo -e "\033[01;32m
Remo773 (2018)

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
TNAME="$PROC";
echo -e "\033[32m$(figlet -f Remo773.flf "$TNAME")\033[0m";
echo "";
echo -e '\e[0;35m+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[00m';
echo -e '\033[1;43;30m### SUBSCRIBE MY YOUTUBE CHANNEL ### \033[0m';
echo -e '\e[0;35m+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[00m';
echo "";
echo -e "\e[1;34m┌─[\e[1;32m$PROC\e[1;33m@\e[36mtermux\e[1;34m]\e[0m-\e[1;34m[\e[33m$(date +'%d %a %b')\e[1;34m]\e[0m-\e[1;34m[\e[33m$(date +'%l:%M %p')\e[1;34m]
\e[1;34m├─[\e[1;33m~\e[1;34m]
└─[\e[1;35m$\e[1;34m]\e[0m"
tput setaf 3
read -p  "Do you want to setup this ? (y/n) " PROC32
tput sgr 0
if [ "$PROC32" = "y" ]; then
	if [ -e $HOME/t-header.txt ]; then
		rm $HOME/t-header.txt;
fi

	if [ -d $HOME/T-Header ]; then
	cd $HOME/T-Header
	fi
	
	wget https://raw.githubusercontent.com/remo7777/REMO773/master/t-head.txt &> /dev/null ;

	sleep 3
	sed -i '/^TNAME=/d' $HOME/.zshrc
	echo "TNAME='$PROC'" >> $HOME/.zshrc
	cat t-head.txt >> $HOME/.zshrc
	sleep 3
	rm t-head.txt
	rm $HOME/.oh-my-zsh/themes/xiong-chiamiov-plus.zsh-theme
	if [ -e $PWD/.remo773.zsh-theme ]; then
	sed -e "s/\Remo773/$PROC/g" .remo773.zsh-theme > $HOME/.oh-my-zsh/themes/xiong-chiamiov-plus.zsh-theme
else
wget https://raw.githubusercontent.com/remo7777/T-Header/master/.remo773.zsh-theme &> /dev/null
sed -e "s/\Remo773/$PROC/g" .remo773.zsh-theme > $HOME/.oh-my-zsh/themes/xiong-chiamiov-plus.zsh-theme
fi
source ~/.zshrc
else
	echo -e "\033[32mHope you like my work..\033[0m"
fi
exit
}

clear;
echo -e "\033[31m$(figlet -f Remo773 "T- Header")\e[0m"
echo -e "\e[1;32m
+----------------------------------*/
Remo773 : (\e[33m12.7.2018\e[32m)

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
if [ "$PROC33" = "y" ]; then


ozsh=0
if [ -d $HOME/.oh-my-zsh ]; then
	rm -rf $HOME/.oh-my-zsh/
	rm $HOME/.zshrc
elif [ -d $HOME/.zsh ]; then
	rm -rf $HOME/.zsh
else
	echo -e "\e[1;34m[*] \e[32mYou hvnt oh-my-zsh...\e[0m";
fi
while [ $ozsh = 0 ];
do
	echo -e "\e[1;34m[*] \e[32mOh-my-zsh new setup....\e[0m";
	echo "";

	( git clone https://github.com/Cabbagec/termux-ohmyzsh.git "$HOME/termux-ohmyzsh" --depth 1; cp -R "$HOME/termux-ohmyzsh/.termux" "$HOME/.termux"; git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh" --depth 1; mv "$HOME/.termux" "$HOME/.termux.bak.$(date +%Y.%m.%d-%H:%M:%S)"; cp "$HOME/.oh-my-zsh/templates/zshrc.zsh-template" "$HOME/.zshrc"; sed -i '/^ZSH_THEME/d' "$HOME/.zshrc"; sed -i '1iZSH_THEME="xiong-chiamiov-plus"' "$HOME/.zshrc"; echo "alias chcolor='$HOME/.termux/colors.sh'" >> "$HOME/.zshrc"; echo "alias chfont='$HOME/.termux/fonts.sh'" >> "$HOME/.zshrc"; rm -rf $HOME/termux-ohmyzsh; termux-wake-unlock; ) &> /dev/null & spin;
	chsh -s zsh;
if [ -d $HOME/.oh-my-zsh ];
then
	ozsh=1

elif [ -e $HOME/.termux/colors.sh ];
then
	ozsh=1
else
	echo -e "\e[1;34m[*] \e[32mdownload fail no.2..i ll try again..\e[0m";

fi
done

echo -e "\e[1;34m[*] \e[32mZsh-autosuggestion plugins setup..\e[0m";

zshau=0
mkdir -p $HOME/.plugins/
cd $HOME/.plugins/

while [ $zshau = 0 ];
do
	( git clone https://github.com/zsh-users/zsh-autosuggestions.git; echo "source ~/.plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> $HOME/.zshrc; ) &> /dev/null & spin
	if [ -d $HOME/.plugins/zsh-autosuggestions ];
then
	zshau=1
else

echo -e "\e[1;34m[*] \e[32mdownload fail..i ll try again..\e[0m";

fi
done
zshsyx=0

cd $HOME/.plugins/

while [ $zshsyx = 0 ];
do
echo -e "\e[1;34m[*] \e[32mZsh-syntax-highlighter setup....\e[0m";
	( git clone https://github.com/zsh-users/zsh-syntax-highlighting.git; echo "source ~/.plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> $HOME/.zshrc; ) &> /dev/null & spin

if [ -d $HOME/.plugins/zsh-syntax-highlighting ];
then
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
