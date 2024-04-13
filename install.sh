#!/usr/bin/env bash

USER=user

MESSAGE_PREFIX="                "

message_start_action()
{
	echo "${MESSAGE_PREFIX}"$1"..."
}

message_end_action()
{
	echo $MESSAGE_PREFIX$1.
}

setup_git()
{
	message_start_action "setup git"
	git config --global user.name "Alexandr Bushuev"
	git config --global user.email zxsnems@gmail.com
	git config --global core.editor nvim
	git config --global core.excludesFile '~/.gitignore'
}

create_directories() {
    mkdir -pv ~/{Downloads,Documents,Work,src,Dev,Org,Work,Pictures/Screenshots}/
}

install_deb_packages() {
	message_start_action "installing apt packages"
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get install -y $(grep -vE "^\s*#" ./packages.deb.txt  | tr "\n" " ")
    sudo apt-get autoremove -y
    sudo apt-get autoclean -y
    sudo apt-get clean -y
}

setup_neovim() {
    message_start_action "installing neovim"
    curl -LO https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage
    chmod a+x nvim.appimage
    sudo mv ./nvim.appimage /usr/local/bin/nvim
    sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/nvim 1
    sudo update-alternatives --set vi /usr/local/bin/nvim
}

install_firefox() {
    cd /tmp
    wget https://ftp.mozilla.org/pub/firefox/releases/89.0/linux-x86_64/en-US/firefox-89.0.tar.bz2
    sudo tar xf firefox-89.0.tar.bz2 -C /opt/
}

install_thunderbird() {
    # TODO: Install firetray
    cd /tmp
    wget https://releases.mozilla.org/pub/thunderbird/releases/89.0b4/linux-x86_64/en-US/thunderbird-89.0b4.tar.bz2
    sudo tar xf thunderbird-89.0b4.tar.bz2 -C /opt/
}

install_packages() {
    if [[ -f /etc/debian_version ]]; then
        install_deb_packages
    else
        echo "Unsupported OS"
        exit 1
    fi

    #install_firefox
    #install_thunderbird
}

create_symlinks() {
    for f in "$1"/* "$1"/.[^.]*; do
        if echo "$f" | egrep '.*\/?((\.){1,2}|.git|assets|README.md|install.sh|tags)$' >/dev/null; then
            continue
        fi
        if [[ -f $f ]]; then
            ln -sfn `realpath "$f"` "$HOME/$f"
        fi
        if [[ -d $f ]]; then
            mkdir -p "$HOME"/"$f"
            create_symlinks "$f"
        fi
    done
}

setup_shell()
{
	git clone https://github.com/so-fancy/diff-so-fancy.git ~/src/diff-so-fancy
	git clone https://github.com/zsh-users/antigen.git ~/.local/antigen  
    message_start_action "setup shell"
    chsh --shell `which zsh`
}

setup_keyboard()
{
    message_start_action "setup keyboard"
    #setxkbmap -layout "us,ru" -option ctrl:swapcaps grp:alt_shift_toggle
    setxkbmap -layout "us,ru" -option grp:alt_shift_toggle
}

setup_alacritty()
{
    sudo add-apt-repository ppa:aslatter/ppa -y
    sudo apt-get update
    sudo apt install alacritty
}

setup_alacritty_fonts()
{
    mkdir -p "$HOME/.fonts"
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
    unzip -j ./JetBrainsMono.zip -d "$HOME/.fonts"
    rm ./JetBrainsMono.zip
    fc-cache -rv
}


if [[ $2 == "-A" ]]; then
    create_directories
    install_packages
fi

setup_keyboard
create_directories
install_packages
create_symlinks .
setup_shell
setup_neovim
setup_git

setup_alacritty
setup_alacritty_fonts

message_end_action "All done".



