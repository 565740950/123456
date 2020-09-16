title: 记录V2ray搭建
author: 林林总总
abbrlink: 1d80bfd
tags:
  - 翻墙
  - V2ray
categories:
  - 记录
date: 2020-02-22 22:14:00
---


###一键安装v2ray 脚本
``` bash
bash <(curl -L -s https://install.direct/go.sh)
```
###手动安装步骤如下：
1] 下载并解压V2Ray程序
首先下载V2Ray的发行版程序，解压压缩包并查看目录中的文件。
``` bash
wget https://github.com/v2ray/v2ray-core/releases/download/v3.24/v2ray-linux-64.zip
```
解压
``` bash
unzip v2ray-linux-64.zip
cd v2ray-v3.24-linux-64
ll -a
```
###分析
其中v2ray和v2ctl是V2Ray的主程序和控制程序；geoip.dat和geosite.dat是程序所需要数据文件；systemd和systemv两个目录中包含了用于生成服务的文件。为了可以使用预先设置好的服务文件，需要把文件移动至正确位置。
2] 将文件移动至正确位置
根据V2Ray的安装脚本，会自动在如下目录生成如下文件：

    /usr/bin/v2ray/v2ray
    /usr/bin/v2ray/v2ctl
    /etc/v2ray/config.json
    /usr/bin/v2ray/geoip.dat
    /usr/bin/v2ray/geosite.dat

###于是现在要做的就是将文件移动至相应位置：

``` bash
 mkdir /usr/bin/v2ray
 cp v2ray /usr/bin/v2ray/v2ray
 cp v2ctl /usr/bin/v2ray/v2ctl
 cp geoip.dat /usr/bin/v2ray/geoip.dat
 cp geosite.dat /usr/bin/v2ray/geosite.dat
 mkdir /etc/v2ray/
 cp vpoint_vmess_freedom.json /etc/v2ray/config.json
```
最后一条命令是将当前的vpoint_vmess_freedom.json配置文件复制到指定位置，并修改其为config.json。由于V2Ray是不区分服务端和客户端的，同一个程序可以配置成服务器也可以配置成客户端，程序目录中的vpoint_vmess_freedom.json一般用于配置服