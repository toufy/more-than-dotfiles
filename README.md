# more-than-dotfiles

this is just a script to automate the setup of my basic/template development and home environment.

it includes:
- theme setup (catppuccin mocha wherever possible, including refind bootloader and tty)
- hyprland+waybar setup
- bash setup
- git setup
- environment variables (for development and others)
- neovim setup
- other dotfiles for common applications
- nvidia setup
- secure boot
- qemu/virt-manager setup
- plymouth

i'm currently using archlinux, and this script makes use of pacman and the aur.
if you use vanilla/minimal archlinux, or a light/minimal arch-based distro,
and have a container-oriented workflow, this might be useful to you, so feel free to use it i guess.
but I can't guarantee it works for you. and if you do use it, make sure to read and modify the scripts 
as this is tailored towards my personal workflow.

### usage

to use the setup script you can run `python setup.py`.
running `python setup.py` will show an interactive prompt, you must never run this as root.

make sure to modify relevant parts before running the script and performing operations.
these are found in the following places:

- `<project_dir>/.config`: general config files that get symlinked to "$HOME"/.config/
- `<project_dir>/etc`: these get copied with `-f` to /etc, be very careful modifying them
- [ `<project_dir>/.bash` `<project_dir>/.bashrc` `<project_dir>/.bash_profile` ]: shell configs, they get symlinked to "$HOME"/
- `<project_dir>/boxes.ini`: distrobox setup file, this is used to create the containers

any of these config files overwrite existing ones.
if you have something that you don't want overwritten, modify the scripts in `<project_dir>/scripts`.

a majority of the config is symlinked, not copied.
this is intentional, to reflect any changes to the project's directory.

it should be safe to run the script from anywhere, but it's safer to `cd` into the script's directory before running it.

## note
*this is, and probably forever will be, a work in progress.
some parts i claimed "it includes" may be missing, and will be gradually added.
