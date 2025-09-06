---
layout: post
type: blog
title: 使用文件引索作为共享网盘与Maven仓库！
date: 2023/09/27 17:21:00
author: Amaruq·Illaujaq
categories: [咩狼博客, 折腾]
tags: [Java, Gradle, 技术]
pin: false
---

有时候我会为Minecraft的开发或者一般项目开发而设计一些Lib，但是我没有很好的仓库存储它们。通常我会发布到Github Package，但是Github Package不便于其他人拉取，并且很多时候会引起Gradle不悦而拉取抽风。Jitpack会在远端构建，有时候会出一些奇怪的问题或者因为一些年久失修的源服务器无法访问而无法构建（本地可以借助本地仓库来取代年久失修的项目，因此是正常构建）。
如果要推送到Maven中央仓库，又得经过一波折腾，相比之下使用自己的服务器搭建私有仓库是最好的选择。
Nexus是最受欢迎的选择，而Artifactor的出现大规模取代了Nexus的热度。但是经过一波操作之后发现——这玩意是真难用。且不提特定版本下Gradle不悦而抽风导致无法推送，它对性能的开销也不小。
文件引索式访问应该是不错的选择，它闻起来就像是在浏览器里输入 `file:///C:/` 一样。它就像FTP或者毫无装饰的共享网盘——借FTP和MavenPullingToLocal的力量就可以打包一套依赖发送到服务器，这样就能直接借助这套功能完成！
同样的，也可以使用Github或者Gitee等公共Git网站托管，但是我更喜欢自己折腾一下CentOS。


# 使用SimpleHTTPServer
Linux中使用SimpleHTTPServer就可以做到这样的效果，而这是一套Python程式，因此先安装Python环境：
```linux
#~> yum install python39 
```
注意：不要安装3.11，最新版本还不具备足够的稳定性和pip！
接下来就是非常简单的内容，通过pip拉取SimpleHTTPServer，然后指定端口，启动！
```linux
#~> python3 -m pip insall simple-http-server

// 开放到8000端口，目前cd在哪就是从往哪开
#~> python3 -m http.server 8000
// python -m SimpleHTTPServer 8000   非Python3环境用这个

// 后台托管
#~> python3 -m http.server 8000 &

// 完全后台托管
#~> nohup python -m http.server 8000 &
```

此时访问http://127.0.0.1:8000就能看到自己的文件引索了！
借助Socket还可以让SimpleHTTPServer开放你的站点！

# 在Maven中使用引索
推送到本地后把Maven套件拷贝到服务器，然后开启SimpleHTTPServer，接着只需要在Maven里加入你的地址即可！
```groove
// Other
maven {
    url 'http://127.0.0.1:8000/'
}
```

例如我的仓库：http://maven.snowlyicewolf.club/

