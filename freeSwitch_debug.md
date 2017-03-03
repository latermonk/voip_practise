# How To Debug ？



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