sudo apt install texlive-lang-cjk xdvik-ja texlive-fonts-recommended texlive-fonts-extra -y
sudo apt install latexmk -y
cp .latexmkrc ~/.latexmkrc
sudo apt install zathura libsynctex-dev libgtk-3-dev xdotool -y
mkdir -p ~/.config/zathura/
cp .zathurarc ~/.config/zathura/.zathurarc

sudo pip3 install neovim-remote

sudo cp mediabb.sty /usr/share/texlive/texmf-dist/tex/platex/base/mediabb.sty

cd /usr/share/texlive/
sudo mktexlsr

# Pandoc
# Use pandoc -Dlatex for LaTeX default document
#
# Command example for creating PDF from Markdown using Morisawa font:
#
# pandoc README.md -o readme.pdf --latex-engine=lualatex -V documentclass=bxjsarticle -V mainfont=UDDigiKyokashoN-R.otf

# for pandoc
#apt install texlive-lualatex
