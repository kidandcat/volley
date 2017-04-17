#!/bin/sh
cd src
nim c --out:../ng2bounce -d:release --opt:speed bounce.nim
rm -rf nimcache
cd ..

