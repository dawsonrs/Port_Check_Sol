#!/usr/bin/ksh
#
#
# For Solaris 8, 9 or 10 without lsof, this script maps PIDS to ports and vice versa.
# It also shows you which peers are connected on which port.
# Wildcards are accepted for -p and -P options.
#
#  USAGE
# 
## show a listing of all open ports and their corresponding PIDs
# root@Pluto # ./port_check2.ksh -a
# 
## Which process has port 21 open?
# root@Pluto # ./port_check2.ksh -p 21
# PID     Process Name and Port
# _________________________________________________________
# 401     /usr/sbin/inetd 21
#         sockname: AF_INET6 ::  port: 21
# _________________________________________________________
# 6944    in.ftpd 21
#         sockname: AF_INET6 ::ffff:10.14.140.11  port: 21
#         sockname: AF_INET6 ::ffff:10.14.140.11  port: 21
# _________________________________________________________
#
## Which ports does PID 401 have open?
# root@Pluto # ./port_check2.ksh -P 401
# PID     Process Name and Port
# _________________________________________________________
# 401     /usr/sbin/inetd
#         sockname: AF_INET6 ::  port: 21
#         sockname: AF_INET6 ::  port: 23
#         sockname: AF_INET 0.0.0.0  port: 42
#         sockname: AF_INET 0.0.0.0  port: 514
#         sockname: AF_INET6 ::  port: 514
#         sockname: AF_INET6 ::  port: 513
#         sockname: AF_INET 0.0.0.0  port: 512
#         sockname: AF_INET6 ::  port: 512
#         sockname: AF_INET 0.0.0.0  port: 512
#         sockname: AF_INET 0.0.0.0  port: 517
#         sockname: AF_INET 0.0.0.0  port: 540
#         sockname: AF_INET6 ::  port: 79
#         sockname: AF_INET6 ::  port: 37
#         sockname: AF_INET6 ::  port: 37
#         sockname: AF_INET6 ::  port: 7
#         sockname: AF_INET6 ::  port: 7
#         sockname: AF_INET6 ::  port: 9
#         sockname: AF_INET6 ::  port: 9
#         sockname: AF_INET6 ::  port: 13
#         sockname: AF_INET6 ::  port: 13
#         sockname: AF_INET6 ::  port: 19
#         sockname: AF_INET6 ::  port: 19
#         sockname: AF_INET 0.0.0.0  port: 7100
#         sockname: AF_INET6 ::  port: 515
#         sockname: AF_INET 0.0.0.0  port: 6112
#         sockname: AF_INET 0.0.0.0  port: 32778
#         sockname: AF_INET 0.0.0.0  port: 665
#         sockname: AF_INET6 ::  port: 665
#         sockname: AF_INET 0.0.0.0  port: 32779
#         sockname: AF_INET 0.0.0.0  port: 13782
#         sockname: AF_INET 0.0.0.0  port: 13724
#         sockname: AF_INET 0.0.0.0  port: 13783
# _________________________________________________________
# 
#
i=0
while getopts :p:P:a opt
do
case "${opt}" in
p ) port="${OPTARG}";i=3;;
P ) pid="${OPTARG}";i=3;;
a ) all=all;i=2;;
esac
done
if [ $OPTIND != $i ]
then
echo >&2 "usage: $0 [-p PORT] [-P PID] [-a] (Wildcards OK) "
exit 1
fi
shift `expr $OPTIND - 1`
if [ "$port" ]
then
# Enter the port number, get the PID
#
port=${OPTARG}
echo "PID\tProcess Name and Port"
echo "_________________________________________________________"
for proc in `ptree -a | awk '/ptree/ {next} {print $1};'`
do
result=`pfiles $proc 2> /dev/null| egrep "port: $port$"`
if [ ! -z "$result" ]
then
program=`ps -fo comm= -p $proc`
echo "$proc\t$program\t$port\n$result"
echo "_________________________________________________________"
fi
done
elif [ "$pid" ]
then
# Enter the PID, get the port
#
pid=$OPTARG
# Print out the information
echo "PID\tProcess Name and Port"
echo "_________________________________________________________"
for proc in `ptree -a | awk '/ptree/ {next} $1 ~ /^'"$pid"'$/ {print $1};'`
do
result=`pfiles $proc 2> /dev/null| egrep port:`
if [ ! -z "$result" ]
then
program=`ps -fo comm= -p $proc`
echo "$proc\t$program\n$result"
echo "_________________________________________________________"
fi
done
elif [ $all ]
then
# Show all PIDs, Ports and Peers
#
echo "PID\tProcess Name and Port"
echo "_________________________________________________________"
for proc in `ptree -a | sort -n | awk '/ptree/ {next} {print $1};'`
do
out=`pfiles $proc 2>/dev/null| egrep "port:"`
if [ ! -z "$out" ]
then
name=`ps -fo comm= -p $proc`
echo "$proc\t$name\n$out"
echo "_________________________________________________________"
fi
done
fi
exit 0
