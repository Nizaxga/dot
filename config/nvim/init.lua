require("vim._core.ui2").enable({})
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = "~",
}
-- Options
vim.o.wrap = false
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.winborder = "rounded"
vim.o.expandtab = true
vim.o.modeline = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.textwidth = 100
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
vim.o.autocomplete = true
vim.o.complete = ".,w,b,t,o"
vim.o.completeopt = "fuzzy,menuone,noselect,popup"
vim.o.pumheight = 8


vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nohlsearch")
vim.pack.add({
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/blazkowolf/gruber-darker.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/ej-shafran/compile-mode.nvim" },
    { src = "https://github.com/nvim-mini/mini.pairs" },
    { src = "https://github.com/nvim-mini/mini.ai" },
    { src = "https://github.com/sindrets/diffview.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/neogitorg/neogit" },
    { src = "https://github.com/m00qek/baleia.nvim" },
})

require('mason').setup()
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
    signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir                 = {
        follow_files = true
    },
    auto_attach                  = true,
    attach_to_untracked          = false,
    current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    blame_formatter              = nil, -- Use default
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil,   -- Use default
    max_file_length              = 40000, -- Disable if file is longer than this (in lines)
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

vim.api.nvim_set_hl(0, "GruberDarkerYellow", { link = "GruberDarkerYellowBold" })
vim.api.nvim_set_hl(0, "Statement", { link = "GruberDarkerYellowBold" })
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        local hls = vim.api.nvim_get_hl(0, {})
        for name, _ in pairs(hls) do
            if name:match("[Ss]tatement") then
                vim.api.nvim_set_hl(0, name, { link = "GruberDarkerYellowBold" })
            end
        end
    end,
})

require('mini.pairs').setup()
require('mini.ai').setup()
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
    view_options = { show_hidden = true },
})
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
require("telescope").setup({ -- Yank path
    defaults = {
        mappings = {
            i = {
                ["<C-y>"] = function(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    -- selection[1] contains the relative path from the cwd
                    vim.fn.setreg("+", selection[1])
                    print("Copied path: " .. selection[1])
                    actions.close(prompt_bufnr)
                    -- If you want absolute paths instead, use selection.path
                end,
            },
            n = {
                ["<C-y>"] = function(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    vim.fn.setreg("+", selection[1])
                    print("Copied path: " .. selection[1])
                    actions.close(prompt_bufnr)
                end,
            },
        },
    },
})
local builtin = require("telescope.builtin")
local ivy = require("telescope.themes").get_ivy()
vim.g.compile_mode = {
    bang_expansion = true,
    -- Default to run current file
    default_command = {
        python = "python %",
        lua = "lua %",
        javascript = "bun %",
        typescript = "bun %",
        c = "[ -f Makefile ] && make -k || (cc -o %:r % && ./%:r)",
        cpp = "[ -f Makefile ] && make -k || (cc -std=c++23 -o %:r % && ./%:r)",
        go = "go run %",
        rust = "[ -f Cargo.toml ] && cargo run || (rustc % --crate-name %:r && ./%:r)"
    },
    baleia_setup = true,
}

-- QOL
map.set({ "n", "x" }, "j", "gj")
map.set({ "n", "x" }, "k", "gk")
map.set({ "n", "x" }, "x", '"_x')
map.set({ "n", "x" }, "c", '"_c')
map.set({ 'n', "v" }, '<leader>ca', vim.lsp.buf.code_action)
map.set("t", "<Esc>", "<C-\\><C-n>")
map.set("x", "<", "<gv")
map.set("x", ">", ">gv")
map.set("n", "<C-j>", "<C-w>j")
map.set("n", "<C-k>", "<C-w>k")
map.set("n", "<C-h>", "<C-w>h")
map.set("n", "<C-l>", "<C-w>l")
map.set("n", "<leader>o", "<C-w>o")
map.set("n", "<leader>n", "<cmd>new<cr>")
map.set("n", "<leader>bd", "<cmd>bnext | bd#<cr>")
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
map.set("n", "<leader>|", "<cmd>vsplit<cr>")
map.set("n", "<leader>-", "<cmd>split<cr>")
map.set("n", "<leader>e", "<cmd>Oil<cr>")
map.set("n", "<leader>C", "<cmd>Compile<cr>")
map.set("n", "<leader>R", "<cmd>Recompile<cr>")
map.set("n", "<leader>fc", function() vim.cmd.edit(vim.fn.stdpath("config") .. "/init.lua") end)
map.set("n", '<leader>ud', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end)
map.set('n', '<leader>uh', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)

map.set("n", "<leader><leader>", function() builtin.find_files(ivy) end)
map.set("n", "<leader>/", function() builtin.live_grep(ivy) end)
map.set("n", "<leader>,", function() builtin.buffers(ivy) end)
map.set("n", "<leader>fr", function() builtin.oldfiles(ivy) end)
map.set("n", "<leader>ft", function() builtin.lsp_dynamic_workspace_symbols(ivy) end)
map.set("n", "<leader>xx", function() builtin.diagnostics(ivy) end)
map.set("n", "gI", function() builtin.lsp_implementations(ivy) end)
map.set("n", "gD", function() builtin.lsp_definitions(ivy) end)
map.set("n", "<leader>gb", function() builtin.git_branches(ivy) end)
map.set("n", "<leader>gc", function() builtin.git_bcommits(ivy) end)

map.set("n", "<leader>U", "<cmd>Undotree<cr>")
map.set("n", "n", "nzzzv")
map.set("n", "N", "Nzzzv")
local neogit = require("neogit")
neogit.setup {
    integrations = {
        telescope = true,
        diffview = true,
    },
    diff_viewer = "diffview",
}

vim.lsp.enable({
    "rust_analyzer",
    "clangd",
    "lua_ls",
    "pyright",
    "ruff",
    "tinymist",
    "ts_ls",
    "gopls",
    "yamlls",
    "jsonls",
    "jdtls",
    "bashls",
})

vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = true,
    severity_sort = true,
})
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})
local format_on_save = false
vim.api.nvim_create_user_command("FormatOnSaveToggle", function()
    format_on_save = not format_on_save
    vim.notify("Format on save: " .. (format_on_save and "enabled" or "disabled"))
end, {})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        if format_on_save then
            vim.lsp.buf.format { async = false }
        end
    end,
})
map.set("n", "<leader>=", "<cmd>FormatOnSaveToggle<cr>")
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
            -- Optional formating of items
            convert = function(item)
                -- Remove leading misc chars for abbr name,
                -- and cap field to 25 chars
                --local abbr = item.label
                --abbr = abbr:match("[%w_.]+.*") or abbr
                --abbr = #abbr > 25 and abbr:sub(1, 24) .. "…" or abbr
                --
                -- Remove return value
                --local menu = ""

                -- Only show abbr name, remove leading misc chars (bullets etc.),
                -- and cap field to 15 chars
                local abbr = item.label
                abbr = abbr:gsub("%b()", ""):gsub("%b{}", "")
                abbr = abbr:match("[%w_.]+.*") or abbr
                abbr = #abbr > 15 and abbr:sub(1, 14) .. "…" or abbr

                -- Cap return value field to 15 chars
                local menu = item.detail or ""
                menu = #menu > 15 and menu:sub(1, 14) .. "…" or menu

                return { abbr = abbr, menu = menu }
            end,
        })
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "TelescopePrompt" },
    callback = function()
        vim.bo.autocomplete = false
    end
})
vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
end, { desc = "Update Packages" })

local function pack_clean()
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
end
vim.api.nvim_create_user_command("PackClean", pack_clean, { desc = "Clean Unused Packages" })
