local ghostty = "/Applications/Ghostty.app/Contents/MacOS/ghostty"

local primaryScreen = hs.screen.primaryScreen()
local winRect = primaryScreen:frame()
local WIDTH = winRect._w
local HEIGHT = winRect._h

local HOME = os.getenv("HOME")
local PUBLIC = os.getenv("HOME") .. "/.config/public"
local ZSHRC_CMD = ". " .. HOME .. "/.zshrc;"

local savedWindows = {}
local function saveAndMinimizeWindows()
	savedWindows = {}

	for _, win in ipairs(hs.window.allWindows()) do
		if win:isVisible() and not win:isMinimized() and win:screen() == primaryScreen then
			table.insert(savedWindows, {
				window = win,
			})
			win:minimize()
		end
	end
end

local function restoreWindows()
	for _, entry in ipairs(savedWindows) do
		local win = entry.window
		if win then
			win:unminimize()
		end
	end
	savedWindows = {}
end

local terminals = {
	{
		idx = 0,
		title = "nvim-projects",
		dir = HOME .. "/.config/zsh",
		cmd = "nvim ./plugins.zsh -c 'vsplit ./init.zsh'",
		x = 8,
		y = 8,
		w = WIDTH * 0.6,
		h = HEIGHT * 0.65,
	},
	{
		idx = 1,
		title = "personal-website",
		dir = HOME .. "/dev/02-web/personal-website",
		cmd = "lazygit",
		x = WIDTH - WIDTH * 0.6 - 8,
		y = HEIGHT * 0.05,
		w = WIDTH * 0.6,
		h = HEIGHT * 0.8,
	},
	{
		idx = 2,
		title = "zig-scanner",
		dir = HOME .. "/dev/06-zig/zig-print-files-structure",
		cmd = 'tmux new-session -n "editor" \\; send-keys -t "editor" "nvim +40 ./src/scanner.zig" Enter \\; new-window -n "term" \\; select-window -t "editor"',
		x = WIDTH * 0.1,
		y = HEIGHT - HEIGHT * 0.72 - 8,
		w = WIDTH * 0.6,
		h = HEIGHT * 0.7,
	},
}

local function findWindowByTitle(title)
	local app = hs.application.find("ghostty")
	if not app then
		return nil
	end

	for _, proc in ipairs(hs.application.applicationsForBundleID(app:bundleID())) do
		local pid = proc:pid()
		local handle = io.popen("ps -p " .. pid .. " -o args=")
		if handle then
			local args = handle:read("*l")
			handle:close()
			if args and args:find("--title=" .. title, 1, true) then
				local wins = proc:allWindows()
				if wins and #wins > 0 then
					return wins[1]
				end
			end
		end
	end
	return nil
end

local function afterAllDone()
	for _, term in ipairs(terminals) do
		if not term.done then
			return
		end
	end

	hs.timer.doAfter(0.3, function()
		table.sort(terminals, function(a, b)
			return a.idx < b.idx
		end)

		for _, term in ipairs(terminals) do
			term.win:focus()
			hs.timer.usleep(1000000 * 0.1)
		end

		local screen = hs.screen.primaryScreen()
		local img = screen:snapshot()
		local imgFilePath = PUBLIC .. "/setup.jpg"
		img:saveToFile(imgFilePath)

		hs.timer.usleep(1000000 * 0.2)

		for _, term in ipairs(terminals) do
			term.win:application():kill9()
		end

		local loader = hs.notify.new({
			title = "Dotfiles setup preview captured",
			informativeText = "Optimization started...",
			withdrawAfter = 0,
		})
		loader:send()

		local optimizeCmd = "magick "
			.. imgFilePath
			.. " -colorspace srgb -resize 1920x -type truecolor -quality 100 "
			.. imgFilePath
		hs.task
			.new("/bin/zsh", function(exitCode, _, stdErr)
				loader:withdraw()
				hs.notify.withdrawAll()
				if exitCode == 0 then
					hs.notify.new({ title = "Dotfiles setup optimization finished" }):send()
				else
					hs.notify
						.new({ title = "Dotfiles setup optimization error", informativeText = "Error: " .. stdErr })
						:send()
				end
			end, {
				"-c",
				ZSHRC_CMD .. optimizeCmd,
			})
			:start()

		restoreWindows()
	end)
end

saveAndMinimizeWindows()

hs.timer.doAfter(0.5, function()
	for _, term in ipairs(terminals) do
		term.done = false

		hs.task
			.new(ghostty, nil, {
				"--title=" .. term.title,
				"--working-directory=" .. term.dir,
				"-e",
				"/bin/zsh",
				"-l",
				"-c",
				ZSHRC_CMD .. term.cmd,
			})
			:start()

		hs.timer.usleep(1000000 * 0.2)

		local i = 0
		hs.timer.doUntil(function()
			i = i + 1
			term.win = findWindowByTitle(term.title)
			if term.win then
				term.win:setFrame(hs.geometry.rect(term.x, term.y, term.w, term.h))
				hs.timer.doAfter(0.1, function()
					term.done = true
					afterAllDone()
				end)
				return true
			end
			return i < 20
		end, 0.1)
	end
end)
