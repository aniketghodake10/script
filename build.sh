#!/bin/bash


#Colors
black='\033[0;30m'
red='\033[0;31m'
green='\033[0;32m'
blue='\033[0;34m'
purple='\033[1;35m'
cyan='\033[0;36m'
nc='\033[0m'

echo -e "$cyan---------------- ----";
echo -e "------------------------\n";
echo -e "██████╗--█████╗-- ███████╗";
echo -e "██╔══██╗██╔══██╗     ██  ╝";
echo -e "██████╔╝███████║     ██ ║";
echo -e "██╔══██╗██╔══██║     ██ ║";
echo -e "██║--██║██║--██║ ██████ ║";
echo -e "╚═╝--╚═╝╚═╝--╚═╝ ╚══════╝\n";


echo -e "$cyan  Welcome To Automated Kernel Compiler For smartron"
echo -e "$red  By rajkale99"
make clean && make mrproper && rm -rf output && rm -rf dsm/modules && rm -rf dsm/zImage
echo -e "$purple Cleaned Some Old Crappy Files"
export CROSS_COMPILE=~/toolchains/ubertc/bin/aarch64-linux-android-
mkdir output && mkdir modules && mkdir -p output/modules
echo -e "$green Compiler Set Sucessful"
export ARCH=arm64
echo -e "$brown  Compiler Set To Build For ARM64"
make -C $(pwd) O=output rk_defconfig
echo -e "$blue  Picked Stock Config"
make -j16 -C $(pwd) O=output
cp ~/rkoreo/output/arch/arm64/boot/Image.gz-dtb ~/rkoreo/dsm
mv ~/rkoreo/dsm/Image.gz-dtb ~/rkoreo/dsm/zImage
cd ~/rkoreo/output && mkdir -p modules/
find ~/rkoreo/output -name '*.ko' -exec cp {} modules/ \;
cd ~/rkoreo/output/modules
~/toolchains/ubertc/bin/aarch64-linux-android-strip --strip-unneeded *.ko && mkdir pronto && cp -a wlan.ko pronto_wlan.ko && mv pronto_wlan.ko pronto
mv ~/rkoreo/output/modules/ ~/rkoreo/dsm
echo -e "$nc  Building Has Been Completed"
