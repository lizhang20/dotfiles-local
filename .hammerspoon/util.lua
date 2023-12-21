require('rescuewindows')
require('globalproxy')

utilMenu = hs.menubar.new()

-- http://cocoamine.net/blog/2015/03/20/replacing-photoshop-with-nsstring/
-- https://asiafu.com/blog/6032765a1782dd14dc62c6c6
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

local smileIconBackup= [[
. . . . 3 # # M . . . . .
. . . . . # # # . . . . .
1 . . 1 . 4 # # L . . . .
. . . . . . 5 # # K . . .
1 . . 1 . . . 6 # # J . .
. . . . . . . . 7 # # I .
. . . . . . . . # # # # .
. . . . . . . . 8 # # H .
2 . . 2 . . . 9 # # G . .
. . . . . . A # # F . . .
2 . . 2 . B # # E . . . .
. . . . . # # # . . . . .
. . . . C # # D . . . . .
]]

local smileIcon= [[
. . . . 3 # S . . . . . .
. . . . . 4 # R . . . . .
1 1 . . . . 5 # Q . . . .
1 1 . . . . . 6 # P . . .
. . . . . . . . 7 # O . .
. . . . . . . . . 8 # N .
. . . . . . . . . . 9 # M
. . . . . . . . . A # L .
. . . . . . . . B # K . .
2 2 . . . . . C # J . . .
2 2 . . . . D # I . . . .
. . . . . E # H . . . . .
. . . . F # G . . . . . .
]]

local iconAsciiBackup = [[
......AD....
............
.F.......PQ.
.I..........
............
............
K..........G
N..........H
............
............
..........L.
.BC.......M.
............
....SR......
]]

local iconAscii = [[
............
......AD....
.F..........
.I..........
............
........PQ..
K..........G
N..........H
..BC........
............
..........L.
..........M.
....SR......
............
]]

ampOnIcon = [[
.....1a..........AC..........E
..............................
......4.......................
1..........aA..........CE.....
e.2......4.3...........h......
..............................
..............................
.......................h......
e.2......6.3..........t..q....
5..........c..........s.......
......6..................q....
......................s..t....
.....5c.......................
]]

ampOffIcon = [[
.....1a.....x....AC.y.......zE
..............................
......4.......................
1..........aA..........CE.....
e.2......4.3...........h......
..............................
..............................
.......................h......
e.2......6.3..........t..q....
5..........c..........s.......
......6..................q....
......................s..t....
...x.5c....y.......z..........
]]


utilMenu:setIcon('ASCII:' .. icon)

local menu = nil

local reloadMenu = function() utilMenu:setMenu(menu) end

menu = {
  {
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
      menuItem.checked = proxyOn
      reloadMenu()
    end
  },
  {
    title = "-" -- separator
  },
  {
    title = "Balance Audio",
    fn = function()
      balanceAudio()
    end
  },
  {
    title = "-" -- separator
  },
  {
    title = "Reset Ethernet IPv6",
    fn = function()
      hs.notify.new({title='Reset Ethernet', informativeText='Reset Ethernet'}):send()
      hs.execute("networksetup -setv6off AX88179A")
      hs.execute("networksetup -setv6automatic AX88179A")
    end
  }
  -- {
  --   title = "Samba Status",
  --   fn = function()
  --     hs.notify.new({title='Samba', informativeText='Todo: using macos sharing command'}):send()
  --   end
  -- },
  -- {
  --   title = "-" -- separator
  -- },
  -- {
  --   title = "Layout: Lab",
  --   fn = function()
  --     applyLayout("Lab", layoutLab())
  --   end
  -- },
  -- {
  --   title = "Layout: MacbookPro",
  --   fn = function()
  --     applyLayout("Lab", layoutLab())
  --   end
  -- },
}

reloadMenu()
