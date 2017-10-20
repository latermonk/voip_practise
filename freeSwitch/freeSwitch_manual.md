# freeswitch Basic

## 零、常用命令查询

[command_Card 点击这里](https://freeswitch.org/confluence/display/FREESWITCH/mod_commands)


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



**插入图片**

配置目录的图片



### 4.添加一个用户

* 三步  [ **以添加用户1234为例** ]

  1. 在conf/directory/default 中增加一个用户配置文件

     ~~~
     cd  /usr/local/freeswitch/conf/directory/default
     cp  1000.xml   1234.xml
     vim 1234.xml   //把1000都换成1234，然后把effective_caller_id_name的值改为 Jack
     ~~~

     ​

  2. 修改拨号计划（Dialplan）使其他用户可以呼叫到他

     ~~~
     cd  /usr/local/freeswitch/conf/dialplan/
     vim default.xml
     修改：
     <condition field="destination_number" expression="^(10[01][0-9])$">
     为：
     <condition field="destination_number" expression="^(10[01][0-9]|1234)$"> //增加 |1234
     ~~~

     ​

  3. 重新加载配置文件使其生效。

     ~~~
     reloadxml  /  F6            // reloadxml命令即可生效
     ~~~

* 测试：

在SIP终端中添加账号1234，测试能不能打通电话。



* 常见命令：

```
sofia status profile internal reg      //显示多少用户已注册
```

```
originate user/1000  &echo    //echo程序
```

```
originate user/1000 9999      //1000 call 9999
```

```
originate user/1000 &echo  XML default // 1000 echo
```





### 5.freeswitch做客户端 [需要安装 mod_portaudio ]

* 安装方法：

```
make mod_portaudio
```

```
make mod_portaudio-install
```

**fs_cli:**

```
load mod_portaudio-install   //
```



* 设备配置

```
pa devlist   //查看设备列表
```

```
pa indev  #0   //配置输入输出
pa outdev #2
```



* **命令行软电话：**

```
pa looptest   echo测试
```

```
pa call 9196  呼叫
```

```
pa call 1000  呼叫
```

```
pa hangup     挂机
```



**现在久可以使用这个软电话呼叫任何的号码了。**

* 配置以使得其他的号码能够呼到这个软电话：

```
cd ~/conf/dialplan/default/portaudio.xml

添加：
===
```

然后F6 使生效。



* 配置铃声的话需要修改文件 **~/conf/autoload_config/portaudio.conf.xml** 文件

  ​

### 6.配置SIP网关拨打外部电话

如果有运营商提供的SIP账号，那么就可以拨打外部电话了。对于fs而言，这个账号便是 **SIP网关**。

```
修改：
**/usr/local/freeswitch/conf/sip_profiles/external** 文件


```

然后执行：

```
sofia profile external rescan.  
```

显示网关状态：

```
sofia status     //reged表示已经注册上了
```

测试网关是否正常工作：

```
orignate sofia/gateway/gw1/12345678 &echo  //通过网关拨打你手机号码
```



* 从某一分机呼出 ／ 呼入电话处理



### 7.基础命令

```
freeswitch -h
```

```
Usage: freeswitch [OPTIONS]

These are the optional arguments you can pass to freeswitch:
	-nf                    -- no forking
	-reincarnate           -- restart the switch on an uncontrolled exit
	-reincarnate-reexec    -- run execv on a restart (helpful for upgrades)
	-u [user]              -- specify user to switch to
	-g [group]             -- specify group to switch to
	-core                  -- dump cores
	-help                  -- this message
	-version               -- print the version and exit
	-rp                    -- enable high(realtime) priority settings
	-lp                    -- enable low priority settings
	-np                    -- enable normal priority settings
	-vg                    -- run under valgrind
	-nosql                 -- disable internal sql scoreboard
	-heavy-timer           -- Heavy Timer, possibly more accurate but at a cost
	-nonat                 -- disable auto nat detection
	-nonatmap              -- disable auto nat port mapping
	-nocal                 -- disable clock calibration
	-nort                  -- disable clock clock_realtime
	-stop                  -- stop freeswitch
	-nc                    -- do not output to a console and background
	-ncwait                -- do not output to a console and background but wait until the system is ready before exiting (implies -nc)
	-c                     -- output to a console and stay in the foreground

	Options to control locations of files:
	-base [basedir]         -- alternate prefix directory
	-cfgname [filename]     -- alternate filename for FreeSWITCH main configuration file
	-conf [confdir]         -- alternate directory for FreeSWITCH configuration files
	-log [logdir]           -- alternate directory for logfiles
	-run [rundir]           -- alternate directory for runtime files
	-db [dbdir]             -- alternate directory for the internal database
	-mod [moddir]           -- alternate directory for modules
	-htdocs [htdocsdir]     -- alternate directory for htdocs
	-scripts [scriptsdir]   -- alternate directory for scripts
	-temp [directory]       -- alternate directory for temporary files
	-grammar [directory]    -- alternate directory for grammar files
	-certs [directory]      -- alternate directory for certificates
	-recordings [directory] -- alternate directory for recordings
	-storage [directory]    -- alternate directory for voicemail storage
	-cache [directory]      -- alternate directory for cache files
	-sounds [directory]     -- alternate directory for sound files

```



* 常用的参数

```
freeswitch -nc

tail -f  log/freeswitch.log. //通过tail查看freeswitch输出
```

```
freeswitch -nonat   // no nat
```



* 设置**开机启动**脚本：

```
把源码目录中的 ~/build/freeswitch.init.* 放到 /etc/init.d 目录下
```





* 常用命令

```
version
status
sofia status
help
```



* 控制台快捷键

```
F1 ～ F12

cd /usr/local/freeswitch/conf/autoload_configs
vim switch.conf.xml
```



### 8.呼叫

* 发起呼叫

```
originate user/1000 &echo
```

* 查看注册信息：

```
sofia status profile internal reg
```

* park

```
originate user/alice &park
```

* hold

```
originate user/alice &hold
originate user/alice &playback(/root/welcome.wav)   //play specify wave file
originate user/alice &record(/tmp/voice_of_alice.wav)   //record
```

* Bridge  **桥接通话**

```
originate user/alice  &bridge(user/bob)    
```



**完整过程演示**：

```
orginate user/alice &park
orginate user/bob &park
show channels
uuids_bridge <alice_uuid> <bob_uuid>
```





## 四、架构

* **处理高并发请求的架构**

```
使用线程模型来处理并发请求，每个连接都在单独的线程中进行处理，不同的线程间通过Mutex互斥访问共享资源，并通过消息和异步事件等方式进行通信。

**能处理很高的并发，并且在多核环境中运算能均匀的分布到多棵CPU或者单科CPU的多个核上。**
```



* **组织架构**

```
* 内核小 负责基本的功能
* 外围扩展 可动态加载及卸载

外围模块儿通过核心代码提供的 Public API 与外围进行通信，核心则通过回调机制执行外围模块儿中的代码。

```



* 架构图

lic here

### 核心Core

#### 数据库

* 系统默认的数据库是 sqlite 
* 也支持ODBC的方式连接到其他数据库

```
核心数据库的位置：
／usr/local/freeswitch/db/core.db
```



#### 公共应用程序接口 Public-API



#### 接口 Interface



#### 事件 Event



```
fs_cli> /event plain all
```



freeswitch主要事件有两类：

* 主事件
* 自定义事件

### 接口实现

* 终点
* 拨号计划
* 聊天计划
* 常用程序
* 命令接口
* XML接口
* 编解码器
* 语音识别和语音合成
* 格式、文件接口
* 日志
* 定时器
* 嵌入式语言
* 事件套接字



### 目录结构

```
程序位置：
／usr/local/freeswitch
/usr/local/src/freeswitch

```



* 目录结构：





### 配置文件

```
XML调试方法：
log/freeswitch.xml.fsxml 是XML的一个内存镜像，可以利用它排错。
```

* **freeswitch.xml**


**总配置文件**，其中包含了各个 section 对应的文件时什么

如下：

```
X-PRE-PROCESS

data:
vars.xml
autoload_configs/*.xml


坑：
试图去注释掉一个是没有用的 必须破坏掉XML
```



* **vars.xml**


 **定义全局变量**

```Xml
domain
domain_name
hold_music
use_profile
```



* 查看变量值的命令

```
global_getvar  sound_prefix

```





* **autoload_configures 目录**




```
sofia.conf.xml

modules.conf.xml                          决定freeSwitch启动时自动加载哪些模块儿
post_load_modules.conf.xml                玩些时候加载的模块名单 
```



* 其它目录

```
* dialplan
* ivr_menues
* directory
```





### XML用户目录

```
/usr/local/freeswitch/conf/directory/   
default.xml
default_dir 
	1001.xml
	1002.xml
	...
	1019.xml
```

**default.xml**

```

domain
params
variables

```





### 呼叫的相关概念

* 典型的呼叫流程：

- [ ] Bob - > freeswitch , freeswitch - > Alice
- [ ] Freeswitch  -> Bob &  Freeswitch  -> Alice, 然后把 Bob & Alice bridge到一起



* 来话 去话

来话去话都是针对freeswitch来讲的

- [ ] 来话： 拨打fs
- [ ] 去话：接听fs来话



* Session     sip session 用于控制整个呼叫流程



* Channel 每个session控制一个 channel，channel是一对儿UA之间通信的实体。每个channel有一个ID，

叫 Channel UUID。

```
freeswitch的作用是把两个channel桥接到一起，使双方可以正常的通话。

```



```
在通话中，音频和视频数据流在RTP包中传输。

Channel一般是双向的，因此媒体流会有 send／write & receive ／ read 两个方向
```



* 回铃音   &  Early Media
* 全局变量  &   局部变量



### 小结









## 五 拨号计划 Dial Plan

```
主要作用是：
对电话进行路由，决定和影响通话的流程。


就是当用户拨号时，对用户的拨号进行分析，进而决定下一步该如何做。

```



### XML Dialplan

* 文件位置：

```
／usr/local/freeswitch/conf/dialplan

freeswitch.xml中写到：


<X-PRE-PROCESS cmd="include" data="dialplan/*.xml">
```



* 拨号计划

```
* Context
* Extension

```



test extension

```xml
<extension name="my echo Test"
           <condition field="destination_number" expression = "^echo|1234$"  />
				<action application="answer" data=""/>
				<action application="echo" data=""/>
		   </condition>
</extention>

```

* 配置文件 default.xml

```
把刚才的配置添加到 default.xml中，reloadxml / F6

20170313 18:47 :)
```



然后 注册客户端，拨打1234

```
[INFO] mod_dialplan_xml.c:637 Processing 1000 <1000>->1234 in context default
处理dialplan 1000 -> 拨打 1234 

1.呼叫已达到路由阶段，要从 XML PLAN 中寻找路由
2.1000是主叫 1234是被叫 



Dialplan: sofia/internal/1000@10.1.42.123 parsing [default->my echo test] continue=false

XML解析阶段

从XML中找到一个 context，它的第一个 extension是 my echo test




Dialplan: sofia/internal/1000@10.1.42.123 Regex (PASS) [my echo test] destination_number(1234) =~ /^echo|1234$/ break=on-false

Dialplan: sofia/internal/1000@10.1.42.123 Action answer()

Dialplan: sofia/internal/1000@10.1.42.123 Action echo()



```



* 呼叫状态切换

```
routing  ->  excuting
```



**对于DianPlan出现的问题：**

**最简单 最有效的方法就是， F8 打开debug日志，尝试打一个电话，并从log中的绿色的行开始进行分析**



* 默认的配置文件：

系统默认的配置文件包括三个context，分别是default、features、public。

它们分别在三个文件中:

- [ ] default.xml.            默认的dialplan
- [ ] features.xml           
- [ ] public.xml                接收外来呼叫





* 正则表达式



| 例子           | 说明   | 备注   |
| ------------ | ---- | ---- |
| ^1234$       |      |      |
| ^1234\|5678$ |      |      |
|              |      |      |
|              |      |      |
|              |      |      |
|              |      |      |
|              |      |      |
|              |      |      |
|              |      |      |
|              |      |      |
|              |      |      |
|              |      |      |
|              |      |      |
|              |      |      |



* 通道变量

修改 Dialplan ,在 default.xml 加入 extension



```Lua
<extension name="show channel variable">
	<condition field="destiination_number" expression="^1235|info$">
		<action application="info" data="" />
	</condition>
</extension>
```





* 测试条件



* 工作机制剖析



* 内联执行



* 实例解析



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





# freeswitch How To Debug ？



* 发现问题

~~~
* 核实问题的现象 
* 看问题是否能够重现？

~~~



* 定位问题

~~~
* 分段判断法  从逻辑上和功能上清理问题

* 换位思考法  看看问题出现在那一边？



~~~



*  分段法  单独测试通话的一方有没有问题，然后在进行多方的测试。

~~~
例如单独拨打 9196 来进行测试



如果都不正常，就说明问题出在拨打电话的哪一方面，流程根本没有走到通话的另一方。

~~~





* 逐一排除的时候可以试试

~~~
Linux防火墙有没有关闭，暂时/永久 关闭Linux的 iptables / windows 防火墙

~~~



### 调试方法

~~~

1. show channel 查看 channel id
2. uuid_debug_media查看调试输出

uuid_debug_media XXX  both on 




~~~







### 查看日志

系统日志中警告和错误市比较高级别的日志。



~~~
可以使用 console loglevel debug 命令打开debug级别的日志

当然，也可以把日志级别设置到其他的级别


~~~



~~~
打开抓包：
sofia profile internal siptrace on 
sofia profile external siptrace on 

关闭抓包：
sofia global siptrace off

~~~





### 外部抓包

* tupdump
* tshark
* ngrep
* pcapsipdump
* ​





# freeswitch QA

##### fs如何支持视频通话？

```xml
<X-PRE-PROCESS cmd="set" data="codec_string=OPUS,G722,PCMU,PCMA,H264,VP8"/>
```



~~~
在配置文件中配置视频解码 H263 H263+等，然后在两个一样的终端上进行视频通话的测试
~~~

### 

##### fs如何支持语音会议?

~~~

~~~



* fs如何支持中文语音留言等

* sip vs sips , sip协议如何加密？   如何使用TLS为SIP协议加密？  TCP  TLS

* 如何查看freeswitch的调试信息？

  ~~~

  ~~~


* freeSwitch如何做压力测试？

  ~~~
  sipp: sip press
  ~~~

* fs如何支持中文语音？

  ~~~
  1.设置方法：
  ~~~


  2.配置方法


  ~~~

  
  ~~~











# freeswitch Command命令行手册

## 服务器状态



## 拨打电话命令





## 调试命令



* 查看服务器状态：

  ~~~
  sofia status profile internal
  ~~~

  ​

* 查看注册信息：【详细】

  ~~~
  sofia status profile internal
  sofia status profile internal reg
  ~~~

  ​

* 显示注册用户 【分行】

  ~~~
  show registrations
  ~~~
  ​

* 剔除在线用户

  ```
  sofia profile internal flush_inbound_reg 1007 
  ```

  ​

* 更改日志级别

  ~~~
  console loglevel debug/info/...
  ~~~

* ​



## 电话会议

~~~
originate user/1000 &bridge(user/1001）
~~~



拨打 1000 & 1001 的电话会议





管理命令：

## 批量建立用户：shell命令

```shell
cd ~/conf/directory/dafault
```

```shell
for i in `seq 1020 1039`; do sed -e "s/1000/$i/" 1000.xml > $i.xml ; done
```

```shell
F6
```

```
Vim  ~/dialplan/default.xml

express part 正则修改一下即可
```

![](https://raw.githubusercontent.com/latermonk/voip_practise/master/img/change_dialplan.jpg)



