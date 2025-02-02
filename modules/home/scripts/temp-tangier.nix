{pkgs}:
pkgs.writeShellScriptBin "temp" /*bash*/ ''

raw_gpu_temp () {
  #returns millidegree (1000)
  if [[ ! -f /sys/class/drm/card1/device/hwmon/hwmon0/temp1_input ]]; then
    echo "Error: GPU temperature file not found" >&2
    return 1
  else
    cat /sys/class/drm/card1/device/hwmon/hwmon0/temp1_input
  fi
}

celcius_gpu_temp () {
    local temp
    temp="$(raw_gpu_temp)"
    echo -n "$(( temp/1000 ))"
}

raw_gpu_fan () {
    #returns number eg 700 - rpm
    # cat /sys/class/drm/card1/device/hwmon/hwmon1/fan1_input 2> /dev/null
    cat /sys/class/drm/card1/device/hwmon/hwmon1/fan1_input
}

gpu_busy () {
    cat /sys/class/drm/card1/device/gpu_busy_percent
}

gpu_frequency () {
    #returns number eg 700 - rpm
    # list with current *
    #cat /sys/class/drm/card1/device/pp_dpm_mclk | grep "*"
    grep -oE "\s+[0-9]*.*\*" < /sys/class/drm/card1/device/pp_dpm_sclk | tr -cd "[:alnum:]" 
    #outputs [:digit:]Mhz eg 600Mhz
}

# raw_cpu_frequency () {
#     local frequency_hz
#     local frequency_ghz
#
#     #2cpu , 1gpu, 0- nvme
#     frequency_hz="$(cat /sys/class/hwmon/hwmon2/freq1_input 2> /dev/null)"
#     frequency_ghz=$(echo "scale=2; $frequency_hz / 100000000" | bc)
#
#     #outputs raw Ghz eg. just 3.5
#     printf '%s' "$frequency_ghz"
# }

raw_nvme_temp () {
    local nvme_temp
    local temp
    nvme_temp="$(cat /sys/class/hwmon/hwmon0/temp1_input 2> /dev/null)" #get temp in mC
    temp=$(echo "scale=2; $nvme_temp / 1000" | bc) # convert to C
    printf "%.0f\n" "$temp" # temp float - int
}

raw_ssd_temp () {
    local ssd_temp
    local temp
    ssd_temp="$(cat /sys/class/hwmon/hwmon1/temp1_input 2> /dev/null)" #get temp in mC
    temp=$(echo "scale=2; $nvme_temp / 1000" | bc) # convert to C
    printf "%.0f\n" "$temp" # temp float - int
}


proc_cpu () {
awk -F': ' '/cpu MHz/ { sum += $2; count++ } END { if (count > 0) printf "%.2f\n", (sum / count) / 1000 }' /proc/cpuinfo
}

device_picker () {
    case $1 in
        "gpu_temp")
            celcius_gpu_temp
            ;;
        # "cpu_temp")
        #     return
        #     ;;
        "cpu_freq")
            #raw_cpu_frequency
            proc_cpu
            ;;
        "gpu_busy")
            gpu_busy
            ;;
        "gpu_freq")
            gpu_frequency
            ;;
        "gpu_fans")
            raw_gpu_fan
            ;;
        "nvme_temp")
            raw_nvme_temp
            ;;
        "ssd_temp")
            raw_ssd_temp
            ;;
    esac
}
device_picker "$1"
''
