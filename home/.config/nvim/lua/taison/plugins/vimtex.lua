return {
    "lervag/vimtex",
    lazy = false,
    ft = "tex",
    init = function()
        vim.g.vimtex_view_method = 'skim'
        vim.g.vimtex_mappings_enabled = 1
        vim.g.vimtex_compiler_method = 'latexmk'
        vim.g.vimtex_compiler_latexmk_engines = {
            _ = '-xelatex'
        }
    end,
    keys = {
        { "<leader>ll", "<cmd>VimtexCompile<cr>", desc = "VimTeX Compile", ft = "tex" },
        { "<leader>lv", "<cmd>VimtexView<cr>", desc = "VimTeX View", ft = "tex" },
        { "<leader>lc", "<cmd>VimtexClean<cr>", desc = "VimTeX Clean", ft = "tex" },
        { "<leader>ls", "<cmd>VimtexStatus<cr>", desc = "VimTeX Status", ft = "tex" },
        { "<leader>li", "<cmd>VimtexInfo<cr>", desc = "VimTeX Info", ft = "tex" },
    },
}
