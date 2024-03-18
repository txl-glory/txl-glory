# 运行以下命令查看现有硬盘大小。

```shell
fanty@fanty:~$ sudo fdisk -l
Disk /dev/sda: 256 GiB, 274877906944 bytes, 536870912 sectors
Disk model: Ubuntu22-4-3-Lin
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: 9B2A94FC-A055-495A-B503-04535501A44C

Device       Start       End   Sectors Size Type
/dev/sda1     2048      4095      2048   1M BIOS boot
/dev/sda2     4096   4198399   4194304   2G Linux filesystem
/dev/sda3  4198400 134215679 130017280  62G Linux filesystem


Disk /dev/mapper/ubuntu--vg-ubuntu--lv: 62 GiB, 66567798784 bytes, 130015232 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
```

# 运行以下命令查看硬盘分区大小和文件系统类型

```shell
fanty@fanty:~$ sudo df -Th
Filesystem                        Type   Size  Used Avail Use% Mounted on
tmpfs                             tmpfs  1.6G  1.4M  1.6G   1% /run
/dev/mapper/ubuntu--vg-ubuntu--lv ext4    61G   57G  1.5G  98% /
tmpfs                             tmpfs  7.7G     0  7.7G   0% /dev/shm
tmpfs                             tmpfs  5.0M     0  5.0M   0% /run/lock
/dev/sda2                         ext4   2.0G  251M  1.6G  14% /boot
tmpfs                             tmpfs  1.6G  4.0K  1.6G   1% /run/user/1000
```

# 运行以下命令扩容分区

growpart <DeviceName> <PartionNumber>

```shell
fanty@fanty:~$ sudo growpart /dev/sda 3
CHANGED: partition=3 start=4198400 old: size=130017280 end=134215680 new: size=532672479 end=536870879
fanty@fanty:~$ sudo vgdisplay
  --- Volume group ---
  VG Name               ubuntu-vg
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  4
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                1
  Open LV               1
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               <254.00 GiB
  PE Size               4.00 MiB
  Total PE              65023
  Alloc PE / Size       15871 / <62.00 GiB
  Free  PE / Size       49152 / 192.00 GiB
  VG UUID               QthA63-EDCY-bDaV-uxMF-PHkL-KIBz-hcjgcq
```
