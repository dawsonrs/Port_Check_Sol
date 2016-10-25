# Port_Check_Sol

maps PIDS to ports and vice versa for Solaris
Handy when LSOF is not available

USAGE:
run by hand as shown in the 3 examples below
 
show a listing of all open ports and their corresponding PIDs
 root@TestServer # ./port_check2.ksh -a
 
Which process has port 21 open?
 root@TestServer # ./port_check2.ksh -p 21
 PID     Process Name and Port
 _________________________________________________________
 401     /usr/sbin/inetd 21
         sockname: AF_INET6 ::  port: 21
 _________________________________________________________
 6944    in.ftpd 21
         sockname: AF_INET6 ::ffff:10.14.140.11  port: 21
         sockname: AF_INET6 ::ffff:10.14.140.11  port: 21
 _________________________________________________________

Which ports does PID 401 have open?
 root@TestServer # ./port_check2.ksh -P 401
 PID     Process Name and Port
 _________________________________________________________
 401     /usr/sbin/inetd
         sockname: AF_INET6 ::  port: 21
         sockname: AF_INET6 ::  port: 23
         sockname: AF_INET 0.0.0.0  port: 42
         sockname: AF_INET 0.0.0.0  port: 514
         sockname: AF_INET6 ::  port: 514
         sockname: AF_INET6 ::  port: 513
         sockname: AF_INET 0.0.0.0  port: 512
         sockname: AF_INET6 ::  port: 512
         sockname: AF_INET 0.0.0.0  port: 512
         sockname: AF_INET 0.0.0.0  port: 517
         sockname: AF_INET 0.0.0.0  port: 540
         sockname: AF_INET6 ::  port: 79
         sockname: AF_INET6 ::  port: 37
         sockname: AF_INET6 ::  port: 37
         sockname: AF_INET6 ::  port: 7
         sockname: AF_INET6 ::  port: 7
         sockname: AF_INET6 ::  port: 9
         sockname: AF_INET6 ::  port: 9
         sockname: AF_INET6 ::  port: 13
         sockname: AF_INET6 ::  port: 13
         sockname: AF_INET6 ::  port: 19
         sockname: AF_INET6 ::  port: 19
         sockname: AF_INET 0.0.0.0  port: 7100
         sockname: AF_INET6 ::  port: 515
         sockname: AF_INET 0.0.0.0  port: 6112
         sockname: AF_INET 0.0.0.0  port: 32778
         sockname: AF_INET 0.0.0.0  port: 665
         sockname: AF_INET6 ::  port: 665
         sockname: AF_INET 0.0.0.0  port: 32779
         sockname: AF_INET 0.0.0.0  port: 13782
         sockname: AF_INET 0.0.0.0  port: 13724
         sockname: AF_INET 0.0.0.0  port: 13783
