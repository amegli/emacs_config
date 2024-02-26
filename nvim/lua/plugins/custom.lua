return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "meh",
    },
  },
  {
    "echasnovski/mini.indentscope",
    opts = {
      symbol = " ",
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    opts = {
      indent = {
        char = " ",
        tab_char = " ",
      },
    },
  },
  {
    "chomosuke/term-edit.nvim",
    lazy = false,
    version = "1.*",
  },
}
