Config_SHM = {

    -- Maximum distance for playing sounds within the "PlayWithinDistance" event.
    DistanceLimit = 300,

    -- Standard volume for playing sounds. Adjust if needed.
    StandardVolume = 0.3,

    -- Synchronize with the player loading process. 
    -- If true, continuously check for the player's existence until valid. 
    -- If false, wait for the specified time and then assume the player has loaded.
    PlayerSync = true,

    defaultCoords = { -- Default (this is only when you don't set coords for sound)
        x = 0.0,
        y = 0.0,
        z = 0.0,
    }
}
