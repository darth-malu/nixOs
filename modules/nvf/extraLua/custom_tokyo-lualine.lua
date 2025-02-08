local badu = {
  normal = {
    a = {bg = "#82AAFF", fg = "#242B42", gui = 'bold'},
    b = {bg = nil, fg = "#769AE7"},
    c = {bg = nil, fg = "#4BCDB5"}
  },
  insert = {
    a = {bg = "#C3E88D", fg = "#242B42", gui = 'bold'},
    b = {bg = nil, fg = "#AFD084"},
    c = {bg = nil, fg = "#AFD084"}
  },
  visual = {
    a = {bg = "#C099FF", fg = "#242B42", gui = 'bold'},
    b = {bg = nil, fg = "#AD8BE7"},
    c = {bg = nil, fg = "#AD8BE7"}
  },
  replace = {
    a = {bg = "#FF757F", fg = "#242B42", gui = 'bold'},
    b = {bg = nil, fg = "#F1707C"},
    c = {bg = nil, fg = "#F1707C"}
  },
  command = {
    a = {bg = "#FFC777", fg = "#242B42", gui = 'bold'},
    b = {bg = nil, fg = "#E4B372"},
    c = {bg = nil, fg = "#242B42"}
  },
  -- inactive = {
  --   a = {bg = darkgray, fg = gray, gui = 'bold'},
  --   b = {bg = "#3B4261", fg = gray},
  --   c = {bg = nil, fg = gray}
  -- }
}

require('lualine').setup {
  options = {theme = badu}
}
