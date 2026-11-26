-- ログイン時に自動起動
hs.autoLaunch(true)

--------------------------------------------------------------------------------
-- KVM専用プロファイル（GLKVM-Chrome）で起動したChromeが前面にある間、
-- Karabinerの変数 glkvm_active を 1 にする
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

-- KVM専用プロファイルで起動したChromeのプロセスかどうかを判定（PIDごとにキャッシュ）
local glkvmPids = {}

local function isGlkvmProcess(app)
	local pid = app:pid()
	if glkvmPids[pid] == nil then
		local cmd = hs.execute("/bin/ps -o command= -p " .. pid) or ""
		glkvmPids[pid] = cmd:find("GLKVM-Chrome", 1, true) ~= nil
	end
	return glkvmPids[pid]
end

local function updateGlkvm()
	local win = hs.window.focusedWindow()
	local active = 0
	if win then
		local app = win:application()
		if app and app:bundleID() == "com.google.Chrome" and isGlkvmProcess(app) then
			active = 1
		end
	end
	setGlkvmActive(active)
end

-- 前面のウィンドウを定期的にチェック（グローバル変数にしてGCを防ぐ）
glkvmTimer = hs.timer.doEvery(0.3, updateGlkvm)
