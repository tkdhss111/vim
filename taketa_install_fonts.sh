#=====================================================
# Font installation script
#
#
# Created by: Hisashi Takeda, Ph.D. 2019-01-26
#=====================================================

USER=denko

git clone https://github.com/kudryavka/Ricty
cd Ricty/
apt install fontforge -y
apt install fonts-inconsolata -y
curl -L -o 'migu-1m-20130617.zip' 'http://sourceforge.jp/frs/redir.php?m=iij&f=%2Fmix-mplus-ipa%2F59022%2Fmigu-1m-20130617.zip'
unzip migu-1m-20130617.zip
sh ricty_generator.sh auto
mkdir ~/.fonts/
cp -f Ricty*.ttf ~/.fonts/
fc-cache -vf
rm -r Ricty

#
# IPA fonts
#
apt install -y fonts-ipafont
apt install -y otf-ipafont-gothic
apt install -y fonts-ipafont-gothic
apt install -y fonts-ipaexfont
apt install -y ubuntu-defaults-ja
fc-cache -vf
fc-list | rg ipa

# https://github.com/mzyy94/RictyDiminished-for-Powerline
apt install unity-tweak-tool
# Use unity-tweak-tool to set system default font

#
# Morisawa fonts 
#
cp -r fonts/morisawa_kyokasho /usr/share/fonts/opentype/
fc-cache -vf
fc-list | rg morisawa_kyokasho



