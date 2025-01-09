---
layout: post
type: blog
title: Java/Kotlin对Png文件大小进行硬边缩放（点阵无损缩放）
date: 2023/06/14 21:41:00
author: icewolf
categories: [咩狼博客, 折腾]
tags: [Java, Kotlin, 图像处理]
pin: true
---


很早之前就在研究图像处理，因为这个项目是个Java项目，当时尝试了Java和Kotlin，一直在找这样的方法，甚至用了一些库，但是打包一个库进去多少不太好，就不得不Bing了一下。然而Bing提供的结果也没多靠谱，缩放的极其难看，也达不到我期望的需求。
但是我找到了Java的图像处理类AffineTransformOp，问题解决，这边随爪记录一下。

```java
// 假设我们已经传入图片流到缓存BufferedImage，存储在sourceImg变量中。

// 缩放的倍率。
int scale = 2;

// 申明AffineTransformOp，
AffineTransformOp op = new AffineTransformOp(AffineTransform.getScaleInstance(scale, scale), null);

// 对图片进行缩放
BufferedImage img = op.filter(sourceImg, null);
```

2023/7/2 更新
上面的方法在一些情况下不是很好用，比如目标文件的尺寸不可知，如果想做和PS Ase那种目标缩放，这里找到了新的方法。
废话不多，上才艺：
```java
BufferedImage remakeSize(int size, BufferedImage img) {
    BufferedImage newImg = new BufferedImage(size, size, BufferedImage.TYPE_INT_ARGB);
    newImg.getGraphics().drawImage(img.getScaledInstance(size, size, Image.SCALE_SMOOTH), 0, 0, null);
    return newImg;
}
```
