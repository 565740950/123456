title: Frp可用服务器记录
author: 林林总总
abbrlink: '28364060'
tags:
  - FRP
  - 内网穿透
categories:
  - 记录
date: 2020-02-22 22:39:00
---
记录近期互联网收集可用Frp服务器
<!--more-->


###配置文件
``` bash
[common] 
server_addr = hk1.frp.ioiox.com 
server_port = 7007 
token = www.ioiox.com 
[11833ssh] 
type = tcp 
local_ip = 127.0.0.1 
local_port = 11833 
remote_port = 41242 
```

香港服务器地址: hk1.frp.ioiox.com 
香港服务器地址: hk2.frp.ioiox.com 
日本服务器地址: jp1.frp.ioiox.com 
日本服务器地址: jp2.frp.ioiox.com 
美国服务器地址: us1.frp.ioiox.com 
端口: 7007 
Token: www.ioiox.com 
当前 frps 版本为 0.31.2 客户端 frpc 
请勿使用过低的版本. 提供 80,443,4000-50000 tcp 端口. 不提供免费二级域名,请自行准备域名. 

``` bash
[common] 
server_addr = frp.2t.work 
server_port = 7000 
[113ssh] type = tcp 
local_ip = 127.0.0.1 
local_port = 11599 
remote_port = 12599 
```

pr 端口12022