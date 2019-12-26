#! /bin/bash

for f in *.png; do
  convert $f eps3:${f%.png}.eps;
  rm $f;
done

for f in *.jpg; do
  convert $f eps3:${f%.jpg}.eps;
  rm $f;
done

for f in *.bmp; do
  convert $f eps3:${f%.bmp}.eps;
  rm $f;
done

for f in *.svg; do
  inkscape -f $f -E ${f%.svg}.eps;
  rm $f;
done
