---
layout: post
type: blog
title: DLang多线程之spawn
date: 2024/11/04 23:21:00
author: Amaruq·Illaujaq
categories: [咩狼博客, 折腾]
tags: [DLang, 技术]
pin: false
---

# 碎碎念
最近正在研究使用 DLang 编写一些实用小工具，在 PineappleScript 成型之前都得靠 DLang 作为日用维护系统的脚本了。

但很显然，我很快就遇到了并发需求项目，经过一番折腾并表达了对 Jvm 语言的思乡之情之后最终解决了这个问题，就记录一下喽。

# 关于 DLang 并发
DLang 有对多线程与协程的支持，DLang 的协程其实相当好理解，但多线程就有意思了。在 DLang 中，静态是强调绝对本地化的，也就是静态函数中使用的内容必须是编译时可见（参数除外）。而多线程的时候通常也是强调这一点，因此推荐使用静态函数作为并发函数，本文也会使用静态函数作为示例。

DLang 中的并发分为并行迭代（`parallelism`，`parallel`，`map&amap`），委托（`task`）以及信道通讯（`spawn`）。这些并发方法均具有委托性质。本文主要针对通常会被使用的信道通讯（Message Passing Concurrency）进行演示。

# 概念
不要着急看代码，至少先有个概念。最最少你也得知道，**编写并发需要导入包 std.concurrency 。**

信道通讯将会分为一个总线（主线程）和若干子线（并发线程）。通过函数 `spawn` 进行委托。委托后返回线程标识符 `Tid`。

`Tid` 的拓展函数 `send` 可以传送任意数据到目标线程。线程中可以通过 `thisTid` 获取当前的线程标识符，在子线程中也可以使用 `ownerTid` 获取主线程的标识符，用于传递消息。

首先先看一个简单的并发例子：

```d
import std.stdio;
import std.concurrency;

static void threadFunction(string varString)
{
    writeln(varString);
}

void main()
{
    spawn(&threadFunction, "Hello world from sub-thread!");
    writeln("Hello world from main thread")
}
```

随后将会看到我们期望的两段话。理所当然，不是咩？

很好，那么让我们再看看讯息传递的例子：

```d
import std.stdio;
import std.concurrency;
import std.Thread;

static void threadFunction()
{
    while(true) {
        receive(
            (string message) { writeln(message); }
        );
    }
}

void main()
{
    Tid tid = spawn(&threadFunction);
    Thread.sleep(500);
    tid.send("Hello world!");
}
```

由于 `while` 的条件是 `true`，这一段程序不会自己退出。不过别着急强制杀死，`Thread.sleep` 这个喜闻乐见的用于延长业务运行周期迫使用户交钱来获取最快速度的顶级函数的效果之后就可以看到我们的 "Hello world!" 了。

但需要注意，**并发时不可以传入指针**，指正指向的地址是本地的变量，而跨线程访问会有安全隐患，因此 DLang 会直接拒绝编译传入**非原子**指针。此处必须存在原子操作才可安全传入指针。
