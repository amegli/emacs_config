local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.elixir" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.dap.nlua" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- import/override with your plugins
    { "David-Kunz/jester" },
    { "theHamsta/nvim-dap-virtual-text" },

    { "rktjmp/lush.nvim" },
    { "vim-colors-meh" },
    { "nordtheme/vim" },
    { "ellisonleao/gruvbox.nvim" },
    { "ericbn/vim-solarized" },
    { "hardselius/warlock" },
    { "mcchrish/zenbones.nvim" },
    { "davidosomething/vim-colors-meh" },
    { "vim-scripts/zenesque.vim" },
    { "kvrohit/rasmus.nvim" },
    { import = "lazyvim.plugins.extras.util.project" },
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

require("term-edit").setup({
  -- Mandatory option:
  -- Set this to a lua pattern that would match the end of your prompt.
  -- Or a table of multiple lua patterns where at least one would match the
  -- end of your prompt at any given time.
  -- For most bash/zsh user this is '%$ '.
  -- For most powershell/fish user this is '> '.
  -- For most windows cmd user this is '>'.
  prompt_end = "%$ ",
  -- How to write lua patterns: https://www.lua.org/pil/20.2.html
})

--[[
require("dap").adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { "~/.config/nvim/js-debug/src/dapDebugServer.js", "${port}" },
  },
}

require("dap").configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}
]]

require("jester").setup({
  dap = {
    type = "pwa-node",
  },
})

require("nvim-dap-virtual-text").setup({})
