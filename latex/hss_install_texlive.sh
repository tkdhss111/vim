sudo apt install wget perl-tk -y

wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzf install-tl-unx.tar.gz

cd install-tl-20220303
sudo ./install-tl

cp ~/.bashrc ~/.bashrc_bak
cat <<EOF>>~/.bashrc
export PATH=/usr/local/texlive/2022/bin/x86_64-linux${PATH:+:${PATH}}
export INFOPATH=/usr/local/texlive/2022/texmf-dist/doc/info${INFOPATH:+:${INFOPATH}}
export MANPATH=/usr/local/texlive/2022/texmf-dist/doc/man${MANPATH:+:${MANPATH}}
EOF

sudo apt install equivs --no-install-recommends freeglut3
wget -O debian-equivs-2022-ex.txt https://www.tug.org/texlive/files/debian-equivs-2022-ex.txt

equivs-build debian-equivs-2022-ex.txt
sudo dpkg -i texlive-local_2022.99999999-1_all.deb
sudo apt install -f

# To open package manager
sudo env PATH="$PATH" tlmgr --gui
