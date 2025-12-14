-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load core configuration
require("core.options")
require("core.keymaps")

-- Load plugins
require("plugins.init")

-- Function to recursively require all .lua files in a directory
local function load_moduls_directory(dir_path)
	local config_dir = vim.fn.stdpath("config") .. "/lua/" .. dir_path
	local success, dir_content = pcall(vim.fn.readdir, config_dir)

	if not success then
		return
	end

	for _, item in ipairs(dir_content) do
		local item_path = config_dir .. "/" .. item
		local is_directory = vim.fn.isdirectory(item_path) == 1

		if is_directory then
			-- Recursively load subdirectories
			load_moduls_directory(dir_path .. "/" .. item)
		elseif item:match("%.lua$") then
			-- Require .lua files
			local module_name = item:gsub("%.lua$", "")
			local full_module_path = dir_path .. "." .. module_name
			pcall(require, full_module_path)
		end
	end
end

-- Function to load all configs from a specific directory
local function load_lazy_configs(config_type)
	local config_dir = "config/" .. config_type
	local success, dir_content = pcall(vim.fn.readdir, vim.fn.stdpath("config") .. "/lua/" .. config_dir)

	if not success then
		return
	end

	for _, item in ipairs(dir_content) do
		if item:match("%.lua$") then
			local module_name = item:gsub("%.lua$", "")
			local full_module_path = config_dir .. "." .. module_name
			pcall(require, full_module_path)
		end
	end
end


-- Loadm all moduls
load_moduls_directory("moduls")
load_moduls_directory("autocmd")


-- load config.....
-- Load all plugin lazy configurations
load_lazy_configs("plugin_cfg")
load_lazy_configs("lsp_cfg")

load_moduls_directory("config/modul_cfg")
