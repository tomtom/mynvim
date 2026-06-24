vim.g.myhostname = vim.fn.toupper(vim.fn.hostname())
-- require("local." .. vim.g.myhostname)
local ok, err = pcall(require, "local." .. vim.g.myhostname)

-- vim.opt.packpath = vim.opt.rtp:get()

-- vim.opt.autocomplete = true
-- vim.opt.clipboard = "unnamedplus"
vim.opt.autoread = true
vim.opt.conceallevel = 2
vim.opt.cpoptions:append({ m = true, y = true, M = false })
vim.opt.expandtab = true
vim.opt.foldlevel = 4
vim.opt.foldmethod = "marker"
vim.opt.formatoptions:append({ r = true, w = true })
vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.joinspaces = false
vim.opt.linespace = 4
vim.opt.shiftwidth = 4
vim.opt.shortmess:append("I")
vim.opt.showbreak = "| "
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.tagcase = "match"
vim.opt.tags = "./tags;tags"
vim.opt.textwidth = 72
vim.opt.title = true
vim.opt.titlestring = "%{expand('%:p')} %m"
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.wildmode="longest:full,full"

vim.g.mapleader      = '#'
vim.g.maplocalleader = '+'
vim.g.tvimfiles = vim.fn.stdpath('config')
vim.g.tlib_persistent = vim.g.tvimfiles .. '/share_' .. vim.g.myhostname
vim.g.tvimcacheroot = vim.g.tvimfiles .. '/cache_' .. vim.g.myhostname
vim.g.tvimcachedir = vim.g.tvimcacheroot .. '/vim/'
vim.g.tlib_cache = vim.g.tvimcacheroot

local aug = vim.api.nvim_create_augroup("AutoRead", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  group = aug,
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" }
})

-- Restore last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Source your existing .vimrc
-- vim.cmd("source ~/.vimrc")
vim.cmd("colorscheme tmlDarkOcean")
vim.cmd("packadd myvimrc")

require("autodir")
-- require("tml")

require("autopack").setup({

    -- debug = true,
    unknown = "install",

	{ spec = "https://github.com/neovim/nvim-lspconfig", },

	{ spec = "https://github.com/rafamadriz/friendly-snippets", },

    {
        spec = { src = "https://github.com/nvim-mini/mini.nvim", version = "stable" },
        submodules = {
            ["mini.cursorword"] = { startup = true, setup = true, },
            ["mini.indentscope"] = { startup = true, setup = true, },
            -- ["mini.pairs"] = { startup = true, setup = true, },
            ["mini.statusline"] = { startup = true, setup = true, },
            ["mini.snippets"] = {
                imaps = { "<c-j>", },
                dependencies = { "friendly-snippets", },
                setup = function(snippets)
                    local gen_loader = snippets.gen_loader
                    snippets.setup({
                        snippets = {
                            -- Load custom file with global snippets first (adjust for Windows)
                            gen_loader.from_file('~/.config/nvim/snippets/global.json'),

                            -- Load snippets based on current language by reading files from
                            -- "snippets/" subdirectories from 'runtimepath' directories.
                            gen_loader.from_lang(),
                        },
                    })
                end,
            },
            ["mini.hipatterns"] = {
                startup = true,
                setup = function(hipatterns)
                    hipatterns.setup({
                        highlighters = {
                            -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
                            fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                            hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
                            todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
                            note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
                            -- Highlight hex color strings (`#rrggbb`) using that color
                            hex_color = hipatterns.gen_highlighter.hex_color(),
                        },
                    })
                end,
            },
        },
    },

    "https://github.com/nvim-tree/nvim-web-devicons",
    {
        spec = "https://github.com/ibhagwan/fzf-lua", 
        dependencies = { "nvim-web-devicons", },
        commands = { "FzfLua", },
        setup = {
            winopts = {
                fullscreen = true,
            },
            files = {
                -- Show hidden files and ignore .gitignore
                -- fd_opts = "--no-ignore",
                -- Alternative for ripgrep-based finders:
                -- rg_opts = "--hidden --no-ignore",
            },
            grep = {
                bin = "rg", -- force ripgrep
                -- rg_opts = "-u",
            },
        },
    },

	-- { spec = "https://github.com/avifenesh/claucode.nvim", },

	-- R
	{ 
        spec = "https://github.com/R-nvim/R.nvim", 
        patterns = { "*.R", "*.r", "*.rmd", "*.Rmd", },
    },

    {
        name = "tselectbuffer_vim",
        commands = { "TSelectBuffer" },
    },

    {
        name = "tcomment_vim",
        maps = { "gc", "<c-_>" },
    },

    {
        name = "tfiles_vim",
        commands = { "Tfiles" },
    },

    {
        name = "tinykeymap_vim",
        nmaps = { "<leader>m", "M", "gt", "gp", },
        commands = { "Tinykeymap", "TinykeymapsInfo", },
    },

    {
        name = "trag_vim",
        nmaps = { "<leader>rr", "<leader>rw", "<leader>r<space>", "<leader>rf", "<leader>rq", "<leader>rl", },
        commands = { "Trag", "Tragcw", "Traglw", },
    },

})


