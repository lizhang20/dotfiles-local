checkProxyStatus = function(interface)
    local output = hs.execute("networksetup -getwebproxy " .. interface .. " | grep No")
    local enabled
    if string.find(output, "No") then
        enabled = false
    else
        enabled = true
    end
    return enabled
end

toggleGlobalProxy = function()
    local proxyOn = checkProxyStatus("Wi-Fi")  -- check proxy status when reloading menu
    if proxyOn then
        -- if proxy is enabled, disable it
        hs.execute("networksetup -setwebproxystate Wi-Fi off")
        hs.execute("networksetup -setsecurewebproxystate Wi-Fi off")
        hs.execute("networksetup -setsocksfirewallproxystate Wi-Fi off")
        hs.execute("networksetup -setstreamingfirewallproxystate Wi-Fi off")
        return false
    else
        -- if proxy is disabled, enable it
        hs.execute("networksetup -setwebproxystate Wi-Fi on")
        hs.execute("networksetup -setsecurewebproxystate Wi-Fi on")
        hs.execute("networksetup -setsocksfirewallproxystate Wi-Fi on")
        hs.execute("networksetup -setstreamingfirewallproxystate Wi-Fi on")
        local proxyStatus = hs.execute("networksetup -getwebproxy Wi-Fi")
        local alertInfo = "Proxy status: enabled\n" .. proxyStatus:sub(1, -2)  -- remove the last \n
        hs.alert.show(alertInfo)
        return true
    end
end

menubarInit = function()
    return checkProxyStatus("Wi-Fi")
end