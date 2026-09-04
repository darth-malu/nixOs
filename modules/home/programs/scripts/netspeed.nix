{ pkgs }:

pkgs.writeShellScriptBin "netspeed" ''

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

      # If both are empty, show nothing at all
      if [ -z "$received" ] && [ -z "$sent" ]; then
          printf ""
          return
      fi
      case "$1" in
          'upload')
              printf '%s\n' "$sent"
              ;;
          'download')
              printf '%s\n' "$received"
              ;;
          *)
              printf "%s\t\t%s\n" "$received ↘" "$sent ↗"
              ;;
      esac
  }

  calculate_speed "$1"
''
