{ pkgs }:
pkgs.writeShellScriptBin "temp" ''

  gpu_temp() {
    # Returns temperature in millidegrees Celsius (multiplied by 1000).
    # local raw_temp="$(cat /sys/class/drm/card1/device/hwmon/hwmon2/temp1_input 2> /dev/null)"
    # echo -n "$(($raw_temp / 1000))"
    printf '%d' "$(($(cat /sys/class/drm/card1/device/hwmon/hwmon2/temp1_input 2> /dev/null) / 1000))"
  }

  gpu_fan() {
      # returns number eg 700 - rpm
      cat /sys/class/drm/card1/device/hwmon/hwmon0/fan1_input 2> /dev/null
  }

  gpu_busy() {
      cat /sys/class/drm/card1/device/gpu_busy_percent 2> /dev/null
  }

  gpu_frequency() {
      #outputs [:digit:]Mhz eg 600Mhz
      # list with current *
      #cat /sys/class/drm/card1/device/pp_dpm_mclk | grep "*"
      grep -oE "\s+[0-9]*.*\*" </sys/class/drm/card1/device/pp_dpm_sclk | tr -cd "[:alnum:]" 2> /dev/null
  }

  nvme_temp() {
      # nvme_temp="$(cat /sys/class/hwmon/hwmon0/temp1_input 2> /dev/null)" #get temp in mC
      local nvme_temp="$(cat /sys/class/hwmon/hwmon1/temp1_input)" #get temp in mC
      local temp=$(echo "scale=2; $nvme_temp / 1000" | bc)         # convert to C
      printf "%.0f\n" "$temp"                                # temp float - int
  }

  ssd_temp() {
      local ssd_temp="$(cat /sys/class/hwmon/hwmon1/temp1_input 2>/dev/null)" #get temp in mC
      printf "%.0f\n" "$(echo "scale=2; $(cat /sys/class/hwmon/hwmon1/temp1_input 2>/dev/null) / 1000" | bc)"                                           # temp float - int
  }

  proc_cpu() {
      awk -F': ' '/cpu MHz/ { sum += $2; count++ } END { if (count > 0) printf "%.2f\n", (sum / count) / 1000 }' /proc/cpuinfo
  }

  device_picker() {
      case $1 in
      "gpu_temp")
          gpu_temp
          ;;
      "cpu_freq")
          proc_cpu
          ;;
      "gpu_busy")
          gpu_busy
          ;;
      "gpu_freq")
          gpu_frequency
          ;;
      "gpu_fans")
          gpu_fan
          ;;
      "nvme_temp")
          nvme_temp
          ;;
      "ssd_temp")
          ssd_temp
          ;;
      esac
  }
  device_picker "$1"
''
