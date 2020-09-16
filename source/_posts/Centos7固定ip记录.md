title: Centos7固定ip记录
author: 林林总总
abbrlink: ce8a6ea2
date: 2020-02-26 21:35:45
tags:
---
### centos7设置固定ip 记录

1.进入 network-scripts文件
2.
````bash
cd /etc/sysconfig/network-scripts/  
````
2.修改ifcfg-eth0 文件
````bash
DEVICE=eth0
TYPE=Ethernet 
ONBOOT=yes 改为yes
NM_CONTROLLED=yes 
BOOTPROTO=static   #指定为静态IP 
DNS1=114.114.114.114 
IPADDR=192.168.238.128   #指定ip地址 
NETMASK=255.255.255.0  #子网掩码 9 GATEWAY=192.168.1.1  #网关
````
3.使用service network restart 重启服务 
如果重启网络服务之后没有全是ok提示重启网卡提示
Bringing up interface eth0: Device eth0 does not seem to be present,delaying initialization. [FAILED]:

这是因为克隆的机器没有正确的mac,UUID信息冲突导致
1.首先将 /etc/udev/rules.d/70-persistent-net.rules
文件删除rm -rf 
2.然后将网卡配置文件 /etc/sysconfig/network-scripts/ifcfg-eth0的uuid和hwaddr这两行删除dd 
3.重启虚拟机 init 6 
