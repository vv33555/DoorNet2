# DoorNet2
## 👉使用本固件前，请严格遵守国家互联网使用相关法律规定,不要违反国家法律规定！👈

### 注：不要用恢复备份。。不保证某个插件是否正常运行。。。建议重新设置贼好！

### 默认编译  

- 用户名：root 密码：password  管理IP：192.168.11.1
- 下载地址： https://github.com/DHDAXCW/DoorNet2/releases
### 固件分类 在[releases](https://github.com/DHDAXCW/DoorNet2/releases)有备注关键词
- 精简_超频_docker容器 带docker容器 有超频 玩udp不建议选择这个
- 稳定版_默频 不含有超频，稳定性，发热极少
- 全插件_默频 带有全插件，而且不超频，发热极少
- 全插件_超频（推荐）满足全部要求，插件都有
### 基于lede openwrt kernel 5.4内核固件下载
- https://github.com/DHDAXCW/doornet2-5.4/releases
### 购买设备
- 懂得openwrt玩法建议去买官网，小白不懂可以去下面其他商家，有售后支持。官网售后不懂。。。
- BIGDONGDONG https://item.taobao.com/item.htm?spm=a230r.1.14.56.33e15e555hXDPd&id=670679179652
- JackyLee https://item.taobao.com/item.htm?spm=a21dvs.23580594.0.0.621e3d0df6lcxD&ft=t&id=670195918968
- 壹阿壹阿壹 https://item.taobao.com/item.htm?spm=a21dvs.23580594.0.0.67813d0dEmsMiR&ft=t&id=670082025644
- 官网 https://item.taobao.com/item.htm?spm=a2oq0.12575281.0.0.16c11debx4XxEY&ft=t&id=668601945840

# [EMMC刷机方法](https://github.com/DHDAXCW/DoorNet2/blob/main/emmc.md)

# 系统截图
![image](https://user-images.githubusercontent.com/74764072/159131539-6919908e-502b-4754-88f5-f44e12f3bc10.png)

![image](https://user-images.githubusercontent.com/74764072/150896121-f24cd658-2a9f-49d0-9e88-ceaedd1bc67f.png)

![image](https://user-images.githubusercontent.com/74764072/150896194-92269903-6865-40aa-b227-d068ae067510.png)

![image](https://user-images.githubusercontent.com/74764072/150896256-f8603322-332b-4bea-bfe3-b2f7ab1cd29a.png)

![image](https://user-images.githubusercontent.com/74764072/150896333-71a0a2d5-a7a1-429b-a3d6-8824d4d279a0.png)

## 提示
 - 如果感觉很热  就加风扇，推荐 风扇6cm×6cm，薄1cm，usb也行 或者1.25排针
 - 风扇链接 [点击进入](https://s.click.taobao.com/t?e=m%3D2%26s%3Dd8Ack0Lbx8McQipKwQzePOeEDrYVVa64LKpWJ%2Bin0XJRAdhuF14FMXpyNmcFd6mT8sviUM61dt2T0mcOGN1M6FAj1gqltKaEfKzCcEr0EW0YuhTK3FPxiHMT7yc3NZrQKSOkJV8harV3phaPbavinqGCwVfdcN0wcSpj5qSCmbA%3D)  建议用这种风扇
 - 年后号上架
# [赏个鸡腿吧](https://afdian.net/@dhdaxcw/plan)
### https://afdian.net/@dhdaxcw/plan

请不要fork我项目，因为yml文件中已托管到我本地服务器，目的是为了加速编译。
如果想fork自己编译，那就请到yml文件中修改下面
```bash
23行 runs-on: self-hosted 改为 runs-on: ubuntu-20.04
185行 runs-on: self-hosted 改为 runs-on: ubuntu-20.04
```
改好就可以用github的机器编译了


## 鸣谢

特别感谢以下项目： 

Openwrt 官方项目：

<https://github.com/openwrt/openwrt>

Lean 大的 Openwrt 项目：

<https://github.com/coolsnowwolf/lede>

immortalwrt 的 OpenWrt 项目：

<https://github.com/immortalwrt/immortalwrt>

P3TERX 大佬的 Actions-OpenWrt 项目：

<https://github.com/P3TERX/Actions-OpenWrt>

SuLingGG 大佬的 Actions 编译框架 项目：

https://github.com/SuLingGG/OpenWrt-Rpi
