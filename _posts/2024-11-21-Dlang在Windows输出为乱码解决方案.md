---
layout: post
type: blog
title: DLang 在 Windows 控制台中输出乱码的解决方案
date: 2024/11/21 10:00:00
author: icewolf
categories: [咩狼博客, 折腾]
tags: [DLang, 技术]
pin: true
---

因为 Windows 的控制台默认并不是 UTF-8, 但 DLang 强调使用 UTF-8 格式作为文件编码, 同时我们很大程度上并不希望使用 UTF-8 以外的编码，因此我们需要修改控制台编码。  
修改自身操作系统一劳永途的方法很多，网上都能找到，这里只讲嵌入代码中的解决方案方便适配到任何地方。  
首先要知道的是在 DLang 中想要导入 Windows 包, 应该是从 `core.sys` 下寻找 `core.sys.windows.windows`。

```d
import std.stdio;
import core.sys.windows.windows : SetConsoleOutputCP, CP_UTF8;

void main() {
    SetConsoleOutputCP(CP_UTF8);

    writeln("你好世界！");
}

```
