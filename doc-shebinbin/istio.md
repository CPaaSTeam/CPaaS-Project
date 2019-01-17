# istio 原理、部署、使用、问题分析

## istio 原理

### istio 架构

Istio 服务网格逻辑上分为<label style="color:red">**数据平面**</label>和<label style="color:red">**控制平面**</label>。

**数据平面** 
> 数据平面由一组以 sidecar 方式部署的智能代理（Envoy）组成。这些代理可以调节和控制微服务及 Mixer 之间所有的网络通信。

**控制平面**
> 控制平面负责管理和配置代理路由流量。此外控制平面配置Mixer以**实施策略**和**收集遥测数据**。

下图显示了构成每个面板的不同组件：
<div align="center">
<img src="./Pictures/istioArch.svg" width = "100%" height = "100%"/>
<div>图1-1 istio架构图</div>
</div>

### istio 组件
#### 

## istio 部署

## istio 使用

## istio 问题

### istio 如何实现服务发现？

### K8S一个node节点上istio是在如何知道某个pod、docker上运行的是什么服务的？

### istio又是如何管理服务间通信的？