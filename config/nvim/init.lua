-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
augroup Packer
autocmd!
autocmd BufWritePost init.lua PackerCompile
augroup end
]]

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager

  -- Vim plugins
  use 'preservim/nerdcommenter'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat' -- '.' repeating for the above plugins
  use 'kwsp/vim-tmux-navigator' -- integration with tmux

  -- Fuzzy search
  use { 'junegunn/fzf', run = './install --bin', }
  use { 'junegunn/fzf.vim',
    config = function()
      vim.api.nvim_set_keymap('n', ';', "<cmd>Buffers<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-p>', "<cmd>Files<CR>", { noremap = true, silent = true })
    end,
  }

  -- Colorscheme
  --use 'kwsp/halcyon-neovim'
  use 'folke/tokyonight.nvim'

  -- Statusline
  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      require('lualine').setup {
        options = {
          component_separators = '|',
          section_separators = '',
          theme = 'tokyonight',
        },
      }
    end,
  }

  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'

  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'tpope/vim-fugitive' }

  -- File explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require 'nvim-tree'.setup {
        view = {
          mappings = {
            list = {
              { key = { "<CR>", "o" }, action = "edit", mode = "n" },
              { key = "s", action = "vsplit" },
              { key = "i", action = "split" },
            }
          }
        }
      }
      vim.api.nvim_set_keymap('n', '<C-n>', '<Cmd>NvimTreeToggle<CR>', { noremap = true })
    end
  }

  -- Syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        incremental_selection = { enable = true },
        autopairs = { enable = true },
        indent = { enable = true },
        rainbow = {
          enable = true,
          disable = { "html" },
          extended_mode = false,
          max_file_lines = nil,
        },
        autotag = { enable = true },
      }
    end,

    requires = {
      {
        -- Parenthesis highlighting
        "p00f/nvim-ts-rainbow",
        after = "nvim-treesitter",
      },
      {
        -- Autoclose tags
        "windwp/nvim-ts-autotag",
        after = "nvim-treesitter",
      },
      {
        -- Context based commenting
        "JoosepAlviste/nvim-ts-context-commentstring",
        after = "nvim-treesitter",
      },
    },
  }

  -- Snippets
  use {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip/loaders/from_vscode").lazy_load()
      require("luasnip/loaders/from_snipmate").lazy_load()
    end,
    requires = {
      "rafamadriz/friendly-snippets",
    },
  }

  -- Completion engine
  use "hrsh7th/nvim-cmp"

  -- Snippet completion source
  use {
    "saadparwaiz1/cmp_luasnip",
    after = "nvim-cmp",
  }

  -- Path completion source
  use {
    "hrsh7th/cmp-path",
    after = "nvim-cmp",
  }

  -- LSP completion source
  use "hrsh7th/cmp-nvim-lsp"

  -- Inject non languagae servers into the LSP framework
  use "jose-elias-alvarez/null-ls.nvim"

  -- LSP manager
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }


  use 'simrat39/symbols-outline.nvim' -- symbol tree
  use 'windwp/nvim-ts-autotag'

  -- Pandoc integration
  use 'vim-pandoc/vim-pandoc'

  -- Standalone pandoc syntax module
  use {
    'vim-pandoc/vim-pandoc-syntax',
    config = function()
      vim.cmd [[ let g:pandoc#syntax#codeblocks#embeds#langs = [ 'python', 'lua', 'c' ] ]]
    end
  }

  -- colorizer
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  }

  -- smooth scroll
  use {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup()
    end
  }

  -- Slime
  use {
    'jpalardy/vim-slime',
    ft = { 'python', 'markdown', 'pandoc', 'markdown.pandoc', 'lisp' },
    config = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }
      vim.g.slime_dont_ask_default = 1
    end
  }

end)

-- Use pandoc syntax for markdown
vim.cmd [[ 
augroup pandoc_syntax
  autocmd! 
  autocmd BufNewFile,BufFilePre,BufRead *.md setfiletype markdown.pandoc
augroup end
]]

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme tokyonight-moon]]

vim.o.hidden = true
vim.wo.number = true --Make line numbers default
vim.o.mouse = 'a' --Enable mouse mode
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.cmd [[ autocmd BufRead,BufNewFile *.py set shiftwidth=4 ]]
vim.o.expandtab = true
--vim.o.smartindent = true
--vim.o.autoindent = true
--vim.o.copyindent = true
vim.opt.undofile = true --Save undo history
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250 --Decrease update time
vim.wo.signcolumn = 'yes'
vim.o.clipboard = "unnamedplus"
vim.o.autoread = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

