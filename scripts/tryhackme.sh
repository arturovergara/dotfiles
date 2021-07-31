#!/bin/bash

# Crear el archivo .nanorc
cat > ~/.nanorc <<- "EOF"
set linenumbers
set tabsize 4
set titlecolor brightwhite,green
set functioncolor brightwhite
set numbercolor brightwhite,cyan
set statuscolor brightwhite,green
set keycolor brightwhite,cyan
EOF

# Crear el script ctfscan
apt-get install golang-go -y
go get -u github.com/liamg/furious

cat > /usr/bin/ctfscan <<- "EOF"
#!/bin/bash

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

if [ $# -ne 1 ]; then
        echo -e "${yellowColor}[!] USAGE: ./$(basename $0) [IP_ADDRESS]${endColor}\n"
		        exit 1
fi

ping=$(ping -c 1 $1 2>/dev/null)

if [ $? -ne 0 ]; then
        echo -e  "${redColor}[-] Error: Couldn't reach to the host.${endColor}"
		        exit 1
fi

# Obtiene el sistema operativo de acuerdo al TTL de una traza ICMP
echo -ne "${yellowColor}[!] OS based on TTL: "
ttl=$(echo $ping | cut -d " " -f13 | cut -d "=" -f2)

if [[ $ttl -ge 33 && $ttl -le 64 ]]; then
        echo -n "Linux"
	elif [[ $ttl -ge 65 && $ttl -le 128 ]]; then
	        echo -n "Windows"
		elif [[ $ttl -ge 129 && $ttl -le 255 ]]; then
		        echo -n "Cisco"
			else
			        echo "Unknown OS"
fi

echo -e "${endColor}\n"

# Obtiene los puertos abiertos TCP del sistema, a traves de furious
furious=$(/root/go/bin/furious -s connect -p 1-65535 $1 | grep "/tcp" | cut -d "/" -f1 | tr -d "\t" | sed -e 'H;${x;s/\n/,/g;s/^,//;p;};d')

echo -e "${greenColor}[+] Open ports: $furious${endColor}\n"

# Realiza un escaneo avanzado con los puertos encontrados, a traves de nmap
echo -e "${blueColor}[!] Nmap Output:${endColor}\n"
nmap -sC -sV -Pn -T4 -n -p $furious $1 | tail -n+5 | head -n-3
echo
EOF

chmod +x /usr/bin/ctfscan

# Instalar xclip
apt-get install xclip -y

# Instalar neovim
apt-get install neovim -y

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

mkdir -p ~/.config/nvim/

cat > ~/.config/nvim/init.vim <<- "EOF"
set autoindent
set tabstop=4
set shiftwidth=4
set number
set relativenumber
set numberwidth=1
set background=dark
set encoding=utf-8
syntax enable
set cursorline
set termguicolors
set mouse=a

" Ajustes para el plugin lightline
set laststatus=2
set noshowmode

call plug#begin('~/nvim/Plugged')

" Temas
Plug 'nlknguyen/papercolor-theme'

" IDE
Plug 'scrooloose/nerdtree'
Plug 'mattn/emmet-vim'

"Barra Inferior
Plug 'itchyny/lightline.vim'

"Colores para CSS
Plug 'ap/vim-css-color'

call plug#end()

" Setear el Tema
silent! colorscheme PaperColor

" Abrir NerdTree con ALT + SHIFT + Q
map <A-Q> :NERDTreeToggle<CR>


"Opciones para abrir una nueva terminal con CTRL + SHIFT + N

" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://powershell
    resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>
EOF

nvim +'PlugInstall --sync' +qa

# Configuraciones de Mate-Terminal
dconf write /org/mate/terminal/profiles/default/use-theme-colors false
dconf write /org/mate/terminal/profiles/default/background-color "'#000000000000'"
dconf write /org/mate/terminal/profiles/default/background-type "'transparent'"
dconf write /org/mate/terminal/profiles/default/background-darkness 0.9
dconf write /org/mate/terminal/profiles/default/foreground-color "'#FFFFFFFFFFFF'" 
dconf write /org/mate/terminal/profiles/default/palette "'#000000000000:#AAAA00000000:#0000AAAA0000:#AAAA55540000:#00000000AAAA:#AAAA0000AAAA:#0000AAAAAAAA:#AAAAAAAAAAAA:#555455545554:#FFFF55545554:#5554FFFF5554:#FFFFFFFF5554:#55545554FFFF:#FFFF5554FFFF:#5554FFFFFFFF:#FFFFFFFFFFFF'"
dconf write /org/mate/terminal/profiles/default/use-system-font false
dconf write /org/mate/terminal/profiles/default/font "'Monospace 11'"
dconf write /org/mate/terminal/profiles/default/allow-bold true

# Configuraciones de Mate-Panel
pkill plank
dconf write /org/mate/panel/general/default-layout "'redmond'"
mate-panel --reset

# Modificar archivo .bashrc
sed -i 's/32m/92m/' ~/.bashrc
sed -i 's/34m/96m/' ~/.bashrc
echo 'alias smbserver="python /opt/impacket/examples/smbserver.py a $(pwd)"' >> ~/.bashrc
echo 'alias cls="clear"'
echo "alias cppwd=\"pwd |  awk '{print \\\"\\\\\\\"\\\"\\\$0\\\"\\\\\\\"\\\"}' | tr -d '\n' | xclip -selection c\"" >> ~/.bashrc

exit
