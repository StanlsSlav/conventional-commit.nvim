local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local themes = require("telescope.themes")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local commit_types = require("conventional-commits.commit_types")

local M = {}

function M.setup(opts)
    opts = opts or {}
end

function M.show(opts)
    opts = opts or themes.get_dropdown()

    local type = ""
    pickers.new(opts, {
        prompt_title = "Commit Type",
        finder = finders.new_table({ results = commit_types:get_names_only() }),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()

                type = selection[1]
            end)
            return true
        end,
    }):find()

    vim.api.nvim_put({ type .. "(scope): "}, "", false, true)
end

return M
