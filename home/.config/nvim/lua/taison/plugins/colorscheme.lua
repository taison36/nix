return {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        vim.g.gruvbox_material_background = 'soft'
        vim.g.gruvbox_material_foreground = 'mix'
        vim.cmd.colorscheme('gruvbox-material')
    end
}
--
--
--return {
--    "slugbyte/lackluster.nvim",
--    lazy = false,
--    priority = 1000,
--    init = function()
--        --vim.cmd.colorscheme("lackluster")
--        -- vim.cmd.colorscheme("lackluster-hack") -- my favorite
--         vim.cmd.colorscheme("lackluster-mint")
--    end,
--}
--return {
--    "zenbones-theme/zenbones.nvim",
--    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
--    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
--    -- In Vim, compat mode is turned on as Lush only works in Neovim.
--    dependencies = "rktjmp/lush.nvim",
--    lazy = false,
--    priority = 1000,
--    config = function()
--        vim.g.zenbones_darken_comments = 45
--        vim.cmd.colorscheme('warm')
--    end
--}

--return {
--    {
--        "silentium-theme/silentium.nvim",
--        lazy = false,
--        priority = 1000,
--        config = function()
--            require("silentium").setup({
--                accent = require("silentium").accents.yellow,
--            })
--
--            vim.cmd.colorscheme("silentium")
--        end,
--    },
--}

--return {
--  "kvrohit/rasmus.nvim",
--  priority = 1000,
--  config = function()
--    vim.cmd([[colorscheme rasmus]])
--  end,
--}
