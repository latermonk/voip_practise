一、exc_bad_access 错误

Git clone  commit id = 28b2914c0cad1709a9f4a688501821343c326d0a 的 linphone 代码后，编译是OK的但是在使用assistant 登录的时候，每次登录的时候都报错。

这个错误貌似是无法识别IP地址造成的，因为如果用域名登录的话是没有问题的。

开始换成 www.baidu.com  是可以的不会崩溃，但是无法登录，后来用linphone提供的账号也是可以的，说明这可能就是问题所在。



在 ***linphone_core_iterate***的地方   报错 **exc_bad_access**，错误貌似出在SDK里边，但是却无法调试。这就需要在 代码编译的时候把一个开关打开 

```
 ./prepare.py -c && ./prepare.py --debug && make
```



之后重新编译并运行即可定位到SDK中具体报错的位置，真的如猜想的一样是sip处理的模块儿出了问题。从从官网或者github拿最新的代码替换过去，系统就能正常运行。



二、







