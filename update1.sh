#!/bin/bash

echo '*********** 正常启动，开始测试  **************'


cores3399=6
cpucores=$(cat /proc/cpuinfo |grep processor | wc -l)
echo 'cpu cores:'$cpucores

if [[ $cpucores == $cores3399 ]]; then
    echo 'CUP核心数正常'
else
    echo 'CUP核心数异常'
    error_cpu=1
fi

min_speed=900

# /sys/devices/platform/ff540000.ethernet/net/eth0

# /sys/devices/platform/usb@ff600000/ff600000.dwc3/xhci-hcd.0.auto/usb4/4-1/4-1:1.0/net/eth1

# /sys/devices/platform/ff5c0000.usb/usb1/1-1/1-1:1.0/net/wlan0

#本地ip
eth0_host=$(ip -4 addr show eth0 | grep inet | awk '{print $2}' | cut -d / -f 1)
eth0_gateway=$( ip -4 addr show eth0 | grep inet | awk '{print $4}' | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.')

#网关地址
eth1_host=$(ip -4 addr show eth1 | grep inet | awk '{print $2}' | cut -d / -f 1)
eth1_gateway=$( ip -4 addr show eth1 | grep inet | awk '{print $4}' | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.')
echo 'eth0 host aaddress :'$eth0_host'      eth1 host aaddress:'$eth1_host

echo '*********** 开始网口测试  **************'
echo ' '
echo '     测试速度不低于900Mbits/sec为正常    '
echo ' '
eth0_txspeed=$(iperf3 -c ${eth0_gateway}1 -t 5   | grep sender | awk '{print $7}')
echo '网口0发送速度：' $eth0_txspeed
eth0_rxspeed=$(iperf3 -c ${eth0_gateway}1 -t 5 -R| grep sender | awk '{print $7}')
echo '网口0接收速度：' $eth0_rxspeed
eth1_txspeed=$(iperf3 -c ${eth1_gateway}1 -t 5   | grep sender | awk '{print $7}')
echo '网口1发送速度：' $eth1_txspeed
eth1_rxspeed=$(iperf3 -c ${eth1_gateway}1 -t 5 -R| grep sender | awk '{print $7}')
echo '网口1接收速度：' $eth1_rxspeed

echo '*********** 网口测试结果  **************'
if [ $eth0_txspeed ]; then
    if [ $eth0_txspeed -lt $min_speed  ]; then
        echo 'error 网卡0发送错误'
        error=1
    fi
else
    echo 'error 网卡0发送错误'
    error=1
fi

if [ $eth0_rxspeed ]; then
    if [ $eth0_rxspeed -lt $min_speed  ]; then
        echo 'error 网卡0接收错误'
        error=1
    fi
else
    echo 'error 网卡0接收错误'
    error=1
fi

if [ $eth1_txspeed ]; then
    if [ $eth1_txspeed -lt $min_speed ]; then
        echo 'error 网卡1发送错误'
        error=1
    fi
else
    echo 'error 网卡1发送错误'
    error=1
fi

if [ $eth1_rxspeed ]; then
    if [ $eth1_rxspeed -lt $min_speed ]; then
        echo 'error 网卡1接收错误'
        error=1
    fi
else
    echo 'error 网卡1接收错误'
    error=1
fi

pass=1

if [[ $error == $pass ]]; then
    echo '有线网卡测试未通过'
else
    echo '有线网卡测试通过'
fi

echo '*********** 网口测试结束  **************'
echo ' '

echo '*********** emmc读写测试 ***************'

rspeed=$(hdparm -t /dev/mmcblk0 | awk '{print $11}' | cut -b 1-3)
echo 'emmc读取速度：' ${rspeed} 'MB/sec'
rsmin=100

if [ $rspeed ]; then
    if [ $rspeed -lt $rsmin  ]; then
        echo 'error emmc读取速度过低'
        rserror=1
    fi
else
    echo 'error emmc存储设备读取失败'
    rserror=1
fi

echo '*********** 无线网卡测试  **************'
echo ' '
echo '       能扫描到无线信号为正常     '
echo '    若未焊接无线模块则忽略此项测试'
echo ' '
echo '*********** 无线网卡测试  **************'

wlan_device=$(ifconfig -a | grep wlan | awk '{print $1}')

echo 'wireless device list: ' $wlan_device

ip link set wlan0 up
ip link set wlan1 up

iw dev wlan0 scan | grep SSID
iw dev wlan1 scan | grep SSID

echo '*********** 无线网卡测试结束  **************'
echo ' '


echo '-------------测试结果汇总----------------'
echo '--------------测试结果汇总----------------'

if [[ $error_cpu == 1 ]]; then
    echo 'error cpu核心数异常，测试未通过'
else
    echo 'ok    cpu核心数正常'
fi

if [[ $error == $pass ]]; then
    echo 'error 有线网卡测试， 测试未通过'
else
    echo 'ok    有线网卡正常'
fi

if [[ $rserror == 1 ]]; then
    echo 'error emmc读写测试， 测试未通过'
else
    echo 'ok    emmc读写正常'
fi
