#!/bin/bash
# shell knockd client

if [ -z $1 ] || [ -z $2 ]
then
	echo "target:port and port list required, e.g.:\n$0 hostname:port tcp:1000,udp:2020,tcp:399"
	exit
fi

# split target and target ssh port
TARGET=$(echo $1 | awk -F':' '{print $1}')
export TARGET
TARGETSSHPORT=$(echo $1 | awk -F':' '{print $2}')

# split proto+ports into array
set -f
PROTOPORT=(${2//,/ })

# issue commands with split proto and port
for i in "${!PROTOPORT[@]}"
do
	# get proto from col 1
	PROTO=$(echo ${PROTOPORT[i]} | awk -F':' '{print $1}')
	export PROTO
	# get port from col 2
	PORT=$(echo ${PROTOPORT[i]} | awk -F':' '{print $2}')
	export PORT
	echo "knocking: $TARGET:$PROTO:$PORT"
	# send packet
	timeout 1 bash -c "(echo > /dev/$PROTO/$TARGET/$PORT) >& /dev/null"
done

# wait for knockd target to process commands
sleep 3
ssh $TARGET -p $TARGETSSHPORT
