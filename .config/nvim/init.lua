require("vim._core.ui2").enable({})
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
vim.o.textwidth = 120
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
vim.o.tags = "./tags;,tags" -- `ctags -R .`
vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nohlsearch")
vim.cmd.packadd("nvim.difftool")
vim.cmd.packadd("nvim.tohtml")
vim.cmd.packadd("matchit")
vim.pack.add({
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/blazkowolf/gruber-darker.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-mini/mini.pairs" },
    { src = "https://github.com/sindrets/diffview.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/neogitorg/neogit" },
    { src = "https://github.com/m00qek/baleia.nvim" },
    { src = 'https://github.com/saghen/blink.lib' },
    {
        src = 'https://github.com/saghen/blink.cmp',
        version = vim.version.range("*") -- to installed prebuilt bin
    }
})
local cmp = require('blink.cmp').setup({
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
    appearance = {
        nerd_font_variant = 'none',
        kind_icons = {
            Text = '[Txt]',
            Method = '[Mth]',
            Function = '[Fnc]',
            Constructor = '[Cst]',
            Field = '[Fld]',
            Variable = '[Var]',
            Class = '[Cls]',
            Interface = '[Inf]',
            Module = '[Mod]',
            Property = '[Prp]',
            Unit = '[Unt]',
            Value = '[Val]',
            Enum = '[Enm]',
            Keyword = '[Key]',
            Snippet = '[Snp]',
            Color = '[Clr]',
            File = '[Fil]',
            Reference = '[Ref]',
            Folder = '[Fld]',
            EnumMember = '[Enm]',
            Constant = '[Cst]',
            Struct = '[Str]',
            Event = '[Evn]',
            Operator = '[Opr]',
            TypeParameter = '[Typ]',
        }
    }
})
require('mason').setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "rust_analyzer",
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

vim.api.nvim_set_hl(0, "OilDirHidden", { link = "GruberDarkerNiagaraBold" })
vim.api.nvim_set_hl(0, "GruberDarkerYellow", { link = "GruberDarkerYellowBold" })
vim.api.nvim_set_hl(0, "Statement", { link = "GruberDarkerYellowBold" })
-- vim.api.nvim_set_hl(0, "@lsp.type.class", { link = "GruberDarkerWisteria" })
-- vim.api.nvim_set_hl(0, "@lsp.type.type", { link = "GruberDarkerQuartz" })
-- vim.api.nvim_set_hl(0, "@lsp.type.variable", { link = "GruberDarkerNiagara" })

require('mini.pairs').setup({
    mappings = {
        ['('] = { action = 'open', pair = '()', neigh_pattern = '^[^\\][^%w]' },
        ['['] = { action = 'open', pair = '[]', neigh_pattern = '^[^\\][^%w]' },
        ['{'] = { action = 'open', pair = '{}', neigh_pattern = '^[^\\][^%w]' },
        [')'] = { action = 'close', pair = '()', neigh_pattern = '^[^\\]' },
        [']'] = { action = 'close', pair = '[]', neigh_pattern = '^[^\\]' },
        ['}'] = { action = 'close', pair = '{}', neigh_pattern = '^[^\\]' },
        ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '^[^%w\\][^%w]', register = { cr = false } },
        ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '^[^%w\\][^%w]', register = { cr = false } },
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '^[^%w\\][^%w]', register = { cr = false } },
    },
})
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
        ["<C-h>"] = false,
    }
})
local telescope_action = require("telescope.actions")
local telescope_action_state = require("telescope.actions.state")
local telescope_builtin = require("telescope.builtin")
local ivy = require("telescope.themes").get_ivy()
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
local projects_path = vim.fn.stdpath("config") .. "/projects.json"

local function ensure_projects_file()
    local dir = vim.fn.fnamemodify(projects_path, ":h")
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    end
    if vim.fn.filereadable(projects_path) == 0 then
        vim.fn.writefile({ "[]" }, projects_path)
    end
end

local function read_projects()
    ensure_projects_file()
    local lines = vim.fn.readfile(projects_path)
    local content = table.concat(lines, "\n")
    if content == "" then return {} end
    local ok, result = pcall(vim.json.decode, content)
    if ok and type(result) == "table" then
        return result
    end
    vim.notify("Failed to parse projects.json: " .. tostring(result), vim.log.levels.ERROR)
    return {}
