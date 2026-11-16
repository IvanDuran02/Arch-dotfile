vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
vim.keymap.set("n", "<C-y>", ":Git blame<CR>", { noremap = true, silent = true, desc = "Git blame" })
