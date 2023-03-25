#!/usr/bin/bash
var=$(echo $(( ${1} - 1)))
var2=$(seq -s─ ${var}|tr -d '[:digit:]')
var3=$(seq -s\  ${var}|tr -d '[:digit:]')
var4=$(echo $(( ${1} - 20)))
rm -rf ~/.draw.sh
cat >> ~/.draw.sh << EOF
#!/usr/bin/bash
PUT(){ echo -en "\033[\${1};\${2}H";}
DRAW(){ echo -en "\033%";echo -en "\033(0";}
WRITE(){ echo -en "\033(B";}
HIDECURSOR(){ echo -en "\033[?25l";}
NORM(){ echo -en "\033[?12l\033[?25h";}

HIDECURSOR
clear
echo -e "\033[35;1m"
#tput setaf 5
echo "┌${var2}┐"
for ((i=1; i<=8; i++)); do
echo "│${var3}│"
done
echo "└${var2}┘"
PUT 4 0
figlet -c -f ASCII-Shadow -w ${1} "${2}" | lolcat -t
PUT 3 0
echo -e "\033[35;1m"
#tput setaf 5
for ((i=1; i<=7; i++)); do
echo "│"
done
PUT 10 ${var4}
echo -e "\e[32mUnknown Script \e[33m2.0\e[0m"
PUT 12 0
echo
NORM
EOF
bash ~/.draw.sh
