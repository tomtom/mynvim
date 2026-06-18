vim.api.nvim_create_user_command("CloseWin", function()
  if vim.fn.winnr("$") == 1 then
    vim.cmd("q")
  else
    vim.cmd("close")
  end
end, {})

vim.keymap.set("n", "<C-w>c", "<cmd>CloseWin<CR>", { silent = true })

