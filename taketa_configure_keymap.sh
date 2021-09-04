#=====================================================
# Keymap configulation script
#
# NB: keymap will be stored as 'MYKEYMAP'
#
# Created by: Hisashi Takeda, Ph.D. 2019-01-26
#=====================================================

# To see original keymap
cat /usr/share/X11/xkb/symbols/jp # JP keymap

#
# Create keymap file named with username 
#

# JP keymap settings 
sudo touch /usr/share/X11/xkb/symbols/MYKEYMAPJP
sudo chmod 777 /usr/share/X11/xkb/symbols/MYKEYMAPJP
cat <<EOF > /usr/share/X11/xkb/symbols/MYKEYMAPJP
partial hidden modifier_keys
xkb_symbols "keymapjp" {
    replace key <CAPS> { [ Control_L, Control_L ] };  //CapsをCtrlに変更
    replace key <HZTG> { [ Escape, Escape ] };        //Zenkaku_HankakuをEscに変更
    replace key <ESC> { [ Zenkaku_Hankaku, Kanji ] }; //EscをZenkaku_Hankakuに変更
    replace key <AC10> {[ colon, plus ] };            //コロンとセミコロンを交換
    replace key <AC11> {[ semicolon, asterisk ] };    //コロンとセミコロンを交換
  };
EOF

# US keymap settings 
sudo touch /usr/share/X11/xkb/symbols/MYKEYMAPUS
sudo chmod 777 /usr/share/X11/xkb/symbols/MYKEYMAPUS
cat <<EOF > /usr/share/X11/xkb/symbols/MYKEYMAPUS
partial hidden modifier_keys
xkb_symbols "keymapus" {
    replace key <CAPS> {[ Control_L, Control_L ]};      //CapsをCtrlに変更
    replace key <AC10> {[ colon, semicolon ] };         //コロンとセミコロンを交換
    replace key <ESC> {[ Zenkaku_Hankaku, quoteleft ]}; //ESCをZenkaku_Hankakuに変更，Shift+Escで右クオート
    replace key <TLDE> {[ Escape, asciitilde ]};        //チルダをEscに変更，Shift＋Escでチルダ
  };
EOF

# Set keymap settings as a rule
# The rule is either in evdev or base
# N.B. TABs are included in evdev
cd /usr/share/X11/xkb/rules
sudo cp evdev evdev_till${NOW}
sudo sed -i '/MYKEYMAPJP/d' evdev
sudo sed -i '/MYKEYMAPUS/d' evdev
sudo sed -i 's|! option\t=\tsymbols|&\n  MYKEYMAPJP:keymapjp\t=\t+MYKEYMAPJP(keymapjp) // added by user|' evdev
sudo sed -i 's|! option\t=\tsymbols|&\n  MYKEYMAPUS:keymapus\t=\t+MYKEYMAPUS(keymapus) // added by user|' evdev

sudo cp base base_till${NOW}
sudo sed -i '/MYKEYMAPJP/d' base
sudo sed -i '/MYKEYMAPUS/d' base
sudo sed -i 's|! option\t=\tsymbols|&\n  MYKEYMAPJP:keymapjp\t=\t+MYKEYMAPJP(keymapjp) // added by user|' base
sudo sed -i 's|! option\t=\tsymbols|&\n  MYKEYMAPUS:keymapus\t=\t+MYKEYMAPUS(keymapus) // added by user|' base
 
#
# Set keymap and print settings
#
setxkbmap us -v 10 -option MYKEYMAPUS:keymapus
setxkbmap -print

#setxkbmap jp -v 10 -option MYKEYMAPJP:keymapjp
#setxkbmap -print

sed -i '/MYKEYMAPJP/d' ~/.bashrc
sed -i '/MYKEYMAPUS/d' ~/.bashrc
cat <<'EOF'>>~/.bashrc
setxkbmap -option
#setxkbmap jp -option MYKEYMAPJP:keymapjp
setxkbmap us -option MYKEYMAPUS:keymapus
setxkbmap -print | grep MYKEYMAP
EOF

rm -rf /var/lib/xkb/*

# Keep settings even if the input method has changed
# N.B. Can not use this for Ubuntu server
#apt install dconf-editor
#dconf write /org/gnome/desktop/input-sources/xkb-options "['MYKEYMAP:keymap']"
