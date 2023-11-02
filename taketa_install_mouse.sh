# https://askubuntu.com/questions/236529/binding-back-forward-to-mouse-buttons
# TWICE CLICK BUG https://forum.obsidian.md/t/linux-mouse-button-goes-back-twice/748/2

sudo apt install -y xdotool xautomation

cat <<EOF>~/.xbindkeysrc
#
# taketa mouse back and forward configuration
#
# History Back & Forward
#"xte 'keydown Alt_L' 'keydown Left' 'keyup Left' 'keyup Alt_L'"
"xdotool key alt+Left"
     b:6 + release

#"xte 'keydown Alt_L' 'keydown Right' 'keyup Right' 'keyup Alt_L'"
"xdotool key alt+Right"
     b:7 + release
EOF

killall xbindkeys

xbindkeys -f ~/.xbindkeysrc
