# Reference
[knock](https://github.com/jvinet/knock) clients in different languages (bash powershell perl and python)

```
# syntax (use knock.sh for bash, knock.ps1 for powershell, knock.pl for perl, knock.py for python)
./knock.sh <target>:<targetsshport> <protocol1>:<port1>,<protocol2>:<port2>...

# example
./knock.sh cloudvm.chadg.net:4444 tcp:9876,udp:2222,udp:10101
```
