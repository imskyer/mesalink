#!/bin/bash

set -xev

# Skip building MesaLink if testing for coverage only
if [[ "$COVERAGE" == "yes" ]]
then
    exit 0
fi

if [[ x"$TARGET" == "x" ]]
then
    #./autogen.sh --enable-examples
    mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX=../inst/usr/local ..
else
    rustup target add $RUST_TARGET
    #./autogen.sh --host=$TARGET --enable-rusthost=$RUST_TARGET
    mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX=../inst/usr/local -DCMAKE_TOOLCHAIN_FILE=${TRAVIS_BUILD_DIR}/cmake/${TARGET}.toolchain.cmake ..
fi

make
make install
du -sh $TRAVIS_BUILD_DIR/inst/usr/local/lib/*
