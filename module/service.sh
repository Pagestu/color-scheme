#!/system/bin/sh
MODDIR=${0%/*}

until [ "$(getprop sys.boot_completed)" = "1" ]; do sleep 2; done
sleep 5

while true; do
  sh "$MODDIR/natural.sh"
  sleep 30
done &