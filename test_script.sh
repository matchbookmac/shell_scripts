#!/bin/bash

# current_time=$(date "+%d-%H-%M-%S")
# touch 1.pdf
# mv 1.pdf _1_$current_time.pdf
# pdftk _1_$current_time.pdf update_info ~/Downloads/.pdfmetadata output $1
# rm _1_$current_time.pdf

current_time=$(date "+%d-%H-%M-%S")
mv $1 _1_$current_time.pdf
pdftk _1_$current_time.pdf update_info ~/Downloads/.pdfmetadata output $1
rm _1_$current_time.pdf

if is scan snap and is older than 1 day, convert back to abby
it may not be abby that you need to watch for.
