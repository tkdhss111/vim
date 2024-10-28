sudo apt-get purge texlive*

sudo rm -rf /usr/local/texlive/*

rm -rf ~/.texlive*

sudo rm -rf /usr/local/share/texmf

sudo rm -rf /var/lib/texmf

sudo rm -rf /etc/texmf

sudo apt remove tex-common --purge

rm -rf ~/.texlive

find -L /usr/local/bin/ -lname /usr/local/texlive/*/bin/* | xargs -r rm
