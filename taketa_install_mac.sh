pip3 install pynvm

#
# Zathura PDF
#
brew tap zegervdv/zathura
brew install zathura
brew install zathura-pdf-poppler
brew install xdotool

mkdir -p $(brew --prefix zathura)/lib/zathura
ln -s $(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib $(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib

#
# LaTeX
#
brew cask install mactex
