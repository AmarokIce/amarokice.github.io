---
layout: post
type: blog
title: Java/Kotlin图像裁切
date: 2023/12/15 16:38:49
author: Amaruq·Illaujaq
categories: [Java, Kotlin]
tags: [Java, Kotlin, 图像处理]
pin: false
---

今天被朋友委托编写一个图像裁切程式，自动化处理一些聚合图像（如BitMap Textures）。原本是想套Python，但是朋友电脑没有Python，也没有安装的打算。我们都是Java玩家，因此我决定以Java的方式处理它。
当然，作为Kotlin忠实玩家，这里我选用了Kotlin作为开发语言。
原本我期望在Graphics2D中完成裁切，但是无论我怎么操作，都只能得到一团黑幕。最后使用Param Overload的形式解决了。
上代码：  
```kotlin
val fileStream = Files.newInputStream(file.toPath())
val imageStream = ImageIO.createImageInputStream(fileStream)
val reader = ImageIO.getImageReaders(imageStream).next()
reader.setInput(imageStream, true)
val param = reader.defaultReadParam
param.setSourceRegion(Rectangle(baseX, baseY, imageBaseX, imageBaseY))
val outputImage = reader.read(0, param)

ImageIO.write(outputImage, "PNG", File(fileOutput, "$id.png"))
imageStream.close()
fileStream.close()
```
