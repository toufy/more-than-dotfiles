#!/bin/bash
SCRDIR=$1

# remove fedora remotes
flatpak remote-delete fedora || echo "fedora remote already deleted"
flatpak remote-delete fedora-testing || echo "fedora-testing remote already deleted"

flatpak install --assumeyes flathub org.gnome.clocks org.gnome.Weather org.gnome.Loupe \
    io.github.celluloid_player.Celluloid org.gnome.Calculator org.gnome.Calendar org.gnome.Geary \
    org.gnome.Evince org.libreoffice.LibreOffice org.gustavoperedo.FontDownloader \
    com.github.tchx84.Flatseal io.github.flattool.Warehouse net.nokyan.Resources \
    me.kozec.syncthingtk iorg.gimp.GIMP org.inkscape.Inkscape org.gnome.gitlab.YaLTeR.Identity \
    io.gitlab.theevilskeleton.Upscaler org.gnome.Builder re.sonny.Workbench \
    com.github.huluti.Curtail org.mozilla.firefox org.gnome.TextEditor org.signal.Signal \
    com.discordapp.Discord net.cozic.joplin_desktop io.github.mrvladus.List \
    org.keepassxc.KeePassXC org.gnome.Lollypop
