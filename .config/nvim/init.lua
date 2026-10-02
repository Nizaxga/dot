require("vim._core.ui2").enable({ enable = true })

-- options

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.wrap = false
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.winborder = "rounded"
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.expandtab = true
vim.o.modeline = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.textwidth = 100
vim.o.scrolloff = 4
vim.o.showtabline = 1
vim.o.smoothscroll = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 4
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.foldmethod = "manual"
vim.o.pumheight = 8
vim.o.autoread = true
vim.o.undofile = true
vim.o.tags = "./tags;,tags" -- `ctags -R .`
vim.o.makeprg = "make"
-- vim.o.grepprg = "rg --vimgrep --smart-case --hidden"
-- vim.opt.grepformat = "%f:%l:%c:%m"
vim.diagnostic.config({
    underline = true,
    virtual_text = { spacing = 2, prefix = "●" },
    float = { border = "double" },
    severity_sort = true,
})
vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nohlsearch")
vim.cmd.packadd("nvim.difftool")
vim.cmd.packadd("nvim.tohtml")
vim.cmd.packadd("matchit")
vim.cmd.packadd("cfilter")
vim.pack.add({
    -- utils
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/kylechui/nvim-surround",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/kdheepak/lazygit.nvim",
    "https://github.com/stevearc/quicker.nvim",
    -- lsp stuff
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    -- cmp stuff
    'https://github.com/saghen/blink.lib',
    { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range("*") },
})

local map = vim.keymap.set

local function lsp_format(bufnr)
    vim.lsp.buf.format({ bufnr = bufnr, async = false, })
end

local function diagnostic_highlights()
    local colors = {
        Error = "#fb4934",
        Warn  = "#fabd2f",
        Info  = "#83a598",
        Hint  = "#8ec07c",
        Ok    = "#b8bb26",
    }
    for level, color in pairs(colors) do
        vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. level, { undercurl = true, sp = color })
        vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. level, { fg = color })
    end
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = diagnostic_highlights })
diagnostic_highlights()

vim.cmd.colorscheme("retrobox")

-- plugin setup

require("quicker").setup({
    type_icons = { E = "E ", W = "W ", I = "I ", N = "N ", H = "H ", },
    keys = {
        {
            ">",
            function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end,
            desc = "Expand quickfix context",
        },
        {
            "<",
            function() require("quicker").collapse() end,
            desc = "Collapse quickfix context",
        },
    },
})
require('blink.cmp').setup({
    keymap = {
        preset = 'default',
        ['<C-n>'] = { 'show', 'select_next', 'fallback' },
        ['<CR>'] = { 'select_and_accept', 'fallback' },
    },
    completion = {
        menu = {
            border = "none",
            scrollbar = false
        },
        documentation = { auto_show = false },
    },
    sources = { default = { 'buffer', 'snippets', 'lsp', 'path' } },
    appearance = { nerd_font_variant = 'mono' }
})
require("nvim-autopairs").setup({})
require('mason').setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "lua_ls",
    },
}
require('gitsigns').setup {
    signs                        = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
    },
    signs_staged                 = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = '┆' },
    },
    signs_staged_enable          = true,
    signcolumn                   = true,
    numhl                        = false,
    linehl                       = false,
    word_diff                    = false,
    watch_gitdir                 = {
        follow_files = true
    },
    auto_attach                  = true,
    attach_to_untracked          = false,
    current_line_blame           = false,
    current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    blame_formatter              = nil,
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil,
    max_file_length              = 40000,
    preview_config               = {
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    on_attach                    = function(buf)
        local gs = require("gitsigns")
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = buf
            vim.keymap.set(mode, l, r, opts)
        end

        map("n", "]c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "]c", bang = true })
            else
                gs.nav_hunk('next')
            end
        end)
        map("n", "[c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "[c", bang = true })
            else
                gs.nav_hunk('prev')
            end
        end)
    end,
}


require('oil').setup({
    default_file_explorer = true,
    columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
    },
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    prompt_save_on_select_new_entry = false,
    view_options = { show_hidden = true },
    keymaps = {
        ["<C-l>"] = false,
        ["<C-h>"] = false,
        ["<S-r>"] = "actions.refresh",
    }
})

-- Keymap

