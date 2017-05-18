print("Hello World")


---- -- -- -- -- -- -- -- -- --  基础语法 --- --- -- -- -- -- -- -- -- -- -- 

-- 这是单行的注释

--[[

这是多行的注释


--]]


-- 如何删除变量

n = 10
print(n)

n = bil
print(n)



---- -- -- -- -- -- -- -- -- --  数据类型 --- --- -- -- -- -- -- -- -- -- -- 

print("数据类型：nil")
print(type(nil))



print("\n")
print("效果")
print("\n")
print("咋样？")


print("数据类型 number")
-- Lua 默认只有number一种数据诶行。
-- double 是双精度类型

print(type(2.3))
print(type(0.01))


print("\n")


print("数据类型 string")

-- 字符串由一对双引号活着单引号来表示

print(type("hello world in lua ! HaHa "))


-- 也可以用2个方括号 “[[]]” 来表示“一块儿” 字符串

str = [[
	
	hello 
	world
	in 
	lua
	!
	
]]


print(str)


--计算字符串长度

print("The length of str is "..#str)


print("\n")


print("数据类型 table")   --important

-- 不同于其他语言的数组把0作为数组的初索引，在LUA中默认索引从1开始

tab = { key1 = "value1", key2 = "value2" }

for k,v in pairs(tab) do
	print(k .. "--".. v) --连接符--
end



print(type(true))


print("\n")

tabt = {}

tabt["key3"] = "value3"
-- tabt[key3] = "value333"

key4 = "key4"
tabt[key4] = "value4"


for k,v in pairs(tabt) do
	print(k.."="..v)
	
end


print("\n")
--索引

--对table的索引使用方括号[]


print("索引"..tabt[key4])
-- print("索引"..tabt[key3])


print("\n")


print("数据类型 function")
print(type(print))



function demo()
	print("This is a function :)")
end

print(demo())


print("\n")





--匿名函数

function anonymous(tab,fn)
	for k,v in pairs(tab) do
		print(fn(k,v))
	end
end

--
anonymous(tabt,function(k,v)
	return k .."==".. v
end)
--


-- 数组

print("\n")

arr = { 1, 2, 3, "hello"}

for i = 1,4 do
	print("数组 "..i.." =="..arr[i])
end




print("多维数组")

arrm = {}
arrm[1]={1,2,3,4}
arrm[2]={5,6,7,8}



for i= 1,2 do
	for j = 1,4 do
		print("多维数组 "..arrm[i][j]) --notice
	end
end





function demo_function()
	print("This is a demo function")
end

print(demo_function())

-- ----------------------------------- Lua 变量 --------------------------------


print("\n")




-- 文件操作

filehandle = io.open( "/USers/wei/test.txt","r" )

y = 1;

for line in filehandle:lines() do  
	print(y ..":".. line)  
	y = y + 1  
end  


filehandle.close();





print("\n")


--

--[[

lua变量有三种类型：
全局变量
局部变量
表中的域

默认所有变量是全局变量
只有显式声明为 local 的变量是局部变量，作用区域是 语句块


* 所有变量的默认值是 nil


* 尽可能的使用 local变量，因为：

1.访问局部变量速度快
2.避免明明冲突



--]]



a = 12
local b = 13

function area()
	a = 14
	local b = 15
	local c = 16
end

print( "a is :"..a)

-- 注意局部变量和全局变量的值


a,b = "hello","world"
print(a  .."  " .. b)



-- ----------------------------- Lua 循环 -----------------------------------





-- ----------------------------- Lua 流程控制 -----------------------------------






---- -- -- -- -- -- -- -- -- --  Lua 函数 --- --- -- -- -- -- -- -- -- -- -- 




-- lua 函数可以返回多个值
-- return a,b

-- 可变参数

function cot(...)
	return "参数个数是 "..#arg
end 

print(cot(1))

 




---- -- -- -- -- -- -- -- -- --  Lua 字符串 --- --- -- -- -- -- -- -- -- -- -- 

str = "Hello lua, i am a string type"


print(string.upper(str))
print(string.lower(str))
print(string.reverse(str))









---- -- -- -- -- -- -- -- -- --  Lua table --- --- -- -- -- -- -- -- -- -- -- 

--[[

lua table
--]]

print("\n")


fruits = {1,2,3,4}

print("after link",table.concat(fruits,'-'))





print("\n")

table.insert(fruits, 'hh')
print(fruits[5])


table.remove(fruits)


table.sort(fruits)
for k,v in pairs(fruits) do
	print(k.."---"..v)
end







---- -- -- -- -- -- -- -- -- --  协同程序 --- --- -- -- -- -- -- -- -- -- -- 

print("\n")
print("\n")
print("\n")

co = coroutine.create(
	function()
		print("Hello. coroutine !")
end)



print(coroutine.status(co))


co = coroutine.create(
	function(a,b,c)
	
		print("co",a,b,c)
end)

print(coroutine.resume(co, 1,2,3,4))



co = coroutine.create( function()

	print("HI")
end)

print(co)
print(coroutine.status(co))
coroutine.resume(co)
print(coroutine.status(co))

print("testing ... ")
co = coroutine.create(function()

	for i=1,10 do
		print("co",i)
		coroutine.yield()
	end

end)


coroutine.resume(co)
print(coroutine.status(co))

coroutine.resume(co)
print(coroutine.status(co))

coroutine.resume(co)
print(coroutine.status(co))

coroutine.resume(co)
print(coroutine.status(co))

coroutine.resume(co)
print(coroutine.status(co))




---- -- -- -- -- -- -- -- -- --  Lua 模块 --- --- -- -- -- -- -- -- -- -- -- 

print("\n")



module = {}

module.constant = "Define constant"

function module.fn1()
	print{"define a pulblic function"}
end



local function fn2()
	print("private function")
end


return module



-- require(fn1)

