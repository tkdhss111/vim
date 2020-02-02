apt install texlive-lang-cjk xdvik-ja texlive-fonts-recommended texlive-fonts-extra -y
apt install latexmk -y
cp .latexmkrc ~/.latexmkrc
apt install zathura xdotool -y
mkdir -p ~/.config/zathura/
cp .zathurarc ~/.config/zathura/.zathurarc
pip install --upgrade pip
pip3 install neovim-remote
