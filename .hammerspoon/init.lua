-- 1. rescue application window outside of display
-- 2. caffeinate
require('util')

-- move window to anywhere
--
-- 1. left, right, up, bottom of current screen
-- 2. upleft, upright, downleft, downright of current screen
-- 3. move between displays
-- 4. full screen, center screen
-- 5. window hints
--
-- see more info in window.lua
require('window')

-- auto change input method in different app
-- see current app dir and input method using ctrl+command+.
require('ime')

-- use command+up/down to set volume
require('volume')
-- fix Airpods automatically unbalance issue
require('balanceaudio')

require('settings')

require('clipboard')

require('config')
require('layout')

-- auto reload hammerspoon config file when file changed
require('reloader')
