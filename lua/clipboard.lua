local has = function(x)
	return vim.fn.has(x) == 1
end

local is_mac = has("macunix")
local is_linux = has("linux")
local is_win = has("win32")
local is_wsl = has("wsl")

if is_wsl then
	require("wsl")
end

if is_mac or is_linux then
	require("unix")
end
if is_win then
	require("windows")
end
