sudo apt update
sudo apt upgrade -y
sudo apt install build-essential devscripts -y
sudo apt build-dep ibus-mozc -y
apt source ibus-mozc
cd ~/mozc*
FILE=$(find . -name property_handler.cc)
echo $FILE
dpkg-buildpackage -us -uc -b
sudo dpkg -i ../mozc*.deb ../ibus-mozc*.deb
