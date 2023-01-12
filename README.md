### 使用说明
leader--->空格键

leader-q打开/关闭quickfix

F8 代码格式化

F9 编译

F10 运行

F12 编译&运行  

### Changelog

V0.30

使用 Vim9Script

V0.27  
修改了C语言编译指令以兼容谭语言  
  
V0.26  
修改默认编译的可执行文件后缀名为run避免与输出数据冲突  
  
V0.25  
移除了手写Vimrc的quickfixList开关,改用ListToggle插件  
更改默认的leader键为空格键  
  
V0.24  
添加插件vim-quickui  
  
V0.23  
去掉了传统编译  
使用内置make和Vim的quickfix特性来替代  
修改部分编译函数  
现在F5用于编译，出现错误后可以使用F4快捷键来打开/关闭quickfix  
  
V0.22  
用vim-plug替换了Vundle  
增加插件vim-github-dashboard(需要Ruby支持)和vim-easy-align  
  
V0.21  
更新到Vim8.2.35  
改用X64版本的Vim  
  
V0.20  
更新到Vim8.2  
更新了一些配置，仿宋在gVim(Windows)中显示的效果优于黑体  
  
V0.14  
加入了vimtweak.dll，支持窗口透明  
  
V0.13  
增加了AStyle代码自动格式化使用AStyle3.1ForWindows  
  
V0.12  
移除了Debug功能  
编译功能从内置term进行改回系统终端  
增加彩虹括号插件  
  
V0.11  
升级到Vim8.1  
添加了Debug功能，采用Vim自带TermDebug  
  
V0.10  
升级到Vim8.0  
编译功能改为在Vim8内置的term中进行  
修正了一些问题  
添加新主题  
  
V0.01  
初始版本  
