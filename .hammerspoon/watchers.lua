require('volume')

wakeupWatcher = hs.caffeinate.watcher.new(function(state)
  if state == hs.caffeinate.watcher.systemDidWake then

    -- mute the volume
    muteBuiltInSpeakerDevice()

    -- network authentication when there is en7
    _, status, _ = hs.execute("ifconfig en7")
    if status then
        -- execute a script in current directory: net-auth.sh
        hs.execute("bash ./net-auth.sh")
    end

  end
end):start()
