

local function get_dir_name(path)
	local slash_index = path:reverse():find("\\")
	return path:sub(-slash_index + 1):gsub("\\", "")
end


local function get_prompt_dir(cwd)
	if config.use_root_symbol and cwd == "C:\\" then
		return symbols.root
	elseif config.use_home_symbol and cwd == clink.get_env("HOME") then
		return symbols.home
	elseif config.use_short_paths then
		return get_dir_name(cwd)
	elseif config.use_posix_paths then
		return cwd:gsub("\\", "/")
	end
	
	return cwd
end


local function add_prompt_segment()
	local cwd = clink.get_cwd()
	local arrow_color = last_command_failed() and colors.red or colors.green
	
	add_to_prompt(format_fg_color(symbols.arrow, arrow_color))
	add_to_prompt(format_fg_color(get_prompt_dir(cwd), colors.cyan))
end


clink.prompt.register_filter(add_prompt_segment, 55)
