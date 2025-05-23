-- ------------------
-- options
-- -------------------
-- hellow
local options = {
  -- File handling
  backup = false,          
  writebackup = false,     
  swapfile = false,        

  -- UI/Display
  termguicolors = true,    
  laststatus = 0,          
  number = true,           
  relativenumber = true,   
  ruler = false,           
  showcmd = false,         
  cmdheight = 1,           
  wrap = false,            
  guicursor = "",          
  syntax = "off",          

  -- Search
  hlsearch = false,        
  incsearch = true,        
  ignorecase = true,       
  smartcase = true,        

  -- Indentation
  expandtab = true,        
  tabstop = 2,             
  shiftwidth = 2,          
  softtabstop = 2,         
  autoindent = true,       
  smartindent = true,      
  cindent = true,          

  -- Completion
  completeopt = { "menuone", "noselect" },  

  -- Window management
  splitbelow = true,       
  splitright = true,      

  -- Text display
  conceallevel = 0,      
}
for key, value in pairs(options) do
  vim.opt[key] = value
end

vim.g.netrw_banner = 0
vim.cmd.colorscheme("darkland")

-- -------------
-- COMMANDS
-- -------------
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- ------------------
-- Keybindings
-- ------------------
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

function remap(mode, maps)
  local o = { noremap = true, silent = mode ~= "c" }
  for _, key in ipairs(maps) do
    vim.keymap.set(mode, key[1], key[2])
  end
end

local nmaps = {
  -- Resize window
  { "<C-Down>", ":resize -2<CR>" },
  { "<C-Left>", ":vertical resize +2<CR>" },
  { "<C-Right>", ":vertical resize -2<CR>" },
  { "<C-Up>", ":resize +2<CR>" },
  -- create empty line
  { "<C-Return>", "o<ESC>" },
  { "<S-Return>", "O<ESC>" },
  -- dup line
  { "<C-,>", ":t.<CR>" },
  -- Move cursor to end and beginning
  { "<C-l>", "$" },
  { "<C-h>", "^" },
  -- move up and down
  { "<C-n>", ":m .+1<CR>==" },
  { "<C-p>", ":m .-2<CR>==" },
  -- V-Line
  { "<Leader>;", "V" },
  -- Select whole file
  { "<Leader>a", "ggVG" },
  -- buffer
  { "<Leader>W", ":wa<CR>" },
  { "<Leader>e", ":Exp<CR>" },
  { "<Leader>q", ":bd<CR>" },
  { "<Leader>r", ":source $MYVIMRC<CR>" },
  { "<Leader>w", ":w<CR>" },
  -- paste from sys clipboard
  { "<Leader>p", '"+p' },
  { "<Leader>P", '"+P' },
  -- delete without change register
  { "<leader>d", '"_d' },
  -- keep cursor pos after yank
  { "<Leader>y", '"+ygv<ESC>' },
  -- Exec lua code 
  { "<Leader>x", ":.lua<CR>" },
  { "X", '"_X' },
  { "x", '"_x' },
  -- mini picker
  { "<Leader>fb", ":Pick buffers<CR>" },
  { "<Leader>ff", ":Pick files<CR>" },
  { "<Leader>fs", ":Pick grep_live<CR>" },
}

local imaps = {
  { "jk", "<Esc>" },
  { "<C-BS>", "<C-w>" },
  { "<C-l>", "<C-o>x" },
  { "<C-Return>", "<C-o>o" },
  { "<S-Return>", "<C-o>O" },
}

local vmaps = {
  -- better indent
  { ">", ">gv" },
  { "<", "<gv" },
  -- keyp cur pos
  { "y", "ygv<ESC>" },
  -- move up and down
  { "<C-j>", ":move '>+1<CR>gv=gv" },
  { "<C-k>", ":move '<-2<CR>gv=gv" },
  -- exec Lua code
  { "<Leader>X", ":lua<CR>" },
  -- V-Line
  { "<Leader>;", "V" },
  -- Select whole file
  { "<Leader>a", "ggVG" },
  -- paste from sys clipboard
  { "<Leader>p", '"+p' },
  -- delete without change register
  { "<leader>d", '"_d' },
  -- keep cursor pos after yank
  { "<Leader>y", '"+ygv<ESC>' },
}

local cmaps = {
  { "<A-b>", "<Left>" },
  { "<A-f>", "<Right>" },
  { "<C-n>", "<Down>" },
  { "<C-p>", "<Up>" },
}

remap("n", nmaps)
remap("i", imaps)
remap("v", vmaps)
remap("c", cmaps)

-- -----------------------
-- LAZY PACKAGE MANAGER
-- -----------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- -----------------------
-- PLUGINS
-- -----------------------
-- List of Plugins
plugins = {
  { "echasnovski/mini.pick", version = false, config = true },
}
require("lazy").setup({
  spec = plugins,
  checker = { enabled = false },
})
