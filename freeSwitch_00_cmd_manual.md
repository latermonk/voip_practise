# cmmmand_manual命令行手册

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
for i in `seq 1020 1039`; do sed -e "s/1000/$i/" 1000.xml > $i.xml ; done
```

