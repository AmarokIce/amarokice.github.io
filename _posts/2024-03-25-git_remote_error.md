---
title: Git疑难杂症-权限令牌错误 remote-Permission to xxxxx.git denied to xxx fatal - The requested URL returned error - 403
date: 2024/03/25 09:33:00
author: icewolf
categories: [咩狼博客, 折腾]
tags: [技术, Git]
pin: false
---

在我将我的代码转入团队后，即便我为我的账号分配了 Admin ，我依然无法提交代码。但是奇怪的是，如果我使用令牌验证，就可以。
错报如下：
```shell
remote: Permission to xxxxx.git denied to xxx.

fatal: unable to access 'https://github.com/xxx.git/': The requested URL returned error: 403
```

好嘛，难道要把团队的仓库挪回个人？Bing了很久才偶遇一个解决方案，特此记录一下。

首先进入项目根目录，打开隐藏文件夹 `.git` ，找到无后缀名文档 `config` ，打开。
在 `[remote "origin"]` （取决于你的本地分支名称） 下，找到 `url` 。

里面原本的内容应该是 `https://github.com/所有者名称/项目名称.git` , 改成下述形式即可： `https://推送者名称@github.com/所有者名称/项目名称.git`

再次 push ，成功。收工睡觉喽——
