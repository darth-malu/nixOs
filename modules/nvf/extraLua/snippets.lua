
local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("nix", { --filetype first parameter
  s("hello", { --snippet name and snippet body
    t('print("hello nix world)')
  })
})
