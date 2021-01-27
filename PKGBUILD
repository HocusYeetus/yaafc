# This is an example PKGBUILD file. Use this as a start to creating your own,
# and remove these comments. For more information, see 'man PKGBUILD'.
# NOTE: Please fill out the license field for your package! If it is unknown,
# then please put 'unknown'.

# Maintainer: Your Name <youremail@domain.com>
pkgname=yaafc-git
pkgver=1.0
pkgrel=1
pkgdesc="Yet another AMD fan controller"
arch=('any')
url="https://github.com/HocusYeetus/yaafc"
license=('GPL')
depends=('systemd' 'bash')
backup=('etc/yaafc.conf')
install=
changelog=
source=('yaafc' 'yaafc.service' 'yaafc.conf')
md5sums=()
validpgpkeys=()

prepare() {
	cd "$pkgname-$pkgver"
	patch -p1 -i "$srcdir/$pkgname-$pkgver.patch"
}

build() {
	cd "$pkgname-$pkgver"
	./configure --prefix=/usr
	make
}

check() {
	cd "$pkgname-$pkgver"
	make -k check
}

package() {
	cd "$pkgname-$pkgver"
	make DESTDIR="$pkgdir/" install
}
