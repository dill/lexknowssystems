#!/bin/bash

# Lex knows systems!

# get a file at random
thefile=$(ls images/* |sort -R |tail -1)

# first change the size of the original
convert -background black $thefile -resize 478x393 -gravity center -extent 478x393 tmp/thisos.png

# shear it to the angle of the monitor
convert -background black tmp/thisos.png -shear -5x-8 tmp/thisos.png

# get perspective
convert  -background black tmp/thisos.png -distort Perspective '0,0 -1,-6  0,393 0,395  478,0 418,40 478,393 418,395' -layers merge tmp/thisos2.png

# merge that into the hole in the base image
convert tmp/thisos2.png -page -229-129 base.png -layers merge merged.png

# add the subtitle
thesystem=${thefile/images/}
thesystem=${thesystem/\//}
thesystem=${thesystem//_/ }
thesystem=${thesystem/\.[a-z][a-z][a-z]/}
# "it's a Unix system, I know this"
convert merged.png \( -background black -fill yellow -font Helvetica -pointsize 48 -gravity center label:"This is a ${thesystem} system,\nI know this!" \) -gravity south -compose over -composite merged_final.png

