-- =========================
-- BASIC SETTINGS
-- =========================
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- =========================
-- KEYMAPS (Leader)
-- =========================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =========================
-- LAZY BOOTSTRAP
-- =========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath
    })
end

vim.opt.rtp:prepend(lazypath)

-- =========================
-- PLUGINS
-- =========================
require("lazy").setup({

    -- =========================
    -- THEME
    -- =========================
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("tokyonight-night")
        end
    },

    -- =========================
    -- UI MODERNIZATION
    -- =========================
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "rcarriga/nvim-notify",
            "MunifTanjim/nui.nvim"
        },
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                    }
                },
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    long_message_to_split = true,
                }
            })
        end
    },

    {
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
        end
    },

    {
        "echasnovski/mini.animate",
        event = "VeryLazy",
        config = function()
            require("mini.animate").setup()
        end
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup()
        end
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup()
        end
    },

    -- =========================
    -- FILE TREE
    -- =========================
    {
        "nvim-tree/nvim-tree.lua",
        keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" } },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                view = { width = 35 },
                renderer = { icons = { show = { git = true } } }
            })
        end
    },

    -- =========================
    -- TELESCOPE
    -- =========================
    {
        "nvim-telescope/telescope.nvim",
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup()
            telescope.load_extension("fzf")
        end
    },

    -- =========================
    -- TREESITTER
    -- =========================
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "python", "lua", "javascript", "c", "cpp" },
                highlight = { enable = true },
                indent = { enable = true }
            })
        end
    },

    -- =========================
    -- EDITING
    -- =========================
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end
    },

    {
        "numToStr/Comment.nvim",
        keys = {
            { "gc", mode = { "n", "v" }, desc = "Comment toggle" },
            { "gb", mode = { "n", "v" }, desc = "Block comment" }
        },
        config = function()
            require("Comment").setup()
        end
    },

    -- =========================
    -- GIT
    -- =========================
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    },

    -- =========================
    -- STATUSLINE
    -- =========================
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "tokyonight",
                    component_separators = { left = "│", right = "│" },
                    section_separators = { left = "", right = "" }
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { { "filename", path = 1 } },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" }
                }
            })
        end
    },

    -- =========================
    -- TERMINAL
    -- =========================
    {
        "akinsho/toggleterm.nvim",
        keys = { { "<leader>t", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" } },
        config = function()
            require("toggleterm").setup({
                open_mapping = nil,
                direction = "float",
                float_opts = { border = "rounded" }
            })
        end
    },

    -- =========================
    -- MASON & LSP
    -- =========================
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },

    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", "clangd", "gopls" }
            })
        end
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable("pyright")
            vim.lsp.enable("clangd")
            vim.lsp.enable("gopls")
        end
    },

    -- =========================
    -- AUTOCOMPLETE
    -- =========================
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip"
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                }
            })
            -- Autopairs ile uyumluluk (varsa)
            pcall(function()
                local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            end)
        end
    }

})

-- Nvim-tree her başlangıçta aç
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function(data)
        if vim.fn.isdirectory(data.file) == 1 then
            vim.cmd.cd(data.file)
        end
        require("nvim-tree.api").tree.open()
    end,
})
