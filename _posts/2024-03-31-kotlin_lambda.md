---
layout: post
type: blog
title: Kotlin中Lambda表达式与object表达式
date: 2024/03/31 11:17:14
author: Amaruq·Illaujaq
categories: [Kotlin]
tags: [技术, Kotlin]
pin: false
---

出于某种原因，我一时间忘记如何在 `object` 表达式的 λ 中使用指向父级的 `this` 了，因此我会记录一片文章防止我的脑子里只有凤梨。  
在网上查找了很久，除了复制黏贴的文章之外什么也没找到，最后还是脑子里的凤梨全回到该到的地方才想起来怎么用。  
在Kotlin中灵活使用 Lambda 表达式也是非常重要的，而Kotlin有多重集成API。  
如果你不是一个 Java 的老开发者，也不太了解 Java8 发生啥事，那么你可能不知道 Lambda 是什么，或者说你经常使用，但你不知道它其实就叫 Lambda 。无论如何，这一篇解析将会透彻讲解 Kotlin 的Lambda 。如果你觉得我写的还不错，~~那就让我来 λλ 你的凤梨~~ 记得分享我的文章。

Lambda 本质是一种匿名的代码块传递。首先我们来看一组例子：
```kotlin
open class FunnyClass

class NotFunnyClass {}

fun funnyFunction() {}

var funnyVariable = { i: Int ->
    i + 1
}
```

快问快答！上面四组非常有趣（或者没那么有趣）的例子中哪个是真正的Lambda——  
答案是可变变量 `funnyVariable`！ 此处使用了一个 Lambda 将一个执行代码块传入了变量 `funnyVariable`。那么我们要如何使用 `funnyVariable` ？

```kotlin
var funnyVariable = { i: Int ->
    i + 1
}

val o = funnyVariable(1)
```
如果你有一种疑问：“这和方法有什么区别？”  
事实上 Lambda 的运用不止如此——而将 Lambda 传入对象也是一种精妙的设计！再来看这样的例子：

```kotlin
val data = HashMap<String, (Int) -> Unit>()
```
注意到这和一般的申明 HashMap 有什么不同吗？ 它的值不是一个标准 Object，而是一个Lambda！  
那么我们现在使用这样的data HashMap：

```kotlin
val data = HashMap<String, (Int) -> Unit>()

run {
    data["test"] =  { // 传入参数只有一种时，Kotlin会静默将其申明为 it
        val i = it + 514
        print(i)
    }

    val dat = data["test2"]?.let { // 巧妙的 Lambda Let 会在文章的后面讲到！
        it(114)
    } ?: -1  // 因为 dada 中没有 test2 ，所以此处返回值永远都是 -1
}
```

这在 Java 中要如何实现？好吧，我们需要先实现一个接口来承载方法。

### 内联方法体
与 Java 一样，在调用 Lambda 的时候允许直接传入 Lambda 对象内联方法体，也就是使用 `::Method` 上实例：

```kotlin
fun add(entry: Map.Entry<Int, Int>): Int {
    return entry.key + entry.key
}

val intMap = HashMap<Int, Int>()
intMap[1] = 1
intMap.map(::add).forEach(::print)
```

### 减少性能开销
Kotlin 中使用 Lambda 匿名的本质事实上也是在调用时动态创建一个匿名类作为承载体。不断的实例确实是相当耗费性能的。  
此时一个新的标记登场：`inline`。  
但事实上，我不会推荐在每个地方都打上 `inline` 。因为如果你预期的内连方法体中并没有新的 Lambda 函数参数，在最新的 Kotlin 中，这样的性能开销早已微不足道。  
但是这篇教学依然会向你展示 `inline` 的标记点：

```kotlin
inline fun add(entry: Map.Entry<Int, Int>): Int {
    return entry.key + entry.key
}

val intMap = HashMap<Int, Int>()
intMap[1] = 1
intMap.map(::add).forEach(::print)
```
