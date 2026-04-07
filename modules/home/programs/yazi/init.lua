--symlink in status bar
Status:children_add(function(self)
  local h = self._current.hovered
  if h and h.link_to then
    return " -> " .. tostring(h.link_to)
  else
    return ""
  end
end, 3300, Status.LEFT)

--user:group
Status:children_add(function()
  local h = cx.active.current.hovered
  if not h or ya.target_family() ~= "unix" then
    return ""
  end

  return ui.Line {
    ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
    ":",
    ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
    " ",
  }
end, 500, Status.RIGHT)

--full-border
--ya pkg add yazi-rs/plugins:full-border | delete to remvoe
-- require("full-border"):setup {
  -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
  -- type = ui.Border.ROUNDED,
-- }

-- BookMark stuff
require("bookmarks"):setup({
	last_directory = { enable = false, persist = false, mode="dir" },
	persist = "vim",             --vim (caps saved), all, none
	desc_format = "full",        --parent, full
	file_pick_mode = "hover",
	custom_desc_input = false,
	show_keys = true,
	notify = {
		enable = true,
		timeout = 1,
		message = {
			new = "New bookmark '<key>' -> '<folder>'",
			delete = "Deleted bookmark in '<key>'",
			delete_all = "Deleted all bookmarks",
		},
	},
})
