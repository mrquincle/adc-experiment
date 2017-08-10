ename=${1:? "usage: experiment-name"}

echo "Empty log file (if this is a mistake, see /tmp/minicom.log)"
cp ~/minicom.log /tmp
truncate -s 0 ~/minicom.log 

echo "Sleep 2 minutes"
sleep 120

mkdir -p logs/PACR01B2E
export lfile="logs/PACR01B2E/$(date '+%Y%m%d')_${ename}.log"
echo "Store results in file $lfile"
cp ~/minicom.log $lfile

echo "Size of log retrieved"
wc -l $lfile

./extract.sh $lfile

echo "Number of voltage curves"
wc -l $lfile.volt

echo "Number of current curves"
wc -l $lfile.current

