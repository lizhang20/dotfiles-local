-- ref:
-- https://www.hammerspoon.org/docs/hs.pathwatcher.html

local reloadConfig = function()
  hs.notify.new({title='Hammerspoon', informativeText='Reloading config'}):send()
  hs.reload()
end

local getCurFilename = function()
  -- debug.getinfo(2, "S").source return example: "@/Users/zli/.hammerspoon/reloader.lua"
  -- f will be "/reloader.lua"
  local f = debug.getinfo(2, "S").source:match("^.+(/.+)$")
  return f
end

-- get real path of hammerspoon config
local currentFilename = getCurFilename()
local absPath = hs.fs.pathToAbsolute(hs.fs.currentDir() .. currentFilename) 
local configPath = absPath:sub(1, -#currentFilename)

configWatcher = hs.pathwatcher.new(configPath, reloadConfig):start()