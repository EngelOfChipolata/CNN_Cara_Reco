#!/bin/bash
for i in '0' '1' '2' '3' '4' '5' '6' '7' '8' '9'; do
for var in $(ls $i/*.gif); do
   #echo "$var ${var%.*}.pgm"
   convert $var ${var%.*}.pgm
   rm $var
done
done
