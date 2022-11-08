#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage :
        bash raw_to_data.sh all # read from ./cliplist.txt 
        bash raw_to_data.sh {clipzippath}"
    exit
fi

pre='frame'
datadir='Dataset'

if [ $1 == 'all' ]; then
    while read clip; do
        mkdir temp
        unzip $datadir/$clip.zip -d temp
        for f in $(ls temp/obj_train_data); do
            ftail=${f##*_}
            fext=${ftail##*.}
            if [ $fext == 'txt' ]; then
                cp temp/obj_train_data/$f $datadir/train/labels/"$clip"_"$ftail"
            else
                cp temp/obj_train_data/$f $datadir/train/images/"$clip"_"$ftail"
            fi
        done
        for f in $(ls temp/val_data); do
            ftail=${f##*_}
            fext=${ftail##*.}
            if [ $fext == 'txt' ]; then
                cp temp/val_data/$f $datadir/val/labels/"$clip"_"$ftail"
            else
                cp temp/val_data/$f $datadir/val/images/"$clip"_"$ftail"
            fi
        done
        rm -rf temp
    done < cliplist.txt
else
    if [ -e $1 ]; then
        zipname=$(basename $1)
        clip=${zipname%.*}
        mkdir temp
        # tar xvf $1 -C temp >> /dev/null
        unzip $1 -d temp >> /dev/null
        for f in $(ls temp/obj_train_data); do
            ftail=${f##*_}
            fext=${ftail##*.}
            if [ $fext == 'txt' ]; then
                cp temp/obj_train_data/$f $datadir/train/labels/"$clip"_"$ftail"
            else
                cp temp/obj_train_data/$f $datadir/train/images/"$clip"_"$ftail"
            fi
        done
        for f in $(ls temp/val_data); do
            ftail=${f##*_}
            fext=${ftail##*.}
            if [ $fext == 'txt' ]; then
                cp temp/val_data/$f $datadir/val/labels/"$clip"_"$ftail"
            else
                cp temp/val_data/$f $datadir/val/images/"$clip"_"$ftail"
            fi
        done
        rm -rf temp
    else
        echo "./$1 is not exist"
        exit
    fi
fi
# fname=${1%.*}
# fext=${1##*.}
# src_dir=$fname