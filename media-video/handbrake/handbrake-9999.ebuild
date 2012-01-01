# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

EGIT_REPO_URI="https://github.com/HandBrake/HandBrake.git"

inherit gnome2-utils autotools git-2

SRC_HB="http://download.m0k.org/handbrake/contrib/"
DESCRIPTION="Open-source DVD to MPEG-4 converter"
HOMEPAGE="http://handbrake.fr/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+css gtk"
RDEPEND="sys-libs/zlib
	css? ( media-libs/libdvdcss )
	gtk? (	x11-libs/gtk+:2
			dev-libs/dbus-glib
			net-libs/webkit-gtk
			x11-libs/libnotify
			media-libs/gstreamer
			media-libs/gst-plugins-base
	)"
DEPEND="sys-devel/automake:1.4
	sys-devel/automake:1.9
	sys-devel/automake:1.10
	dev-lang/yasm
	dev-lang/python
	|| ( net-misc/wget net-misc/curl ) 
	${RDEPEND}"

src_configure() {
	# Python configure script doesn't accept all econf flags
	./configure --force --prefix=/usr \
		$(use_enable gtk) \
		|| die "configure failed"
}

src_compile() {
	WANT_AUTOMAKE=1.11 emake -C build || die "failed compiling ${PN}"
}

src_install() {
	emake -C build DESTDIR="${D}" install || die "failed installing ${PN}"
	emake -C build doc
	dodoc AUTHORS CREDITS NEWS THANKS
	dodoc build/doc/articles/txt/*
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
