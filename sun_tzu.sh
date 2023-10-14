curl -s https://raw.githubusercontent.com/0xstaark/test/main/sun_tzu_quotes | shuf -n 1 | awk -F"\n" '{print $1}'
