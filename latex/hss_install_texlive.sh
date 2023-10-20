YR=2022

sudo apt install wget perl-tk -y
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzf install-tl-unx.tar.gz

cd install-tl-${YR}
sudo ./install-tl

# DEPRECATED: use init.vim for setting PATH
#cp ~/.bashrc ~/.bashrc_bak
#cat <<EOF>>~/.bashrc
#export PATH=/usr/local/texlive/${YR}/bin/x86_64-linux${PATH:+:${PATH}}
#export INFOPATH=/usr/local/texlive/${YR}/texmf-dist/doc/info${INFOPATH:+:${INFOPATH}}
#export MANPATH=/usr/local/texlive/${YR}/texmf-dist/doc/man${MANPATH:+:${MANPATH}}
#EOF

sudo chmod 777 -R /usr/local/texlive
tlmgr --gui

# DEPRECATED: use init.vim for setting PATH
#sudo ln -s /usr/local/texlive/${YR}/bin/x86_64-linux/lualatex /usr/local/bin/
#sudo ln -s /usr/local/texlive/${YR}/bin/x86_64-linux/latexmk /usr/local/bin/

#sudo apt install equivs --no-install-recommends freeglut3
#wget -O debian-equivs-2022-ex.txt https://www.tug.org/texlive/files/debian-equivs-2022-ex.txt
#
#equivs-build debian-equivs-2022-ex.txt
#sudo dpkg -i texlive-local_2022.99999999-1_all.deb
#sudo apt install -f
#
## To open package manager
#sudo env PATH="$PATH" tlmgr --gui
