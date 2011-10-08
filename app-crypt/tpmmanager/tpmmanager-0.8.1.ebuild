# Copyright 1999-2009 Gentoo Foundation ; 2009-2009 Chris Gianelloni
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="2"

# inherit qt4-build

HOMEPAGE="http://projects.sirrix.com/trac/tpmmanager"
SRC_URI="mirror://sourceforge/tpmmanager/${P}.tar.gz
	doc? ( mirror://sourceforge/tpmmanager/${P}.pdf )"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=app-crypt/trousers-0.3.0
	dev-libs/glib
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	dev-libs/openssl"
RDEPEND="${DEPEND}"

src_prepare() {
	qmake || die "qmake"
}

src_install() {
	dobin bin/tpmmanager || die "dobin"
	dodoc README || die "dodoc"
}
