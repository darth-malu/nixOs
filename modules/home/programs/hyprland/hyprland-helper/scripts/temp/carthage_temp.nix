{ pkgs }:
pkgs.writeShellScriptBin "temp" ''

  gpu_temp() {
    # Returns temperature in millidegrees Celsius (multiplied by 1000).
    awk '{print int($0/1000)}' /sys/class/drm/card*/device/hwmon/hwmon*/temp1_input | head -n1 #  only print the first match
  }

  gpu_fan() {
      cat /sys/class/drm/card1/device/hwmon/hwmon0/fan1_input # returns number eg 700 - rpm
  }

  gpu_busy() {   # %
      cat /sys/class/drm/card1/device/gpu_busy_percent 2> /dev/null
  }

  gpu_frequency() {
      # outputs [:digit:]Mhz eg 600Mhz # pick current -> *
      awk '/*/ {print $2}' /sys/class/drm/card1/device/pp_dpm_sclk
  }

  nvme_temp() {
      awk '{print int($0/1000)}' /sys/class/hwmon/hwmon1/temp1_input
  }

  ssd_temp() {
      awk '{ print int($0/1000)}' /sys/class/hwmon/hwmon1/temp1_input
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
