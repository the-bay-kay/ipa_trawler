#!/usr/bin/bash

# DICT_PATH="/usr/share/dict/linux.words"
DICT_PATH="/home/katie/Documents/scripts/ipa_trawler/dict.txt"
LINK="https://dictionary.cambridge.org/dictionary/english/"
OUTFILE="US_English_IPA.dict"
# Outfile setup
touch $OUTFILE

while read -r line;
do
    url="${LINK}$line"
    f_path="/tmp/${line}-ipa_trawler.txt"
    wget --quiet $url -O $f_path
    err=$(cat $f_path | grep 'home')
    # If dictionary entry doesn't exist, reroutes to homepag
    if ! [ -z "$err" ];
    then
        >&2 echo "    [!] ${line} Not Found"
        continue
    fi
    # This temp readline is janky, BUT IT WORKS B)
    tmp=$(cat $f_path | grep 'ipa' | { read l_1; read l_2; echo $l_2 ; })
    tmp=${tmp:68}
    tmp=${tmp::-50}
    output="${line} ${tmp}"
    echo $output >> $OUTFILE
    >&1 echo "${line}"
    rm $f_path
done <$DICT_PATH
