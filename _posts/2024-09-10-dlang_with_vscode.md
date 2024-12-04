---
title: DLang+VSCode 快速上爪指北
author: icewolf
date: 2024-09-10 18:30:00 +0800
categories: [咩狼博客, 折腾]
tags: [DLang]
pin: true
---

D 语言一直是一门不温不火但又相当优雅，集成了 C++， Java，C# 与 Python 的语言特性，获取它们的优点，解决了很多编程时的痛苦之处。

但也正因为它的不温不火，导致它的第三方库大多年久失修，官方文档上也有一些 VSCode 开发方面没有讲清的地方。再折腾了一天之后我决定记录成一篇文章。

首先按照官方文档为 VSCode 安装插件 `D Programming Language (code-d)` 。

如果你从未安装过 D 语言，那么在安装这个插件之后应该会自动跳转到 DMD 下载界面。如果什么也没有发生，你可以手动过去。[点我前往](https://dlang.org/download.html)

不知道下载哪个？如果你是一个新手，不愿意折腾 GCC 一类的 C 语言社区环境，那么使用 DMD 是极佳的。

随后，找个好地方。然后打开你的终端（或 cmd），输入 `dub init`(或者 `dub init 你的项目名称`, 尽量不要大写/中文字符) 进行项目初始化。你可以全部回车，直到向导结束。现在，使用 VSCode 打开项目。

为你的 VSCode 配置 code-d 与 server-d。当然，如果你不在乎它们的位置，那就让 VSCode 的插件自己下载就好，你需要做的就是去泡一杯咖啡然后等它自己编译。

一切都很好。现在，我们进入 Debugging 选项卡（如果你不知道是什么，Ctrl Shift D 进入），选择创建 launch.json，选择创建 DuB Debugging。

现在，你的 `./.vscode/launch.json` 的内容看起来应该是这样：

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "code-d",
            "request": "launch",
            "dubBuild": true,
            "name": "Build & Debug DUB project",
            "cwd": "${command:dubWorkingDirectory}",
            "program": "${command:dubTarget}"
        }
    ]
}
```

如果你找不到，可能是因为你已经打开了 .d 文件。保持选项卡中没有文件被打开，然后再试一次。

接下来我们配置 `tasks.json`。可以手动创建或使用 VSCode 的指令创建。然后复制下面的内容黏贴过去：

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "dub build",
			"type": "dub",
			"run": false,
			"compiler": "$current",
			"archType": "$current",
			"buildType": "$current",
			"configuration": "$current",
			"problemMatcher": [
				"$dmd"
			],
			"group": "build",
			"detail": "dub build --compiler=C:\\D\\dmd2\\windows\\bin\\dmd.exe -a=x86_64 -b=debug -c=application"
		}
    ]
}
```

注意: `detail` 处的 dmd.exe 路径改为你的 dmd 安装路径。

接着回到 `launch.sjon`, 为刚配置的 `configurations` 增加一条：

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "code-d",
            "request": "launch",
            "dubBuild": true,
            "name": "Build & Debug DUB project",
            "preLaunchTask": "dub build",
            "cwd": "${command:dubWorkingDirectory}",
            "program": "${command:dubTarget}"
        }
    ]
}
```

大功告成！现在我们在 `./source/app.d` 中写点什么：

```d
import std.stdio;

void main()
{
	writeln("Hello D World!");
}

```

现在，你可以使用 VSCode 的运行与调试来执行你的代码了！大功告成！