vim.lsp.enable("clangd", {
  capabilities = {
    offsetEncoding = { "utf-8" },
  },
})

vim.lsp.enable("jdtls", {
  capabilities = {
    offsetEncoding = { "utf-16" },
  },
})

vim.lsp.enable("gopls", {
  capabilities = {
    offsetEncoding = { "utf-16" },
  },
})

-- optional: disable inline diagnostics (you already did this)
vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end


local keymap = vim.keymap
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }


    vim.keymap.set("n", "<Esc>", function()
      vim.cmd("nohlsearch")
    end)

    -- set keybinds
    opts.desc = "Show LSP references"
    keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

    opts.desc = "Go to declaration"
    keymap.set("n", "gd", vim.lsp.buf.declaration, opts) -- go to declaration

    opts.desc = "Show LSP impl/definition"
    keymap.set("n", "gi", vim.lsp.buf.definition, opts) -- show lsp definition

    opts.desc = "Show LSP type definitions"
    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

    opts.desc = "See available code actions"
    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

    opts.desc = "Smart rename"
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

    opts.desc = "Show buffer diagnostics"
    keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

    opts.desc = "Show line diagnostics"
    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

    opts.desc = "Show documentation for what is under cursor"
    keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = "Restart LSP"
    keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
  end,
})
