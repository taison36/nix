return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    enabled = true,
    render_modes = { "n", "c", "t" },
  },
  keys = {
    {
      "<leader>mr",
      "<cmd>RenderMarkdown buf_toggle<CR>",
      desc = "Toggle Markdown rendering",
    },
    {
      "<leader>mp",
      "<cmd>RenderMarkdown preview<CR>",
      desc = "Preview Markdown in Neovim",
    },
  },
}
