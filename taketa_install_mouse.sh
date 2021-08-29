# https://askubuntu.com/questions/236529/binding-back-forward-to-mouse-buttons

sudo apt install -y x11-utils xautomation

cat <<EOF>~/.xbindkeysrc
#
# taketa mouse back and forward configuration
#
# History Back & Forward
"xte 'keydown Alt_L' 'keydown Left' 'keyup Left' 'keyup Alt_L'"
     b:6

"xte 'keydown Alt_L' 'keydown Right' 'keyup Right' 'keyup Alt_L'"
     b:7
EOF

killall xbindkeys

xbindkeys -f ~/.xbindkeysrc
