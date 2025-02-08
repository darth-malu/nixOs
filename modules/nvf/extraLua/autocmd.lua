vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('yankee' , { clear = true }),
  callback = function()
    vim.highlight.on_yank({higroup='MatchParen', timeout =250})
  end,
})

-- vim.api.nvim_create_autocmd('BufEnter', {
--   desc = 'highlight current line only',
--   group = vim.api.nvim_create_augroup('highlighterr' , { clear = true }),
--   callback = function()
--     vim.cmd('highlight CursorLineNr ctermfg=yellow guifg=#3FA8C6') --#EBBCBA
--     -- Highlight the current line
--     vim.o.cursorline = true
--   end,
-- })

vim.api.nvim_create_autocmd('TermOpen', { --no numbers on term
  group = vim.api.nvim_create_augroup('custom-term-open' , { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- smallie terminal - like trouble
local job_id = 0
vim.keymap.set("n", "<leader>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
  job_id = vim.bo.channel --#TODO: investigate bo vs opt and bo.channel in particular
end)

vim.keymap.set("n", "<space>ls", function()
  -- make this launch my code
  vim.fn.chansend(job_id, { "ls -al\r\n" })
end)
