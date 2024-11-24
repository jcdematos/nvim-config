local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local previewers = require('telescope.previewers')
local utils = require('telescope.previewers.utils')
local config = require('telescope.config').values

local log = require('plenary.log'):new()
log.level = 'debug'

local M = {}

M.show_docker_images = function(opts)
    pickers.new(opts, {
	finder = finders.new_async_job({
	    command_generator = function()
		return {"docker", "images", "--format", "json"}
	    end,
	    results = {
		{name = "Yes", value = {1, 2, 3, 4, 5} },
		{name = "No", value = {1, 2, 3, 4, 5} },
		{name = "Maybe", value = {1, 2, 3, 4, 5} },
		{name = "Perhaps", value = {1, 2, 3, 4, 5} },
	    },
	    entry_maker = function(entry) 
		log.debug(entry)
		local parsed = vim.json.decode(entry)
		log.debug(parsed)
		if parsed then
		    return {
			value = parsed, 
			display = parsed.Repository,
			ordinal = parsed.Repository .. ':' .. parsed.Tag -- enabled searching by Tag
		    }
		end
	    end
	}),
	sorter = config.generic_sorter(opts),
	previewer = previewers.new_buffer_previewer({
	    title = "Docker Image Details",
	    define_preview = function(self, entry)
		vim.api.nvim_buf_set_lines(
		self.state.bufnr, 
		0, 
		0, 
		true, 
		vim.tbl_flatten({"Hello", "Everyone",
		"```lua",
		vim.split(vim.inspect(entry.value), "\n"),
		"```lua"})
		)
		utils.highlighter(self.state.bufnr, "markdown")
	    end,
	}),
	attach_mappings = function(prompt_bufnr)
	    actions.select_default:replace(function() 
		local selection = action_state.get_selected_entry()
		log.debug("Selected", selection)
		actions.close(prompt_bufnr)
		local command = {
		    "edit",
		    "term://docker",
		    "run",
		    "-it",
		    selection.value.Repository,
		}
		log.debug("Let's go", command)
		vim.cmd(vim.fn.join(command))
	    end)
	    return true
	end
    }):find()
end

return M
