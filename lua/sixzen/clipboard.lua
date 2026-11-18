local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has "macunix"
local is_linux = has "linux"
local is_win = has "win32"
local is_wsl = has "wsl"

-- Remote session (ssh or an `hc machine add` remote): copy through the
-- terminal with OSC 52 so the text reaches the client's clipboard.
-- On WSL inside hc this replaces win32yank, which would only reach the
-- clipboard of the Windows host running WSL.
local env = vim.env
local is_ssh = env.SSH_CONNECTION ~= nil or env.SSH_TTY ~= nil
local in_hc = env.HC_SCOPE ~= nil or env.HC_TERMINAL_ID ~= nil
local has_display = env.WAYLAND_DISPLAY ~= nil or env.DISPLAY ~= nil

if is_wsl then
  if is_ssh or in_hc then
    require "sixzen.osc52"
  else
    require "sixzen.wsl"
  end
elseif is_linux and (is_ssh or not has_display) then
  require "sixzen.osc52"
end

if is_mac or is_linux then
  require "sixzen.unix"
end
if is_win then
  require "sixzen.windows"
end
