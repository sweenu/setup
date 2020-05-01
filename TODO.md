# Ansible:
- networkmanager: potentially use nmcli module instead of what I do
- format: make some research on the error of vfat on logical sector size of 4MiB and change format role accordingly
- use a git submodule for the aur module
- configure venvs with pyenv (neovim, sway, ...)
- Import gpg keys for:
  - spotify
- fix gpg role
- add:
	- tmux role
	- waybar role
	- espanso role
	- mako role
	- neomutt role
	- spotifyd and spotify-tui roles
	- zathura role
	- dash being default sh role
	- wayland role (installing: qt5-wayland, glfw-wayland, glew-wayland
	- playerctl as dependency in sway role
	- starship role
	- update alacritty role

# Things I miss in wayland:
## Wayland:
- Electron apps are blurry https://github.com/electron/electron/issues/10915

## Waybar:
- missing a taskbar https://github.com/Alexays/Waybar/issues/186

## Missing apps
- rofimoji / a way to search and insert emojis anywhere
