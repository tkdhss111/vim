#! /bin/bash

for f in *.png; do
convert $f eps2:${f%.png}.eps;
done

for f in *.jpg; do
convert $f eps2:${f%.jpg}.eps;
done

for f in *.bmp; do
convert $f eps2:${f%.bmp}.eps;
done
