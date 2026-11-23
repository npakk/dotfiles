-- ログイン時に自動起動
hs.autoLaunch(true)

--------------------------------------------------------------------------------
-- ChromeでGLKVMを開いている間、Karabinerの変数 glkvm_active を 1 にする
-- （Karabiner側で variable_unless 条件を付け、RShiftをそのまま送るため）
--------------------------------------------------------------------------------
local karabinerCli = "/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli"
local glkvmLast = nil

local function setGlkvmActive(active)
	if active == glkvmLast then
		return
	end
	glkvmLast = active
	hs.task.new(karabinerCli, nil, { "--set-variables", '{"glkvm_active":' .. active .. "}" }):start()
end

local function updateGlkvm()
	local win = hs.window.focusedWindow()
	local active = 0
	if win then
		local app = win:application()
		if app and app:bundleID() == "com.google.Chrome" and (win:title() or ""):find("GLKVM", 1, true) then
			active = 1
		end
	end
	setGlkvmActive(active)
end

-- タブ切り替えも拾えるよう定期的にチェック（グローバル変数にしてGCを防ぐ）
glkvmTimer = hs.timer.doEvery(0.3, updateGlkvm)
