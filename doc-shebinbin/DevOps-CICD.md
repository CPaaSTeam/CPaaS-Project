# 目录
[正文](#content)
* [一、gitlab搭建与使用](#1)
  * [1、本章前言](#1-1)
  * [2、Git基本原理](#1-2)
  * [3、Git常用命令](#1-3)
  * [4、Git服务器搭建](#1-5)
  * [5、问题解决](#1-4)
* [二、Jenkins搭建与使用](#2)
  + [1、Jenkins介绍](#2-1)
    + [Jenkins](#2-1-1)
    + [其他开源CI/CD工具](#2-1-2)
      + [GitLab CI](#2-1-2-1)
      + [GoCD](#2-1-2-2)
      + [Travis CI](#2-1-2-3)
      + [Concourse CI](#2-1-2-4)
      + [Spinnaker](#2-1-2-5)
      + [Screwdriver](#2-1-2-6)
  + [2、Jenkins基本原理](#2-2)
  + [3、Jenkins服务搭建](#2-3)
  + [4、问题解决](#2-4)
* [三、docker搭建与使用](#3)
  + [1、docker介绍](#3-1)
  + [2、其他容器产品介绍](#3-2)
    + [gVisor](#3-2-1)
    + [Rocket](#3-2-2)
* [四、搭建CICD](#4)
  * [1、持续集成 CI](#4-1)
  * [2、持续部署 CD](#4-2)
  * [3、CICD容器化](#4-3)
  * [4、CICD上云](#4-4)
* [五、落地场景分析](#5)
  * [1、场景描述](#5-1)
  * [2、运维自动化改造](#5-2)
  * [3、实施CI/CD落地](#5-3)
* [六、总结](#6)

<span id="content"></span>
# 正文
<span id="1"></span>
## 一、gitlab搭建与使用

<span id="1-1"></span>
### 1、本章前言

[GitHub]:https://github.com/  "GitHub"
[码云]:https://gitee.com/ "码云"
包括软件开发在内的生产生活场景中，我们经常遇到版本控制的问题。针对这个需求，市面上出现了很多的版本控制系统（Version Control System，即 VCS），SVN和Git是我们最常用的两种。早期SVN占据了绝大部分市场，而后来随着Git的出现，越来越多的人选择将它作为版本控制工具，Git社区也越来越强大，比较知名的如[GitHub]、[码云]等都使用Git作为代码托管的“引擎”。

SVN和Git最核心的区别在于Git是分布式的VCS，而SVN需要一个中央版本库进行集中控制。分布式模式的最大好处就是不依赖于网络，每一个pull下来的Git仓库都是主仓库的一个分布式版本，一个可以进行提交的本地仓库。如果你愿意甚至可以一直在本地进行提交。当有网络的时候，本地与远程的仓库也可以进行同步。当然，分布式和集中式各有各的优缺点，但从目前来看，分布式的Git正逐渐被越来越多的人所接受并推广。

这一章节下，我们将讨论Git的基本原理、Git常用命令，试图告诉大家Git是如何工作的。我们将进行Git服务器的搭建以及解决在搭建过程中遇到的各种各样的问题。
    

<span id="1-2"></span>
### 2、Git基本原理


<span id="1-3"></span>
### 3、Git常用命令

<span id="1-4"></span>
### 4、Git服务器搭建

<span id="1-5"></span>
### 5、问题解决



<span id="2"></span>
## 二、Jenkins搭建与使用

<span id="2-1"></span>
### 1、Jenkins介绍

<span id="2-1-1"></span>
 > Jenkins

<span id="2-1-2"></span>
 > 其他开源CI/CD工具

<span id="2-1-2-1"></span>
1. GitLab CI
<span id="2-1-2-2"></span>
2. GoCD
<span id="2-1-2-3"></span>
3. Travis CI
<span id="2-1-2-4"></span>
4. Concourse CI
<span id="2-1-2-5"></span>
5. Spinnaker
<span id="2-1-2-6"></span>
6. Screwdriver

<span id="2-2"></span>
### 2、Jenkins基本原理

<span id="2-3"></span>
### 3、Jenkins服务搭建

<span id="2-4"></span>
### 4、问题解决

<span id="3"></span>
## 三、docker搭建与使用

<span id="3-1"></span>
### 1、docker介绍

<span id="3-2"></span>
### 2、其他容器产品介绍

<span id="3-2-1"></span>
> gVisor

<span id="3-2-2"></span>
> Rocket


<span id="4"></span>
## 四、搭建CICD

<span id="4-1"></span>
### 1、持续集成 CI

<span id="4-2"></span>
### 2、持续部署 CD

<span id="4-3"></span>
### 3、CICD容器化

<span id="4-4"></span>
### 4、CICD上云

<span id="5"></span>
## 五、落地场景分析

<span id="5-1"></span>
### 1、场景描述

<span id="5-2"></span>
### 2、运维自动化改造

<span id="5-3"></span>
### 3、实施CI/CD落地

<span id="6"></span>
## 六、总结