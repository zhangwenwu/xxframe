--2018-11-16 v1.0.1
--更改多点对象中不设置锚点属性时的逻辑
--更改锚点属性Middle的算法
--更新多点对象Area属性,存在锚点时的算法
----------------------------------------------------------------------------------------------------------------------------------
--2018-11-16 v1.0.2
--	增加System对象中的锚点和从属点缩放模式"unequal",可以对一些全屏显示的游戏进行转换
----------------------------------------------------------------------------------------------------------------------------------
--2018-11-16 v1.0.3
--	修改锚点转换Left,Right,Top,Bottom,之前写错了
----------------------------------------------------------------------------------------------------------------------------------
--2018-11-18 v1.0.4
--	在point(multipoint):getandCmpColor类中,增加属性,可以传入布尔值,当比色得结果等于这个传入的布尔值时,则点击
--	新旧对比
--		旧
--			local a=point:new({x=100,y=100,color=oxffffff})
--				if a:getandCmpcolor() then
--				a:Click(1)
--			end
--		新
--			point:new({x=100,y=100,color=oxffffff}):getandCmpColor(true,1)
--	新增函数mulitpoint:AllClick(T),作用是点击new时所传入的所有参数点(不包含锚点和index)
----------------------------------------------------------------------------------------------------------------------------------
--2018-11-19 9:30 v1.0.5
--	整合multipoint和point类,把锚点缩放代码拿了出来
----------------------------------------------------------------------------------------------------------------------------------
--2018-11-23 15:19 v1.0.6
--	之前忘了加了,进行了增加,现在开发设备有黑边也可以进行缩放了
----------------------------------------------------------------------------------------------------------------------------------
--2018-12-01 20:05 v1.0.7
--	修改findcolor对象,找到后会返回以x,y组成的point对象
--	优化,把创建点对象时的TableCopy删除了,减少了部分内存消耗
----------------------------------------------------------------------------------------------------------------------------------
--2018-12-07 00:44 v1.0.8
--	删除了创建对象时不必要的代码
----------------------------------------------------------------------------------------------------------------------------------
--2018-12-07 16:41 v1.1.0
--	修改为调用2.0的api
--		修改point:getXY()为point:getPoint(),将会已缩放后的点创建Point类
--		修改point类,保留传入的参数,并把缩放后的锚点和从属点放入self.Cur中
--		修改File类,增加new时Path的传参,对应引擎目录Public和Private
--		增加runTime计时器类
--			new之后setcheckTime(T)设置计时器时长 单位/秒
--			checkTime()检查时间,返回true并重设起点时间,或false
--			cmpTime()比较当前与起点时间的时间差 单位/毫秒
--		增加多点对象中的findColors方法
----------------------------------------------------------------------------------------------------------------------------------
--2018-12-09 23:02 v1.2.0
--	内部格式大改,我也不记得改了啥了
----------------------------------------------------------------------------------------------------------------------------------
--2018-12-11 21:32 v1.3.1
--	修改多点对象中findcolor和findcolors,可以选择传入getXY(string)则{x=(number),y=(number)},默认为返回以找到的点构建的单点对象
----------------------------------------------------------------------------------------------------------------------------------
--2018-12-12 13:04 v1.3.3
--	增加了const常量表,在传参的时候可以简化点了
----------------------------------------------------------------------------------------------------------------------------------
--2018-12-12 16:27 v1.3.4
--	写了个我也不知道好不好用的findcolorEX,原理就是调用screen.findcolors的返回点,去进行比色,再返回比色成功的点
--	findcolorEX(Ac) Ac填写需要提交给findcolors的点的数量,会调用new时传入的点,同时必须要添加MainPoint属性
----------------------------------------------------------------------------------------------------------------------------------
--2018-12-13 18:15 v1.3.6
--	增加了Slide函数,在_const中增加参数,可以通过修改GetColorMode修改getandCmpcolor时的取色方式
--	Slide:move(),Slide:Close() Slide:Enlarge()
---------------------------------------------------------------------------------------------------------------------------------
--2018-12-14 21:51 v1.3.7
--	假装优化了下
--	修改getScaleMainPoint,之前版本发现每次都会创建一次switch表,因此我把缩放函数放入了_const中改成全局的了,通过指针调用
--	对于速度貌似没什么影响不过不舒服改了
---------------------------------------------------------------------------------------------------------------------------------
--2018-12-15 22:45 v1.3.8
--	给point类增加元方法,虽然感觉没啥用 支持point对象的+-和==,+-会对Cur即缩放后的坐标进行相应的算术,并且以该点创建个新的point
--		a=point:new({x=100,y=200})
--		b=point:new({x=100,y=200})
--		c=a+b;c=a-b,a==b
--	修改了findColorEX中:现在会自动把第一个点作为锚点,并且只会调用getcolor作为取色
---------------------------------------------------------------------------------------------------------------------------------
--2018-12-17 11:21 v1.3.9
--	修复:system:new时会覆盖_const.Arry的问题
--	增加了内部函数point:newBymulti,目的是为了区分别对象的方法
---------------------------------------------------------------------------------------------------------------------------------
--2018-12-17 20:51 v1.3.10
--	很尴尬忘了给newBymulti加上Arry了
--	删除了个错误且不需要的函数getKeysSortedByValue,代替方法还是直接table.sort来的快
---------------------------------------------------------------------------------------------------------------------------------
--2018-12-18  11:05 v1.3.11
--	删除比色不需要的计算:把之前的取绝对值操作给删除了,计算改为运算操作符乘方
--	之前没有对对象中的Arry属性进行局部,导致缩放错误
---------------------------------------------------------------------------------------------------------------------------------
--2018-12-20  2:04 v1.3.12
-- 增加元方法tostring
---------------------------------------------------------------------------------------------------------------------------------
--2018-12-20  15:03 v1.3.13
-- 对多点对象的cmpColor中添加_printcmpColorErr_(),传入Cur,Dev和计算出的颜色插值,自定义报错信息打印
---------------------------------------------------------------------------------------------------------------------------------
--2018-12-22  17:02 v1.3.14
-- 修改Print,内部转换成字符串打印,打印速度将会变快
---------------------------------------------------------------------------------------------------------------------------------
--2018-12-22  21:00 v1.3.15
-- 修改比色,现在可以使用偏色进行比色
-- 再次修改Print,现在可以打印_G,并大幅优化速度
-- 给TableCopy增加拷贝元表的功能
-- 增加split函数
---------------------------------------------------------------------------------------------------------------------------------
--2018-12-23  0:38 v1.3.16
--	多点对象Click支持两种传参
--	修复多点对象index的bug,之前明名错误
-- 	HUD支持通过Rect进行创建
--	修复HUD 可选textsize不传入会报错的问题
--	增加HUD:clear() 清除HUD id
---------------------------------------------------------------------------------------------------------------------------------
--2018-12-24  14:44 v1.3.17
--	优化打印函数打印point和multiPoint
--	增加_printmultiPoint_,_printPoint_自定义打印内容
---------------------------------------------------------------------------------------------------------------------------------
--2018-12-25  19:91 v1.3.17(fix)
--	修复一个bug
--	增加multiPoint:offsetXY,实际上还是调用每个对象的self:offsetXY
--	runTime:checkTime()可以传入bool选择是否重设起点时间