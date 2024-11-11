-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Disable adding a trailing newline in markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.bo.fileformat = "unix"
    vim.bo.fixendofline = false
  end,
})
