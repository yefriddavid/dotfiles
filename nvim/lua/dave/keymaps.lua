local map = vim.keymap.set

-- Console mode
map("c", "<C-a>", "<Home>")
map("c", "<C-b>", "<Left>")
map("c", "<C-f>", "<Right>")

-- Clear search highlight
map("n", "<Esc>", ":nohlsearch<CR><Esc>")

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Tabs
map("n", "<C-n>", ":tabnext<CR>")
map("n", "<C-p>", ":tabprevious<CR>")
map("n", "<Leader>t", ":$tabnew<CR>")
map("n", "<Leader>Tq", ":tabclose<CR>")

-- FZF
map("n", "<Leader>a", ":Ag<Space>")
map("n", "<Leader>b", ":Buffers<CR>")
map("n", "<Leader>o", ":Files<CR>")
map("n", "<Leader>W", ":Windows<CR>")
map("n", "<Leader>zh", ":History<CR>")
map("n", "<Leader>zl", ":Lines<CR>")
map("n", "<Leader>zm", ":Marks<CR>")
map("n", "<Leader>zt", ":Tags<CR>")
map("n", "<Leader>yt", ":BTags<CR>")

-- Quickfix
map("n", "<Leader>n", ":cnext<CR>")
map("n", "<Leader>p", ":cprevious<CR>")

-- File operations
map("n", "<Leader>sp", ":echo expand('%:p')<CR>")
map("n", "<Leader>q", "<C-w>q")
map("n", "<Leader>s", ":wall<CR>")
map("n", "<Leader>w", ":w<CR>")
map("n", "<Leader>y;", ":edit #<CR>")
map("n", "<Leader>yn", ":bnext<CR>")
map("n", "<Leader>yp", ":bprevious<CR>")
map("n", "<Leader>yr", ":edit!<CR>")
map("n", "<Leader>qa", ":qa<CR>")
map("n", "<Leader>fq", ":q!<CR>")

-- ALE
map("n", "<Leader>yf", ":ALEFix<CR>")

-- Format (formatter.nvim)
map("n", "<Leader>f", ":Format<CR>")
map("n", "<Leader>F", ":FormatWrite<CR>")

-- Mark current line with color
map("n", "<Leader>ml", "ml:execute 'match Search /\\%'.line('.').'l/'<CR>")

-- Show function/class name at top of scope
map("n", "<Leader>.", "<cmd>echo getline(search('^[[:alpha:]$_]', 'bcnW'))<CR>")

-- Ranger
map("n", "<Leader>r", ":RangerEdit<CR>")
map("n", "<Leader>Ra", ":RangerAppend<CR>")
map("n", "<Leader>Rc", ":set operatorfunc=RangerChangeOperator<cr>g@")
map("n", "<Leader>Ri", ":RangerInsert<CR>")
map("n", "<Leader>Rs", ":RangerSplit<CR>")
map("n", "<Leader>Rt", ":RangerTab<CR>")
map("n", "<Leader>Rv", ":RangerVSplit<CR>")

-- Tagbar
map("n", "<F6>", ":TagbarJumpPrev<CR>")
map("n", "<F7>", ":TagbarToggle<CR>")
map("n", "<F8>", ":TagbarJumpNext<CR>")
map("n", "<F9>", ":TagbarJump<CR>")

-- Listchars toggle
map("n", "<Leader><Tab><Tab>", ":set invlist<CR>")
map("n", "<Leader><Tab><Tab><Tab>", ":set nolist<CR>")

-- Star search without moving cursor
map("n", "*", "*``")

-- Terminal navigation
map("t", "<C-w>h", "<C-\\><C-n><C-w>h")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j")
map("t", "<C-w>k", "<C-\\><C-n><C-w>k")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l")

-- KiCad macros
map("n", "<Leader>mx", "/(pad.* th<CR>")
map("n", "<Leader>mc", "/ad.*np_thru<CR>")
map("n", "<Leader>mz", "/pad.*np_.*\\*.Cu.*\\*.Mask<CR>")
map("n", "<Leader>mv", "/ad.*np_thru.*F<CR>")

-- DAP (debugging)
map("n", "<F5>",  function() require("dap").continue() end,        { desc = "DAP: Continue" })
map("n", "<F10>", function() require("dap").step_over() end,       { desc = "DAP: Step Over" })
map("n", "<F11>", function() require("dap").step_into() end,       { desc = "DAP: Step Into" })
map("n", "<F12>", function() require("dap").step_out() end,        { desc = "DAP: Step Out" })
map("n", "<Leader>db", function() require("dap").toggle_breakpoint() end, { desc = "DAP: Toggle Breakpoint" })
map("n", "<Leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP: Conditional Breakpoint" })
map("n", "<Leader>dr", function() require("dap").repl.open() end,  { desc = "DAP: REPL" })
map("n", "<Leader>dl", function() require("dap").run_last() end,   { desc = "DAP: Run Last" })
map("n", "<Leader>du", function() require("dapui").toggle() end,   { desc = "DAP: UI Toggle" })

-- LSP keymaps (buffer-local, set only when a server attaches)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    map("n", "<Leader>g",  vim.lsp.buf.definition,  opts)
    map("n", "<Leader>Gr", vim.lsp.buf.rename,       opts)
    map("n", "<Leader>gr", vim.lsp.buf.references,   opts)
    map("n", "K",          vim.lsp.buf.hover,        opts)
  end,
})
