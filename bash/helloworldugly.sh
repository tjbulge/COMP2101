#!/bin/bash
# Third Script - created Sept 14, 2021

# Different way of creating output text by starting with something else and stream editing into pipeline

echo -n "helb wold" |
  sed -e "s/b/o/g" -e "s/l/ll/" -e "s/ol/orl/" |
  tr "h" "H" |
  tr "w" "W" |
  awk '{print $1 "\x20" $2 "\x21"}'
bc <<< "(($$ * 4 -24)/2 +12)/2" |
  sed 's/^/I am process # /' 
