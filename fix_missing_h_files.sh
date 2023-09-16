gcc_v=`gcc --version | awk '/gcc/ {print $3}'`
kver=`uname -r`

sudo ln -sf /usr/lib/gcc/x86_64-pc-linux-gnu/$gcc_v/include/stdarg.h /lib/modules/$kver/build/include/.
