#!/bin/bash

# Tested on: linuxmint-20.1-cinnamon-64bit

# Colores
greenColor="\e[0;32m\033[1m"
endColor="\033[0m\e[0m"
redColor="\e[0;31m\033[1m"
lightBlueColor="\e[94m"
blueColor="\e[0;34m\033[1m"
yellowColor="\e[0;33m\033[1m"
purpleColor="\e[0;35m\033[1m"
turquoiseColor="\e[0;36m\033[1m"
grayColor="\e[0;90m\033[1m"

# Install Git
sudo apt-get install git -y

# Install Bspwm and SXHKD
mkdir ~/GitHub
cd ~/GitHub
git clone https://github.com/baskerville/bspwm.git
git clone https://github.com/baskerville/sxhkd.git
sudo apt-get install xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev gcc make libc6-dev-i386 -y
cd ~/GitHub/bspwm
make
sudo make install
cd ~/GitHub/sxhkd
make
sudo make install
mkdir -p ~/.config/bspwm
mkdir -p ~/.config/sxhkd

wget https://raw.githubusercontent.com/ArturoVergara/dotfiles/main/bspwmrc -O ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/bspwmrc
wget https://raw.githubusercontent.com/ArturoVergara/dotfiles/main/sxhkdrc -O ~/.config/sxhkd/sxhkdrc
sudo cp /home/xtrem/GitHub/bspwm/contrib/freedesktop/bspwm.desktop /usr/share/xsessions/

# Install Fonts
cd ~/Downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip
sudo mkdir /usr/share/fonts/truetype/Caskaydia
sudo unzip ~/Downloads/CascadiaCode.zip -d /usr/share/fonts/truetype/Caskaydia
fc-cache -f -v

# Install URXVT Terminal
sudo apt install rxvt-unicode xsel -y
wget https://raw.githubusercontent.com/ArturoVergara/dotfiles/main/.Xresources -O ~/.Xresources
xrdb -load ~/.Xresources

# Install Polybar
sudo apt install build-essential git cmake cmake-data pkg-config python3-sphinx python3-packaging libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev -y
sudo apt install libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev -y
cd ~/GitHub
git clone --recursive https://github.com/polybar/polybar
cd ~/GitHub/polybar
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install

cd ~/GitHub
git clone --depth=1 https://github.com/adi1090x/polybar-themes.git
cd polybar-themes
chmod +x ./setup.sh && echo "1" | ./setup.sh
cd ~/Downloads
wget https://github.com/ArturoVergara/dotfiles/raw/main/xtrem-polybar-themes.zip
unzip -o ~/Downloads/xtrem-polybar-themes.zip -d ~/.config/polybar

# Install Rofi
sudo apt install rofi -y
sudo wget https://raw.githubusercontent.com/ArturoVergara/dotfiles/main/Xtrem.rasi -O /usr/share/rofi/themes/Xtrem.rasi
mkdir ~/.config/rofi
echo 'rofi.theme: /usr/share/rofi/themes/Xtrem.rasi' > ~/.config/rofi/config

# Install Feh
sudo apt install compton feh -y
#wget https://img5.goodfon.com/original/1920x1080/d/22/yoan-agostini-by-yoan-agostini-flat-design-background-minima.jpg -O ~/Pictures/forest.jpg 

# Install Neovim
sudo apt install neovim -y
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir ~/.config/nvim
wget https://raw.githubusercontent.com/ArturoVergara/dotfiles/main/init.vim -O ~/.config/nvim/init.vim

# Install NodeJS
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

# Configure LightDM Service
cat > ~/slick-greeter.conf <<- "EOF"
[Greeter]
background=/usr/share/backgrounds/linuxmint-ulyssa/sferrara_matterhorn.jpg
draw-grid=true
draw-user-backgrounds=false
EOF

sudo mv ~/slick-greeter.conf /etc/lightdm
sudo service lightdm restart
