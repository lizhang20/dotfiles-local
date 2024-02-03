require('volume')

logger = hs.logger.new("watchers", "info")

function netAuth()
    _, status, _ = hs.execute("ifconfig en7")
    if status then
        logger.i("network interface en7 detected")
        output, _, _ = hs.execute("pwd")
        logger.i("current working dir " .. output)
        -- execute a script in current directory: net-auth.sh
        output, status, _ = hs.execute("bash ./net-auth.sh")
        logger.i("netwotk auth result " .. output)
        if not status then hs.execute("bash ./net-auth.sh") end
    end
end

wakeupWatcher = hs.caffeinate.watcher.new(function(state)
    if (state == hs.caffeinate.watcher.systemDidWake or 
        state == hs.caffeinate.watcher.screensDidUnlock) then
        -- mute the volume
        muteBuiltInSpeakerDevice()
        -- network authentication when there is en7
        netAuth()
    end
end):start()
