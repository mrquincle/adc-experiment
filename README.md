# How to use

Set up minicom, have it stream current/voltage values to minicom.log file

    minicom -b 38400 -c on -D /dev/ttyACM0 -C ~/minicom.log

If necessary, empty log file and only start to stream from this moment (remove everything in file!)

    truncate -s 0 ~/minicom.log 
	
Extract the voltage and current values from a duplicated log file `lfile`:

    mkdir -p logs/PACR01B2E
    export lfile="logs/PACR01B2E/$(date '+%Y%m%d')_off.log"
    cp ~/minicom.log $lfile
    ./extract.sh $lfile

Now run the octave script:

    octave-cli plot_volt_cur.m $lfile
