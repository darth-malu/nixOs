{ pkgs }:

pkgs.writeShellScriptBin "netspeed" ''
  # Algorithm
  # 1. get difference of rx1-rx2 every second
  # 2. get difference of tx1-tx2 every second
  # 3. TODO Display different icon for each interface
  # 4. Display Download | Upload

  function  getCurrentInterface() {
      for interface in /sys/class/net/*; do
          if [ "$(cat $interface/operstate)" = "up" ]; then
              basename "$interface"
              return 0
          fi
      done
  }


  function calculate_speed() {
      local rx1  rx2  tx1  tx2 received sent
      local current_interface=$(getCurrentInterface) # ethernet or wifi

      [ -z "$current_interface" ] && { printf "Interface Missing ⚠️"; return; }

      rx1="$(cat /sys/class/net/$current_interface/statistics/rx_bytes)"
      tx1="$(cat /sys/class/net/$current_interface/statistics/tx_bytes)"
      sleep 1
      rx2="$(cat /sys/class/net/$current_interface/statistics/rx_bytes)"
      tx2="$(cat /sys/class/net/$current_interface/statistics/tx_bytes)"

      received=$(awk "BEGIN {printf \"%.2f\", ($rx2 - $rx1)*8/1000000}")
      sent=$(awk "BEGIN {printf \"%.2f\", ($tx2 - $tx1)*8/1000000}")

      # received=$(( (rx2 - rx1) * 8 / 1000000 ))
      # sent=$(( (tx2 - tx1) * 8 / 1000000 ))

      printf '%s | %s' "$received ↘" "$sent ↗"

      # if [[ $current_interface =~ ^e ]]; then
      #   printf '%s | %s' "󰈁 $received ↘" "$sent ↗"
      # elif [[ $current_interface =~ ^w ]];then
      #   printf '%s | %s' " $received ↘" "$sent ↗"
      # fi
  }

  calculate_speed
''
