-- SHM Sounds
-- Version: v1.0.0
-- Path: server/main.lua
--
-- Allows sounds to be played on single clients, all clients, or all clients within
-- a specific range from the entity to which the sound has been created.
--

-- Global variables
local standardVolumeOutput = Config_SHM.StandardVolume
local PlayerInfo = {
    hasLoaded = false,
    playerId = nil,
    Id = PlayerId(),
}

if Config_SHM.PlayerSync then
    Citizen.CreateThread(function()
        while PlayerInfo.playerId == nil do 
            Wait(15000)
            PlayerInfo.playerId = PlayerInfo.Id
        end
        PlayerInfo.hasLoaded = true
    end)
else
    Citizen.CreateThread(function()
        Wait(15000)
        PlayerInfo.hasLoaded = true
    end)
end

-- RegisterNetEvent SHM-Sounds_CL:PlayOnTarget
-- Triggers -> SendNUIMessage to play sound on a single client
--
-- @param audioFile    - The name of the sound file within the client/html/sounds/ folder.
--                      - Can also specify a folder/sound file.
-- @param audioVolume  - The volume at which the audioFile should be played.
--                      - Nil or default for standardVolumeOutput (0.1 to 1.0).
--
-- Starts playing a sound locally on a single client.
RegisterNetEvent('SHM-Sounds_CL:PlayOnTarget')
AddEventHandler('SHM-Sounds_CL:PlayOnTarget', function(audioFile, audioVolume)
    if PlayerInfo.hasLoaded then
        SendNUIMessage({
            audioCategory = 'playSound',
            audioFile = audioFile,
            audioVolume = audioVolume or standardVolumeOutput
        })
    end
end)

-- RegisterNetEvent SHM-Sounds_CL:PlayGlobally
-- Triggers -> SendNUIMessage to play sound on all clients
--
-- @param audioFile    - The name of the sound file within the client/html/sounds/ folder.
--                      - Can also specify a folder/sound file.
-- @param audioVolume  - The volume at which the audioFile should be played.
--                      - Nil or default for standardVolumeOutput (0.1 to 1.0).
--
-- Starts playing a sound on all clients who are online in the server.
RegisterNetEvent('SHM-Sounds_CL:PlayGlobally')
AddEventHandler('SHM-Sounds_CL:PlayGlobally', function(audioFile, audioVolume)
    if PlayerInfo.hasLoaded then
        SendNUIMessage({
            audioCategory = 'playSound',
            audioFile = audioFile,
            audioVolume = audioVolume or standardVolumeOutput
        })
    end
end)

-- RegisterNetEvent SHM-Sounds_CL:PlaySpatially
-- Triggers -> SendNUIMessage to play sound on a client within a specific distance
--
-- @param otherPlayerCoords - The coordinates of the player/entity for which the max distance is drawn.
-- @param maxDistance       - The maximum distance to allow the player to hear the sound file being played.
-- @param audioFile         - The name of the sound file within the client/html/sounds/ folder.
--                          - Can also specify a folder/sound file.
-- @param audioVolume       - The volume at which the audioFile should be played.
--                          - Nil or default for standardVolumeOutput (0.1 to 1.0).
--
-- Starts playing a sound on a client if the client is within the specified maxDistance from the otherPlayerCoords.
-- @TODO Change sound volume based on the distance the player is away from the otherPlayerCoords.
RegisterNetEvent('SHM-Sounds_CL:PlaySpatially')
AddEventHandler('SHM-Sounds_CL:PlaySpatially', function(otherPlayerCoords, maxDistance, audioFile, audioVolume)
    if PlayerInfo.hasLoaded then
        local distance = #(GetEntityCoords(PlayerPedId()) - otherPlayerCoords)

        if distance < maxDistance = maxDistance or Config_SHM.DistanceLimit then
            SendNUIMessage({
                audioCategory = 'playSound',
                audioFile = audioFile,
                audioVolume = audioVolume or standardVolumeOutput
            })
        end
    end
end)


RegisterNetEvent('SHM-Sounds_CL:PlaySpatiallyAtCoords')
AddEventHandler('SHM-Sounds_CL:PlaySpatiallyAtCoords', function(maxDistance, audioFile, audioVolume, coords)
    if PlayerInfo.hasLoaded then
        local distance = #(coords - GetEntityCoords(PlayerPedId()))

        if distance < maxDistance then
            SendNUIMessage({
                audioCategory = 'playSound',
                audioFile = audioFile,
                audioVolume = audioVolume or standardVolumeOutput,
                coords = { x = coords.x, y = coords.y, z = coords.z } or { x = 0.0, y = 0.0, z = 0.0 }
            })
        end
    end
end)



