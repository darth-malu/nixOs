{ pkgs }:

pkgs.writeShellScriptBin "netspeed" ''
  # Algorithm
  # 1. get difference of rx1-rx2 every second
  # 2. get difference of tx1-tx2 every second
  # 3. TODO Display different icon for each interface
  # 4. Display Download | Upload

  function  getCurrentInterface() {
      for interface in /sys/class/net/*; do
          local interface_name=$(basename "$interface")
          if [ "$interface_name" != "lo" ] && [ "$(cat $interface/operstate)" = "up" ]; then
              printf '%s' "$interface_name"
              return 0
          fi
      done
  }


  function calculate_speed() {
      local rx1  rx2  tx1  tx2 received sent
      local current_interface=$(getCurrentInterface) # ethernet or wifi

      # No "up" interface
      [ -z "$current_interface" ] && { printf "⚠️"; return; }

      rx1="$(cat /sys/class/net/$current_interface/statistics/rx_bytes)"
      tx1="$(cat /sys/class/net/$current_interface/statistics/tx_bytes)"
      sleep 1
      rx2="$(cat /sys/class/net/$current_interface/statistics/rx_bytes)"
      tx2="$(cat /sys/class/net/$current_interface/statistics/tx_bytes)"

      # Calculate received (download) speed in Mbps with 1 decimal place
      received=$(awk "BEGIN {printf \"%.1f\", ($rx2 - $rx1)*8/1000000}")
      sent=$(awk "BEGIN {printf \"%.1f\", ($tx2 - $tx1)*8/1000000}")

      # Set to empty string if the speed is 0.0 (i.e., less than 0.05 Mbps)
      [ "$received" = "0.0" ] && received="" ; [ "$sent" = "0.0" ] && sent=""

      # If both are empty, show nothing at all
      if [ -z "$received" ] && [ -z "$sent" ]; then
          printf ""
          return
      fi

      printf "%s\t\t%s" "$received ↘" "$sent ↗"
      # received=$(( (rx2 - rx1) * 8 / 1000000 ))
      # sent=$(( (tx2 - tx1) * 8 / 1000000 ))


      # if [[ $current_interface =~ ^e ]]; then
      #   printf '%s | %s' "󰈁 $received ↘" "$sent ↗"
      # elif [[ $current_interface =~ ^w ]];then
      #   printf '%s | %s' " $received ↘" "$sent ↗"
      # fi
  }

  calculate_speed
''
