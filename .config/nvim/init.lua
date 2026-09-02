require("vim._core.ui2").enable({ enable = true })
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.wrap = false
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
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
vim.o.grepprg = "rg --vimgrep --smart-case --hidden"
vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = true,
    severity_sort = true,
    float = { border = "none" },
})
vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nohlsearch")
vim.cmd.packadd("nvim.difftool")
vim.cmd.packadd("nvim.tohtml")
vim.cmd.packadd("matchit")
vim.cmd.packadd("cfilter")
vim.pack.add({
    -- utils
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-telescope/telescope-ui-select.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/blazkowolf/gruber-darker.nvim",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/m00qek/baleia.nvim",
    -- git stuff
    "https://github.com/sindrets/diffview.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    -- lsp stuff
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/neogitorg/neogit",
    -- cmp stuff
    'https://github.com/saghen/blink.lib',
    { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range("*") },
})
vim.g.baleia = require("baleia").setup({})
vim.api.nvim_create_user_command("Colorize", function()
    vim.g.baleia.once(vim.api.nvim_get_current_buf())
end, { bang = true })
local neogit = require("neogit")
neogit.setup {
    integrations = {
        telescope = true,
        diffview = true,
    },
    diff_viewer = "diffview",
}
require("diffview").setup({
    use_icons = false
})
require('blink.cmp').setup({
    keymap = {
        preset = 'default',
        ['<C-n>'] = { 'show', 'select_next', 'fallback' },
        ['<CR>'] = { 'select_and_accept', 'fallback' },
    },
    completion = {
        menu = { scrollbar = false },
        documentation = { auto_show = false },
    },
    sources = { default = { 'buffer', 'snippets', 'lsp', 'path' } },
    -- appearance = { nerd_font_variant = 'none', }
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
        local map = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = buf, desc = desc })
        end
        map("<leader>gB", gs.blame, "Blame Buffer")
        map("<leader>gd", gs.diffthis, "Diff This")
        map("]c", gs.next_hunk, "Next Hunk")
        map("[c", gs.prev_hunk, "Prev Hunk")
        map("dp", gs.reset_hunk, "Reset Hunk")
        map("do", gs.preview_hunk, "Preview Hunk")
        map("d<S-o>", gs.stage_hunk, "Stage Hunk")
    end,
}
local map = vim.keymap
require('gruber-darker').setup({
    bold = true,
    undercurl = true,
    underline = true,
    italic = {
        strings = false,
        comments = false,
        folds = false,
    },
})
vim.cmd.colorscheme("gruber-darker")
vim.api.nvim_set_hl(0, "OilDirHidden", { link = "GruberDarkerNiagaraBold" })
vim.api.nvim_set_hl(0, "GruberDarkerYellow", { link = "GruberDarkerYellowBold" })
vim.api.nvim_set_hl(0, "Statement", { link = "GruberDarkerYellowBold" })
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
local telescope_action = require("telescope.actions")
local telescope_action_state = require("telescope.actions.state")
local telescope_builtin = require("telescope.builtin")
local ivy_theme = require("telescope.themes").get_ivy()
local telescope = require("telescope")
telescope.setup({
    defaults = {
        path_display = { "smart" },
        mappings = {
            i = {
                ["<C-y>"] = function(prompt_bufnr)
                    local selection = telescope_action_state.get_selected_entry()
                    vim.fn.setreg("+", selection.path)
                    print("Copied path: " .. selection.path)
                    telescope_action.close(prompt_bufnr)
                end,
            },
            n = {
                ["<C-y>"] = function(prompt_bufnr)
                    local selection = telescope_action_state.get_selected_entry()
                    vim.fn.setreg("+", selection.path)
                    print("Copied path: " .. selection.path)
                    telescope_action.close(prompt_bufnr)
                end,
            },
        },
    },
    extensions = {
        ["ui-select"] = require("telescope.themes").get_ivy({}),
    },
})
telescope.load_extension("ui-select")
map.set({ "n", "x" }, "j", "gj")
map.set({ "n", "x" }, "k", "gk")
map.set({ "n", "x" }, "x", '"_x')
map.set({ "n", "x" }, "c", '"_c')
map.set({ 'n', 'x' }, '<leader>r', function() vim.lsp.buf.rename() end)
map.set('n', '<leader>ca', vim.lsp.buf.code_action)
map.set("t", "<Esc>", "<C-\\><C-n>")
map.set("x", "<", "<gv")
map.set("x", ">", ">gv")
map.set("n", "<C-j>", "<C-w>j")
map.set("n", "<C-h>", "<C-w>h")
map.set("n", "<C-l>", "<C-w>l")
map.set("n", "<C-k>", "<C-w>k")
map.set("n", "<leader>bo", function()
    local current = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
            vim.api.nvim_buf_delete(buf, {})
        end
    end
end)
map.set("n", "<s-h>", "<cmd>bp<cr>")
map.set("n", "<s-l>", "<cmd>bn<cr>")
map.set("n", "+", "<cmd>vertical resize +5<cr>")
map.set("n", "-", "<cmd>vertical resize -5<cr>")
map.set("n", "<leader>|", "<cmd>vsplit<cr>")
map.set("n", "<leader>-", "<cmd>split<cr>")
map.set("n", "<leader>e", "<cmd>Oil<cr>")
map.set("n", "<leader>u", "<cmd>Undotree<cr>")
map.set("n", "n", "nzzzv")
map.set("n", "N", "Nzzzv")
map.set("n", "*", "*zzzv")
map.set("n", "#", "#zzzv")
map.set("n", "<leader>yp", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify("Yanked absolute path: " .. path)
end, { desc = "Yank absolute buffer path" })
map.set("n", "<leader>fc", function()
    vim.cmd.edit(vim.fn.stdpath("config") .. "/init.lua")
end)
map.set("n", "<leader>ud", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end)
map.set("n", "<leader>uh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)
map.set("n", "<leader><leader>", function()
    telescope_builtin.find_files(vim.tbl_extend("force", ivy_theme, {
        previewer = false,
        hidden = true,
        no_ignore = true,
        file_ignore_patterns = { "^%.git/" }
    }))
end)
map.set("n", "<leader>/", function()
    telescope_builtin.live_grep(vim.tbl_extend("force", ivy_theme, {
        hidden = true,
        no_ignore = true,
        additional_args = { "--glob=!.git/" }
    }))
end)
map.set("n", "<leader>fw", function() telescope_builtin.grep_string(ivy_theme) end)
map.set("n", "<leader>,", function() telescope_builtin.buffers(ivy_theme) end)
map.set("n", "<leader>fr", function() telescope_builtin.oldfiles(ivy_theme) end)
map.set("n", "<leader>fh", function() telescope_builtin.help_tags(ivy_theme) end)
map.set("n", "<leader><S-m>", function() telescope_builtin.diagnostics(ivy_theme) end)
map.set("n", "gA", function() telescope_builtin.lsp_references(ivy_theme) end)
map.set("n", "gI", function() telescope_builtin.lsp_implementations(ivy_theme) end)
map.set("n", "gD", function() telescope_builtin.lsp_definitions(ivy_theme) end)


-- Auto Command

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(event)
        vim.b[event.buf].format_on_save = true
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
local function lsp_format(bufnr)
    vim.lsp.buf.format({ bufnr = bufnr, async = false, })
end
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(event)
        if vim.b[event.buf].format_on_save then
            lsp_format(event.buf)
        end
    end,
})
map.set("n", "<leader>=", function()
    vim.b.format_on_save = not (vim.b.format_on_save ~= false)
    vim.notify("Format on save: " .. (vim.b.format_on_save and "enabled" or "disabled"))
end)

-- User Command

vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
end, { desc = "Update Packages" })

vim.api.nvim_create_user_command("PackClean", function()
    local active_plugins = {}
    local unused_plugins = {}
    for _, plugin in ipairs(vim.pack.get()) do
        active_plugins[plugin.spec.name] = plugin.active
    end
    for _, plugin in ipairs(vim.pack.get()) do
        if not active_plugins[plugin.spec.name] then
            table.insert(unused_plugins, plugin.spec.name)
        end
    end
    if #unused_plugins == 0 then
        print("No unused plugins.")
        return
    end
    local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
    if choice == 1 then
        vim.pack.del(unused_plugins)
    end
end, { desc = "Clean Unused Packages" })

vim.api.nvim_create_user_command("ConflictQF", function()
    vim.cmd.cexpr("system('git diff --check')")
    if not vim.tbl_isempty(vim.fn.getqflist()) then
        vim.cmd.copen()
    else
        print("No conflict markers found.")
    end
end, { desc = "Load leftover merge conflict markers into quickfix" })
