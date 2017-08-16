---
typora-copy-images-to: ipic
---

# compile Linphone SDK & linphone for ios



## 1.Download  source code 



- open web  http://linphone.org/technical-corner/linphone/downloads

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



Pic1





## 3.compile & run the linphone App in the ios simulator

## 

Pic1

pic2

pic3





