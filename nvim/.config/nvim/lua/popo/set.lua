vim.g.mapleader = " "

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Tabs & Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Undo persistence
vim.opt.swapfile = false
vim.opt.backup = false
local undodir = os.getenv("HOME") .. "/.vim/undodir"
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir
vim.opt.undofile = true

-- Search settings
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Colors & Display
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

-- Native Wayland clipboard integration
if vim.fn.has("wsl") == 0 and os.getenv("WAYLAND_DISPLAY") ~= nil then
	vim.opt.clipboard = "unnamedplus"
end
