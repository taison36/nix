return {
  {
    "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "clangd",
            "jdtls",
            "gopls",
      },
    },
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },
        "neovim/nvim-lspconfig",
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "prettier",
        "clang-format",
        "google-java-format",
      },
    },
    dependencies = {
      "williamboman/mason.nvim",
    },
  },
}
