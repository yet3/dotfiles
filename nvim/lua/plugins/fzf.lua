return {
	"ibhagwan/fzf-lua",
	dependencies = {
		{ "junegunn/fzf", build = "./install --bin" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local path = require("fzf-lua.path")
		local actions = require("fzf-lua.actions")
		local uv = vim.uv or vim.loop

		local get_path = function(sel, opts)
			local entry = path.entry_to_file(sel, opts, opts._uri)
			if entry.path == "<none>" then
				return
			end
			local fullpath = entry.bufname or entry.uri and entry.uri:match("^%a+://(.*)") or entry.path

			if not path.is_absolute(fullpath) then
				fullpath = path.join({ opts.cwd or opts._cwd or uv.cwd(), fullpath })
			end

			return fullpath
		end

		require("fzf-lua").setup({
			winopts = {
				fullscreen = true,
			},
			keymap = {
				builtin = {
					false,
					["<M-j>"] = "preview-page-down",
					["<M-k>"] = "preview-page-up",
				},
				fzf = {
					false, -- do not inherit from defaults
					["ctrl-d"] = "half-page-down",
					["ctrl-u"] = "half-page-up",
				},
			},
			actions = {
				files = {
					false,
					["enter"] = actions.file_edit_or_qf,
					["ctrl-s"] = actions.file_vsplit,
					["ctrl-h"] = actions.file_split,

					["ctrl-o"] = function(selected, opts)
						local fullpath = get_path(selected[1], opts)

						if fullpath == nil then
							return
						end

						local win_id = require("window-picker").pick_window({
							filter_rules = {
								include_current_win = true,
							},
						}) or vim.api.nvim_get_current_win()
						local buf_id = vim.fn.bufadd(fullpath) -- Add the file as a buffer
						vim.fn.bufload(buf_id)
						vim.api.nvim_win_set_buf(win_id, buf_id)
						vim.api.nvim_set_current_win(win_id)
					end,

					["ctrl-n"] = function(selected, opts)
						local fullpath = get_path(selected[1], opts)

						if fullpath == nil then
							return
						end

						local dirpath = fullpath
						if path.extension(fullpath) ~= nil then
							dirpath = path.parent(fullpath, true) or ""
						end

						vim.cmd("Oil " .. dirpath)
					end,
				},
			},
			fzf_opts = {
				-- ['--sort'] = "name",
				-- ["--exact"] = true
				-- sort=name --exact'
				-- ['--layout'] = "reverse",
				-- ["--border"] = "top"
			},
		})

		vim.keymap.set("n", "<c-f>", require("fzf-lua").files, { desc = "Fzf Files" })
		vim.keymap.set("n", "<c-s-f>", function()
			require("fzf-lua").files({ resume = true })
		end, { desc = "Fzf Files" })
		vim.keymap.set("n", "<c-g>", require("fzf-lua").live_grep, { desc = "Fzf Live Grep" })
		vim.keymap.set("n", "<c-s-g>", require("fzf-lua").live_grep_resume, { desc = "Fzf Live Grep" })
	end,
}
