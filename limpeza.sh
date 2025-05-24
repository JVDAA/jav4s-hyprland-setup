#!/bin/bash

echo "🧹 Iniciando processo de limpeza Jav4s..."

# Removendo pacotes do Pacman
echo "🗑️ Removendo pacotes instalados via Pacman..."
sudo pacman -Rns --noconfirm hyprland hyprpaper waybar wofi swww kitty thunar \
gvfs gvfs-mtp gvfs-gphoto2 udiskie polkit-kde-agent pipewire \
pipewire-pulse wireplumber pavucontrol network-manager-applet grim \
slurp wl-clipboard swappy qt5-wayland qt6-wayland \
xdg-desktop-portal-hyprland nwg-look nmap traceroute figlet lolcat \
papirus-icon-theme zsh jdk8-openjdk jdk-openjdk nodejs npm yarn php php-cli \
php-gd php-curl php-intl php-pgsql php-sqlite php-zip composer \
python python-pip go || echo "⚠️ Alguns pacotes não estavam instalados no pacman."

# Removendo pacotes do AUR via yay
echo "🗑️ Removendo pacotes instalados via Yay..."
yay -Rns --noconfirm brave-bin spotify winbox ferdium-bin neofetch powerlevel10k || echo "⚠️ Alguns pacotes não estavam no yay."

# Limpando pastas e arquivos residuais
echo "🗑️ Removendo arquivos e configurações locais..."
rm -rf ~/.oh-my-zsh ~/.zshrc ~/.p10k.zsh
rm -rf ~/Downloads/WhiteSur-gtk-theme*
rm -rf ~/Downloads/WhiteSur-grub-theme*
rm -rf ~/Downloads/WhiteSur-kde*

# Limpando cache do yay
echo "🧽 Limpando cache do yay..."
yay -Sc --noconfirm

# Removendo pacotes órfãos
echo "🧹 Removendo pacotes órfãos..."
sudo pacman -Qtdq | sudo pacman -Rns - --noconfirm || echo "✅ Nenhum órfão encontrado."

echo "🎯 Limpeza concluída! Sistema livre de resíduos Jav4s."

