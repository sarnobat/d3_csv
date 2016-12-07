cat before.html | tee out.html
cat - | perl -pe 's{"?([^"]*)"?,"?([^"]*)"?}{  \{ source : "$1", target : "$2" \},}g' | tee -a out.html
cat after.html | tee -a out.html