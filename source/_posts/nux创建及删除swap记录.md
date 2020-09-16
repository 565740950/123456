title: linux创建及删除swap记录
author: 林林总总
abbrlink: a77e25fd
tags:
  - linux
categories:
  - 记录
date: 2020-02-22 22:41:00
---
在操作centos系统创建swap过程记录。

###创建要作为swap分区的文件:增加1GB大小的交换分区，则命令写法如下，其中的count等于想要的块的数量（bs*count=文件大小）。 

``` bash
$ dd if=/dev/zero of=/root/swapfile bs=1M count=1024
```


###格式化为交换分区文件: 

``` bash
$ mkswap /root/swapfile #建立swap的文件系统
```

###启用交换分区文件: 

``` bash
$ swapon /root/swapfile #启用swap文件
```

###检查swap是否已打开。 

``` bash
$ cat /proc/swaps #或者free命令
```

###使系统开机时自启用，在文件/etc/fstab中添加一行： 

``` bash
$ /root/swapfile swap swap defaults 0 0
```

###卸载删除

``` bash
$ swapoff /swapfile #卸载swap文件 
```

###并修改/etc/fstab文件 #从配置总删除 
rm -rf /swapfile #删除文件