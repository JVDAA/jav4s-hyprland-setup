#!/bin/bash

# ================================
# 🚀 Jav4s Hyprland Setup Script Completo
# 🔥 Desenvolvido por Joao "Jav4s" Victor
# ================================

set -e

echo "🔧 Atualizando sistema..."
sudo pacman -Syu --noconfirm

echo "🚀 Instalando dependencias essenciais..."
sudo pacman -S --noconfirm git curl wget base-devel dconf unzip

if ! command -v yay &> /dev/null; then
    echo "🛠️ Instalando yay..."
    git clone --depth=1 https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

echo "🖥️ Instalando Hyprland e interface gráfica..."
sudo pacman -S --noconfirm hyprland hyprpaper waybar wofi swww kitty thunar gvfs gvfs-mtp gvfs-gphoto2 udiskie polkit-kde-agent pipewire pipewire-pulse wireplumber pavucontrol network-manager-applet blueman lxappearance qt5ct qt6ct grim slurp wl-clipboard swappy qt5-wayland qt6-wayland xdg-desktop-portal-hyprland nwg-look nmap traceroute figlet lolcat papirus-icon-theme

yay -S --noconfirm brave-bin spotify winbox ferdium-bin neofetch || sudo pacman -S --noconfirm fastfetch

echo "🖥️ Instalando Display Manager (LightDM)..."
sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
sudo systemctl enable lightdm

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

echo "🔧 Instalando linguagens de desenvolvimento (Java, Node, Python, Golang)..."
sudo pacman -S --noconfirm jdk8-openjdk jdk-openjdk nodejs npm yarn python python-pip go

echo "🎉 Setup finalizado com sucesso! Reinicie seu sistema e aproveite!"
