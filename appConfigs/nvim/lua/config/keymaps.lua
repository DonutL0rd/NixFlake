-- Custom keymaps (LazyVim defaults are inherited automatically)
local map = vim.keymap.set

-- Buffer navigation
map("n", "<leader>bb", "<cmd>Telescope buffers<cr>", { desc = "Buffer picker" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Delete other buffers" })
