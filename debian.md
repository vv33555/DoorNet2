# 在 Debian 上安装openmediavault

为此，在 x86 上只需使用Debian netinst images安装系统。之后应用以下命令。请不要安装图形环境，仅使用最小的服务器安装。有关分步安装指南，请查看 Debian 最小安装指南。

在 ARM 设备上检查是否有合适的Armbian Buster (Debian 10) 映像可用。安装 Armbian 后，使用 armbian-config工具一步安装 OMV，其中包括所有性能和可靠性调整。如果您的设备没有 Armbian，只需按照下面概述的步骤操作即可。

在Raspberry Pi OS上，以下说明仅部分有效。请参考具体的安装脚本

手动安装 openmediavault 密钥环：
``
apt-get install --yes gnupg
wget -O "/etc/apt/trusted.gpg.d/openmediavault-archive-keyring.asc" https://packages.openmediavault.org/public/archive.key
apt-key add "/etc/apt/trusted.gpg.d/openmediavault-archive-keyring.asc"
``
添加软件包存储库：
`
cat <<EOF >> /etc/apt/sources.list.d/openmediavault.list

deb https://packages.openmediavault.org/public usul main

# deb https://downloads.sourceforge.net/project/openmediavault/packages usul main

## Uncomment the following line to add software from the proposed repository.

# deb https://packages.openmediavault.org/public usul-proposed main

# deb https://downloads.sourceforge.net/project/openmediavault/packages usul-proposed main

## This software is not part of OpenMediaVault, but is offered by third-party

## developers as a service to OpenMediaVault users.

# deb https://packages.openmediavault.org/public usul partner

# deb https://downloads.sourceforge.net/project/openmediavault/packages usul partner

EOF`

笔记

如果是中国大陆用户，TUNA 提供镜像服务。

安装 openmediavault 包：
`
export LANG=C.UTF-8
export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=none
apt-get update
apt-get --yes --auto-remove --show-upgraded \
    --allow-downgrades --allow-change-held-packages \
    --no-install-recommends \
    --option DPkg::Options::="--force-confdef" \
    --option DPkg::Options::="--force-confold" \
    install openmediavault-keyring openmediavault

omv-confdbadm populate
`
