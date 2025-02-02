/*bash*/''
#H - host, #E - inbuilt?, 
set -g @catppuccin_flavor "mocha"
set -g @catppuccin_status_background "default" # transparent bg

# Some basic mocha colors.
set -g @ctp_bg "#24273a"
set -g @ctp_surface_1 "#494d64"
set -g @ctp_fg "#cad3f5"
set -g @ctp_mauve "#c6a0f6"
set -g @ctp_crust "#181926"

# status
set -g @catppuccin_status_modules_right "session directory date_time" # application, session, directory, date_time
set -g status-right-length 100
set -g status-left-length 100
set -g status-left ""
# set -ogq @catppuccin_status_module_bg_color "#{@thm_surface_0}"
# set -ogq @catppuccin_status_module_bg_color "default" # "#{@thm_surface_0}"
set -ogq @catppuccin_status_module_bg_color "#222436" # "#{@thm_surface_0}"

# general
# set -g @catppuccin_directory_text "#{b:pane_current_path}"
set -g @catppuccin_directory_text "#{b:pane_current_path}" #TODO: session text mod as well
# set -g @catppuccin_directory_text "#{pane_current_path}"

#pane
# set -g pane-active-border-style "fg=#{@ctp_mauve},bg=#{@ctp_mauve}" #magenta
# set -ogq @catppuccin_pane_active_border_style "##{?pane_in_mode,fg=#{@thm_lavender},##{?pane_synchronized,fg=#{@thm_mauve},fg=#{@thm_lavender}}}"
set -ogq @catppuccin_pane_active_border_style "##{?pane_in_mode,fg=#{@ctp_mauve},##{?pane_synchronized,fg=#{@ctp_mauve},fg=#{@ctp_mauve}}}"
# set -g pane-border-style "fg=#{@ctp_mauve},bg=#{@ctp_mauve}" #brightblack
# set -ogq @catppuccin_pane_color "#{@thm_green}"

set -g pane-border-indicators colour # [off | colour | arrows | both]

# window
# default
set -g @catppuccin_window_default_fill "number" #none, number,all
set -g @catppuccin_window_default_text "#W"
# set -g @catppuccin_window_number_position "right" #left::
# current
set -g @catppuccin_window_current_fill "number"
set -g @catppuccin_window_status_style "custom" #slanted, none,basic(square), rounded
set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag, 󰋲 ,}"
# set -g @catppuccin_window_current_text "#W >- #{b:pane_current_path}" # use "#W" for application instead of directory

#seperators
set -g @catppuccin_window_left_separator  ""
# set -g @catppuccin_window_middle_separator "█ "
set -g @catppuccin_window_middle_separator ""
set -g @catppuccin_window_right_separator " "

set -g @catppuccin_window_current_number_color "#{@thm_lavender}"

set -ogq @catppuccin_window_flags "icon" # none, icon, or text
set -ogq @catppuccin_window_flags_icon_last " 󰖰" # -
set -ogq @catppuccin_window_flags_icon_mark " 󰃀" # M
set -ogq @catppuccin_window_flags_icon_silent " 󰂛" # ~
set -ogq @catppuccin_window_flags_icon_activity " 󱅫" # #
set -ogq @catppuccin_window_flags_icon_bell " 󰂞" # !

# Status line options
# set -ogq @catppuccin_status_middle_separator "█"
set -ogq @catppuccin_status_left_separator " "
set -ogq @catppuccin_status_right_separator ""
# set -g @catppuccin_status_right_separator_inverse "no"
# set -ogq @catppuccin_status_connect_separator "no" #if no , bg color blend with bg of tmux
set -ogq @catppuccin_status_fill "icon" #icon , all

set -g @catppuccin_date_time_text "%H:%M"
# set -g @catppuccin_status_modules_left "session"

# set -ogq @catppuccin_window_flags_icon_current " 󰖯" # *

# if BAT
if 'test -r /sys/class/power_supply/BAT*' {
  set -agF status-right '#{E:@catppuccin_status_battery}'
}
# Matches icon order when using `#F` (`#!~[*-]MZ`)
# set -ogq @catppuccin_window_flags_icon_format "##{?window_activity_flag,#{E:@catppuccin_window_flags_icon_activity},}##{?window_bell_flag,#{E:@catppuccin_window_flags_icon_bell},}##{?window_silence_flag,#{E:@catppuccin_window_flags_icon_silent},}##{?window_active,#{E:@catppuccin_window_flags_icon_current},}##{?window_last_flag,#{E:@catppuccin_window_flags_icon_last},}##{?window_marked_flag,#{E:@catppuccin_window_flags_icon_mark},}##{?window_zoomed_flag,#{E:@catppuccin_window_flags_icon_zoom},} "
''
