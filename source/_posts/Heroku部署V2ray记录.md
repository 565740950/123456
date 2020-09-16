title: Heroku部署V2ray记录
author: 林林总总
abbrlink: dae4191f
tags:
  - 翻墙
  - V2ray
categories:
  - 记录
date: 2020-02-26 22:13:00
---
思路
虽然网上已经有了现成的在 Heroku 搭建 V2Ray 的教程，但大多数都是东抄西搬来的内容。此外，根据一些人反馈的情况来看，在 Heroku 上部署 V2Ray 后帐户会被“秒封”。仔细看了这些用于 Heroku 搭建 V2Ray 的 Dockerfile 后，找出了可能封号的原因，大致三种情况。

所选用系统过于庞大，几近 60MB，占用了过多的空间；
同时运行了 V2Ray 和 Caddy，占用大量资源；
用户长时间大流量连接单个应用，超出限额·引起管理员怀疑。
针对这些问题，提出出了三个优化的方法。

使用 Alpine Linux 在 Heroku 部署 V2Ray；
让 V2Ray 监听 0.0.0.0，不通过 Caddy 反向代理；
部署多个应用，配置 V2Ray 特有的，避免用户长时间大流量连接单个应用。 于是用四行代码解决了 Dockerfile… 调用 V2Ray 官方安装脚本，部署时自动下载安装最新的 V2Ray，无需手动定义版本号。
部署
本镜像现已开源至博主的 GayHub，欢迎 Star+Fork： 一键部署

部署成功
打开 Heroku 分配的 Endpoint，出现 Bad Request，可以大致判断 V2Ray 已经在运行。 博主一共部署了两个应用，配置了 V2Ray 的负载均衡，这里给出一个配置示例。

````bash
{
  "inbounds": [
    {
      "port": 1080,
      "listen": "127.0.0.1",
      "protocol": "socks",
      "sniffing": {
        "enabled": true,
        "destOverride": ["http", "tls"]
      },
      "settings": {
        "auth": "noauth",
        "udp": false
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "vmess",
      "settings": {
        "vnext": [
          {
            "address": "1st.herokuapp.com",
            "port": 443,
            "users": [
              {
                "id": "40c98649-847b-412c-a229-5e68ca9985eb",
                "security": "auto",
                "alterId": 64
              }
            ]
          },
          {
            "address": "2nd.herokuapp.com",
            "port": 443,
            "users": [
              {
                "id": "40c98649-847b-412c-a229-5e68ca9985eb",
                "security": "auto",
                "alterId": 64
              }
            ]
          }
        ]
      },
      
    "streamSettings": {
````
      
      
###经过测试，本地电信非高峰时段速度在 20Mbps 左右，应急使用是足够了。

### 进阶

- 套上 ClouFlare
可惜电信国际出口晚上炸成了狗，Heroku 到中国的速度便连电话线都不如了。
偶然发现（其实早就知道了）Heroku 可以给应用绑定域名，所以给 Herokuapp 套上 CloudFlare，或许情况会好很多。
可怜的 CloudFlare（

- 有一个域名
值得一提的是，Heroku 需要先添加一张信用卡才能绑定域名。经过博主测试，银联信用卡成功绑定，并且会被识别为 Discover。
随后在应用中添加要绑定的域名，在 CloudFlare DNS 管理页中添加 Heroku 给出的对应 CNAME 地址，点亮 CloudFlare 云朵，即可完成绑定。
为了提高门槛防止 CloudFlare 被玩坏，此处不给出过于详细的教程。
没有信用卡和域名
但是也有一部分人没有信用卡和域名，但是也想白女票 CloudFlare 加速的，为了方便这一部分人，博主也想出来一个办法…
好在 CloudFlare 最近推出了他们的 Serverless 应用 CloudFlare Workers，Workers 使用的语言是 Node.js，借助 Workers，我们可以利用它反向代理部署的 Heroku 应用。

为了防止被玩坏，这里略去具体部署过程，只贴出反向代理的代码
````bash
addEventListener(
  "fetch",event => {
     let url=new URL(event.request.url);
     url.hostname="应用名称.herokuapp.com";
     let request=new Request(url,event.request);
     event. respondWith(
       fetch(request)
     )
  }
)
````

部署完成后，将 Heroku 分配的链接改为 CloudFlare Workers 分配的应用链接即可～～