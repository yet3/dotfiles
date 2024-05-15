local M = {
	"freddiehaddad/feline.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"f-person/git-blame.nvim",
		"rcarriga/nvim-notify",
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyCheck",
			callback = function()
				vim.opt.statusline = vim.opt.statusline
			end,
		})
	end,
}

function M.config()
	local feline = require "feline"

	local colors = {
		bg = get_hi_bg "StatusLineBg",

		m_normal = get_hi "StatusLineModeNormal",
		m_visual = get_hi "StatusLineModeVisual",
		m_insert = get_hi "StatusLineModeInsert",
		m_replace = get_hi "StatusLineModeReplace",
		m_command = get_hi "StatusLineModeCommand",
		m_s = get_hi "StatusLineModS",

		-- m_visual = '#9ccfd8',
		-- m_normal = '#ebbcba',
		-- m_insert = '#eb6f92',
		-- m_replace = '#eb6f92',
		-- m_command = '#f6c177',
		-- m_s = '#c4a7e7',

		ruler_bg = "#403d52",
		ruler_fg = "#908caa",

		island_fg = "#f6c177",
		island_bg = "#403d52",

		git_branch = get_hi "StatusLineGitBranch",

		file = get_hi "StatusLineFile",
		file_modified = get_hi "StatusLineFileModified",

		git_blame = get_hi "StatusLineGitBlame",

		caret_pos = get_hi "StatusLineCaretPos",

		git_del = "#eb6f92",
		git_add = "#9ccfd8",
		git_change = "#c4a7e7",
	}

	local mode_theme = {
		["NORMAL"] = colors.m_normal,
		["OP"] = colors.m_command,
		["INSERT"] = colors.m_insert,
		["VISUAL"] = colors.m_visual,
		["LINES"] = colors.m_visual,
		["BLOCK"] = colors.m_visual,
		["REPLACE"] = colors.m_replace,
		["V-REPLACE"] = colors.m_replace,
		["ENTER"] = colors.m_insert,
		["MORE"] = colors.m_visual,
		["SELECT"] = colors.m_s,
		["SHELL"] = colors.m_command,
		["TERM"] = colors.m_command,
		["NONE"] = colors.m_normal,
		["COMMAND"] = colors.m_command,
	}

	local modes = setmetatable({
		["n"] = "N",
		["no"] = "N",
		["v"] = "V",
		["V"] = "VL",
		[""] = "VB",
		["s"] = "S",
		["S"] = "SL",
		[""] = "SB",
		["i"] = "I",
		["ic"] = "I",
		["R"] = "R",
		["Rv"] = "VR",
		["c"] = "C",
		["cv"] = "EX",
		["ce"] = "X",
		["r"] = "P",
		["rm"] = "M",
		["r?"] = "C",
		["!"] = "SH",
		["t"] = "T",
	}, {
		__index = function()
			return "-"
		end,
	})

	local components = {
		active = {},
		inactive = {},
	}
	local LEFT = 1
	local MID = 2
	local RIGHT = 3

	-- Insert three sections (left, mid and right) for the active statusline
	table.insert(components.active, {})
	table.insert(components.active, {})
	table.insert(components.active, {})

	-- Insert two sections (left and right) for the inactive statusline
	table.insert(components.inactive, {})
	table.insert(components.inactive, {})
	table.insert(components.inactive, {})

	-- Mode
	table.insert(components.active[LEFT], {
		provider = {
			name = "vim_mode",
			update = { "ModeChanged" },
		},
		hl = function()
			local hi = require("feline.providers.vi_mode").get_mode_color()
			return {
				fg = hi.fg,
				bg = hi.bg,
				style = "bold",
			}
		end,
		left_sep = "left_rounded",
		right_sep = "right_rounded",
	})

	table.insert(components.active[LEFT], {
		enabled = function()
			return vim.b.gitsigns_head ~= nil
		end,
		provider = {
			name = "git",
			update = function()
				return vim.b.gitsigns_head ~= nil
			end,
		},
		hl = function()
			return {
				fg = colors.git_branch.fg,
				bg = colors.git_branch.bg,
				style = "bold",
			}
		end,
		left_sep = " ",
		right_sep = "right_rounded",
	})

	-- File icon
	table.insert(components.active[LEFT], {
		provider = function()
			local bufName = vim.api.nvim_buf_get_name(0)
			local extension = vim.fn.fnamemodify(bufName, ":e")
			local icon = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
			return icon .. " "
		end,
		hl = function()
			local _, icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
			return {
				fg = icon_color,
				bg = colors.island_bg,
				style = "bold",
			}
		end,
		left_sep = " ",
		right_sep = "",
	})

	-- File name
	table.insert(components.active[LEFT], {
		provider = function()
			local bufName = vim.api.nvim_buf_get_name(0)

			local filename = vim.fn.fnamemodify(bufName, ":.")
			if filename == "" then
				return "[No Name]"
			end
			filename = vim.fn.pathshorten(filename)

			return filename
		end,
		hl = {
			fg = colors.file.fg,
			bg = colors.file.bg,
			style = "bold",
		},
		left_sep = "",
		right_sep = function()
			return vim.bo.modified and "" or "right_rounded"
		end,
	})

	table.insert(components.inactive[MID], {
		provider = function()
			local bufName = vim.api.nvim_buf_get_name(0)

			local filename = vim.fn.fnamemodify(bufName, ":.")
			if filename == "" then
				return "[No Name]"
			end
			filename = vim.fn.pathshorten(filename)

			return filename
		end,
		hl = {
			fg = colors.file.fg,
			bg = colors.file.bg,
			style = "bold",
		},
		left_sep = "left_rounded",
		right_sep = "right_rounded",
	})

	-- File flags
	table.insert(components.active[LEFT], {
		enabled = function()
			return vim.bo.modified
		end,
		provider = " ",
		hl = {
			fg = colors.file_modified.fg,
			bg = colors.file_modified.bg,
			style = "bold",
		},
		left_sep = "",
		right_sep = "",
	})

	-- GitBlame
	table.insert(components.active[RIGHT], {
		enabled = function()
			local git_blame = require "gitblame"
			return git_blame.is_blame_text_available()
		end,
		provider = {
			name = "git_blame",
		},
		hl = {
			fg = colors.git_blame.fg,
			bg = colors.git_blame.bg,
		},
		left_sep = "left_rounded",
		right_sep = " ",
	})

	-- CaretPos
	table.insert(components.active[RIGHT], {
		provider = "%l/%L:%c",
		hl = {
			fg = colors.caret_pos.fg,
			bg = colors.caret_pos.bg,
		},
		left_sep = "left_rounded",
		right_sep = "right_rounded",
	})

	feline.setup {
		disable = {
			filetypes = {
				"^NvimTree$",
				"^neo-tree$",
				"neo-tree",
				"^NeoTree$",
				"^packer$",
				"^startify$",
				"^fugitive$",
				"^fugitiveblame$",
				"^qf$",
				"^help$",
			},
			buftypes = {
				"^terminal$",
				"^neo-tree$",
			},
			bufnames = {
				"^neo-tree$",
			},
		},
		custom_providers = {
			vim_mode = function(_, opts)
				local mode = modes[vim.api.nvim_get_mode().mode]
				if opts.type ~= "short" then
					mode = " " .. mode .. " "
				end
				return mode
			end,
			git = function(_, opts)
				if vim.b.gitsigns_head ~= nil then
					return " " .. vim.b.gitsigns_head
				end
				return " ..."
			end,
			git_blame = function(_, opts)
				local git_blame = require "gitblame"
				local name = str_split(git_blame.get_current_blame_text(), " • ")[1]
				if name == nil then
					return ""
				end
				local p = name:sub(-1):lower() == "s" and "" or "s"
				if name == "Not" then
					return ""
				end
				return name .. "'" .. p .. " fault"
			end,
		},
		components = components,
		theme = colors,
		vi_mode_colors = mode_theme,
	}

	-- Git refresh
	vim.cmd [[call timer_start(500, {-> execute(':let &stl=&stl')}, {'repeat': -1})]]
end

return M
