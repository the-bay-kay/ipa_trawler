#!/usr/bin/bash

# DICT_PATH="/usr/share/dict/linux.words"
DICT_PATH="/home/katie/Documents/scripts/ipa_trawler/dict.txt"
LINK="https://dictionary.cambridge.org/dictionary/english/"
OUTFILE="US_English_IPA.dict"
# Outfile setup
touch $OUTFILE

while read -r line;
do 
    test="${line//[^0-9]/}"
    url="${LINK}$line"
    f_path="/tmp/${line}-ipa_trawler.txt"
    wget --quiet $url -O $f_path
    err=$(cat $f_path | grep 'home')
    # If dictionary entry doesn't exist, reroutes to homepag
    if ! [ -z "$err" ] || ! [ -z $test ];
    then
        >&2 echo "    [!] ${line} Not Found"
        continue
    fi
    # This temp readline is janky, BUT IT WORKS B)
    tmp=$(cat $f_path | grep 'ipa' | { read l_1; read l_2; echo $l_2 ; })
    if [ -z "$tmp" ];
    then
        >&2 echo "    [!] ${line} Not Found"
        continue
    fi
    re='s|<[^>]*>||g'
    re2='s/\s.*$//'
    tmp=$(echo $tmp | sed $re | sed $re2)
    output="${line} ${tmp///}"
    echo $output >> $OUTFILE
    echo "+ $line"
    rm $f_path
done <$DICT_PATH
