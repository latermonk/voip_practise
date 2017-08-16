

# compile Linphone SDK & linphone for ios



## 1.Download  source code 



- Open web  http://linphone.org/technical-corner/linphone/downloads

then donwload :

```
git clone git://git.linphone.org/linphone-iphone.git --recursive
```



- Open web https://github.com/BelledonneCommunications/linphone-iphone

```
git clone https://github.com/BelledonneCommunications/linphone-iphone.git
```




## 2.compile SDK 

```
./prepare.py
PATH=/usr/local/bin:$PATH
./prepare.py -c && ./prepare.py && make
```





![](https://github.com/latermonk/voip_practise/raw/master/img/SDK.png)





## 3.compile & run the linphone App in the ios simulator

## 

![](https://github.com/latermonk/voip_practise/raw/master/img/Snip20170816_3.png)

![](https://github.com/latermonk/voip_practise/raw/master/img/Snip20170816_2.png)

![](https://github.com/latermonk/voip_practise/raw/master/img/Snip20170816_1.png)



#####编译过程中遇到的一些问题：


prepare.py 文件是准备环境的脚本，只要这个脚本没有问题 编译基本都没有问题。

我在编译时总是遇见 
"iOS SDK not found, please install Xcode from AppStore or equivalent."
的问题，找了半天也找不到解决方案。

后来去里边看了看源码：

```
 p = Popen("xcrun --sdk iphoneos --show-sdk-path".split(" "), stdout=devnull, stderr=devnull)
        p.wait()
        if p.returncode != 0:
            error("iOS SDK not found, please install Xcode from AppStore or equivalent.")
            reterr = 1
        else:
```

这个地方报错主要是因为 xcrun --sdk iphoneos --show-sdk-path 的结果不对，直接在网上找这个问题的解决方案就很容易了。


``` 
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer/
```