-- Copy (visual mode)
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to clipboard" })

-- Cut (visual mode)
vim.keymap.set("v", "<C-x>", '"+d', { desc = "Cut to clipboard" })
-- Paste
vim.keymap.set('n', '<c-q>', '<c-v>', { desc = 'Blockwise visual' })
vim.keymap.set("n", "<C-v>", '"+p',      { desc = "Paste from clipboard" })
vim.keymap.set("i", "<C-v>", "<C-r>+",   { desc = "Paste from clipboard" })
vim.keymap.set("c", "<C-v>", "<C-r>+",   { desc = "Paste from clipboard" })
vim.keymap.set("t", "<C-v>", '<C-\\><C-n>"+pi', { desc = "Paste in terminal" })
-- Select-all (bonus, Ctrl-A)
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

vim.keymap.set('n', '<c-z>', 'u', { desc = 'Undo' })
vim.keymap.set('n', '<c-s>', '<cmd>update<cr>', { desc = 'Save' })
vim.keymap.set('n', '<leader><c-s>', '<cmd>wa<cr>', { desc = 'Save all' })
-- vim.keymap.set('x', 'ß', '<cmd>sort i<cr>', { desc = 'Save all' })
vim.keymap.set("x", "ß", ":sort i<CR>", { silent = true })
vim.keymap.set("n", "ß", "vip:'<,'>sort i<CR>", { silent = true })

-- nmap <Leader>:e :e %:p:h/
vim.keymap.set('n', '<leader>ee', ':e %:p:h/', { desc = 'Edit in dir' })

-- call TMultiMap("ni", "map", "<m-c>", "~l", "l", "guw", "w")
-- vim.keymap.set('n', '<m-c>', 'gUlw', { desc = 'Capitalize' })
vim.keymap.set('n', '<m-c>', '~w', { desc = 'Capitalize' })
vim.keymap.set('i', '<m-c>', '<c-o>~<c-right>', { desc = 'Capitalize' })

-- call TMultiMap("*I", "noremap", "<C-BS>",  "<S-C-Left><Del>")
-- vim.keymap.set('i', '<c-bs>', '<S-C-Left><Del>', { desc = 'Save previous word' })
vim.keymap.set("i", "<C-BS>", "<C-w>", { noremap = true, silent = true })
vim.keymap.set("c", "<C-BS>", "<C-w>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-BS>", "dw", { silent = true, desc = 'Delete word forward' })
-- If <C-BS> is not recognized, your terminal may be sending <C-H>. In that case, map <C-H> instead:
-- vim.keymap.set("i", "<C-H>", "<C-w>", { noremap = true, silent = true })   

-- call TMultiMap("*I", "noremap", "<C-Del>", "<S-C-Right><Del>")
-- vim.keymap.set('i', '<c-del>', '<S-C-Right><Del>', { desc = 'Save next word' })
vim.keymap.set("n", "<C-Del>", "de", { silent = true, desc = "Delete word forward" })
vim.keymap.set("v", "<C-Del>", "de", { silent = true, desc = "Delete word forward" })
vim.keymap.set("i", "<C-Del>", "<C-O>dw", { silent = true, desc = "Delete word forward" })   
-- If <C-Del> does not work in Insert mode due to terminal limitations
-- Remap Ctrl+Backspace (often more reliable than Del in terminals)
-- vim.keymap.set("i", "<C-BS>", "<C-O>dw", { silent = true, desc = "Delete word forward in insert" })   

