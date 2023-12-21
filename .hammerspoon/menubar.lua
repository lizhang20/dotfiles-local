require('rescuewindows')
require('globalproxy')
require('icons')

utilMenu = hs.menubar.new()
-- utilMenu:setIcon('ASCII:' .. icon)
utilMenu:setIcon(hammerIcon)

local menu = nil
local reloadMenu = function() 
  utilMenu:setMenu(menu) 
end

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
