
#!/bin/bash
# 🚀 Jav4s Hyprland Setup Script
# 🔥 Desenvolvido por Joao "Jav4s" Victor

set -e

echo "🔧 Atualizando sistema..."
sudo pacman -Syu --noconfirm

echo "🚀 Instalando dependencias..."
sudo pacman -S --noconfirm git curl wget base-devel dconf

if ! command -v yay &> /dev/null; then
    echo "🛠️ Instalando yay..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

echo "🖥️ Instalando Hyprland e apps essenciais..."
sudo pacman -S --noconfirm hyprland hyprpaper waybar wofi swww kitty thunar gvfs gvfs-mtp gvfs-gphoto2 udiskie polkit-kde-agent pipewire pipewire-pulse wireplumber pavucontrol network-manager-applet grim slurp wl-clipboard swappy qt5-wayland qt6-wayland xdg-desktop-portal-hyprland nwg-look nmap traceroute figlet lolcat

yay -S --noconfirm brave-bin spotify winbox ferdium-bin neofetch || sudo pacman -S --noconfirm fastfetch

echo "🖼️ Baixando wallpapers..."
mkdir -p ~/Pictures/Wallpapers
cd ~/Pictures/Wallpapers
wget -O wallpaper-1.jpg "https://images.alphacoders.com/137/1371030.jpg"
wget -O wallpaper-2.jpg "https://images.alphacoders.com/030/30173.jpg"
wget -O wallpaper-3.jpg "https://images.alphacoders.com/130/1307235.jpg"
cd ~

echo "🎨 Instalando temas WhiteSur e Papirus..."
sudo pacman -S --noconfirm papirus-icon-theme gtk-engine-murrine gtk-engines

git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
cd WhiteSur-gtk-theme
./install.sh -D
cd ..
rm -rf WhiteSur-gtk-theme

git clone https://github.com/vinceliuice/WhiteSur-grub-theme.git
cd WhiteSur-grub-theme
sudo ./install.sh -t dark
cd ..
rm -rf WhiteSur-grub-theme

sudo pacman -S --noconfirm sddm
sudo systemctl enable sddm

git clone https://github.com/vinceliuice/WhiteSur-kde.git
cd WhiteSur-kde/sddm
sudo ./install.sh
cd ../../
rm -rf WhiteSur-kde

yay -S --noconfirm nerd-fonts-jetbrains-mono

echo "🦑 Instalando Oh My Zsh..."
sudo pacman -S --noconfirm zsh
chsh -s $(which zsh)

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "🎨 Escolha seu tema de terminal:"
select tema in "Mikeh" "Powerlevel10k"; do
    case $tema in
        Mikeh )
            ZSH_THEME="mikeh"
            break;;
        Powerlevel10k )
            ZSH_THEME="powerlevel10k/powerlevel10k"
            break;;
    esac
done

cat <<EOF > ~/.zshrc
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="$ZSH_THEME"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source \$ZSH/oh-my-zsh.sh

clear
figlet "Joao 'Jav4s' Victor" | lolcat
(neofetch || fastfetch)

alias ls='ls --color=auto'
alias ll='ls -la'
alias update='sudo pacman -Syu'
alias cls='clear'
alias ping='ping -c 5'
alias traceroute='traceroute -I'
EOF

echo "🔧 Você deseja instalar as linguagens de desenvolvimento?"
select yn in "Sim" "Não"; do
    case $yn in
        Sim )
            sudo pacman -S --noconfirm jdk8-openjdk jdk-openjdk nodejs npm yarn php php-cli php-gd php-curl php-intl php-pgsql php-sqlite php-zip composer python python-pip go
            composer global require laravel/installer
            echo 'export PATH="$PATH:$HOME/.config/composer/vendor/bin"' >> ~/.zshrc
            break;;
        Não ) echo "⏭️ Pulando instalação das linguagens..."; break;;
    esac
done

echo "🎉 Setup finalizado com sucesso! Reinicie sua sessão e aproveite!"
