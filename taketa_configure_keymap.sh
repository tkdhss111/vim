#=====================================================
# Keymap configulation script
#
# NB: keymap will be stored as 'MYKEYMAP'
#
# Created by: Hisashi Takeda, Ph.D. 2019-01-26
#=====================================================

#
# Create keymap file named with username 
#
MAP=/usr/share/X11/xkb/symbols/MYKEYMAP

# Keymap settings 
cat <<EOF > ${MAP}
partial hidden modifier_keys
xkb_symbols "keymap" {
    key <HENK> { [ i ] }; // 変換をRightに変更
    key <MUHE> { [ Escape ] }; // 無変換をLeftに変更
    key <HKTG> { [ BackSpace ] }; // ひらがなカタカナをBackSpaceに変更
    replace key <CAPS> { [ Control_L, Control_L ] }; // CapsをCtrlに変更
//  replace key <CAPS> { [ Escape, Escape ] };       // CapsをEscapeに変更
    modifier_map  Control { <CAPS>, <LCTL> };        // CapsをCtrlに変更 
  };
EOF

# Set keymap settings as a rule
cd /usr/share/X11/xkb/rules
cp evdev evdev_till${NOW}
sed -i '/MYKEYMAP/d' evdev
sed -i 's|! option\t=\tsymbols|&\n\tMYKEYMAP:keymap = +MYKEYMAP(keymap) // added by user|' evdev

#
# Set keymap and print settings
#
setxkbmap -option MYKEYMAP:keymap
setxkbmap -print

rm -rf /var/lib/xkb/*

# Keep settings even if the input method has changed
apt install dconf-editor
dconf write /org/gnome/desktop/input-sources/xkb-options "['MYKEYMAP:keymap']"

# 
# sudo crontab -e 
#
# Append the following command:
# @reboot /home/jma/vim/taketa_configure_keymap.sh
#


#reboot