end

local function write_projects(projects)
    if #projects == 0 then
        vim.fn.writefile({ "[]" }, projects_path)
        return
    end
    local lines = { "[" }
    for i, p in ipairs(projects) do
        local ok, name_enc = pcall(vim.json.encode, p.name)
        local ok2, path_enc = pcall(vim.json.encode, p.path)
        if not (ok and ok2) then
            vim.notify("Failed to encode project entry", vim.log.levels.ERROR)
            return
        end
        local comma = (i < #projects) and "," or ""
        table.insert(lines, string.format('  { "name": %s, "path": %s }%s', name_enc, path_enc, comma))
    end
    table.insert(lines, "]")
    vim.fn.writefile(lines, projects_path)
end

local function open_project()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values

    local projects = read_projects()
    if #projects == 0 then
        vim.notify("No projects yet. Use :AddProject", vim.log.levels.WARN)
        return
    end

    pickers.new(ivy, {
        prompt_title = "Projects",
        finder = finders.new_table({
            results = projects,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.name,
                    ordinal = entry.name,
                }
            end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, _)
            telescope_action.select_default:replace(function()
                telescope_action.close(prompt_bufnr)
                local selection = telescope_action_state.get_selected_entry()
                local path = vim.fn.expand(selection.value.path)
                vim.fn.chdir(path)
                require("oil").open(path)
            end)
            return true
        end,
    }):find()
end


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
map.set("n", "<C-k>", function() telescope_builtin.builtin(vim.tbl_extend("force", ivy, { previewer = false, })) end)
map.set("n", "<leader><leader>", function()
    telescope_builtin.find_files(vim.tbl_extend("force", ivy, {
        previewer = false,
        hidden = true,
        no_ignore = true,
        file_ignore_patterns = { "^%.git/" }
    }))
end)
map.set("n", "<leader>/", function()
    telescope_builtin.live_grep(vim.tbl_extend("force", ivy, {
        hidden = true,
        no_ignore = true,
        additional_args = { "--glob=!.git/" }
    }))
end)
map.set("n", "<leader>fw", function() telescope_builtin.grep_string(ivy) end)
map.set("n", "<leader>,", function() telescope_builtin.buffers(ivy) end)
map.set("n", "<leader>fr", function() telescope_builtin.oldfiles(ivy) end)
map.set("n", "<leader>fh", function() telescope_builtin.help_tags(ivy) end)
map.set("n", "<leader>xx", function() telescope_builtin.diagnostics(ivy) end)
map.set("n", "gR", function() telescope_builtin.lsp_references(ivy) end)
map.set("n", "gI", function() telescope_builtin.lsp_implementations(ivy) end)
map.set("n", "gD", function() telescope_builtin.lsp_definitions(ivy) end)
map.set("n", "<leader>fp", open_project)
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

vim.api.nvim_create_user_command("AddProject", function()
    vim.ui.input({ prompt = "Project name: " }, function(name)
        if not name or name == "" then
            return
        end

        local path = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
        local projects = read_projects()

        for _, p in ipairs(projects) do
            if p.path == path then
                vim.notify("Project already exists: " .. p.name, vim.log.levels.WARN)
                return
            end
        end

        table.insert(projects, { name = name, path = path })
        write_projects(projects)
        vim.notify("Added project: " .. name .. " -> " .. path)
    end)
end, { desc = "Add current dir as project" })
vim.api.nvim_create_user_command("RemoveProject", function()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values

    local projects = read_projects()
    if #projects == 0 then
        vim.notify("No projects yet. Use :AddProject", vim.log.levels.WARN)
        return
    end
    pickers.new(ivy, {
        prompt_title = "Remove Project",
        finder = finders.new_table({
            results = projects,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.name,
                    ordinal = entry.name,
                }
            end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, _)
            telescope_action.select_default:replace(function()
                local selection = telescope_action_state.get_selected_entry()
                telescope_action.close(prompt_bufnr)

                local target = selection.value
                local remaining = {}
                for _, p in ipairs(projects) do
                    if p.path ~= target.path then
                        table.insert(remaining, p)
                    end
                end

                write_projects(remaining)
                vim.notify("Removed project: " .. target.name)
            end)
            return true
        end,
    }):find()
end
, { desc = "Remove a project from the list" })
