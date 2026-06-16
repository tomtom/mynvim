vim.opt.rtp:prepend(vim.fn.expand("~/.vim"))
vim.opt.rtp:append(vim.fn.expand("~/.vim/after"))
-- vim.opt.packpath = vim.opt.rtp:get()

vim.opt.autoread = true
vim.opt.clipboard = "unnamedplus"
vim.opt.conceallevel = 2
vim.opt.cpoptions:append({ m = true, y = true, M = false })
vim.opt.expandtab = true
vim.opt.foldlevel = 4
vim.opt.foldmethod = "marker"
vim.opt.formatoptions:append({ r = true, w = true })
vim.opt.guifont = "Fira Code:h12"
vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.joinspaces = false
vim.opt.linespace = 4
vim.opt.shiftwidth = 4
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
vim.opt.wildmode="longest:full,full"

vim.g.mapleader      = '#'
vim.g.maplocalleader = '+'
vim.g.myhostname = vim.fn.toupper(vim.fn.hostname())
vim.g.tvimfiles = vim.fn.stdpath('config')
vim.g.tlib_persistent = vim.g.tvimfiles .. '/share_' .. vim.g.myhostname
vim.g.tvimcacheroot = vim.g.tvimfiles .. '/cache_' .. vim.g.myhostname
vim.g.tvimcachedir = vim.g.tvimcacheroot .. '/vim/'
vim.g.tlib_cache = vim.g.tvimcacheroot

-- vim.opt.autocomplete = true

-- Source your existing .vimrc
-- vim.cmd("source ~/.vimrc")
vim.cmd("colorscheme tmlDarkOcean")

require("autopack").register({

	{ spec = "https://github.com/neovim/nvim-lspconfig", },

    -- { spec = "https://github.com/nvim-tree/nvim-web-devicons" },
    "https://github.com/nvim-tree/nvim-web-devicons",
    {
        spec = "https://github.com/ibhagwan/fzf-lua", 
        dependencies = { "nvim-web-devicons", },
        commands = { "FzfLua", },
    },

	{ spec = "https://github.com/avifenesh/claucode.nvim", },

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
        keys = { "gc", "<c-_>" },
    },

    {
        name = "tfiles_vim",
        commands = { "Tfiles" },
    },

    {
        name = "tinykeymap_vim",
        keys = { "<leader>m", "M", "gt", "gp", },
        commands = { "Tinykeymap", "TinykeymapsInfo", },
    },

    {
        name = "trag_vim",
        keys = { "<leader>rr", "<leader>rw", "<leader>r<space>", "<leader>rf", "<leader>rq", "<leader>rl", },
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
vim.keymap.set('x', 'ß', '<cmd>sort i<cr>', { desc = 'Save all' })

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
-- call TMultiMap("ni", "noremap <silent>", "<m-w>", ":call tml#FormatParagraph('}', 'ap', 'gw')<cr>")
-- call TMultiMap("ni", "noremap <silent>", "<m-q>", ":call tml#FormatParagraph('}', 'ap')<cr>")
-- call TMultiMap("v", "noremap <silent>", "<m-q>", ":'<,'>-1s/ *$/ /ge<cr>", '`<gqap')
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

vim.keymap.set('n', '<M-r>', '<cmd>Tmru<cr>', { desc = 'Recent files' })
-- call TMultiMap("n", "noremap", "<s-m-r>",    ':Tmrusession! ')
-- call TMultiMap("n", "noremap", "<Leader>mru",    ':Tmru<cr>')

vim.keymap.set('n', '<M-b>', '<cmd>TSelectBuffer<cr>', { desc = 'Switch buffers' })
vim.keymap.set('n', '<S-M-b>', '<cmd>TSelectBuffer!<cr>', { desc = 'Switch buffers' })
vim.keymap.set('n', '<leader>b', '<cmd>TSelectBuffer<cr>', { desc = 'Switch buffers' })
vim.keymap.set('n', '<leader>B', '<cmd>TSelectBuffer!<cr>', { desc = 'Switch buffers' })

vim.keymap.set('n', '<leader>ff', '<cmd>Tfiles<cr>', { desc = 'Show files' })
vim.keymap.set('n', '<leader>f.', '<cmd>Tfiles --glob=*<cr>', { desc = 'Show files' })
vim.keymap.set('n', '<leader>FF', '<cmd>Tfiles!<cr>', { desc = 'Show files' })
vim.keymap.set('n', '<leader>F:', '<cmd>Tfiles! --glob=*<cr>', { desc = 'Show files' })

vim.keymap.set('n', '<leader>ap', '<cmd>Autoprojectselect<cr>', { desc = 'Select project' })
vim.keymap.set('n', '<leader>AP', '<cmd>Autoprojectselect!<cr>', { desc = 'Select project' })