map({ "n", "x" }, "x", '"_x')
map({ "n", "x" }, "c", '"_c')
map("n", "<leader>ca", vim.lsp.buf.code_action)
map("t", "<Esc>", function()
    if vim.bo.filetype == "lazygit" then
        return "<Esc>"
    end
    return "<C-\\><C-n>"
end, { expr = true })
map("x", "<", "<gv")
map("x", ">", ">gv")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-k>", "<C-w>k")
map("n", "<leader>bo", function()
    local current = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
            vim.api.nvim_buf_delete(buf, {})
        end
    end
end)
map("n", "<S-h>", "<cmd>bp<cr>")
map("n", "<S-l>", "<cmd>bn<cr>")
map("n", "+", "<cmd>vertical resize +5<cr>")
map("n", "-", "<cmd>vertical resize -5<cr>")
map("n", "<leader>|", "<cmd>vsplit<cr>")
map("n", "<leader>_", "<cmd>split<cr>")
map("n", "-", "<cmd>Oil<cr>")
map("n", "<leader>q", function() require("quicker").toggle() end)
map("n", "<leader>l", function() require("quicker").toggle({ loclist = true }) end)
map("n", "<leader>m", function() vim.diagnostic.setqflist() end)
map("n", "<leader>f", ":Fd ")
map("n", "<leader>/", ":Rg ")
map("n", "<leader>lg", "<cmd>LazyGit<cr>")
map("n", "n", "nzzzv")
map("n", "<S-n>", "Nzzzv")
map("n", "*", "*zzzv")
map("n", "#", "#zzzv")
map("n", "yp", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify("Yanked absolute path: " .. path)
end, { desc = "Yank absolute buffer path" })
map("n", "<leader>cf", function()
    vim.cmd.edit(vim.fn.stdpath("config") .. "/init.lua")
end)
map("n", "<leader>ud", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end)
map("n", "<leader>uh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)
map("x", "sa", "<Plug>(nvim-surround-visual)")

-- Auto Command

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = '*', callback = function() pcall(vim.treesitter.start) end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(event)
        vim.b[event.buf].format_on_save = false
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].vim_last_loc then
            return
        end
        vim.b[buf].vim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        vim.b[args.buf].format_on_save = true
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(event)
        if vim.b[event.buf].format_on_save then
            lsp_format(event.buf)
        end
    end,
})

map("n", "<leader>=", function()
    vim.b.format_on_save = not (vim.b.format_on_save ~= false)
    vim.notify("Format on save: " .. (vim.b.format_on_save and "enabled" or "disabled"))
end)

-- User Command

vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
end, { desc = "Update Packages" })

vim.api.nvim_create_user_command("PackClean", function()
    local unused = {}
    for _, plugin in ipairs(vim.pack.get()) do
        if not plugin.active then
            table.insert(unused, plugin.spec.name)
        end
    end
    if #unused == 0 then
        vim.notify("No unused plugins.")
        return
    end
    local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
    if choice == 1 then
        vim.pack.del(unused)
    end
end, { desc = "Clean unused packages" })

vim.api.nvim_create_user_command("ConflictQF", function()
    local result = vim.system({ "rg", "--vimgrep", "--hidden", "--glob", "!.git/**", "^<<<<<<< ", }, { text = true })
        :wait()
    if result.code ~= 0 and result.code ~= 1 then
        vim.notify(result.stderr, vim.log.levels.ERROR)
        return
    end
    local lines = vim.split(result.stdout, "\n", { trimempty = true })
    local cnt = #lines
    vim.fn.setqflist({}, " ", {
        title = string.format("Git Conflicts (%d)", cnt),
        lines = lines,
    })
    vim.cmd("copen")
end, { desc = "Grep all merge conflicts into QFList", })

vim.api.nvim_create_user_command("Fd", function(opts)
    local result = vim.system({ "fd", "--type", "f", "--hidden", "--exclude", ".git", opts.args, }, { text = true })
        :wait()
    if result.code ~= 0 then
        vim.notify(result.stderr, vim.log.levels.ERROR)
        return
    end
    local items = {}
    for path in vim.gsplit(result.stdout, "\n", { trimempty = true }) do
        table.insert(items, { filename = path, lnum = 1, col = 1 })
    end
    vim.fn.setqflist({}, " ", { title = "Fd: " .. opts.args, items = items })
    vim.cmd("copen")
end, { nargs = "+", })

vim.api.nvim_create_user_command("Rg", function(opts)
    local result = vim.system({ "rg", "--vimgrep", "--smart-case", "--hidden", "--glob", "!.git/**", opts.args, },
        { text = true }):wait()
    if result.code ~= 0 and result.code ~= 1 then
        vim.notify(result.stderr, vim.log.levels.ERROR)
        return
    end
    local lines = vim.split(result.stdout, "\n", { trimempty = true })
    vim.fn.setqflist({}, " ", {
        title = "Rg: " .. opts.args,
        lines = lines,
    })
    vim.cmd("copen")
end, { nargs = "+", })
