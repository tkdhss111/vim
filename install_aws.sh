#
# Time Zone and Locale Setting
#
timedatectl
sudo timedatectl set-timezone Asia/Tokyo
timedatectl
sudo apt install language-pack-ja
sudo update-locale LANG=ja_JP.UTF-8
export LANG=ja_JP.UTF-8

# Neovim
#
# git clone https://github.com/tkdhss111/vim.git
# cd vim
# cp -r .config ../
# ./install_aws.sh (this file)
sudo apt update
sudo apt install -y build-essential gfortran
sudo apt install -y nodejs npm tree-sitter-cli
sudo apt install -y podman, cmake, ninja-build
sudo apt install -y unzip universal-ctags, ripgrep, p7zip-full
sudo snap install nvim --classic
snap info nvim
nvim

cd ~/.ssh
touch id_rsa_hp-z840
sudo chmod 400 id_rsa_hp-z840
# Manually copy and paste its contents

cat <<EOF > config
Host github.com
HostName github.com
IdentityFile ~/.ssh/id_rsa_hp-z840
IdentitiesOnly yes
TCPKeepAlive yes
AddKeysToAgent yes
User git
EOF

#
# DATA directory
#
sudo mkdir /mnt/DATA
sudo chmod 777 -R /mnt/DATA
sudo chown ubuntu:ubuntu -R /mnt/DATA

#
# Podman Deps.
#
mkdir TAKEDATA
cd TAKEDATA

# fortran-load
mkdir /mnt/DATA/$(HOST)/load
git clone git@github.com:tkdhss111/fortran-load.git
curl https://stats.dip.jp/podman-images/fortran-load_v1.0.tar.gz \
  --output fortran-load/install/fortran-load_v1.0.tar.gz
cd fortran-load/install
make service_files
sudo make install_image
make service
make watchdog

# fortran-open-meteo
mkdir /mnt/DATA/$(HOST)/open-meteo
git clone git@github.com:tkdhss111/fortran-open-meteo.git
curl https://stats.dip.jp/podman-images/fortran-open-meteo_v1.0.tar.gz \
  --output fortran-open-meteo/install/fortran-open-meteo_v1.0.tar.gz
cd fortran-open-meteo/install
make service_files
sudo make install_image
make service
make watchdog
