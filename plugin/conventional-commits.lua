if vim.g.loaded_conventions == 1 then
  return
end
vim.g.loaded_conventions = 1

require("conventional-commits").setup()

vim.api.nvim_create_user_command("ConventionalCommits", require("conventional-commits").show, {})
