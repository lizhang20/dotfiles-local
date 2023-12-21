MACBOOK_MONITOR = 'Color LCD'
LAB_LEFT_MONITOR = 'DELL U2720QM'
LAB_RIGHT_MONITOR = 'DELL U2412M'

local u = hs.geometry.unitrect

function concat(...)
    local res = {}
    for _, tab in ipairs({...}) do
        for _, elem in ipairs(tab) do
            table.insert(res, elem)
        end
    end
    return res
end

local detectIDE = function()
    local ide = nil
    for _, v in ipairs(IDEs) do
        if hs.application.get(v) then
            ide = v
            break
        end
    end
    return ide
end

layoutLab = function()
    -- {'Microsoft Edge', nil, LAB_LEFT_MONITOR, u(0, 1/4, 1, 3/4), nil, nil, visible=true},
    -- u(start from left side, start from upsize, last for horizontal, last for vertical)
    local right = {{
        'Notion',
        nil,
        LAB_RIGHT_MONITOR,
        u(0, 0.3, 1, 0.7),
        nil,
        nil,
        visible = true
    }, {
        '邮件',
        nil,
        LAB_RIGHT_MONITOR,
        u(0, 0, 1, 0.5),
        nil,
        nil,
        visible = true
    }, {
        '日历',
        nil,
        LAB_RIGHT_MONITOR,
        u(0, 0.4, 1, 0.5),
        nil,
        nil,
        visible = true
    }}

    local left = {{
        'Code',
        nil,
        LAB_LEFT_MONITOR,
        u(0, 0, 1, 1),
        nil,
        nil,
        visible = true
    }, {
        'iTerm2',
        nil,
        LAB_LEFT_MONITOR,
        u(0, 0, 1, 1),
        nil,
        nil,
        visible = true
    }, {
        'Microsoft Edge',
        nil,
        LAB_LEFT_MONITOR,
        u(0, 0, 1, 1),
        nil,
        nil,
        visible = true
    }}

    -- Apps on macbook display
    -- local mb = {
    --   {'Keybase', nil, MACBOOK_MONITOR, u(0, 0, 1/2, 1), nil, nil, visible=true},
    --   {'Mail', nil, MACBOOK_MONITOR, u(1/2, 0, 1/2, 1), nil, nil, visible=true},
    --   {'Slack', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false},
    --   {'Spotify', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false}
    -- }
    return concat(left, right)
end

layoutLaptop = {{'Calendar', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil},
                {'Emacs', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil},
                {'Google Chrome', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil},
                {'Mail', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil},
                {'Slack', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil},
                {'Spotify', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil},
                {'Things', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil},
                {'iTerm2', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil},
                {'Keybase', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil}}

applyLayout = function(name, layout)
    for _, entry in ipairs(layout) do
        local name = entry[1]
        local show = entry['visible']
        if show ~= nil then
            local app = hs.application.get(name)
            if app then
                if show then
                    app:unhide()
                else
                    app:hide()
                end
            end
        end
    end
    hs.layout.apply(layout)
    hs.notify.new({
        title = 'Layout',
        informativeText = 'Applied layout: ' .. name
    }):send()
end

hasScreen = function(name)
    for _, screen in ipairs(hs.screen.allScreens()) do
        if screen:name() == name then
            return true
        end
    end
    return false
end
