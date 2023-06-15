#!/bin/bash

set -e   # stop on command execution failure
set -u   # exit if an undefined variable is encountered

echo -e "\n\n========== INSTALLING PACKAGES =========="
cmd_install_tools="sudo apt update && sudo apt install -y baobab cgdb ccache clangd cmake-curses-gui dconf-cli dconf-editor g++-12 git gparted gpg gnome-shell-extension-manager gnome-shell-extension-prefs gnome-tweaks htop meld net-tools remmina silversearcher-ag tree wget xrdp"
echo $cmd_install_tools
eval $cmd_install_tools




echo -e "\n\n========== INSTALLING VS CODE =========="
cmd_vscode_setup_1="wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg"
echo $cmd_vscode_setup_1
eval $cmd_vscode_setup_1

cmd_vscode_setup_2="sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg"
echo $cmd_vscode_setup_2
eval $cmd_vscode_setup_2

cmd_vscode_setup_3="sudo sh -c 'echo \"deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main\" > /etc/apt/sources.list.d/vscode.list'"
echo $cmd_vscode_setup_3
eval $cmd_vscode_setup_3

cmd_vscode_setup_4="rm -f packages.microsoft.gpg && sudo apt install apt-transport-https && sudo apt update && sudo apt install code"
echo $cmd_vscode_setup_4
eval $cmd_vscode_setup_4

cmd_vscode_setup_5="mkdir -p /home/$USER/.config/Code/User && cp vscode/user_settings.json /home/$USER/.config/Code/User/settings.json"
echo $cmd_vscode_setup_5
eval $cmd_vscode_setup_5




echo -e "\n\n========== CONFIGURE CLANGD =========="
cmd_clang_setup_1="cp .clangd ~/"
echo $cmd_clang_setup_1
eval $cmd_clang_setup_1




echo -e "\n\n========== CONFIGURE GNOME TERMINAL =========="
# dconf list /org/gnome/terminal/legacy/profiles:/   # prints out the current terminal profile ID
# it should give: :b1dcc9dd-5262-4d8d-a863-c897e6d979b9/

cmd_gnome_terminal_setup_1="dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/use-theme-colors \"false\""
echo $cmd_gnome_terminal_setup_1
eval $cmd_gnome_terminal_setup_1

cmd_gnome_terminal_setup_2="dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/background-color \"'rgb(0,43,54)'\""
echo $cmd_gnome_terminal_setup_2
eval $cmd_gnome_terminal_setup_2

cmd_gnome_terminal_setup_3="dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/foreground-color \"'rgb(131,148,150)'\""
echo $cmd_gnome_terminal_setup_3
eval $cmd_gnome_terminal_setup_3

cmd_gnome_terminal_setup_4="dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/bold-is-bright \"true\""
echo $cmd_gnome_terminal_setup_4
eval $cmd_gnome_terminal_setup_4

cmd_gnome_terminal_setup_5="dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/audible-bell \"false\""
echo $cmd_gnome_terminal_setup_5
eval $cmd_gnome_terminal_setup_5

cmd_gnome_terminal_setup_6="dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/default-size-columns 132"
echo $cmd_gnome_terminal_setup_6
eval $cmd_gnome_terminal_setup_6

cmd_gnome_terminal_setup_7="dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/default-size-rows 24"
echo $cmd_gnome_terminal_setup_7
eval $cmd_gnome_terminal_setup_7

cmd_gnome_terminal_setup_8="dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/palette \"['rgb(46,52,54)', 'rgb(204,0,0)', 'rgb(78,154,6)', 'rgb(196,160,0)', 'rgb(52,101,164)', 'rgb(117,80,123)', 'rgb(6,152,154)', 'rgb(211,215,207)', 'rgb(85,87,83)', 'rgb(239,41,41)', 'rgb(138,226,52)', 'rgb(252,233,79)', 'rgb(114,159,207)', 'rgb(173,127,168)', 'rgb(52,226,226)', 'rgb(238,238,236)']\""
echo $cmd_gnome_terminal_setup_8
eval $cmd_gnome_terminal_setup_8




echo -e "\n\n========== CONFIGURE GEDIT =========="
cmd_gedit_setup_1="dconf write /org/gnome/gedit/preferences/editor/auto-indent \"true\""
echo $cmd_gedit_setup_1
eval $cmd_gedit_setup_1

