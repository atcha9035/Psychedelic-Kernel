KERNEL_DIR=$PWD
ANYKERNEL_DIR=../AnyKernel2
DTBTOOL=$KERNEL_DIR/dtbTool
DATE=$(date +"%d%m%Y")
KERNEL_NAME="Psychedelic-Kernel"
DEVICE="-scorpio-"
VER="-v0.4-"
TYPE="MIUI"
FINAL_ZIP="$KERNEL_NAME""$DEVICE""$DATE""$VER""$TYPE".zip

rm -rf $ANYKERNEL_DIR/scorpio/*.ko && rm $ANYKERNEL_DIR/scorpio/zImage $ANYKERNEL_DIR/scorpio/dtb
rm $KERNEL_DIR/arch/arm64/boot/Image.gz $KERNEL_DIR/arch/arm64/boot/dt.img $KERNEL_DIR/arch/arm64/boot/Image.gz-dtb

export ARCH=arm64
export KBUILD_BUILD_USER="Psy_Man"
export KBUILD_BUILD_HOST="PsyBuntu"
export CROSS_COMPILE=/home/psybuntu/toolchain/aarch64-linux-android-5.3/bin/aarch64-linux-android-
export LD_LIBRARY_PATH=/home/psybuntu/toolchain/aarch64-linux-android-5.3/lib/
export USE_CCACHE=1
export CCACHE_DIR=/home/psybuntu/DragonXia-OC/CCACHES/scorpio/.ccache

make clean && make mrproper
make scorpio_defconfig
make -j3

./dtbTool -s 2048 -o arch/arm64/boot/dt.img -p scripts/dtc/ arch/arm/boot/dts/qcom/
cp $KERNEL_DIR/arch/arm64/boot/dt.img $ANYKERNEL_DIR/scorpio/dtb
cp $KERNEL_DIR/arch/arm64/boot/Image.gz $ANYKERNEL_DIR/scorpio/zImage
cp $KERNEL_DIR/drivers/staging/qcacld-2.0/wlan.ko $ANYKERNEL_DIR/scorpio/
cp $KERNEL_DIR/drivers/char/hw_random/msm_rng.ko $ANYKERNEL_DIR/scorpio/
cp $KERNEL_DIR/drivers/char/hw_random/rng-core.ko $ANYKERNEL_DIR/scorpio/
cp $KERNEL_DIR/drivers/char/rdbg.ko $ANYKERNEL_DIR/scorpio/
cp $KERNEL_DIR/drivers/spi/spidev.ko $ANYKERNEL_DIR/scorpio/
cp $KERNEL_DIR/drivers/input/evbug.ko $ANYKERNEL_DIR/scorpio/
cp $KERNEL_DIR/crypto/ansi_cprng.ko $ANYKERNEL_DIR/scorpio/
cp $KERNEL_DIR/drivers/mmc/card/mmc_test.ko $ANYKERNEL_DIR/scorpio/
cp $KERNEL_DIR/drivers/video/backlight/lcd.ko $ANYKERNEL_DIR/scorpio/
cp $KERNEL_DIR/drivers/video/backlight/backlight.ko $ANYKERNEL_DIR/scorpio/
cp $KERNEL_DIR/drivers/video/backlight/generic_bl.ko $ANYKERNEL_DIR/scorpio/
cd $ANYKERNEL_DIR/scorpio
zip -r9 $FINAL_ZIP * -x *.zip $FINAL_ZIP
