#=====================================================
# Font installation script
#
#
# Created by: Hisashi Takeda, Ph.D. 2019-01-26
#=====================================================

USER=$USER

git clone https://github.com/kudryavka/Ricty
cd Ricty/
sudo apt install fontforge -y
sudo apt install fonts-inconsolata -y
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
sudo apt install -y fonts-ipafont
sudo apt install -y otf-ipafont-gothic
sudo apt install -y fonts-ipafont-gothic
sudo apt install -y fonts-ipaexfont
sudo apt install -y ubuntu-defaults-ja
fc-cache -vf
fc-list | rg ipa

# https://github.com/mzyy94/RictyDiminished-for-Powerline
sudo apt install unity-tweak-tool
# Use unity-tweak-tool to set system default font

#
# Morisawa fonts 
#
sudo cp -r fonts/morisawa_kyokasho /usr/share/fonts/opentype/
sudo fc-cache -vf
sudo fc-list | rg morisawa_kyokasho



