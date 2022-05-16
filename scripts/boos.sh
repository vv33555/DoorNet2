#!/bin/bash

rm -rf target/linux/rockchip
svn co https://github.com/LPDDR6-10000MHz/lede/trunk/target/linux/rockchip target/linux/rockchip
rm -rf package/boot
svn co https://github.com/LPDDR6-10000MHz/lede/trunk/package/boot package/boot
rm -rf include/u-boot.mk
wget -P include https://raw.githubusercontent.com/LPDDR6-10000MHz/lede/flash/include/u-boot.mk
rm -rf package/base-files/files/etc/shadow
wget -P package/base-files/files/etc https://raw.githubusercontent.com/DHDAXCW/openwrt/master/package/base-files/files/etc/shadow
rm -rf package/network/services/dnsmasq/files/dhcp.conf
wget -P package/network/services/dnsmasq/files https://raw.githubusercontent.com/DHDAXCW/openwrt/master/package/network/services/dnsmasq/files/dhcp.conf
rm -rf package/kernel/mac80211
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/mac80211 package/kernel/mac80211
# rtl8821cu
rm -rf package/kernel/rtl8821cu
svn co https://github.com/immortalwrt/immortalwrt/branches/master/package/kernel/rtl8821cu package/kernel/rtl8821cu

# Add luci-app-bypass
rm -rf feeds/Boos/luci-app-bypass
git clone --depth=1 https://github.com/garypang13/luci-app-bypass.git package/lean/luci-app-bypass

# Add luci-app-passwall
rm -rf feeds/Boos/brook
rm -rf feeds/Boos/chinadns-ng
rm -rf feeds/Boos/dns2socks
rm -rf feeds/Boos/dns2tcp
rm -rf feeds/Boos/hysteria
rm -rf feeds/Boos/ipt2socks
rm -rf feeds/Boos/microsocks
rm -rf feeds/Boos/naiveproxy
rm -rf feeds/Boos/pdnsd-alt
rm -rf feeds/Boos/shadowsocks-rust
rm -rf feeds/Boos/shadowsocksr-libev
rm -rf feeds/Boos/simple-obfs
rm -rf feeds/Boos/ssocks
rm -rf feeds/Boos/tcping
rm -rf feeds/Boos/trojan-go
rm -rf feeds/Boos/trojan-plus
rm -rf feeds/Boos/trojan
rm -rf feeds/Boos/v2ray-core
rm -rf feeds/Boos/v2ray-geodata
rm -rf feeds/Boos/v2ray-plugin
rm -rf feeds/Boos/xray-core
rm -rf feeds/Boos/xray-plugin
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall
svn co https://github.com/xiaorouji/openwrt-passwall/branches/luci/luci-app-passwall

# Add OpenClash
rm -rf package/feeds/Boos/luci-app-clash
rm -rf feeds/Boos/luci-app-clash
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/lean/luci-app-openclash

# Add luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/lean/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/lean/luci-app-argon-config
rm -rf customfeeds/luci/themes/luci-theme-argon
rm -rf package/lean/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
cp -f $GITHUB_WORKSPACE/data/bg1.jpg package/lean/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg

# Mod zzz-default-settings
pushd package/lean/default-settings/files
sed -i '/http/d' zzz-default-settings
sed -i '/18.06/d' zzz-default-settings
export orig_version=$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
export date_version=$(date -d "$(rdate -n -4 -p ntp.aliyun.com)" +'%Y-%m-%d')
sed -i "s/${orig_version}/${orig_version} (${date_version})/g" zzz-default-settings
popd

# Fix mt76 wireless driver
pushd package/kernel/mt76
sed -i '/mt7662u_rom_patch.bin/a\\techo mt76-usb disable_usb_sg=1 > $\(1\)\/etc\/modules.d\/mt76-usb' Makefile
popd

# Change default shell to zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# Modify default IP
sed -i 's/10.10.10.1/192.168.11.1/g' package/base-files/files/bin/config_generate
sed -i '/uci commit system/i\uci set system.@system[0].hostname='FusionWrt'' package/lean/default-settings/files/zzz-default-settings
sed -i "s/OpenWrt /DHDAXCW @ FusionWrt /g" package/lean/default-settings/files/zzz-default-settings

# 删除定时coremark
rm -rf ./customfeeds/packages/utils/coremark
svn co https://github.com/DHDAXCW/packages/trunk/utils/coremark customfeeds/packages/utils/coremark

echo -e " DHDAXCW's FusionWrt built on "$(date +%Y.%m.%d)"\n -----------------------------------------------------" >> package/base-files/files/etc/banner
