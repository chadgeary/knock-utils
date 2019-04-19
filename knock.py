#!/usr/bin/python3
import sys
import socket

# instructions
if len(sys.argv) != 3:
    print ("target:port and port list required, e.g.:\n{} hostname:port tcp:1000,udp:2020,tcp:399".format(sys.argv[0]))
    sys.exit(-1)

# split and assign arguments
targetarg = sys.argv[1].split(':')
targetname = targetarg[0]
sshport = targetarg[1]

protoportarg = sys.argv[2].split(',')
for protoports in protoportarg:
    protoport = protoports.split(':')
    proto = protoport[0]
    port = int(protoport[1])
    print("knocking: {}:{}:{}".format(targetname,proto,port))
    if proto == ("tcp"):
        targetsocket = socket.socket()
    try:
        targetsocket.connect((targetname,port))
    except:
        pass
    if proto == ("udp"):
        targetsocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        targetsocket.sendto(bytes("1", "utf-8"), ("desktop",port))
    except:
        pass

# ssh command message, because we're not adding a client here
print("knocking complete, exiting.\nto connect, run: ssh {} -p {}".format(targetname,sshport))
