#!/bin/sh

#Auther : Akash
#https://github.com/Akash97p

#----------------------------- HELP ------------------------------------

help(){
	drawLine
	printf "%-15s %s" "--all   || -a" " : " "All!!!!!!!"  
	printf "\n"
	printf "%-15s %s" "--fish  || -f" " : " "Install and setup fish shell and omf" 
	printf "\n" 
	printf "%-15s %s" "--apps  || -ap" " : " "Install necessary apps" 
	printf "\n"
	printf "%-15s %s" "--theme || -t" " : " "Download and change shell&gtk themes and icons"  
	printf "\n"
	printf "%-15s %s" "--help  || -h" " : " "Display this help"  
	printf "\n"
	drawLine 
}

#-----------------------------------------------------------------------

drawLine () {
    printf "\n"
	for i in {0..20..1}
	do
		echo -n -e '\U1F538\U1f539'
		sleep 0.005	
	done
    printf "\n"
    printf "\n"
}

#-----------------------------------------------------------------------

fishAlias (){
	fish -c "alias $1 \"$2\""
	fish -c "funcsave $1" 
	printf "%-20s %s" $2 " : "  $1
	printf "\n"
}

#-----------------------------------------------------------------------

install (){
	drawLine
	echo " ⬇️ " Installing $3
	echo ""
	sleep 1
	if [[ $1 == "apt" ]]
	then
		sudo apt install $2 -y
	elif [[ $1 == "snap" ]]
	then
		sudo snap install $2
	elif [[ $1 == "flatpak" ]]
	then
		sudo flatpak install $2
	fi
	echo ""
	echo -e ' \U2705' $3 installed successfully
}

#---------------------Install and settup FISH 🐠 ️-----------------------

installAndSetupFish(){

	install "apt" "fish" "🐠"
	drawLine
	echo " ⬇️ " Installing Oh-my-🐠
	curl -L https://get.oh-my.fish | fish
	printf "\n"
	echo " ⬇️ " installing and switching fish theme to batman.
	fish -c "omf install batman"
	fish -c "omf theme batman"
	echo ""
	echo " ⬇️ " Adding Fish aliases.
	echo " "
	printf "%20s %s\n" "alias " " Command";
	fishAlias "a" "alias"
	fishAlias "c" "clear"
	fishAlias "q" "exit"
	fishAlias "f" "funcsave"
	fishAlias "mi" "micro"
	fishAlias "cat" "batcat"
	fishAlias "apts" "apt search"
	fishAlias "i" "sudo apt install -y"
	fishAlias "r" "sudo apt remove"
	fishAlias "si" "sudo snap install"
	fishAlias "hpush" "git push heroku master"
	fishAlias "up" "sudo apt update && sudo apt upgrade && sudo apt clean && sudo apt autoremove"
	fishAlias "neofetch" "neofetch --config off --bold off --colors 7 0 7 0 1 7 --ascii_colors 0 7"
	fishAlias "dw" "google-chrome -kiosk --app=\"https://www.youtube.com/watch?v=qMtcWqCL_UQ\" && q"
	

	sudo chsh --shell /bin/fish
	drawLine
}

#------------------------------------------------------------------------

installApps(){

	install "apt" "flatpak" "Flatpak"
	install "apt" "neofetch" "Neofetch"
	install "apt" "micro" "Micro Editor"
	install "apt" "gnome-tweaks" "Gnome Tweaks"
	install "apt" "vlc" "VLC media player"
	install "apt" "arduino" "Ardiono IDE"
	install "apt" "docker" "Docker"
	install "apt" "nodejs" "NodeJS"
	install "apt" "qbittorrent" "qbittorrent"
	install "apt" "gimp" "Gimp"
	install "apt" "flameshot" "Flameshot"
	install "apt" "kdenlive" "kdenlive"
	install "apt" "htop" "htop"
	install "apt" "gnome-shell-extensions" " gnome Shell Extension"
	install "apt" "bat"

	install "snap" "code" "VS code"
	install "snap" "heroku" "Heroku CLI"
	install "snap" "postman" "Postman"
	install "snap" "spotify" "Spotify"

	drawLine
}

setTheme(){
	
	install "apt" "gnome-tweaks" "Gnome Tweaks"
	install "apt" "gnome-shell-extensions" " gnome Shell Extension" 
	install "apt" "gnome-shell-extension-arc-menu" "Arc menu"
	gnome-extensions enable arcmenu@arcmenu.com
	install "apt" "gnome-shell-extension-dash-to-panel" "Dash to panel"
	gnome-extensions enable dash-to-panel@jderose9.github.com

	sudo apt-get install zip unzip

	mkdir -p /home/$USER/.themes
	mkdir -p /home/$USER/.icons
	mkdir -p /home/$USER/Pictures/Wallpapers
	unzip themes.zip -d /home/$USER/.themes
	unzip icons.zip -d /home/$USER/.icons
	unzip walls.zip /home/$USER/Pictures/Wallpapers
	rm themes.zip
	rm icons.zip
	rm walls.zip

	gsettings set org.gnome.shell.extensions.user-theme name "mojavoc slim shell 1.0.1"
	gsettings set org.gnome.desktop.interface icon-theme "La-capitaine"
	gsettings set org.gnome.desktop.interface gtk-theme "Flat-Remix-GTK-Blue-Darkest-Solid-NoBorder"
	gsettings set org.gnome.desktop.background picture-uri file:///home/$USER/Pictures/Wallpapers/Polygon-Wallpaper-13-2560x1440.jpg

	drawLine
	echo -e '\U2705' Shell theme changed successfully mojavoc slim shell 1.0.1
	echo -e '\U2705' gtk theme changed successfully to Flat-Remix-GTK-Blue-Darkest-Solid-NoBorder
	echo -e '\U2705' Icon changed successfully to La-capitaine
	echo -e '\U2705' Wallpaper changed successfully
	drawLine

}


#----------------------------- Main --------------------------------------

if (( $# == 0 ))
then
	echo""
    echo "No arguments supplied"
    help
elif [[ $1 == "--fish" || $1 == "-f" ]]
then
	sudo apt update
	installAndSetupFish	
elif [[ $1 == "--apps" || $1 == "-ap" ]]
then
	sudo apt update
	installApps
elif [[ $1 == "--theme" || $1 == "-t" ]]
then
	sudo apt update
	setTheme
elif [[ $1 == "--all" || $1 == "-a" ]]
then
	sudo apt update
	installAndSetupFish
	installApps
	setTheme
elif [[ $1 == "--help" || $1 == "-h" ]]
then
	help
else
	echo pass any arguments
	help
fi 
#--------------------------------------------------------------------------