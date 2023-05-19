set -e


INPUT=/tmp/calls.csv
#FILTER=$HOME/work/code_comprehension/filter.sh
FILTER=/tmp/filter_public.sh
DIR=$HOME/github/d3_csv/singlefile_automated/ 

cat <<'EOF' > /tmp/csv2d3.sh
set -e
cd /tmp/
cat before.html | tee out.html
cat - | grep -v "source,target" | perl -pe 's{"?([^"]*)"?,"?([^"\n]*)"?}{  \{ source : "$1", target : "$2" \},}g' | tee -a out.html
cat after.html | tee -a out.html
EOF

cat <<EOF > /tmp/filter_public.sh
cat - \
	| grep -v apache \
	| grep -v microsoft \
	| grep -v junit \
	| grep -v netflix \
	| grep -v java\. \
	| grep -v spring \
	| grep -v Test
EOF

cd $DIR
ls $INPUT
ls $FILTER
ls before.html
ls after.html
ls d3.v3.min.js


cd /tmp/
grep -nil research /tmp/* | grep -v call |  xargs --delimiter '\n' --max-args=1 rm -v || echo "nothing to remove"
rm /tmp/out.html || echo "nothing to remove"
rm /tmp/index.html || echo "nothing to remove"
cd $DIR

cp before.html /tmp/
cp after.html /tmp/
cp d3.v3.min.js /tmp/

# cat $INPUT | sh $FILTER | sh /tmp/csv2d3.sh | tee /tmp/index.html
cat - | sort | uniq | sh /tmp/filter_public.sh | sh /tmp/csv2d3.sh | tee /tmp/index.html
