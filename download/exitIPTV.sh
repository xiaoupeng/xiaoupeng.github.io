
while [ 1 ]
do
	rm_code=`getevent -c 1 /dev/input/event0`	
	
	if [ "$rm_code" = "0001 003b 00000001" ] ; then
	   print $rm_code
	   am start -n com.dangbei.tvlauncher/com.dangbei.tvlauncher.IndexActivity
        fi
	
done
		