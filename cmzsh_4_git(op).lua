

local function get_git_dir(path)
	-- return parent path for specified entry (either file or directory)
	local function get_parent_pathname(path)
			local prefix = ""
			local i = path:find("[\\/:][^\\/:]*$")
			if i then
					prefix = path:sub(1, i-1)
			end
			return prefix
	end

	-- Checks if provided directory contains git directory
	local function has_git_dir(dir)
			return clink.is_dir(dir..'/.git') and dir..'/.git'
	end

	local function has_git_file(dir)
			local gitfile = io.open(dir..'/.git')
			if not gitfile then return false end

			local git_dir = gitfile:read():match('gitdir: (.*)')
			gitfile:close()

			return git_dir and dir..'/'..git_dir
	end

	-- Calculate parent path now otherwise we won't be
	-- able to do that inside of logical operator
	local parent_path = get_parent_pathname(path)

	return has_git_dir(path)
			or has_git_file(path)
			-- Otherwise go up one level and make a recursive call
			or (parent_path ~= path and get_git_dir(parent_path) or nil)
end


local function get_git_branch(git_dir)
	git_dir = git_dir or get_git_dir()

	-- If git directory not found then we're probably outside of repo
	-- or something went wrong. The same is when head_file is nil
	local head_file = git_dir and io.open(git_dir..'/HEAD')
	if not head_file then return "" end

	local HEAD = head_file:read()
	head_file:close()

	-- if HEAD matches branch expression, then we're on named branch
	-- otherwise it is a detached commit
	return HEAD:match('ref: refs/heads/(.+)') or HEAD:sub(1, 7)
end


local function get_git_status()
	return not run_command("git --no-optional-locks status --porcelain 2>nul", "r", "*l")
end


local function add_git_segment()
	local cwd = clink.get_cwd()
	local git_dir = get_git_dir(cwd)
	
	if git_dir then
		local branch = get_git_branch(git_dir)
		local prompt = ""

		if branch then
			local git_prefix = format_fg_color("git:(", colors.blue)
			local git_sufix = format_fg_color(")", colors.blue)
		
			prompt = git_prefix .. format_fg_color(branch, colors.red) .. git_sufix .. " "
		end
		
		if get_git_status() == false then
			prompt = prompt .. format_fg_color(symbols.git_dirty, colors.yellow) .. " "
		end
		
		add_to_prompt(prompt)
	end
end


clink.prompt.register_filter(add_git_segment, 61)
