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
//    replace key <AC10> { [ colon, semicolon ] };
//    key <HENK> { [ i ] }; // 変換をRightに変更
//    key <MUHE> { [ Escape ] }; // 無変換をLeftに変更
//    key <HKTG> { [ BackSpace ] }; // ひらがなカタカナをBackSpaceに変更
    replace key <CAPS> { [ Control_L, Control_L ] };  // CapsをCtrlに変更
    replace key <HZTG> { [ Escape, Escape ] };        // Zenkaku_HankakuをESCに変更
    replace key <ESC> { [ Zenkaku_Hankaku, Kanji ] }; // ESCをZenkaku_Hankakuに変更
  };
EOF

# Set keymap settings as a rule
# The rule is either in evdev or base
# N.B. TABs are included in evdev
cd /usr/share/X11/xkb/rules
cp evdev evdev_till${NOW}
sed -i '/MYKEYMAP/d' evdev
sed -i 's|! option\t=\tsymbols|&\nMYKEYMAP:keymap\t=\t+MYKEYMAP(keymap) // added by user|' evdev

cp base base_till${NOW}
sed -i '/MYKEYMAP/d' base
sed -i 's|! option\t=\tsymbols|&\nMYKEYMAP:keymap\t=\t+MYKEYMAP(keymap) // added by user|' base

#
# Set keymap and print settings
#
#/usr/bin/setxkbmap us -option MYKEYMAP:keymap
/usr/bin/setxkbmap -v 10 -option MYKEYMAP:keymap
/usr/bin/setxkbmap -print

#cat <<'EOF'>>~/.bashrc
#/usr/bin/setxkbmap us -option MYKEYMAP:keymap
#EOF
cat <<'EOF'>>~/.bashrc
/usr/bin/setxkbmap -option MYKEYMAP:keymap
EOF

rm -rf /var/lib/xkb/*

# Keep settings even if the input method has changed
# N.B. Can not use this for Ubuntu server
#apt install dconf-editor
#dconf write /org/gnome/desktop/input-sources/xkb-options "['MYKEYMAP:keymap']"
