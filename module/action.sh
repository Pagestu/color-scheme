#!/system/bin/sh

if [ -f "/data/adb/modules/color_appeaeance/service.sh" ]; then
  sh "/data/adb/modules/thermvx/service.sh" &
  echo "Restarting!"
else
  echo "- service.sh not found."
fi

exit 0
