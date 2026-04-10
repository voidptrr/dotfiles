#!/usr/bin/env sh

polybar-msg cmd quit >/dev/null 2>&1 || true

polybar top >/tmp/polybar-top.log 2>&1 &
