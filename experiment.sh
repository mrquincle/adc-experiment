ename=${1:? "usage: experiment-name"}

echo "Empty log file (if this is a mistake, see /tmp/minicom.log)"
cp ~/minicom.log /tmp
truncate -s 0 ~/minicom.log 

echo "Time: $(date '+%H:%M:%S')"
echo "Sleep 2 minutes to collect samples"
sleep 120

folder=logs/BACR01B1D
mkdir -p $folder
export lfile="$folder/$(date '+%Y%m%d')_${ename}.log"
echo "Store results in file $lfile"
cp ~/minicom.log $lfile

echo "Size of log retrieved"
wc -l $lfile

./extract.sh $lfile

echo "Number of voltage curves"
wc -l $lfile.volt

echo "Number of current curves"
wc -l $lfile.current

