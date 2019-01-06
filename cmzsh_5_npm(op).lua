

local function get_package_json_dir(path)
	-- return parent path for specified entry (either file or directory)
	local function get_parent_pathname(path)
		local prefix = ""
		local i = path:find("[\\/:][^\\/:]*$")
		if i then
				prefix = path:sub(1, i-1)
		end
		return prefix
	end

	local parent_path = get_parent_pathname(path)
	return io.open(path .. "\\package.json") or (parent_path ~= path and get_package_json_dir(parent_path) or nil)
end


local function add_npm_segment()
	local cwd = clink.get_cwd()
	local package_json = get_package_json_dir(cwd)

	if package_json and (config.use_npm_package_name or config.use_npm_package_version) then
		local package_info = package_json:read('*a')
		package_json:close()

		local npm_prefix = format_fg_color("npm:(", colors.green)
		local npm_sufix = format_fg_color(")", colors.green)
		
		local prompt = npm_prefix

		if config.use_npm_package_name then
			local package_name = string.match(package_info, '"name"%s*:%s*"(%g-)"')
			if package_name == nil then package_name = "" end
		
			prompt = prompt .. package_name
		end

		if config.use_npm_package_version then
			local package_version = string.match(package_info, '"version"%s*:%s*"(.-)"')
			if package_version == nil then package_version = "" end

			prompt = prompt .. format_fg_color((config.use_npm_package_name and "@" or "") .. package_version, colors.red)
		end

		prompt = prompt .. npm_sufix .. " "
		add_to_prompt(prompt)
	end
end


clink.prompt.register_filter(add_npm_segment, 60)
