title: FRP使用教程
tags:
  - 翻墙
categories:
  - 记录
abbrlink: 783fd013
author: 林林总总
date: 2020-02-21 13:59:00
---
1. 下载 
```
wge thttp://frp.2t.work/frp_0.21.0_linux_amd64.tar.gz 
```
<!---more--->
2. 解压 
```
tar -zxvf frp_0.21.0_linux_amd64.tar.gz
```
3. 目录
``` 
cd frp_0.21.0_linux_amd64 
```
4. 后台
```  
screen -S frpc 
```
5. 唤醒 
```
screen -r frpc 
```
6. 启动 
```
./frpc -c ./frpc.ini 
```
7. 编辑方法 
```
vim frpc.ini 
```

8.配置文件

```
[common] 
server_addr = frp.2t.work 
server_port = 7000 
[web] 
type = http 
local_port = 80 
custom_domains = *.frp.2t.work（*自定义） [ssh] 
type = tcp 
local_ip = 127.0.0.1 
local_port = 22 
remote_port = （请查看服务器状态后从10000-20000选一个未被使用的端口） 
```