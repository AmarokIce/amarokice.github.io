---
layout: post
type: blog
title: Gravatar无法访问的完美解决方针：Cravatar
date: 2023/04/01 11:25:00
author: icewolf
categories: [咩狼博客, 折腾]
tags: [日常, 博客, 技术]
pin: false
---

今天又是建设站点基本内容的一天，在老站点的时期我就对Gravatar连接过慢感到不满了。因此加入了一些插件，手搓图像优化来制作手动上传，但是这次服务器并不大，Gravatar可能是我唯一的解决方案？
看似是这样的，因此我开始寻找Gravatar镜像源代替它。但是治标不治本——更换头像依然是个难题。好吧，那么有什么能够完美解决这个问题的解决方针？
Gravatar被WordPress收购了，这引起了我的注意。WordPress是很棒的开源博客站，著名的五分钟建站，而且WordPress有**大陆站点**，大陆站会不会提供一些好用的东西？
很好，我知道了。由大陆站LitePress驱动的自由公共头像站源Cravatar正是我需要的！这是一个完全兼容Gravatar的源，因此如果你曾经使用了Gravatar保存你的头像也无需担心，完全能够兼容！
只需要简单的注册一个账号，绑定邮箱，那么任何调用Cravatar（或Gravatar）的站点都能访问你的头像！
如果你想在你的站点使用，将Gravatar的站源定向为 `https://cravatar.cn/avatar/` 即可！

> 咩狼的站点的邮箱功能仅用于绑定头像，不会公开或分发SPAM。

完全没有使用过Cravatar（或Gravatar）？非常简单，简单到不需要教学！
注：`Gravatar In CN` 只是中文站，你可能依然需要梯子或者别的什么才能上去。

[Cravatar](https://cravatar.cn/)
[Gravatar](https://gravatar.com/)
[Gravatar In CN](https://cn.gravatar.com/)
