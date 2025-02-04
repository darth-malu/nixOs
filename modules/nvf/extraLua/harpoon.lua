require("telescope").load_extension('harpoon')

-- local config = function ()
--     local harpoon = require("harpoon")
--
--     -- REQUIRED
--     harpoon:setup()
--
--     vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
--     vim.keymap.set("n", "<leader><C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
--
--     vim.keymap.set("n", "<C-1>", function() harpoon:list():select(1) end)
--     vim.keymap.set("n", "<C-2>", function() harpoon:list():select(2) end)
--     vim.keymap.set("n", "<C-3>", function() harpoon:list():select(3) end)
--     vim.keymap.set("n", "<C-4>", function() harpoon:list():select(4) end)
--
--     -- Toggle previous & next buffers stored within Harpoon list
--     vim.keymap.set("n", "<C-H>", function() harpoon:list():prev() end)
--     vim.keymap.set("n", "<C-L>", function() harpoon:list():next() end)
-- end

