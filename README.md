# Reference
[knock](https://github.com/jvinet/knock) clients in different languages (currently bash powershell and perl)

```
# syntax (use knock.ps1 for powershell, knock.pl for perl)
./knock <target>:<targetsshport> <protocol1>:<port1>,<protocol2>:<port2>...

# example
./knock cloudvm.chadg.net:4444 tcp:9876,udp:2222,udp:10101
```
