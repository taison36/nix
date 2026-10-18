local function navigate(wincmd, direction)
  local previous_window = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. wincmd)

  if vim.api.nvim_get_current_win() ~= previous_window then
    return
  end

  if vim.env.HERDR_PANE_ID and vim.env.HERDR_PANE_ID ~= "" then
    local herdr = vim.env.HERDR_BIN_PATH
    if not herdr or herdr == "" then
      herdr = "herdr"
    end
    vim.fn.system({ herdr, "pane", "focus", "--direction", direction, "--pane", vim.env.HERDR_PANE_ID })
  elseif vim.env.TMUX and vim.env.TMUX ~= "" then
    local tmux_direction = { left = "Left", down = "Down", up = "Up", right = "Right" }
    pcall(vim.cmd, "TmuxNavigate" .. tmux_direction[direction])
  end
end

local function map(key, vim_direction, herdr_direction)
  vim.keymap.set("n", key, function()
    navigate(vim_direction, herdr_direction)
  end, { silent = true, noremap = true })
end

map("<C-h>", "h", "left")
map("<C-j>", "j", "down")
map("<C-k>", "k", "up")
map("<C-l>", "l", "right")
