# SHM-Sounds

Enable immersive audio experiences by utilizing the NUI (Native UI) environment within the FXServer of FiveM to seamlessly trigger and control the playback of a diverse range of sounds. This functionality enhances the overall audio ambiance, providing a dynamic and interactive dimension to the virtual environment.

## Config 

The configuration in this script allows for the customization of various parameters, tailoring the behavior of the sound system to your specific needs. Here's an explanation of each configurable option:

* Maximum distance for playing sounds within the `PlaySpatially` or `PlaySpatiallyAtCoords` event.
// DistanceLimit = 300,

* Standard volume for playing sounds. Adjust if needed.
// StandardVolume = 0.3,

* Synchronize with the player loading process. 
- (If `true`, continuously check for the player's existence until valid.) 
- (If `false`, wait for the specified time and then assume the player has loaded).
// PlayerSync = true,

* this is only when you don't set coords for sound `PlaySpatiallyAtCoords`
defaultCoords = { -- Default
        x = 0.0,
        y = 0.0,
        z = 0.0,
    }

# ChangeLog
- V1.0.0 / Initial Release
- V1.0.1 / Minor adjustments that were causing script issues!
