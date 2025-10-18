# Embest EC9100 Buildroot

Build and run newer U-Boot and Kernel

### Instructions (For 6.17 Kernel)

Fetch Embest External Buildroot (This repo)
~~~
git clone https://github.com/kbader94/Embest-EC9100-Buildroot.git
cd Embest-EC9100-Buildroot
~~~

Fetch Buildroot
~~~
git clone https://github.com/buildroot/buildroot.git
cd buildroot
~~~

Build
~~~
make BR2_EXTERNAL=../embest_br_ext embest_ec9100_defconfig
make
~~~

Copy to SD Card
~~~
sudo umount /dev/sdX?*
sudo dd if=output/images/sdcard.img of=/dev/sdX bs=4M conv=fsync
~~~
Note: replace sdX with the proper SD Card device name. Use lsblk to determine which device to use.

## Other Kernel versions

To build other kernel versions, you'll need to patch in the imx6ul-embest-ec9100.dts and makefile, and modify the BR2_PACKAGE_HOST_LINUX_HEADERS_CUSTOM_ Configuration option in embest_ec9100_defconfig to specify the desired kernel header version. 

