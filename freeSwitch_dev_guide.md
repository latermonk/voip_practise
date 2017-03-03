# freeSwitch开发



* freeSwitch 支持嵌入式的脚本控制呼叫流程，可以提供比较高级的IVR应用和呼叫交互流程。

* 支持嵌入式脚本语言 lua perl python

  ## 一、Lua的应用

  ### lua特点：

  * 变量无需声明
  * 区分大小写
  * 函数可以接受不定个数的参数  vararg expressions
  * hash可以用方括号方式引用
  * 数字区别不大
  * 分号是可选的
  * 默认全局变量
  * 使用双引号和单引号表示字符串
  * 函数是一等公民
  * 函数都是闭包
  * ...

  ### 实例：将电话路由到Lua脚本

  ```lua
  originate user/1000 &lua(test.lua)
  ```

  ​

  ​

  ## 二、Event Socket

* 两种模式：

  ****

  **外连模式**

  fs做客户端连接到一个Tcp Server上

  ![外连](E:\04_GRG_Video\权威指南\外连.png)

  ​

  ​

  **内连模式**

  fs作为服务器接收外部TCP Client的连接

  ![内连](E:\04_GRG_Video\权威指南\内连.png)

  ​

  ****

  ​

* Event Socket协议

* Event Socket库




* ​

  ​

  ​

  ​

  ​

  ​

  ​






