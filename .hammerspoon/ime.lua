local function Chinese()
    hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM.ITABC")
end

local function English()
    hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
end

-- app to expected ime config
local app2Ime = {
    {'iTerm2', 'English'},
    {'Finder', 'English'},
    {'Spotlight', 'English'},
    {'System Preferences', 'English'},
    {'Code', 'English'},
    {'Notion', 'English'},
    {'网易有道词典', 'English'},
    {'PyCharm', 'English'},
    {'Qt Creator', 'English'},
    {'Android Studio', 'English'},
    {'IntelliJ IDEA', 'English'},
    {'Microsoft Edge Beta', 'English'},
    {'DingTalk', 'Chinese'},
    {'NeteaseMusic', 'Chinese'},
    -- {'WeChat', 'Chinese'},
}

function updateFocusAppInputMethod()
    local focusAppName = hs.window.frontmostWindow():application():name()
    for index, app in pairs(app2Ime) do
        local appName = app[1]
        local expectedIme = app[2]

        if focusAppName == appName then
            if expectedIme == 'English' then
                English()
            else
                Chinese()
            end
            break
        end
    end
end

-- helper hotkey to figure out the app path and name of current focused window
hs.hotkey.bind({'ctrl', 'cmd'}, ".", function()
    hs.alert.show("App path:        "
    ..hs.window.focusedWindow():application():path()
    .."\n"
    .."App name:      "
    ..hs.window.focusedWindow():application():name()
    .."\n"
    .."IM source id:  "
    ..hs.keycodes.currentSourceID())
end)

-- Handle cursor focus and application's screen manage.
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        updateFocusAppInputMethod()
    end
end

appWatcher = hs.application.watcher.new(applicationWatcher):start()
