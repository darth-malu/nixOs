{ pkgs }:

pkgs.writeShellScriptBin "gaps" ''

  current_gaps_out_size() {
    #outputs clean number eg. 10
    hyprctl getoption general:gaps_out | grep custom | cut -d ' ' -f3
  }

  gaps_in_size() {
    #outputs clean number eg. 2
    hyprctl getoption general:gaps_in | grep custom | cut -d ' ' -f3
  }

  config_gaps_reader() {
    #NOTE: space essential in regex incase of comments in file
    case "$1" in
    "gaps_in")
      grep -E '\s+gaps_in' "$HOME/Shibuya/modules/home/programs/hyprland/ui.nix" | tr -cd [:digit:]
      ;;
    "gaps_out")
      grep -E '\s+gaps_out' "$HOME/Shibuya/modules/home/programs/hyprland/ui.nix" | tr -cd [:digit:]
      ;;
    esac
  }

  gap_incrementer() {
    local current_gap_out=$(current_gaps_out_size)

    local current_gap_in=$(gaps_in_size)

    case "$1" in
    "gaps_in_add")
      if [ "$current_gap_in" -lt 50 ]; then
        local new_gap=$((current_gap_in + 2))
        local icon="$HOME/Shibuya/assets/icons/gaps.sh/icons8-divider-30.png"

        hyprctl keyword general:gaps_in "$new_gap"

        notify-send -t 2 -a "changegaps" -u low -i "$icon"  "Gaps in: $new_gap"
      fi
      ;;
    "gaps_in_sub")
      if [ "$current_gap_in" -ge 2 ]; then
        local new_gap=$((current_gap_in - 2))
        local icon="$HOME/Shibuya/assets/icons/gaps.sh/icons8-merge-vertical-30.png"

        hyprctl keyword general:gaps_in "$new_gap"

        notify-send -t 2 -a "changegaps" \
          -u low \
          -i "$icon" \
          "Gaps in: $new_gap"
      fi
      ;;
    "gaps_in_reset")
      local icon="$HOME/Shibuya/assets/icons/gaps.sh/icons8-curly-arrow-30.png"
      local config_gaps_in=$(config_gaps_reader 'gaps_in')
      local config_gaps_out=$(config_gaps_reader 'gaps_out')

      hyprctl keyword general:gaps_in "$config_gaps_in"

      notify-send -t 1 -a "changegaps" -u low \
        -i "$icon" \
        "Gaps-in RESET ($config_gaps_in)"
      ;;
    "increment_gap")
      if [ "$current_gap_out" -le 50 ]; then
        local icon="$HOME/Shibuya/assets/icons/gaps.sh/icons8-up-arrow-30.png"
        local new_gap=$((current_gap_out + 1))

        hyprctl keyword general:gaps_out "$new_gap"

        notify-send -t 1 -a "changegaps" -u low -i "$icon" "Gaps out ($new_gap)"
      fi
      ;;
    "decrease_gap")
      if [ "$current_gap_out" -gt 0 ]; then
        local new_gap=$((current_gap_out - 2))
        local icon="$HOME/Shibuya/assets/icons/gaps.sh/icons8-down-arrow-30.png"

        hyprctl keyword general:gaps_out "$new_gap"

        notify-send -t 1 -a "changegaps" -u low -i "$icon" "Gaps out ($new_gap)"
      fi
      ;;
    "toggle_gaps_out")
      if [ "$current_gap_out" -gt 0 ]; then
        local off_icon="$HOME/Shibuya/assets/icons/gaps.sh/icons8-adjust-40.png"

        hyprctl keyword general:gaps_out 0

        notify-send -t 1 -a "changegaps" -u low -i "$off_icon" "Gaps turned OFF"
      else
        local icon="$HOME/Shibuya/assets/icons/gaps.sh/icons8-switch-on-30.png"

        hyprctl keyword general:gaps_out $(config_gaps_reader 'gaps_out')

        notify-send -t 1 -a "changegaps" -u low -i "$icon"  "Gaps turned ON"

      fi
      ;;
    "reset_config")
      local icon="$HOME/Shibuya/assets/icons/gaps.sh/icons8-u-turn-to-left-30.png"
      local gaps_out=$(config_gaps_reader 'gaps_out')

      hyprctl keyword general:gaps_out "$gaps_out"

      notify-send -t 1 -a "changegaps" -u low -i $icon "Gaps reset to: ($gaps_out)"
      ;;
    "reset_zero")
      local icon="$HOME/Shibuya/assets/icons/gaps.sh/icons8-u-turn-to-left-30.png"

      hyprctl keyword general:gaps_out 0

      notify-send -t 1 -a "changegaps" -u low -i $icon "Gaps out reset to ZERO"
      ;;
    esac
  }

  if [ $# -eq 0 ]; then # Ensure the script is called with an argument
    notify-send "Usage: $0 {increment_gap|decrease_gap|toggle_gaps_out|custom}"
    exit 1
  fi

  gap_incrementer "$1"
''
