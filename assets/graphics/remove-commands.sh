tempfile=${1%.tex}-Temp.tex

sed -r 's/\\jv/\\mintinline{java}/g' $1 > $tempfile

cp $tempfile $1
rm $tempfile