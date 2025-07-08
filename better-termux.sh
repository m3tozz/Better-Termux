########################################
# Made By M3TOZZ                       #
# https://m3tozz.github.io             #
########################################

# BetterTermux Version
    version='BetterTermux-1.0'

# Colors
    red='\e[1;31m'
    yellow='\e[1;33m'
    blue='\e[1;34m'
    tp='\e[0m'
    green='\e[0;32m'
    bgreen='\033[1;32m'

# Define Constants.
export APP="BetterTermux" 		# Project Name
export CWD="${PWD}"			# Current Work Directory
export BASENAME="${0##*/}"	# Base Name of This Script

# Functions.
help() {
	echo -e "Wrong usage, there is 3 arguments for ${BASENAME}\n
\t${BASENAME} --install: it's install's the ${APP} project on your Termux.
\t${BASENAME} --uninstall: it's uninstall's the ${APP} project on your Termux.
\t${BASENAME} --version: show the version.
\t${BASENAME} --help: show this page.
"

}

bt:version() {
echo "$version"
}

bt:install() {
echo -e "\033[1;31m 
   ___      __  __            
  / _ )___ / /_/ /____ ____   
 / _  / -_) __/ __/ -_) __/   
/____/\__/\__/\__/\__/_/      
/_  __/__ ______ _  __ ____ __
 / / / -_) __/  ' \/ // /\ \ /
/_/  \__/_/ /_/_/_/\_,_//_\_\ 
Installing...                          
\033[0m"
sleep 3
clear
echo -e "\033[1;31m Checking Better-Termux directory...\033[0m"
if [ -d "$HOME/.bettertermux/Better-Termux" ]; then
    echo -e "\033[1;33m Directory ~/.bettertermux/Better-Termux exists. Removing it...\033[0m"
    rm -rf "$HOME/.bettertermux/Better-Termux"
fi
echo -e "\033[1;31m Cloning Better-Termux to ~/.bettertermux\033[01;32m"
git clone https://github.com/m3tozz/Better-Termux ~/.bettertermux/Better-Termux
echo -e "\033[1;31m Updating PKG Repo\033[01;32m"
mv zshrc .zshrc
pkg update -y
echo -e "\033[1;31m Installıng Zsh\033[01;32m"
pkg install zsh -y
chsh -s zsh 
mkdir -p /data/data/com.termux/files/home/.zsh/plugins
mkdir -p /data/data/com.termux/files/home/.zsh/themes
git clone https://github.com/zdharma-zmirror/fast-syntax-highlighting.git
cp -r  fast-syntax-highlighting /data/data/com.termux/files/home/.zsh/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git
cp -r  zsh-autosuggestions /data/data/com.termux/files/home/.zsh/plugins
git clone https://github.com/zsh-users/zsh-completions.git
cp -r  /zsh-completions /data/data/com.termux/files/home/.zsh/plugins
cp -r .zshrc /data/data/com.termux/files/home/
echo -e "\033[1;31m Installıng NeoCat\033[01;32m"
pkg install neofetch -y
neofetch
git clone https://github.com/m3tozz/NeoCat.git
rm -r /data/data/com.termux/files/home/.config/neofetch/config.conf
cd NeoCat/Termux-Themes/Palm/neofetch
cp -r config.conf /data/data/com.termux/files/home/.config/neofetch/
cp -r ascii.txt /data/data/com.termux/files/home/.config/neofetch/
cd
rm /data/data/com.termux/files/usr/etc/motd
clear
zsh
}

bt:uninstall() {
echo -e "\033[1;31m 
   ___      __  __            
  / _ )___ / /_/ /____ ____   
 / _  / -_) __/ __/ -_) __/   
/____/\__/\__/\__/\__/_/      
/_  __/__ ______ _  __ ____ __
 / / / -_) __/  ' \/ // /\ \ /
/_/  \__/_/ /_/_/_/\_,_//_\_\ 
Uninstalling...                          
\033[0m"
sleep 3
clear
echo -e "\033[1;31m Unnstallıng NeoCat-Termux\033[01;32m"
rm -r /data/data/com.termux/files/home/NeoCat-Termux
rm -r /data/data/com.termux/files/home/.config/neofetch
echo -e "\033[1;31m Uninstallıng Zsh\033[01;32m"
chsh -s bash 
pkg remove zsh -y
clear
echo -e "\033[1;31m Better-Termux has been removed your shell\033[0m"
bash
}

help() {
	echo -e "	 
--install: it's install's the ${APP} project on your distrubution.
--uninstall: it's uninstall's the ${APP} project on your distrubution.
--version: show the version.
--help: show this page."
}



# Argument Parser.
case "${1,,}" in
	"--install"|"-i")
		bt:install
	;;
	"--uninstall"|"-u")
		bt:uninstall
	;;
        	"--version"|"-v")
		bt:version
	;;
	*)
		help
	;;
esac
