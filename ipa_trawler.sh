#!/usr/bin/bash

SAVEIFS=$IFS
IFS=$'\n'
# DICT_PATH="/usr/share/dict/linux.words"
DICT_PATH="/home/katie/Documents/scripts/ipa_trawler/dict.txt"
LINK="https://dictionary.cambridge.org/dictionary/english/"
# Using /tmp/ rather than saving as a variable, as it makes the
# process of stripping the IPA character easier 
# wget --quiet $TEST -O '/tmp/testpen.html'
echo 
while read -r line;
do
    url="${LINK}$line"
    f_path="/tmp/${line}-ipa_trawler.txt"
    echo $f_path
    wget --quiet $url -O $f_path
    tmp=$(cat $f_path | grep 'ipa' | { read l_1; read l_2; echo $l_2 ; })
    echo $tmp
    rm $f_path
    echo -e "$URL"
done <$DICT_PATH

IFS=$SAVEIFS
