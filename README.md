# My-Neovim-Config

Modern and minimal Neovim configuration. A development environment powered by Tokyo Night theme, Lazy.nvim plugin manager, and up-to-date tools.

## 📋 Requirements

- **Neovim** 0.10+ (0.11 recommended)
- **Git**
- **Make** (for telescope-fzf-native build)
- **C compiler** (for tree-sitter parsers)

### Linux (Arch/CachyOS)
```bash
sudo pacman -S neovim git base-devel
```

## 🚀 Installation

### Automatic Installation (Recommended)

Creates `~/.config/nvim` directory and `init.lua` if they don't exist. Backs up and overwrites if they do:

```bash
git clone https://github.com/MorphyKutay/My-Neovim-Config
cd My-Neovim-Config
chmod +x install.sh
./install.sh
```

### Manual Installation

```bash
# Clone the repo
git clone https://github.com/MorphyKutay/My-Neovim-Config ~/My-Neovim-Config  

# Create Neovim config directory (if it doesn't exist)
mkdir -p ~/.config/nvim

# Copy init.lua
cp ~/My-Neovim-Config/init.lua ~/.config/nvim/init.lua

# Launch Neovim - Lazy.nvim will automatically install plugins
nvim
```

On first launch, Lazy.nvim installs automatically and downloads plugins. Run `:TSUpdate` to install tree-sitter parsers.

## 🔧 Tools Used

### Plugin Manager
- **[Lazy.nvim](https://github.com/folke/lazy.nvim)** — Lazy-loading plugin manager (auto bootstrap)

### Theme & Appearance
- **[Tokyo Night](https://github.com/folke/tokyonight.nvim)** — Color scheme
- **[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)** — Indent guides
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** — Statusline
- **[nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)** — File icons

### Modern UI
- **[noice.nvim](https://github.com/folke/noice.nvim)** — Modern command line and message UI
- **[nvim-notify](https://github.com/rcarriga/nvim-notify)** — Toast notifications
- **[mini.animate](https://github.com/echasnovski/mini.animate)** — Window/scroll animations
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** — Keybinding helper

### File & Navigation
- **[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)** — File tree (opens automatically on startup)
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** — Fuzzy finder
- **[telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim)** — Fast native search

### Code Editing
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** — Syntax highlighting (Python, Lua, JS, C, C++)
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** — Bracket/quote pairing
- **[Comment.nvim](https://github.com/numToStr/Comment.nvim)** — Comment toggle

### LSP & Completion
- **[Mason](https://github.com/williamboman/mason.nvim)** — LSP/DAP/Linter installer
- **[mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim)** — Mason-LSP bridge
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** — LSP configuration (Pyright default)
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** — Completion engine
  - cmp-nvim-lsp, cmp-buffer, cmp-path
  - [LuaSnip](https://github.com/L3MON4D3/LuaSnip) — Snippet support

### Other
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** — Git signs
- **[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** — Floating terminal

## ⌨️ Keybindings

| Key | Action |
|-----|--------|
| `<Space>` | Leader key |
| `<Space>e` | File tree (toggle) |
| `<Space>ff` | Find files |
| `<Space>fg` | Live grep |
| `<Space>fb` | Buffers |
| `<Space>fh` | Help tags |
| `<Space>t` | Floating terminal |
| `gc` | Toggle comment (line) |
| `gb` | Block comment |

### Cmp (Completion)
| Key | Action |
|-----|--------|
| `<C-Space>` | Completion menu |
| `<Tab>` / `<S-Tab>` | Select item |
| `<CR>` | Confirm selection |
| `<C-e>` | Abort |

Plugins are stored under `~/.local/share/nvim/lazy/` after installation.

## 🔄 Updating

```bash
cd ~/My-Neovim-Config
git pull
./install.sh
```

Run `:Lazy sync` inside Neovim to update plugins.

## 📝 Customization

- **Theme:** Replace `tokyonight-night` with `tokyonight-storm` or `tokyonight-day` in `init.lua`
- **LSP:** Install more LSPs via `:Mason`; add them to the `vim.lsp.enable()` line in `init.lua`
- **Tree-sitter:** Add languages to `ensure_installed` and run `:TSUpdate`
