#!/system/bin/sh
sleep 15
svc wifi disable

while [ 1 ]
do
	rm_code=`getevent -c 1 /dev/input/event0`	
	
	if [ "$rm_code" = "0001 003c 00000001" ] ; then
		svc wifi enable
		ifconfig eth0 down
	   print $rm_code
	   am start -n com.dangbei.tvlauncher/com.dangbei.launcher.ui.main.MainActivity
     fi
	if [ "$rm_code" = "0001 0066 00000001" ] ; then
		ifconfig eth0 up
		svc wifi disable
	   print $rm_code
     fi
done
dump(){
#以后想恢复就把dump(){这一行和最后一行的}去掉就好，shell没办法多行注释，只能把想注释的代码弄进一个函数，然后不调用
binFolder=/system/bin
dataFolder=/data/data/com.vixtel.stb.agent
dataLocalFolder=/data/local/vixtel/bin

testAgentFileName=testagent
stbAgentFileName=stbagent

testAgentFullFolder=$(echo "$binFolder/$testAgentFileName") 


stbAgentFullFolder="$dataFolder/$stbAgentFileName"

testagentDataFile="$dataLocalFolder/$testAgentFileName"


echo $testAgentFullFolder



while [ ! -f $testAgentFullFolder ]
do
	sleep 3;
done


if [ -f $testagentDataFile ];then
    echo "($testagentDataFile) exist!"
	$(chmod 755 $testagentDataFile)
    $testagentDataFile >/dev/null 2>&1 &
else
    $testAgentFullFolder >/dev/null 2>&1 &
fi


sleep 2

if [ -f $stbAgentFullFolder ] ; then
	echo "($stbAgentFullFolder) exist!"
	$(chmod 755 $stbAgentFullFolder)
	$stbAgentFullFolder >/dev/null 2>&1 &
	echo "vxt_true"
else  
	echo "vxt_false"
fi
}