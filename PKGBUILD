# Maintainer: foo <foo(at)example(dot)org>
# Contributor: bar <bar(at)example(dot)org>
_kver=$(uname -r)
_pkgbase=rcraid
pkgname=rcraid-dkms
pkgver=17.2.1
pkgrel=1
pkgdesc="AMD AM4 socket X370 chipset motherbroad NVMe/SATA RAID driver (DKMS)"
arch=('i686' 'x86_64')
url="https://www.amd.com/en/support/chipsets/amd-socket-am4/x370"
license=('GPL2')
depends=('dkms')
makedepends=('linux-headers>=4.15')
# conflicts=("${_pkgbase}")
# install=${pkgname}.install
source=('manual://raid_linux_driver_8_01_00_039_public.zip'
		'dkms.conf'
		'linux-4.15.patch'
		'linux-5.4.patch'
		'linux-5.6.patch'
		'linux-5.14.patch'
		'linux-5.15.patch'
		'linux-5.17.patch'
		'linux-5.18.patch'
		'linux-6.2.patch'
		'linux-6.4.patch'
		'linux-6.6.patch'
		'linux-6.9.patch'
		'linux-6.11.patch'
		'linux-6.14.patch')
md5sums=('f5692d2ef952f8c903af90cdd9eb3ce6'
         '6f78c424353ae927e81bcbfec67afece'
         '461866e715a1fded49a3f7c043a173d7'
         'cac98de11cc5bd61fff72ff1c8cf363d'
         'bd1ef2b6bcefaec0abf7a832e937f01a'
         '956ccadfdf4fc4188ec0ab79b7311a71'
         '86d51a674e9d8a1aa56a1bb9d741ec8f'
         '978b50c203e156a09977052efc4fe2a5'
         '17ebd1ffddd4cc708117db8ec010c12e'
         'cd542069132376cc10cf0694f309763f'
         'b7e7e4567895a3fd377646113cc7af40'
         '0e2cbf17fefd34917f849073c25f63b6'
         'c171e789b72bd9d6cf68f7fa63dec366'
         '8843beaa9a544bfb5ac6c288a322cb9f'
         'ea3b996a096c3d3360daba6f89844726')

prepare() {
	if [ ! -d ${_pkgbase}-${pkgver} ]; then
		mkdir ${_pkgbase}-${pkgver}
	fi

	cp driver_sdk/src/* ${_pkgbase}-${pkgver}
}

build() {
	cd ${_pkgbase}-${pkgver}

	local src
	for src in "${source[@]}"; do
		src="${src%%::*}"
		src="${src##*/}"
		src="${src%.zst}"
		[[ $src = *.patch ]] || continue
		echo "Applying patch $src..."
		patch -Np1 < "../$src"
	done

	make KVERS="${_kver}" all
}

package() {
	# Copy dkms.conf
	install -Dm644 dkms.conf "${pkgdir}"/usr/src/${_pkgbase}-${pkgver}/dkms.conf

	# Set name and version
	sed -e "s/@_PKGBASE@/${_pkgbase}/" \
			-e "s/@PKGVER@/${pkgver}/" \
			-i "${pkgdir}"/usr/src/${_pkgbase}-${pkgver}/dkms.conf

	cd ${_pkgbase}-${pkgver}

	install -Dm644 rcraid.ko "${pkgdir}"/usr/lib/modules/"${_kver}"/kernel/drivers/scsi/rcraid.ko

	make clean
	cp -r * "${pkgdir}"/usr/src/${_pkgbase}-${pkgver}/
}
