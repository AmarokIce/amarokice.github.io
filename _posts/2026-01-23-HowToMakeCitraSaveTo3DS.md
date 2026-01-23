---
layout: post
type: blog
title: 如何迁移 Citra 存档至 3DS 实体机
date: 2026/01/23 10:00:00
author: Amaruq·Illaujaq
categories: [日常]
tags: [博客]
pin: true
---

自从我的 GBA SP 永远停留在启动画面那一刻之后，我就一直很想换一台 3DS 来再玩一遍复刻宝石系列，但是众所周知的是，3DS 完全就是个保值的砖头。抽象的市场价格让我始终无法下定决心。而最近我终于决心下单了一台二手的日月限定款 New3DSLL，至少我觉得算是很值的一款。

暂缓心动，还有一件事要做：在模拟器 `Citra` 上玩的存档需要拷贝到 3DS 上，毕竟不能让我每天心心念念的宝可梦们就这么随着数据消逝殆尽。

首先需要注意，这里采用的方式是透过 [`CheckPoint`](https://github.com/BernardoGiordano/Checkpoint) 软件重置存档的方式。

New3DS 中可以直接通过远端通讯的方式连接到 Windows，不需要拆卸 SD 卡，不需要麻烦。但是正式开始之前，我们还需要启动一下老式 SMB 设定——这是很多人无法连接到 3DS 的重要原因。

在 Windows 开始菜单中搜索 “Windows 功能”，选中最上面的 “开启或关闭 Windows 功能”，打开 “SMB 1.0/CIFS 档案支持”。

!()[https://raw.githubusercontent.com/AmarokIce/amarokice.github.io/refs/heads/master/assets/img/post/WindowsCupabilities.png]

如果曾经没有打开这项功能，那么现在点击确定会提示重启。是的，这是必须重启的。

稍后，让我们打开 3DS 的设定，进入 “资料管理”，选择 “在电脑上管理 microSD 卡”。按照提示继续。

最后，确定你的 Windows 与 3DS 的为同一项 WiFi，你的 3DS 没有通电（部分人反馈通电会导致无法连接成功），同时 Windows 没有开启代理。我们打开 Windows 网路。如果曾经没有管理过 Windows File Explorer 的话，那么你的左侧侧边栏应该能够找到。这项功能在部分 Windows 上称作网上邻居。

打开你的 3DS,进入 `/3ds/Checkpoint/saves`，找到你的游戏——如果你创建过备份的话。建议任意创建一份备份后再来操作，这样可以节省很多麻烦。  
打开 `Citra`，右键游戏，选择进入档案文件夹。拷贝里面的全部内容。  
回到刚从的存档文件夹，打开任意名称文件夹，拷贝你的存档进去。

最后，覆盖存档，大功告成！

看着我的宝可梦们回到身边的感觉真不错，我得继续抚养我的宝可梦们了。
