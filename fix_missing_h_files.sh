gcc_v=`gcc --version | awk '/gcc/ {print $3}'`

sudo ln -sf /usr/lib/gcc/x86_64-pc-linux-gnu/$gcc_v/include/stdarg.h /usr/src/linux-git/include/.
