function changeVolume(diff)
  return function()
    local current = hs.audiodevice.defaultOutputDevice():volume()
    local new = math.min(100, math.max(0, math.floor(current + diff)))
    if new > 0 then
      hs.audiodevice.defaultOutputDevice():setMuted(false)
    else
      hs.audiodevice.defaultOutputDevice():setMuted(true)
    end
    hs.alert.closeAll(0.0)
    hs.alert.show("Volume " .. new .. "%", {}, 0.3)
    hs.audiodevice.defaultOutputDevice():setVolume(new)
  end
end

function muteVolume()
  return function()
    local muted = hs.audiodevice.defaultOutputDevice():muted()
    if muted then
      hs.audiodevice.defaultOutputDevice():setMuted(false)
    else
      hs.audiodevice.defaultOutputDevice():setMuted(true)
    end
    hs.alert.closeAll(0.0)
    hs.alert.show("Volume " .. (muted and "Unmuted: " .. hs.audiodevice.defaultOutputDevice():volume() or "Muted"), {}, 0.5)
  end
end

hs.hotkey.bind({'cmd'}, 'Down', changeVolume(-8))
hs.hotkey.bind({'cmd'}, 'Up', changeVolume(8))
hs.hotkey.bind({'cmd'}, 'Left', muteVolume())

-- mute built-in speaker device when start up
function muteBuiltInSpeakerDevice()
  local curAudioDevice = hs.audiodevice.current()
  if curAudioDevice.uid == "BuiltInSpeakerDevice" then
    hs.audiodevice.defaultOutputDevice():setMuted(true)
    hs.alert.show("Muted: " .. curAudioDevice.name)
  end
end

wakeupWatcher = hs.caffeinate.watcher.new(function(state)
  if state == hs.caffeinate.watcher.systemDidWake then
    muteBuiltInSpeakerDevice()
  end
end):start()
