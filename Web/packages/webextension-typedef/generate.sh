#!/bin/bash
rm -rf tmp
mkdir tmp
git clone --depth 1 https://github.com/DefinitelyTyped/DefinitelyTyped tmp/DefinitelyTyped
cp tmp/DefinitelyTyped/types/webextension-polyfill/index.d.ts .
cp -r tmp/DefinitelyTyped/types/webextension-polyfill/namespaces .
patch index.d.ts patches/index.d.ts.patch
patch namespaces/runtime.d.ts patches/runtime.d.ts.patch
