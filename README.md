# pinephone-sway-poc
Sway UI configured for PINE64 PinePhone (Proof Of Concept)

You can find ready-made config files, scripts and installation instructions on how to set up Sway on Arch Linux ARM and use it with a PinePhone.

![Screenshots](./screenshots.png)

## Install
### Arch Linux ARM
Start with a [Pine64-Arch](https://github.com/dreemurrs-embedded/Pine64-Arch/) image flashed to the phone and get SSH access.

Disable the default `phosh.service` so that it doesn't get started on boot (`sudo systemctl disable --now phosh.service`).

Run this installation:

```bash
# system components
$ sudo pacman -S sway waybar bemenu bemenu-wayland swaylock swayidle squeekboard bash dialog tzdata alacritty

# build tools
$ sudo pacman -S git make meson ninja cargo linux-headers 

# user components
$ sudo pacman -S networkmanager htop pavucontrol

# theme components
$ sudo pacman -S ttf-font-awesome
```

### Common

```bash
# installation
$ git clone --recurse-submodules https://github.com/Dejvino/pinephone-sway-poc
$ cd pinephone-sway-poc
$ make install_user
$ sudo make install_system

# power button
sudo vim /etc/systemd/logind.conf # or /etc/elogind/logind.conf for non-systemd distros (pmOS)
# replace:
# #HandlePowerKey=poweroff
# with:
# HandlePowerKey=suspend
```

That's it. You should now have everything in place. Reboot to use the new settings.

## Usage
Study the provided config files and shell scripts to get more details. The following is just an introduction.

### Power Button
The power button activates or deactivates a "sleep mode" (suspend). This mode is automatically entered after a period of inactivity (via swayidle). Before that, the backlight is first turned low, then the backlight is turned off and all the CPUs except for the primary one are shut down. The indicator LED is used to indicate the power mode: 1) green = running, low power usage, 2) blue = suspend.

### Top and bottom waybar
The bars show you CPU/MEM usage, backlight brightness, time, etc. Touching them opens a relevant app (e.g. NetworkManager or htop). Touching the date opens a custom "quick execute" menu to launch an app. The **[x]** icon closes the active window. Touching the backlight indicator brings up a custom brightness setting app.

### Touch gestures
Swiping two fingers up / down activates or hides the on-screen keyboard. Swiping two fingers left / right changes the active workspace. Three fingers change the active window in the direction of the swipe. Four fingers move the active window accordingly.

### Screen Rotation
The screen is automatically rotated based on the readings from the phone's built-in accelerometer.

## TIP!
You can use this as a configs backup mechanism!
```
$ make fetch
```
Running this command gathers the relevant config files from your running system and replaces the files in the repository. You can then `git add` and `commit` your own changes, straight from the phone! This is actually how the config files here were created.

## Components
* postmarketOS / Arch Linux ARM - base Linux distribution (though any other would work as well)
* sway (packaged) - tiling Wayland compositor
* * swayidle, swaylock - utils for sway
* bemenu (packaged) - app launcher
* waybar (packaged) - Wayland status bar
* * [carlosdss22/dotfiles](https://github.com/carlosdss22/dotfiles/tree/master/waybar) - styles used
* squeekboard (packaged) - on-screen keyboard for Wayland
* * [terminal.yaml](https://source.puri.sm/btantau/squeekboard/blob/btantau-master-patch-76686/data/keyboards/terminal.yaml) - keyboard layout based on this improved version
* [pinephone-toolkit](https://github.com/Dejvino/pinephone-toolkit) - various utilities for the PinePhone
* [sxmo-lisgd](https://git.sr.ht/~mil/lisgd) - gesture detection daemon
* [rot8](https://github.com/efernau/rot8) - screen rotation daemon using data from the accelerometer
* htop (packaged) - Processes monitoring
* pavucontrol (packaged) - PulseAudio control panel
* mako (packaged) - Notify daemon

(*packaged* = available as a package directly from the repository)

