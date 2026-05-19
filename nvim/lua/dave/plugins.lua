-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- ── Colorscheme ──────────────────────────────────────────────────────────
  {
    "chriskempson/base16-vim",
    priority = 1000,
    config = function()
      -- base16-shell sets ~/.vimrc_background to match terminal theme
      local bg = vim.fn.expand("~/.vimrc_background")
      if vim.fn.filereadable(bg) == 1 then
        vim.g.base16colorspace = 256
        vim.cmd("source " .. bg)
      else
        vim.cmd("colorscheme base16-default-dark")
      end
      vim.cmd([[
        highlight IncSearch      ctermbg=51    ctermfg=white
        highlight QuickFixLine   ctermbg=gray  ctermfg=white
        highlight Search         ctermbg=45    ctermfg=white
        highlight StatusLine     ctermbg=white ctermfg=black
        highlight StatusLineNC   ctermbg=gray  ctermfg=white
        highlight TabLine        ctermbg=gray  ctermfg=black
        highlight TabLineFill    ctermbg=gray
        highlight TabLineSel     ctermbg=black ctermfg=white
        highlight VertSplit      ctermbg=gray  ctermfg=gray
        highlight Visual         ctermbg=gray  ctermfg=white
        highlight WildMenu       ctermbg=yellow ctermfg=white
        highlight dave           ctermbg=green ctermfg=red
        hi link EasyMotionTarget2First  dave
        hi link EasyMotionTarget2Second dave
      ]])
    end,
  },

  -- ── Motion / editing ─────────────────────────────────────────────────────
  "easymotion/vim-easymotion",
  "editorconfig/editorconfig-vim",

  {
    "windwp/nvim-autopairs",   -- replaces jiangmiao/auto-pairs
    event = "InsertEnter",
    config = true,
  },

  {
    "mattn/emmet-vim",
    config = function()
      vim.g.user_emmet_mode = "i"
    end,
  },

  {
    "pangloss/vim-javascript",
    config = function()
      vim.g.javascript_plugin_flow = 1
    end,
  },
  {
    "mxw/vim-jsx",
    config = function()
      vim.g.jsx_ext_required = 0
    end,
  },

  "rafaqz/ranger.vim",

  {
    "terryma/vim-expand-region",
    config = function()
      vim.keymap.set("v", "v",     "<Plug>(expand_region_expand)")
      vim.keymap.set("v", "<C-v>", "<Plug>(expand_region_shrink)")
    end,
  },

  "tmux-plugins/vim-tmux-focus-events",
  "tpope/vim-commentary",
  "tpope/vim-fugitive",
  "tpope/vim-repeat",
  "tpope/vim-surround",

  -- ── Linting / formatting ──────────────────────────────────────────────────
  {
    "dense-analysis/ale",
    config = function()
      vim.g.ale_fixers = { ["*"] = { "prettier" } }
    end,
  },

  {
    "mhartington/formatter.nvim",
    config = function()
      local js = require("formatter.filetypes.javascript").prettier
      local ts = require("formatter.filetypes.typescript").prettier
      require("formatter").setup({
        filetype = {
          javascript      = { js },
          javascriptreact = { js },
          typescript      = { ts },
          typescriptreact = { ts },
          json = { require("formatter.filetypes.json").prettier },
          html = { require("formatter.filetypes.html").prettier },
          css  = { require("formatter.filetypes.css").prettier  },
          lua  = { require("formatter.filetypes.lua").stylua    },
        },
      })
    end,
  },

  -- ── UI helpers ────────────────────────────────────────────────────────────
  {
    "unblevable/quick-scope",
    config = function()
      vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    end,
  },

  -- ── FZF ──────────────────────────────────────────────────────────────────
  {
    "junegunn/fzf",
    build = function() vim.fn["fzf#install"]() end,
  },
  {
    "junegunn/fzf.vim",
    config = function()
      vim.g.fzf_action = {
        ["ctrl-t"] = "tab split",
        ["ctrl-s"] = "split",
        ["ctrl-v"] = "vsplit",
      }
    end,
  },

  -- ── Snippets (replaces UltiSnips + vim-snippets) ──────────────────────────
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      local ls = require("luasnip")
      -- Same triggers as old UltiSnips: C-j expand/jump, C-k jump back
      vim.keymap.set({ "i", "s" }, "<C-j>", function() ls.jump(1)  end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-k>", function() ls.jump(-1) end, { silent = true })
    end,
  },

  -- ── LSP server management ─────────────────────────────────────────────────
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "gopls", "pyright", "lua_ls", "ansiblels" },
        automatic_installation = true,
      })
    end,
  },

  -- ── LSP ───────────────────────────────────────────────────────────────────
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "SmiteshP/nvim-navic",
    },
    config = function()
      local navic        = require("nvim-navic")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Adjuntar navic para breadcrumbs en statusline
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities.documentSymbolProvider then
            navic.attach(client, args.buf)
          end
        end,
      })

      local common = { capabilities = capabilities }

      vim.lsp.config("ts_ls",     common)
      vim.lsp.config("gopls",     common)
      vim.lsp.config("pyright",   common)
      vim.lsp.config("ansiblels", common)
      vim.lsp.config("lua_ls", vim.tbl_extend("force", common, {
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      }))

      vim.lsp.enable({ "ts_ls", "gopls", "pyright", "ansiblels", "lua_ls" })
    end,
  },

  -- ── Completion (replaces coc.nvim) ────────────────────────────────────────
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<TAB>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-TAB>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"]      = cmp.mapping.confirm({ select = false }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]     = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Navic breadcrumbs (used by lspconfig on_attach)
  "SmiteshP/nvim-navic",

  -- OpenSCAD syntax
  "sirtaj/vim-openscad",

  -- ── DAP — debugging con breakpoints ──────────────────────────────────────
  { "mfussenegger/nvim-dap" },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap    = require("dap")
      local dapui  = require("dapui")
      dapui.setup()
      -- Abrir/cerrar UI automáticamente al iniciar/terminar sesión
      dap.listeners.after.event_initialized["dapui_config"]  = function() dapui.open()  end
      dap.listeners.before.event_terminated["dapui_config"]  = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"]      = function() dapui.close() end
    end,
  },

  -- Go debugger (usa delve internamente)
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      require("dap-go").setup()
    end,
  },

  -- Python debugger (requiere: pip install debugpy)
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      require("dap-python").setup("python3")
    end,
  },

  -- JavaScript / TypeScript debugger (adaptador manual via mason)
  -- Para instalar el adaptador: :MasonInstall node-debug2-adapter
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local adapter_path = vim.fn.stdpath("data")
        .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js"
      dap.adapters.node2 = {
        type    = "executable",
        command = "node",
        args    = { adapter_path },
      }
      local js_config = {
        {
          name       = "Launch file",
          type       = "node2",
          request    = "launch",
          program    = "${file}",
          cwd        = "${workspaceFolder}",
          sourceMaps = true,
          protocol   = "inspector",
          console    = "integratedTerminal",
        },
        {
          name      = "Attach to process",
          type      = "node2",
          request   = "attach",
          processId = require("dap.utils").pick_process,
        },
      }
      dap.configurations.javascript      = js_config
      dap.configurations.typescript      = js_config
      dap.configurations.javascriptreact = js_config
      dap.configurations.typescriptreact = js_config
    end,
  },

}, {
  checker = { enabled = false },
})
