# 正文

## 一、使用Git进行开发项目管理

### 1、什么是Git

包括软件开发在内的生产生活场景中，我们经常遇到版本控制的问题。针对这个需求，市面上出现了很多的版本控制系统（Version Control System，即 VCS），SVN和Git是我们最常用的两种。早期SVN占据了绝大部分市场，而后来随着Git的出现，越来越多的人选择将它作为版本控制工具，Git社区也越来越强大，比较知名的如[GitHub](https://github.com/)、[码云](https://gitee.com/)等都使用Git作为代码托管的“引擎”。

SVN和Git最核心的区别在于Git是分布式的VCS，而SVN需要一个中央版本库进行集中控制。分布式模式的最大好处就是不依赖于网络，每一个pull下来的Git仓库都是主仓库的一个分布式版本，一个可以进行提交的本地仓库。如果你愿意甚至可以一直在本地进行提交。当有网络的时候，本地与远程的仓库也可以进行同步。当然，分布式和集中式各有各的优缺点，但从目前来看，分布式的Git正逐渐被越来越多的人所接受并推广。

Git在CICD中扮演中非常重要的角色，它是我们开发环节中代码管理的重要组件，也是触发我们持续集成、自动化测试的关键节点。除了开发测试场景，生产上配置文件、web页面以及所有有版本管理需求的地方都可以用到Git。所以，这一章节下我们将讨论Git基础知识、Git常用命令，试图告诉大家Git是如何工作的。我们将进行Git服务器的搭建、配置触发自动集成、自动测试以及与大家讨论一种生产上使用Git进行配置文件、web页面管理的一种场景。

#### 1.1 版本控制的演进

##### 1.1.1 什么是版本控制？
版本控制是一种记录一个或若干文件内容变化，以便将来查阅特定版本修订情况的系统。通常的理解中版本控制是用于对保存着软件源代码的文本文件作版本控制管理，实际上任何类型的文件都可以进行版本控制。
有了版本控制我们就可以将某个文件回溯到之前的状态，甚至将整个项目都回退到过去某个时间点的状态。我们可以比较文件的变化细节，查出所有的历史记录，明确缺陷的责任人、问题的提出者。

##### 1.1.2 本地版本控制
在使用计算机管理多版本文件的生产和生活中，我们常用的做法是复制整个项目目录的方式来保存不同的版本，或许还会改名加上备份时间以示区别。这估计能引起大多数人的共鸣，因为这么做实在是太简单了。但是，如果你混淆所在的工作目录，弄错文件或者丢了数据那就崩溃去吧。

为了解决这个问题，人们很久以前就开发了许多种本地版本控制系统，大多都是采用某种简单的数据库来记录文件的历次更新差异。如下图：

<div align="center">
<img src="./Pictures/localvcs.png" width = "50%" height = "50%"/>
<div>图1.1.2-1 本地版本控制系统</div>
</div>



##### 1.1.3 集中式版本控制
本地版本控制无法实现让在不同系统上的开发者协同工作。于是，集中化的版本控制系统（ Centralized Version Control Systems，简称 CVCS ）应运而生。我们比较熟悉如SVN 、 CVS 等，都有一个单一的集中管理的服务器，保存所有文件的修订版本，而协同工作的人们都通过客户端连到这台服务器，取出最新的文件或者提交更新。

<div align="center">
<img src="./Pictures/cvcs.png" width = "50%" height = "50%"/>
<div>图1.1.3-1 集中式版本控制系统</div>
</div>

显而易见，最大的缺点是中央服务器的单点故障。

1. 宕机风险：如果宕机一小时，那么在这一小时内，谁都无法提交更新，也就无法协同工作。
2. 要是中央服务器的磁盘发生故障，碰巧没做备份，或者备份不够及时，就会有丢失数据的风险。
3. 最坏的情况是彻底丢失整个项目的所有历史更改记录，而被客户端偶然提取出来的保存在本地的某些快照数据就成了恢复数据的希望。但这样的话依然是个问题，你不能保证所有的数据都已经有人事先完整提取出来过。

##### 1.1.4 分布式版本控制系统
于是分布式版本控制系统（ Distributed Version Control System，简称 DVCS ）面世了。在这类系统中，像 Git，Mercurial，Bazaar 以及 Darcs 等，客户端并不只提取最新版本的文件快照，而是把代码仓库完整地镜像下来。这么一来，任何一处协同工作用的服务器发生故障，事后都可以用任何一个镜像出来的本地仓库恢复。因为每一次的提取操作，实际上都是一次对代码仓库的完整备份（见图1.3）。
<div align="center">
<img src="./Pictures/dvcs.png" width = "60%" height = "60%"/>
<div>图1.1.4-1 分布式版本控制系统</div>
</div>


更进一步，许多这类系统都可以指定和若干不同的远端代码仓库进行交互。籍此，你就可以在同一个项目中，分别和不同工作小组的人相互协作。你可以根据需要设定不同的协作流程，比如层次模型式的工作流，而这在以前的集中式系统中是无法实现的。

#### 1.2 Git简史
Git源于对Linux内核开源项目的维护和管理。2005年BitKeeper商用化，Linux内核开源项目不得不放弃使用BitKeeper，Linux开源社区以及Linux的缔造者Linus Torvalds意识到需要开发一套属于自己的版本控制系统。他们对这个版本控制系统制定了如下需求：
1. 速度
2. 简单的设计
3. 支持非线性开发模式（允许上千个并行开发）
4. 完全分布式
5. 高效管理类似Linux内核一样的超大规模的项目

自2005年诞生以来，Git日臻完善，在高度易用的同时，仍然保留着初期设定的目标。它的速度飞快，极其适合管理大项目，它还有着令人难以置信的非线性分支管理系统，可以应付各种复杂的项目开发需求。

#### 1.3 Git设计思想和基本工作原理
在开始学习Git的过程中，理解Git的设计思想以及基本工作原理将有助于我们准确地使用Git提供的各个功能。

##### 1.3.1 Git只关心文件本身是否发生变化
如何理解标题呢？简单理解一下：在某文件更新前后，判断该文件是否发生更新，只算一下该文件前后的哈希值，如果哈希值发生变化，那么Git将变化的文件作一个快照，记录在一个**微型的文件系统**中；如果哈希值不变，为了提高性能，Git不会再次保存，而是只对上次保存的快照作一个链接。

Git可以被理解为一个小型的文件系统，在此基础之上还提供了更多更强的工具，不只是一个简单的VCS。

##### 1.3.2 Git中99%的操作都无需联网

因为Git是分布式的， 在本地磁盘上就保存着所有当前项目的历史更新，所以不依赖于网络，处理起来速度飞快。即使身处无网络的环境，我们仍然可以非常愉快地频繁提交更新，并且在本地进行所有项目版本的管理。等到了有网络的时候，我们再与远程仓库进行同步。

如果想要看当前版本的文件和一个月前的版本之间有何差异，Git 会取出本地磁盘上微型文件系统中一个月前的快照和当前文件作一次差异运算，而不用请求远程服务器来做这件事。

##### 1.3.3 Git如何保证数据的一致性和完整性

Git 使用 SHA-1 算法计算数据的校验和，通过对文件的内容或目录的结构计算出一个 SHA-1 哈希值。该字串由 40 个字符（0-9 及 a-f）组成，它其实是算出的校验和的十六进制表示。看起来就像是：

```shell
8d73a23d429299cdf9876a87e9fa85ad4f1e1b37
```

保存在Git中的所有文件都要进行上述校验和（checksum）计算，并将此结果作为数据的唯一标识和索引。这项特性作为 Git 的设计哲学，建在整体架构的最底层。所以如果文件在传输时变得不完整，或者磁盘损坏导致文件数据缺失，Git 都能立即察觉。

Git 的工作完全依赖于上述40个字符的字符串，所有保存在 Git 数据库中的东西都是用此哈希值来作索引的，而不是靠文件名。

##### 1.3.4 Git中文件三态

Git中的任何一个文件，都只有三种状态：

1. modified （已修改）
2. staged （已暂存）
3. committed （已提交）

<div align="center">
<img src="./Pictures/gitszzt2.png" width = "95%" height = "95%"/>
<div>图1.3.2-1 Git工作区、暂存区、仓库</div>
</div>


当在工作区新增或者修改了某个文件，那么该文件就处于modified状态。如果现在进行上图中的操作①，那么Git就会将该文件作一个快照保存在暂存区，该文件就处于staged状态。接下来，如果该文件进行了上图中的操作②，那么Git将保存在暂存区域的文件快照永久转储到 Git 目录中，该文件就处于committed状态了。

#### 1.4 Git安装

理解了Git的设计思想和基本工作原理，咱们就开始实际操作了。

##### 1.4.1 从源代码安装

从源代码安装有很多好处，首先能够保证不会下载到被嵌入恶意代码的二进制包，其次能够使用修复了安全和功能BUG的最新的Git版本。

Git编译依赖curl，zlib，openssl，expat，libiconv库的部分代码。

Centos、Redhat、Fedora需要安装：

```shell
sudo yum install curl-devel expat-devel gettext-devel \
  openssl-devel zlib-devel
```

Debian、Ubuntu、Deepin需要安装：

```shell
sudo apt-get install libcurl4-gnutls-dev \
libexpat1-dev gettext libz-dev libssl-dev
```

从Git官方站点下载最新源代码：

```shell
# 从Git官网下载
http://git-scm.com/download
# 从GitHub下载最新的源代码包
wget https://github.com/git/git/archive/v2.20.1.tar.gz
```

<div align="center">
<img src="./Pictures/gitaz1.png" width = "97%" height = "97%"/>
<div>图1.4.1-1 从GitHub上下载Git源代码包（1）</div>
</div>

<div align="center">
<img src="./Pictures/gitaz2.png" width = "97%" height = "970%"/>
<div>图1.4.1-1 从GitHub上下载Git源代码包（2）</div>
</div>

编译和安装：

```shell
$ tar -zxf git-v2.20.1.tar.gz
$ cd git-v2.20.1
$ make prefix=/usr/local/git all
$ sudo make prefix=/usr/local/git install
```

安装完成之后执行 git version，有些用户可能发现还是旧版本。可执行如下命令：

```shell
# 找出旧版本git 可执行文件的路径
$ whereis git
git: /usr/bin/git /usr/share/man/man1/git.1.gz
# 将原来的git可执行文件或者软链接备份
sudo mv /usr/bin/git /usr/bin/git.bak
# 将安装目录下的最新版Git可执行文件,通过软连接方式链接到/usr/bin/git
sudo ln -s /usr/local/git/git  /usr/bin/git
```

如果出现如下结果，则安装成功。

```shell
$ git version
git version 2.20.1
```

##### 1.4.2 二进制文件安装

**Debian系的Linux**

```shell
$ sudo add-apt-repository ppa:git-core/ppa
$ sudo apt update
$ sudo apt install git
```

以上是安装最新版本的Git方式，如果没有最新版本Git 的需求，执行如下命令：

```shell
sudo apt-get install git
```

**RedHat系的Linux**

```shell
sudo yum install git 
```

以上命令只安装yum源中的版本，如需使用最新版本，建议使用源码编译方式安装。

**Windows**

可在[Git官网](https://git-scm.com/downloads)下载Windows版本的.exe格式二进制文件进行安装即可。

**Mac OS X**

可在[Git官网](https://git-scm.com/downloads)下载Mac OS X版本的.dmg格式二进制文件进行安装即可。

#### 1.5 Git配置

安装完成之后，我们需要配置一下Git环境。执行配置命令之后，Git会将配置信息写入文件系统中，不用重复配置。如果需要修改配置可直接修改配置文件或者再次执行配置命令。

Git配置文件主要有三个：

* /etc/gitconfig，优先级最低，该文件对应于如下命令：

```shell
sudo git config --system  user.name  "neroshea"
```

* ~/.gitconfig，优先级其次，该文件是隐藏文件处于用户目录下：

```shell
git config --global  user.name "neroshea"
```

* ${workdir}/.git/config，优先级最高，该文件处于工作区文件夹下：

```shell
git config --local  use.name "neroshea"
```

其中 --local 对应的配置文件优先级最高，只在本工作区起作用。--global 对应的配置文件只适用于当前用户，文件中配置项的优先级其次。--system 对应的配置文件适用于本机所有用户，文件中配置项的优先级最低。优先级高的覆盖优先级低的配置。

熟悉了上述三个文件之后，我们现在开始进行Git配置。

**用户信息配置**

首先配置用户名称和电子邮箱，这两个配置非常重要，Git通过这两个配置来标识是谁做了提交，并且这些信息将会永久写入历史记录中。

```shell
$ git config --global user.name "neroshea"
$ git config --global user.email test@example.com
```

一般情况下配置global即可。配置local则每次新建工作区都需配置该信息；配置system则会干扰其他用户的使用，普通用户也没有配置system的权限。

**文本编辑器**

Git在需要你填入某些信息的时候会自动打开一个编辑器，系统默认为vi或vim编辑器，如果你有特殊需求可以进行配置。

```shell
git config --global core.editor emacs
```

一般不做修改。

**差异分析工具**

当我们解决合并冲突时，需要用到差异分析工具，默认为diff。可修改，如改成vimdiff。

```shell
git config --global merge.tool vimdiff
```

Git 可以理解 kdiff3，tkdiff，meld，xxdiff，emerge，vimdiff，gvimdiff，ecmerge，和 opendiff 等合并工具的输出信息。

**查看配置信息**

检查已有的配置信息：

```shell
git config --list
```

检查特定项目：

```shell
git config user.name
```

#### 1.6 Git帮助

当你不知道如何使用git 时，最快的方法就是使用：

```shell
git help <cmd>
# 比如，查看git config 的用法
git help config
```

如果可以联网，可通过搜索引擎查询。

#### 1.7 小结

这一小结我们详细介绍了Git是什么、Git的由来、Git的设计思想和基本原理、Git安装配置。了解了上述知识，大家理解Git的操作就很方便了，以后学习Git就能更加顺利。

### 2、Git操作和管理

>  光大科技公司Git命令操作规范，Git分支管理，简短有力、全面、能进能退，收放自如。

现代工业体系中的项目运作从来不是一个人独角戏，必定是多人协作。软件工程也不是计算机产业上古时期某个程序员两三天弄出来的小demo。这一章节我们将讨论如何使用Git参与到项目的协作中来。

我试图使用非常简单的图文来向大家描述Git操作命令，每个参数都有示例并告诉大家这些参数的区别。

Git中仓库以及仓库之间的关系和操作，可以使用下图进行简单说明：

<div align="center">
<img src="./Pictures/gitcz4.png" width = "99%" height = 200 />
<div>图2-1 Git操作与仓库之间的关系</div>
</div>

#### 2.1 Git远程仓库

要参与到Git项目的协作，我们首先需要了解远程仓库。远程仓库是指托管在网络上的Git仓库，可能有多个，有些是只读镜像，另外的是可写。同他人协作开发某个项目时，需要管理这些远程仓库，以便推送或拉取数据，分享各自的工作进展。管理远程仓库的工作，包括添加远程库，移除废弃的远程库。本节我们将详细讨论远程库的管理和使用。

**查看当前仓库配置的远程仓库**

```shell
$ git remote
origin
```

它会列出每个远程仓库的别名。如果什么都没有输出，那么需要clone一个远程仓库，下图为获取远程仓库链接：

<div align="center">
<img src="./Pictures/gitclone1.png" width = "99%" height = 200 />
<div>图2.1-1 如何获取Git远程仓库链接</div>
</div>

```shell
$ git clone https://github.com/git/git.git  gitHubAlias
```

命令中的 “gitHubAlias” 为自定义的名字，仓库将处于这个自定义名字的文件夹下，如果不填，那么这个仓库的文件夹名默认为远程仓库的名字。

```shell
$ cd gitHubAlias
# -v 参数可以查看远程仓库的链接。
$ git remote -v
origin	git@github.com:git/git.git (fetch)
origin	git@github.com:git/git.git (push)
```

在clone完一个仓库之后，至少可以看到一个名为origin的远程仓库，Git默认使用origin来表示我们所clone的原始仓库。

#### 2.2 获取Git仓库

#### 2.3 Git更新、提交、撤销操作

#### 2.4 Git查看提交记录

#### 2.5 Git中打版本标签

#### 2.6 Git分支管理

管理各式远程库分支，定义是否跟踪这些分支，等等

#### 2.7 Git别名以及命令自动补全

#### 

### 3、Git项目协作规范

（企业级架构，是否有成熟的Git的落地方案，网络、操作系统、磁盘、CPU、内存）

### 4、Git成为CICD利器

从易于项目管理的角度去看Git ，如何使得Git成为项目管理的利器，而不是简单的只是使用。

webhook

### 5、企业级Git远程服务器搭建

容器化？

云？

gogs而不是gitlab？



### 6、GitOps

生产其他使用场景讨论

### 7、本章总结



## 二、Jenkins搭建与使用



生成一个 job 形成自动化测试。

单元测试（单个容器镜像的测试）

集成测试（容器镜像组合成形成相互调用测试，性能、稳定等测试）

SIT测试（所有容器组合形成生产**系统架构**的形式进行测试）

UAT测试

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
### 3、Jenkins服务搭建（企业级架构）

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
## 四、搭建企业级CICD（这个任务重大呀，需要想的、实践的非常多）

<span id="4-1"></span>
### 1、持续集成 CI

<span id="4-2"></span>
### 2、持续部署 CD

<span id="4-3"></span>
### 3、CICD容器化

<span id="4-4"></span>
### 4、企业级CICD规划——如何上云



这个和容器镜像生命周期中的图有一定的相似，因为测试的是镜像而不是war包等二进制包。

## 五、落地场景分析

<span id="5-1"></span>
### 1、场景描述

<span id="5-2"></span>
### 2、运维自动化改造

<span id="5-3"></span>
### 3、实施CI/CD落地

<span id="6"></span>

## 六、总结