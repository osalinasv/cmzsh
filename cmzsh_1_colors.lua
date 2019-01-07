

colors = {
	esc = "\x1b",
	black = {
		f = "30",
		b = "40",
	},
	red = {
		f = "31",
		b = "41",
	},
	green = {
		f = "32",
		b = "42",
	},
	yellow = {
		f = "33",
		b = "43",
	},
	blue = {
		f = "34",
		b = "44",
	},
	magenta = {
		f = "35",
		b = "45",
	},
	cyan = {
		f = "36",
		b = "46",
	},
	white = {
		f = "37",
		b = "47",
	}
}


function format_fg_color(text, color)
	return format_with_color(text, color.f, colors.black.b)
end


function format_with_color(text, fc, bc)
	return colors.esc .. "[" .. fc .. ";" .. bc .. "m" .. text .. colors.esc .. "[" .. "0m"
end
