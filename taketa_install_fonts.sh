#=====================================================
# Font installation script
#
#
# Created by: Hisashi Takeda, Ph.D. 2019-01-26
#=====================================================

USER=eric

git clone https://github.com/kudryavka/Ricty
cd Ricty/
apt install fontforge -y
apt install fonts-inconsolata -y
curl -L -o 'migu-1m-20130617.zip' 'http://sourceforge.jp/frs/redir.php?m=iij&f=%2Fmix-mplus-ipa%2F59022%2Fmigu-1m-20130617.zip'
unzip migu-1m-20130617.zip
sh ricty_generator.sh auto
sudo mkdir ~/.fonts/
sudo cp -f Ricty*.ttf ~/.fonts/
sudo fc-cache -vf

# https://github.com/mzyy94/RictyDiminished-for-Powerline
sudo apt install unity-tweak-tool
# Use unity-tweak-tool to set system default font