sudo apt install texlive-lang-cjk xdvik-ja texlive-fonts-recommended texlive-fonts-extra -y
sudo apt install latexmk -y
cp .latexmkrc ~/.latexmkrc

sudo apt install okular -y

# (Instruction) Manually set the following in Okular: 
# Settings-Editor Options-'Editor: Custom Text Editor', 'Command:nvr --remote-silent +%l %f'
#
# N.B. Shift + Click inverse search for LaTeX document when 'Browse(bottun)' mode of Okular.

# DEPRECATED: zathura
#sudo apt install zathura libsynctex-dev libgtk-3-dev xdotool -y
#mkdir -p ~/.config/zathura/
#cp .zathurarc ~/.config/zathura/.zathurarc
#
#cat <<EOF>~/.config/zathura/.zathurarc
#set synctex true
#set synctex-editor-command "nvr --remote-silent +%{line} %{input}"
#EOF

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
