---
layout: post
type: blog
title: 编程美学：利用指针合并代码处理
date: 2026/09/18 17:12:48.7222948
author: Amaruq·Illaujaq
categories: [编程美学]
tags: [Dlang]
pin: true
---

我见过很多初入计算机的初学者跟着老一辈写法，会写这样的代码：

```d
import std.stdio : writefln;

void main(string[] args) {
  int x, y;
  for(x = 0; x < 3; x++) for (y = 0; y < 3; y++) writefln("x = %d, y = %d", x, y);
}
```

在 C 语言定义出 `for` 声明部分也被纳入局部变量之前，这种方式看起来没有任何问题。不过，我们应该还是更乐于看到这样的代码：

```d
import std.stdio : writefln;

void main(string[] args) {
  for(int x = 0; x < 3; x++) for (int y = 0; y < 3; y++) {
    writefln("x = %d, y = %d", x, y);
  }
}
```

为了规范，`for` 可能会被拆分成两行。但如果有 `if` 的需求，这边的缩进看起来会很爆炸：

```d
import std.stdio : writefln;

void main(string[] args) {
  for(int x = 0; x < 3; x++) {
    for (int y = 0; y < 3; y++) {
      if (x == 0 || y == 0) {
        continue;
      }
      writefln("x = %d, y = %d", x, y);
    }
  }
}
```

这让我在刚喝完咖啡的时候写出了一个几乎变态的方式：

```d
import std.stdio : writefln;

void main(string[] args) {
  for (int x = 0, y = 0; x < 9; x += (y == 8 ? 1 : 0), y = (++y == 9 ? 0 : y)) {
    if (x == 0 || y == 0) {
      continue;
    }
    writefln("x = %d, y = %d", x, y);
  }
}
```

虽然小山矮了，但屎山高了。  
但很幸运，无论是 C 语言还是 D 语言，指针是我们最强的武器，使得代码看起来可以更可靠一些：

```d
import std.stdio : writefln;

void main(string[] args) {
  for (int x = 0, y = 0; x < 9; doubleIntegerForeach(&x, &y)) {
    writefln("x = %d, y = %d", x, y);
  }
}

void doubleIntegerForeach(int *x, int *y, int limit) {
  boolean flag = *y == limit;
  *x += flag ? 1 : 0;
  *y = flag ? 0 : *y + 1;
}
```

很多时候，一套方法无法被拆分，最大的原因就在于可变型局部变量。  
这部分变量传递后可能需要不停的变动，并且其变动频率远超于常规的方法传递。虽然 `safe` 编程听起来美好且可靠，但也会让代码又臭又长。简短，直达且可读的变得安全的重要前提之一。

