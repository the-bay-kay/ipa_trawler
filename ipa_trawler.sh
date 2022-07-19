#!/usr/bin/bash

DICT_PATH="/usr/share/dict/linux.words"
LINK="https://dictionary.cambridge.org/dictionary/english/"
TEST="${LINK}penguin"
wget --quiet $TEST
echo $TEST
exit
while read -r line;
do
    echo -e "$line"
done <$DICT_PATH

