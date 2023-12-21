-------------------------------------------------------------
-------------------------------------------------------------
--------------- *** Note Note Note *** ----------------------
----------- Remember to create a dynamic link ---------------
----------- using dotbot ./install command ------------------
----------- when creating a new lua script ------------------
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
------- auto reload hammerspoon config file when file changed
require('reloader')
require('menubar')
-- move window to anywhere
--
-- 1. left, right, up, bottom of current screen
-- 2. upleft, upright, downleft, downright of current screen
-- 3. move between displays
-- 4. full screen, center screen
-- 5. window hints
require('window')
-- auto change input method in different app
-- see current app dir and input method using ctrl+command+.
require('ime')
-- use command+up/down to set volume
require('volume')
-- fix Airpods automatically unbalance issue
require('balanceaudio')
require('clipboard')
require('layout')
