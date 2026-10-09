return {
  "akyrey/openapi-navigator.nvim",
  ft = { "yaml", "json" },
  cmd = { "OpenAPIPreview", "OpenAPIPreviewStop" },
  opts = {
    laravel = { enabled = false },
  },
  keys = {
    {
      "<leader>ap",
      "<cmd>OpenAPIPreview<CR>",
      ft = { "yaml", "json" },
      desc = "Preview OpenAPI spec",
    },
    {
      "<leader>as",
      "<cmd>OpenAPIPreviewStop<CR>",
      ft = { "yaml", "json" },
      desc = "Stop OpenAPI preview",
    },
  },
}
