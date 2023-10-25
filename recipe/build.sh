#!/bin/sh

mkdir build

if [[ "$target_platform" == osx-arm64 ]]; then
	cmake -B build -S . \
		${CMAKE_ARGS} \
		-DCMAKE_INSTALL_PREFIX=$PREFIX \
		-DCMAKE_INSTALL_LIBDIR=lib \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_VERBOSE_MAKEFILE=ON \
		-DUSE_SHARED_MBEDTLS_LIBRARY=ON \
		-DENABLE_TESTING=Off

else
	cmake -B build -S . \
		${CMAKE_ARGS} \
		-DCMAKE_INSTALL_PREFIX=$PREFIX \
		-DCMAKE_INSTALL_LIBDIR=lib \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_VERBOSE_MAKEFILE=ON \
		-DUSE_SHARED_MBEDTLS_LIBRARY=ON \
                -DCMAKE_C_FLAGS=" -Wno-stringop-overflow "
fi

cmake --build build
cmake --install build

## from https://github.com/archlinux/svntogit-community/blob/packages/mbedtls/trunk/PKGBUILD 
# rename generic utils
for _prog in "$PREFIX"/bin/*; do
    _baseprog=$(basename "$_prog")
    mv -v "$_prog" "${_prog//$_baseprog/mbedtls_$_baseprog}"
done
