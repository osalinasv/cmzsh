

function run_command(command, mode, read)
	mode = mode or "r"
	read = read or "*a"

	local f = io.popen(command, mode)
	local l = f:read(read)
	f:close()
	
	return l
end


function last_command_failed()
	return run_command("echo %ERRORLEVEL%", "r", "*n") > 0
end


function trim(s)
	return s:match("^%s*(.*%S)") or ""
end


function add_to_prompt(text)
	local trimmed = trim(text)
	if trimmed:len() > 0 then clink.prompt.value = clink.prompt.value .. trimmed .. " " end
end


local function reset_prompt()
	clink.prompt.value = ""
end


local function close_prompt()
	if config.use_prompt_newline then
		clink.prompt.value = clink.prompt.value .. symbols.new_line .. symbols.lambda .. " "
	else
		clink.prompt.value = clink.prompt.value .. (clink.prompt.value:sub(-1) == " " and "" or " ")
	end
end


clink.prompt.register_filter(reset_prompt, 51)
clink.prompt.register_filter(close_prompt, 99)
