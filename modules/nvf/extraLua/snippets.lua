local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local extras = require("luasnip.extras")
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("nix", { --filetype first parameter
  s("hello", { --snippet name and snippet body
    t('print("hello nix world)')
  })
})

ls.add_snippets("nix", { --filetype first parameter
  s("enable", { --snippet name and snippet body
    t('enable = true;'),
    i(0)
  })
})

ls.add_snippets("nix", { --filetype first parameter
  s("import", { --snippet name and snippet body
    t('imports = ['),
    i(1),
    t(']')
  })
})

ls.add_snippets("nix", { --filetype first parameter
  s("host",
    fmt([[if config.networking.hostName == {} then {} else {};]],
    {
      c(1, {
        t('"tangier"'),
        t('"carthage"')
      }),
      i(2), --TODO: add more flare...how to cycle throught options
      i(3),
    })),
})

--TODO: see why its not working
vim.keymap.set({"i", "s" }, "<M-k>", function ()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, {silent = true })

vim.keymap.set({"i", "s" }, "<M-j>", function ()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, {silent = true })