cmd_gedit_setup_2="dconf write /org/gnome/gedit/preferences/editor/highlight-current-line \"true\""
echo $cmd_gedit_setup_2
eval $cmd_gedit_setup_2

cmd_gedit_setup_3="dconf write /org/gnome/gedit/preferences/editor/insert-spaces \"true\""
echo $cmd_gedit_setup_3
eval $cmd_gedit_setup_3

cmd_gedit_setup_4="dconf write /org/gnome/gedit/preferences/editor/tabs-size 4"
echo $cmd_gedit_setup_4
eval $cmd_gedit_setup_4

cmd_gedit_setup_5="dconf write /org/gnome/gedit/preferences/ui/side-panel-visible \"false\""
echo $cmd_gedit_setup_5
eval $cmd_gedit_setup_5

#dconf write /org/gnome/gedit/preferences/editor/scheme "solarized-dark"
#dconf write /org/gnome/gedit/preferences/editor/wrap-last-split-mode "word"
#dconf write /org/gnome/gedit/preferences/editor/wrap-mode "word"
#dconf write /org/gnome/gedit/preferences/ui/show-tabs-mode "auto"




echo -e "\n\n========== CONFIGURE MELD =========="
cmd_meld_setup_1="dconf write /org/gnome/meld/highlight-current-line \"false\""
echo $cmd_meld_setup_1
eval $cmd_meld_setup_1

cmd_meld_setup_2="dconf write /org/gnome/meld/highlight-syntax \"true\""
echo $cmd_meld_setup_2
eval $cmd_meld_setup_2

cmd_meld_setup_3="dconf write /org/gnome/meld/insert-spaces-instead-of-tabs \"true\""
echo $cmd_meld_setup_3
eval $cmd_meld_setup_3

cmd_meld_setup_4="dconf write /org/gnome/meld/show-line-numbers \"true\""
echo $cmd_meld_setup_4
eval $cmd_meld_setup_4




echo -e "\n\n========== CONFIGURE UBUNTU DOCK =========="
cmd_ubuntu_dock_setup_1="dconf write /org/gnome/shell/extensions/dash-to-dock/extend-height \"true\""
echo $cmd_ubuntu_dock_setup_1
eval $cmd_ubuntu_dock_setup_1

cmd_ubuntu_dock_setup_2="dconf write /org/gnome/shell/extensions/dash-to-dock/apply-custom-theme \"true\""
echo $cmd_ubuntu_dock_setup_2
eval $cmd_ubuntu_dock_setup_2

cmd_ubuntu_dock_setup_3="dconf write /org/gnome/shell/extensions/dash-to-dock/show-trash \"false\""
echo $cmd_ubuntu_dock_setup_3
eval $cmd_ubuntu_dock_setup_3

#dconf write /org/gnome/shell/extensions/dash-to-dock/dock-position "LEFT"




echo -e "\n\n========== CCACHE SETUP =========="
cmd_ccache_setup="sudo /usr/sbin/update-ccache-symlinks && echo 'export PATH=\"/usr/lib/ccache:$PATH\"' | tee -a ~/.bashrc"
echo $cmd_ccache_setup
eval $cmd_ccache_setup




echo -e "\n\n========== DESKTOP BACKGROUND =========="
cmd_desktop_picture_uri="gsettings set org.gnome.desktop.background picture-uri \"\""
echo $cmd_desktop_picture_uri
eval $cmd_desktop_picture_uri

cmd_desktop_background_color="gsettings set org.gnome.desktop.background primary-color '#BBEEFF'"
echo $cmd_desktop_background_color
eval $cmd_desktop_background_color




echo -e "\n\n========== RDP CONFIGURATION =========="
# removes annoying popups upon RDP login
cmd_rdp_color_config="echo \"[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes\" | sudo tee /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla > /dev/null"
echo $cmd_rdp_color_config
eval $cmd_rdp_color_config




echo -e "\n\n========== FINAL MANUAL STEPS =========="
echo ">>>>>> Open this folder in VS Code to be prompted to install the recommended extensions" 

echo ">>>>>> Please enable the dock in the open application, then close the window"
gnome-shell-extension-prefs

echo ">>>>>> Please run the 'Extension Manager' app through the GUI. In the app, click 'Browse', then search for 'Allow Locked Remote Desktop'. Once the extension has been identified, install and enable it"