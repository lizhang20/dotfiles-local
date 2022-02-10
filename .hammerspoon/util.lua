require('rescuewindows')
require('globalproxy')

utilMenu = hs.menubar.new()

local icon = [[
1 . . . . . . . . . . . 3
. # # . . . . . . . # # .
. # # # # . . . # # # # .
. . # # # # 2 # # # # . .
. . # # # # # # # # # . .
. . . # # # # # # # . . .
. . . 8 # # # # # 4 . . .
. . . # # # # # # # . . .
. . # # # # # # # # # . .
. . # # # # 6 # # # # . .
. # # # # . . . # # # # .
. # # . . . . . . . # # .
7 . . . . . . . . . . . 5
]]

utilMenu:setIcon('ASCII:' .. icon)

local menu = nil

local reloadMenu = function() utilMenu:setMenu(menu) end

menu = {
  {
    -- details in rescuewindows.lua
    title = "Rescue Windows",
    fn = rescueWindows
  },
  {
    title = "-" -- separator
  },
  {
    title = "Caffeinate",
    checked = false,
    fn = function(modifiers, menuItem)
      local enabled = hs.caffeinate.toggle('displayIdle')
      -- if enabled then
      --   hs.notify.new({title='Caffeinate', informativeText='Caffeinate On'}):send()
      -- else
      --   hs.notify.new({title='Caffeinate', informativeText='Caffeinate Off'}):send()
      -- end
    
      menuItem.checked = enabled
      reloadMenu()
    end
  },
  {
    title = "-" -- separator
  },
  {
    title = "Global Proxy",
    checked = checkProxyStatus(),
    fn = function(modifiers, menuItem)
      local proxyOn = toggleGlobalProxy()
      -- if proxyOn then
      --   hs.notify.new({title='GlobalProxy', informativeText='GlobalProxy On'}):send()
      -- else
      --   hs.notify.new({title='GlobalProxy', informativeText='GlobalProxy Off'}):send()
      -- end
    
      menuItem.checked = proxyOn
      reloadMenu()
    end
  },
  {
    title = "-" -- separator
  },
  {
    title = "Layout: Lab",
    fn = function()
      applyLayout("Lab", layoutLab())
    end
  },
  {
    title = "Layout: MacbookPro",
    fn = function()
      applyLayout("Lab", layoutLab())
    end
  },
}

reloadMenu()
