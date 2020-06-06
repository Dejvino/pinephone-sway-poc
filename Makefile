HOME_PATH=~
BIN_PATH=/usr/local/bin

help:
	@echo " Available Actions:"
	@echo "	install_user 	- builds & copies files into the user's home"
	@echo "	install_system 	- builds & copies files into the system"
	@echo "	fetch		- copies files from the system into this build directory"
	@echo "	help		- this!"

###
# INSTALL - USER
###
install_user: install_user_sway install_user_waybar install_user_htop

install_user_sway:
	mkdir -p $(HOME_PATH)/.config/sway/
	cp home/config/sway/* $(HOME_PATH)/.config/sway/config

install_user_waybar:
	mkdir -p $(HOME_PATH)/.config/waybar/
	cp home/config/waybar/* $(HOME_PATH)/.config/waybar/

install_user_htop:
	mkdir -p $(HOME_PATH)/.config/htop/
	cp home/config/htop/* $(HOME_PATH)/.config/htop/

###
# INSTALL - SYSTEM
###
install_system: install_system_check install_system_lightdm install_system_bin install_pptk install_rot8 install_lisgd

install_system_check:
	@echo "Note: install needs to be run as root."

install_system_lightdm:
	cp usr/share/wayland-sessions/* /usr/share/wayland-sessions/

install_system_bin:
	chmod go+rx usr/local/bin/*
	cp usr/local/bin/* /usr/local/bin/

install_pptk:
	cd pinephone-toolkit && meson build 
	ninja -C pinephone-toolkit/build
	ninja -C pinephone-toolkit/build install

install_rot8:
	cd rot8 && cargo build --release
	cp rot8/target/release/rot8 /usr/local/bin/

install_lisgd:
	cd lisgd && git fetch origin && git reset --hard origin/master
	cd lisgd && git apply ../patches/lisgd.patch
	cd lisgd && make
	cp lisgd/lisgd /usr/local/bin/

###
# FETCH
###
fetch: fetch_sway fetch_waybar fetch_htop fetch_lightdm

fetch_sway:
	cp $(HOME_PATH)/.config/sway/config home/config/sway/config

fetch_waybar:
	cp $(HOME_PATH)/.config/waybar/config* home/config/waybar/
	cp $(HOME_PATH)/.config/waybar/style.css home/config/waybar/

fetch_htop:
	cp $(HOME_PATH)/.config/htop/htoprc home/config/htop/

fetch_lightdm:
	cp /usr/share/wayland-sessions/sway.desktop usr/share/wayland-sessions/

