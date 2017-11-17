在FreeSwitch系统中，所有用户的密码默认为 1234，该设置在 \conf\vars.xml 中，如下所示：<X-PRE-PROCESS cmd=”set” data=”default_password=1234″/>

 

若需要修改默认密码的话，直接修改该处即可。

那用户的密码和默认密码怎么关联起来？请看下面的配置文件，以 用户 1000 为例，打开 \conf\directory\default\1000.xml ,找到如下设置：



```
<param name=”password” value=”$${default_password}”/>，
```

即可找到他们之间的联系。若需要修改某用户的密码，直接修改 value 值即可。

 

修改配置完成后，通过 FS_CLI 运行 reloadxml 即可。

