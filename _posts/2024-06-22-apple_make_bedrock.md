---
layout: post
type: blog
title: 折腾心得-黑苹果装机简要报告
author: bedrock
date: 2024-06-22 18:30:00 +0800
categories: [基岩博客, 技术]
tags: [基岩博客]
pin: false
---

# [折腾心得] 2024年黑苹果装机简要报告
**By BEclR0Ck**

## 前言
最近看到了针对 6700XT 等 Navi22 核心系列显卡的驱动支持，算是给黑果加上了根续命稻草。又回想起当时买这张卡的初衷，就决定把黑苹果捡回来了。简要分享下流程吧。

## 配置检查
遗憾的是，近两年电脑的主流配置大部分都无法驱动，而原因出现在显卡上。intel 芯片从 11 代开始就都无法驱动核显，而独显方面，N 卡比较特殊，自从 Apple 和 Nvidia 摩擦后，能免驱的就只有比较老的开普勒架构的 N 卡了，而且只能免驱到 MacOS 11，即使是打补丁，高于 GTX1080 的 N 卡也无法驱动，而在 MacOS 12-14 下驱动 N 卡，则需要安装 Opencore legacy patcher 但也无法加速，所以有条件建议更换 A 卡。 虽然 N 卡在黑苹果下生存比较艰难，但驱动起来相对还是比较容易的。**但如果你的电脑同时叠了 11/12/13 代 + RTX20/30/40 系的双 buff 的话，恭喜你与黑苹果无缘了。**

## U盘制作
简单的刻录在这里就不提了。主要的问题在EFI制作上。这里要感谢 [@JeoJay](https://github.com/JeoJay127) 大佬开发的 [RapidEFI](https://github.com/JeoJay127/RapidEFI-Tool)，你可以用这个工具一键检测你的环境来生成你所需要的 EFI 文件。

根据你自己的配置，轻轻点击就可以生成出你需要的 EFI 了。得到后，用 [DiskGenius](https://www.diskgenius.cn/) 将之前刻录好的U盘内的 EFI 文件夹删除，替换为你自己的 EFI 就可以了。

## 分区
请注意，在你要安装系统的磁盘里，不能存在小于200MB的区，请在WinPE环境下，将Windows的EFI分区扩容至200MB以上，并备份你的Windows引导，避免出现macOS顶号导致Windows无法正常引导的情况比如我。

## 安装
安装之前，还有些**必要工作**要做。

1. 重启电脑，进入你的BIOS，确保以下选项的开关正确，若你的品牌BIOS中没有对应选项可忽略。

| Disable                       | 关闭            | Enable              | 开启       |
| ----------------------------- | --------------- | ------------------- | ---------- |
| Fast Boot                     | 快速启动        | VT-x                | VT-x       | 虚拟化技术 |
| Secure Boot                   | 安全启动        | Above 4G            | 4G以上解码 |
| Serial/COM Port 	串行/COM端口 | Hyper-Threading | 超线程              |
| Parallel Port                 | 并行端口        | Execute Disable Bit | 执行禁用位 |
| CSM                           | 兼容性支持模块  |                     |
| Intel SGX                     | 英特尔SGX       |                     |
| Inter Platform Trust          | 英特尔平台信任  |                     |
| CFG Lock                      | CFG锁           |                     |

更改完成后，保存这些选项，重启电脑，按下主板对应的不同按键来选择启动项，这里选择你刚刚制作好的U盘，若没有其他问题，你会看到这个画面。


1. 选择Install macOS+对应系统代号，我们便可进入安装界面。
2. 选择“磁盘工具”，在里面找到我们提前为系统准备好的分区，抹掉这个分区，格式选择APFS，待操作完成后返回页面。
    > *假设您的磁盘是空的或者数据是已经备份过的,别怪我没提醒。
    {: .prompt-danger }

3. 选择“安装macOS”，同意出现的条款，安装便开始了。中途会重启多次，重启后，请在引导界面选择macOS Installer继续安装系统，在安装期间，常会自动重启3-4遍。安装时间取决于固态硬盘的读写速度，请务必耐心等待。
4. 安装完成后，你会看到安装向导，跟着向导一步一步走，能跳过的跳过，直到设置向导完成。这时候，桌面就出现了。

## 后期工作
系统安装后,你可以先喝杯咖啡兴奋会儿，因为很快又有新的任务要做。
1. 先打开终端，输入命令： ` ` sudo spctl –master-disable # 启用macOS安装应用允许任何来源 然后会要求你输入密码，**请注意：密码不会显示在屏幕上。**
2. 继续输入命令： ` ` sudo rm -rf /Library/Preferences/SystemConfiguration/NetworkInterfaces.plist ` ` sudo pmset -b hibernatemode 0 # 内存供电，内存镜像不写入硬盘 ` ` sudo pmset -b acwake 0 # 关闭被同一 iCloud 下的设备唤醒
3. 完成这些操作后，重启，这样系统就处于一个可用状态了。
4. 在完成上述操作后，进入WinPE，找到你的EFI分区，将你U盘内的EFI放进磁盘的EFI分区中，就大功告成了。 
   >  *目的是脱离U盘引导使用macOS。
   {: .prompt-tip }

5. 完成后关机，拔掉U盘后再开机，此时的默认引导已经变成OC引导，你可以在此选择启动Windows还是macOS了。

## 后话
2024年可能是黑与白交替的一年，黑苹果已经慢慢步入迟暮，苹果已经逐渐停止对 Intel 架构的全面支持，未来一段时间内，可能 MacOS 将只支持 Arm 平台，随着苹果开始打通中低端市场，愿意用黑苹果的人也会越来越少，且用且珍惜吧。
