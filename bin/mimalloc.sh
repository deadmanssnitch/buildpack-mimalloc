#!/bin/sh

export LD_PRELOAD="/app/vendor/mimalloc/lib/libmimalloc.so $LD_PRELOAD"
exec "$@"