--Remap space as leader key
vim.api.nvim_set_keymap('n', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- navigation
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.cmd [[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]]


-- Gitsigns
require('gitsigns').setup {
  signs                        = {
    add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
  },
  signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir                 = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked          = true,
  current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts      = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority                = 6,
  update_debounce              = 100,
  status_formatter             = nil, -- Use default
  max_file_length              = 40000,
  preview_config               = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm                         = {
    enable = false
  },
  on_attach                    = function(bufnr)
    local function map(mode, lhs, rhs, opts)
      opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    -- Navigation
    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

    -- Actions
    map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
    map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
    map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
    map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
    map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
    map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
    map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
    map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
    map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

    -- Text object
    map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}


-- LSP settings
local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'go', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
vim.keymap.set('n', '<leader>p', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


  local buf_map = vim.api.nvim_buf_set_keymap
  buf_map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_map(bufnr, 'n', '<leader>qf', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_map(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_map(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_map(bufnr, 'n', '<leader>fm', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format { async = true }' ]]

  -- Clangd
  buf_map(bufnr, 'n', '<C-q>', '<cmd>ClangdSwitchSourceHeader<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach
    }
  end,
  -- Next, you can provide targeted overrides for specific servers.
  -- For example, a handler override for the rust_analyzer
  ["rust_analyzer"] = function()
    require("lspconfig")["rust_analyzer"].setup {
      capabilities = capabilities,
      on_attach = on_attach
    }
    require("rust-tools").setup {}
  end,
  ["sumneko_lua"] = function()
    require("lspconfig").sumneko_lua.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          }
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
        },
        telemetry = {
          enable = false,
        },
      },
      capabilities = capabilities,
      on_attach = on_attach
    })
  end
}


-- Builtin LSP settings
vim.diagnostic.config {
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.formatting.prettier
  },
  on_attach = on_attach
})

-- luasnip setup
local luasnip = require 'luasnip'


-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}

function _G.set_terminal_keymaps()
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd [[ autocmd! TermOpen term://* lua set_terminal_keymaps() ]]

require('symbols-outline').setup()
vim.g.symbols_outline = {
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = true,
  position = 'right',
  relative_width = true,
  width = 25,
  auto_close = false,
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  preview_bg_highlight = 'Pmenu',
  keymaps = { -- These keymaps can be a string or a table for multiple keys
    close = { "<Esc>", "q" },
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a",
  },
  lsp_blacklist = {},
  symbol_blacklist = {},
  symbols = {
    File = { icon = "", hl = "TSURI" },
    Module = { icon = "", hl = "TSNamespace" },
    Namespace = { icon = "", hl = "TSNamespace" },
    Package = { icon = "", hl = "TSNamespace" },
    Class = { icon = "𝓒", hl = "TSType" },
    Method = { icon = "ƒ", hl = "TSMethod" },
    Property = { icon = "", hl = "TSMethod" },
    Field = { icon = "", hl = "TSField" },
    Constructor = { icon = "", hl = "TSConstructor" },
    Enum = { icon = "ℰ", hl = "TSType" },
    Interface = { icon = "ﰮ", hl = "TSType" },
    Function = { icon = "", hl = "TSFunction" },
    Variable = { icon = "", hl = "TSConstant" },
    Constant = { icon = "", hl = "TSConstant" },
    String = { icon = "𝓐", hl = "TSString" },
    Number = { icon = "#", hl = "TSNumber" },
    Boolean = { icon = "⊨", hl = "TSBoolean" },
    Array = { icon = "", hl = "TSConstant" },
    Object = { icon = "⦿", hl = "TSType" },
    Key = { icon = "🔐", hl = "TSType" },
    Null = { icon = "NULL", hl = "TSType" },
    EnumMember = { icon = "", hl = "TSField" },
    Struct = { icon = "𝓢", hl = "TSType" },
    Event = { icon = "🗲", hl = "TSType" },
    Operator = { icon = "+", hl = "TSOperator" },
    TypeParameter = { icon = "𝙏", hl = "TSParameter" }
  }
}
vim.api.nvim_set_keymap('n', '<C-s>', [[<cmd>SymbolsOutline<CR>]], { noremap = true, silent = true })



-- Markdown note taking
vim.cmd [[command! Notes autocmd BufWritePost *.md silent !pandoc -s --katex='https://cdn.jsdelivr.net/npm/katex@0.13.18/dist/' --highlight-style pygments --toc % -o %:r.html ]]

-- Competitive programming
vim.cmd [[autocmd filetype cpp nnoremap <leader>r :w <bar> !tmux split-window -h "(set -x; g++ -std=c++20 % -o %:r.out); ./%:r.out; echo '$(tput setaf 2)[finished...]'; read"<CR><CR>]]
vim.cmd [[autocmd filetype cpp nnoremap <leader>tp :read ~/.config/nvim/templates/skeleton.cpp<CR>kdd5j]]
vim.cmd [[autocmd filetype python nnoremap <leader>r :w <bar> !tmux split-window -h "python3 %:r.py; echo '$(tput setaf 2)[finished...]'; read"<CR><CR>]]
vim.cmd [[autocmd filetype python nnoremap <leader>R :w <bar> !tmux split-window -h "python3 -i %:r.py; echo '$(tput setaf 2)[finished...]'; read"<CR><CR>]]
vim.cmd [[autocmd filetype go nnoremap <leader>r :w <bar> !tmux split-window -h "go run %:r.go; echo '$(tput setaf 2)[finished...]'; read"<CR><CR>]]
