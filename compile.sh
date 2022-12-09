#!/bin/bash
# Build mutter from Debian git
# Note that we build two times:
# * once with only the essential, pinenote-required, patch(es)
# * once with additional patches to restrict refresh rates

# ####################### first compile #######################################
cd /root/mutter

if [ ! -d mutter ]; then
    # git clone --branch debian/master https://salsa.debian.org/gnome-team/mutter.git
    apt source mutter
    mv mutter-* mutter
    cd mutter
    patch -p1 < ../0001-Add-META_CONNECTOR_TYPE_DPI.patch
    cd ..
fi

XZ_OPT='-9' tar -cvJf mutter_src_flavor1.tar.xz mutter

cd mutter
time DEB_BUILD_OPTIONS="nocheck parallel=4" dpkg-buildpackage --build=binary
cd ..

outdir="mutter_arm64_debs_flavor1"
test -d "${outdir}" && rm -r "${outdir}"
mkdir "${outdir}"
rm *dbgsym*.deb
rm *test*.deb
mv *.deb "${outdir}"/
mv mutter_src_flavor1.tar.xz "${outdir}/"

echo "Move output directory to artifact directory"

test -d /github/home/"${outdir}" && rm -r /github/home/"${outdir}"

mv "${outdir}" /github/home

# ####################### second compile ######################################
cd /root/mutter
test -d mutter && rm -r mutter

if [ ! -d mutter ]; then
    apt source mutter
    mv mutter-* mutter
    cd mutter
    patch -p1 < ../0001-Add-META_CONNECTOR_TYPE_DPI.patch
	patch -p1 < ../patches_very_experimental/p_refresh_rate_15_Hz.patch
    cd ..
fi
XZ_OPT='-9' tar -cvJf mutter_src_flavor2.tar.xz mutter

cd mutter
time DEB_BUILD_OPTIONS="nocheck parallel=4" dpkg-buildpackage --build=binary
cd ..

outdir="mutter_arm64_debs_flavor2"
test -d "${outdir}" && rm -r "${outdir}"
mkdir "${outdir}"
rm *dbgsym*.deb
rm *test*.deb
mv *.deb "${outdir}"/
mv mutter_src_flavor2.tar.xz "${outdir}/"

echo "Move output directory to artifact directory"

test -d /github/home/"${outdir}" && rm -r /github/home/"${outdir}"

mv "${outdir}" /github/home
chmod -R 0777 /github/home
