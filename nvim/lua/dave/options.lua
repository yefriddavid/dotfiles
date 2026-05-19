local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

opt.ttimeoutlen = 0
opt.timeoutlen = 3333
opt.cmdheight = 2
opt.number = true
opt.cursorline = true
opt.laststatus = 2
opt.termguicolors = true
opt.splitbelow = true
opt.splitright = true
opt.wrap = false
opt.mouse = "a"
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "nosplit"
opt.listchars = {
  eol = "⏎",
  tab = "▷▷⋮",
  trail = "~",
  extends = ">",
  precedes = "<",
  nbsp = "⎵",
  space = "␣",
}

-- KiCad macros
vim.fn.setreg("a", "0")
vim.fn.setreg("x", "ftinp_\x1bn")
vim.fn.setreg("c", 'zzj0wvf"f"lld\x1bn')
vim.fn.setreg("z", "zzf*rBf*RB\x1bn")
vim.fn.setreg("v", 'zzfFhvf"d\x1bn')
