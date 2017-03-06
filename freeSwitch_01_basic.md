# freeSwitch Basic





## 一、安装

Mac安装特别简单 使用官网提供的 brew install  即可。



基本的安装完毕之后可以安装声音文件：



make sounds-install

make moh-install



升级到最新版本：

make current



## 二、连接客户端进行测试



使用 x-lite



使用 zoiper [多客户端和网页端均可]  Mac/PC  iOS /android / web





## 三、基础使用

### 1.检测系统是否运行: 

ps -ef | grep freeswitch



或者

```
netstat -ntlp | grep 5060
```



### 2.拨打 9664 收听保持音乐 



详细见拨号计划



9664  保持音乐

9195/9196 echo测试

33xx 电话会议





### 3. 配置文件







### 4.添加一个用户

三步

然后 reloadxml命令即可生效





然后：

sofia status prfile internal reg  显示多少用户已注册

originate user/1000  &echo    echo程序

originate user/1000 9999 

originate user/1000 &echo  XML default





### 5.freeswitch做客户端

make mod_portaudio

make mod_portaudio-install



fs_cli:

load mod_portaudio



### 6.常用参数

```
freeswitch -nc  /*no console*/
```





```
freeswitch -nonat  /*no NAT*/
```







### 7.配置SIP网关拨打外部电话







### 8.基础命令



version

status

sofia status

help





### 9.呼叫

发起呼叫







### 10.









## 四、架构



稳定的核心 + 外围模块儿

Endpoint Codec DialPlan Application



##### 核心Core

Core包含了关键的数据结构和代码、状态机、数据库等

外围模块通过 Core核心提供的API进行通信

保障了核心的稳定性

###### 数据库      

```
默认使用sqlite数据库 ，sqlite会进行读锁定，不建议外部应用直接读取核心数据库
```



###### 公共应用程序接口 Public API



当Endpointer模块收到一个呼入请求时，此模块调用核心的 switch_core_session_request 函数为呼叫生成一个新的Session



当销毁是调用 switch_core_session_destroy函数将Session释放





#### 配置文件

* freeswitch.xml
* vars.xml
* autoload_configures 目录
* XML用户目录




#### 呼叫的相关概念

* 来话 去话

* Session

* Channel

* Call

  ​

# 五 拨号计划 Dial Plan



* ​
* ​
* ​
* ​





# 六 SIP协议

## 对比HTTP协议：

http request

~~~
HTTP:
GET /INDEX.HTML HTTP/1.1
~~~



sip request

~~~
SIP
INVITE sip:seven@freeswitch.org.cn SIP/2.0
~~~



**UA**: User Agent

sip中 UA 用户代理是有状态的,它维护回话/对话的状态。



**UA**： UA分两种

* UAC  UA client  发起请求的一方

* UAS UA server 接受请求的一方

  ​


SIP用户的中间人：

* proxy server 代理服务器

* redirect server 重定向服务器

* regester server  注册服务器

* back-to-back UA 背靠背用户代理

* session border controller 边界回话控制器

  ​

  ​

## sip消息组成：

SIP 消息有消息头和消息组成：



* sip的6个基本方法



| 基本方法      | 说明   |
| --------- | ---- |
| register  |      |
| invite    |      |
| ack       |      |
| cancel    |      |
| bye       |      |
| option    |      |
|           |      |
| 扩展方法      |      |
| subscribe |      |
| notify    |      |
| message   |      |
| refer     |      |
| info      |      |



* 消息头的组成：

| 名称           | 描述   |
| ------------ | ---- |
| Call-ID      |      |
| CSeq         |      |
| From         |      |
| To           |      |
| Max-Forwards |      |
| Via          |      |



## SIP注册流程：



**注册流程**：

![Jietu20170228-092110](/Users/wei/Downloads/Jietu20170228-092110.jpg)

**呼叫流程**

* UA间接呼叫
* 通过B2BUA呼叫



## 深入理解SIP

* SIP URI
* SDP & SOA
* 3PCC
* SIP承载



## 小结

打开/关闭调试信息的命令：

~~~
sofia global siptrace on / off
~~~







# 七 媒体