-- noremap Q @q
vim.keymap.set("n", "Q", "@q", { silent = true, desc = "Record q" })

-- call TMultiMap("ni", "noremap <silent>", "<m-q>", ":call tml#FormatParagraph('}', 'ap')<cr>")
vim.keymap.set("n", "<m-q>", ":call tml#FormatParagraph('}', 'ap')<cr>", { silent = true, desc = "Rewrap" })
vim.keymap.set("i", "<m-q>", "<c-o>:call tml#FormatParagraph('}', 'ap')<cr>", { silent = true, desc = "Rewrap" })
-- call TMultiMap("v", "noremap <silent>", "<m-q>", ":'<,'>-1s/ *$/ /ge<cr>", '`<gqap')
vim.keymap.set("v", "<m-q>", ":'<,'>-1s/ *$/ /ge<cr>", { silent = true, desc = "Rewrap" })

-- call TMultiMap("ni", "noremap <silent>", "<m-w>", ":call tml#FormatParagraph('}', 'ap', 'gw')<cr>")
-- vnoremap <Leader>q :TUnwrap<cr>
-- call TMultiMap("ni", "map", "<m-c>", "~l", "l", "guw", "w")
-- call TMultiMap("ni", "map", "<leader><m-c>", "m`", "b", "~l", "``")
-- nnoremap <M-%> :%s/<c-r><c-w>//gc<Left><Left><Left>
-- vnoremap <M-%> ""y:%s/<c-r>"//gc<Left><Left><Left>
-- nnoremap <C-F4> :Kwbd<cr>
-- nnoremap <c-w><c-w> :bdelete<cr>

vim.keymap.set('n', '<leader>zr', '<cmd>FzfLua oldfiles<cr>', { desc = 'Fzf Recent Files' })
vim.keymap.set('n', '<leader>zb', '<cmd>FzfLua buffers<cr>', { desc = 'Fzf Buffers' })
vim.keymap.set('n', '<leader>zf', '<cmd>FzfLua files<cr>', { desc = 'Fzf Files' })

-- vim.keymap.set('n', '<m-r>', '<cmd>FzfLua oldfiles<cr>', { desc = 'Fzf Recent Files' })
-- vim.keymap.set('n', '<m-b>', '<cmd>FzfLua buffers<cr>', { desc = 'Fzf Buffers' })
-- vim.keymap.set('n', '<leader>ff', '<cmd>FzfLua files<cr>', { desc = 'Fzf Files' })

vim.keymap.set('n', '<M-r>', '<cmd>Tmru<cr>', { desc = 'Recent files' })
vim.keymap.set('n', '<M-b>', '<cmd>TSelectBuffer<cr>', { desc = 'Switch buffers' })

-- call TMultiMap("n", "noremap", "<s-m-r>",    ':Tmrusession! ')
-- call TMultiMap("n", "noremap", "<Leader>mru",    ':Tmru<cr>')

-- vim.keymap.set('n', '<S-M-b>', '<cmd>TSelectBuffer!<cr>', { desc = 'Switch buffers' })
-- vim.keymap.set('n', '<leader>b', '<cmd>TSelectBuffer<cr>', { desc = 'Switch buffers' })
-- vim.keymap.set('n', '<leader>B', '<cmd>TSelectBuffer!<cr>', { desc = 'Switch buffers' })

vim.keymap.set('n', '<leader>ff', '<cmd>Tfiles<cr>', { desc = 'Show files' })
vim.keymap.set('n', '<leader>f.', '<cmd>Tfiles --glob=*<cr>', { desc = 'Show files' })
vim.keymap.set('n', '<leader>FF', '<cmd>Tfiles!<cr>', { desc = 'Show files' })
vim.keymap.set('n', '<leader>F:', '<cmd>Tfiles! --glob=*<cr>', { desc = 'Show files' })

-- vim.keymap.set('n', '<leader>ap', '<cmd>Autoprojectselect<cr>', { desc = 'Select project' })
-- vim.keymap.set('n', '<leader>AP', '<cmd>Autoprojectselect!<cr>', { desc = 'Select project' })

