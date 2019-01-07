

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


local function get_package_info(package_json)
	if package_json then
		local package_info = package_json:read('*a')
		package_json:close()

		return package_info
	end

	return nil
end


local function get_package_name(package_info)
	return string.match(package_info, '"name"%s*:%s*"(%g-)"')
end


local function get_package_version(package_info)
	return string.match(package_info, '"version"%s*:%s*"(.-)"')
end


local function add_npm_segment()
	if config.use_npm_package_name or config.use_npm_package_version then
		local cwd = clink.get_cwd()
		local package_json = get_package_json_dir(cwd)
		local package_info = get_package_info(package_json)
	
		if package_info then
			local npm_prefix = format_fg_color("npm:(", colors.green)
			local npm_sufix = format_fg_color(")", colors.green)
			
			local prompt = npm_prefix
	
			if config.use_npm_package_name then
				local package_name = get_package_name(package_info)
				prompt = prompt .. (package_name or "package")
			end
	
			if config.use_npm_package_version then
				local package_version = get_package_version(package_info)
				prompt = prompt .. format_fg_color((config.use_npm_package_name and "@" or "") .. (package_version or "0.0.0"), colors.red)
			end
	
			add_to_prompt(prompt .. npm_sufix)
		end
	end
end


clink.prompt.register_filter(add_npm_segment, 60)
