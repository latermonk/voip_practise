# freeSwitch Basic





## 一、安装

Mac安装特别简单



官网提供了 **Mac FI** - Mac freeswich installer 来安装freeswitch

[Mac installer]: https://freeswitch.org/confluence/display/FREESWITCH/macOS+macFI+Installation



安装完成后 freeswitch 的安装路径和源码路径如下：



**bin:**

~~~
/usr/local/freeswitch
~~~



**src:**

~~~
/usr/local/src/freeswitch
~~~





* 安装声音文件：

~~~
make sounds-install
~~~

~~~
make moh-install
~~~



* 升级到最新版本：

~~~
make current
~~~

* 重新编译

~~~
make sure
~~~





* 安装之后建立软连接：[在 /usr/bin 目录下建立 freeswitch & fs_cli 的快捷方式]

~~~
ln -sf /usr/local/freeswitch/bin/freeswitch   /usr/bin
~~~

~~~
ln -sf /usr/local/freeswitch/bin/fs_cli.     /usr/bin
~~~





* 常用的启动方式：

~~~
freswitch -nc            后台运行
~~~

~~~
freeswitch -nonat        不检测nat
~~~



## 二、测试

* 经常使用的客户端：

**x-lite**

**zoiper**  [多客户端和网页端均可]  Mac/PC  iOS /android / web



**系统预留 1000 ～ 1019   20个测试账户，可以随便使用。**



**sip账户设置**

| Item         | value                                    |
| :----------- | :--------------------------------------- |
| user_account | 1000 ~ 1019                              |
| Password     | 1234                                     |
| Domain       | IP address of server / domain name of server |
|              |                                          |





* 配置后之后久可以使用两个客户端进行通话测试了。

  例如用 1000 call 1001

  ​

## 三、基础使用

### 1.检测系统是否运行: 

* 进程是否存在：

  ~~~
  ps -ef | grep freeswitch
  ~~~

  ​

* 端口是否起来

  ~~~
  netstat -ntlp | grep 5060
  ~~~

  ​



### 2.默认号码 



| 号码                    | 说明       |
| :-------------------- | :------- |
| 9664                  | 保持音乐     |
| 9195                  | echo回音测试 |
| 33xx ／ 32xx／31xx／30xx | 电话会议     |
|                       |          |



参考拨号计划：

**Defaut_Dialplan_QRF**



### 3. 配置文件

* 目录： ／usr/lcoal/freeswitch/conf

| 目录和文件            | 说明   |
| ---------------- | ---- |
| vars.xml         |      |
| awitch.xml       |      |
| autoload_configs |      |
| chatplan         |      |
| dialplan         |      |



![conf_directory](/Users/wei/Github/voip_practise/img/conf_directory.png)





### 4.添加一个用户

* 三步
  1. 在conf/directory/default 中增加一个用户配置文件
  2. 修改拨号计划（Dialplan）使其他用户可以呼叫到他
  3. 重新加载配置文件使其生效。

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

## 五 拨号计划 Dial Plan



* ​
* ​
* ​
* ​





## 六 SIP协议

### 对比HTTP协议：

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

### sip消息组成：

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



### SIP注册流程：



**注册流程**：

![Jietu20170228-092110](/Users/wei/Downloads/Jietu20170228-092110.jpg)

**呼叫流程**

* UA间接呼叫
* 通过B2BUA呼叫



### 深入理解SIP

* SIP URI
* SDP & SOA
* 3PCC
* SIP承载



### 小结

打开/关闭调试信息的命令：

~~~
sofia global siptrace on / off
~~~







## 七 媒体





