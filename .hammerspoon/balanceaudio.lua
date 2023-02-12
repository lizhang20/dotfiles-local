function balanceAudio()
    hs.audiodevice.defaultOutputDevice():setBalance(0.5)
    hs.alert.show("Output Audio Balance: 0.5")
end