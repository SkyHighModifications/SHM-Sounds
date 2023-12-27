-- SHM Sounds
-- Version: v1.0.0
-- Path: server/main.lua
Citizen.CreateThread(function()
  local resourceName = string.lower(GetCurrentResourceName())
  if resourceName == "shm-sounds" or resourceName == "shm_sounds" then
    StartResource(resourceName)
    WarningPrint(resourceName .. " has started")  -- Assuming WarningPrint and ErrorPrint are not defined; using print instead
  else
    StopResource(resourceName)
    ErrorPrint(resourceName .. " has stopped due to resourceName malfunction")  -- Using print instead
  end
end)
--
-- Allows sounds to be played on single clients, all clients, or all clients within
-- a specific range from the entity to which the sound has been created. Triggers
-- client events only. Used to trigger sounds on other clients from the client or
-- server without having to pass directly to another client.

-- RegisterServerEvent SHM-Sounds_SV:PlayOnTarget
-- Triggers -> ClientEvent SHM-Sounds_CL:PlayOnTarget
--
-- @param clientNetId  - The network id of the client that the sound should be played on.
-- @param audioFile    - The name of the sound file within the client/html/sounds/ folder.
-- @param audioVolume  - The volume at which the sound file should be played. Nil or default for standardVolumeOutput (0.1 to 1.0).
-- Starts playing a sound locally on a single client.
RegisterNetEvent('SHM-Sounds_SV:PlayOnTarget')
AddEventHandler('SHM-Sounds_SV:PlayOnTarget', function(clientNetId, audioFile, audioVolume)
    TriggerClientEvent('SHM-Sounds_CL:PlayOnTarget', clientNetId, audioFile, audioVolume)
end)

-- RegisterServerEvent SHM-Sounds_SV:PlayOnTargetSource
-- Triggers -> ClientEvent SHM-Sounds_CL:PlayOnTargetSource
--
-- @param audioFile    - The name of the sound file within the client/html/sounds/ folder.
-- @param audioVolume  - The volume at which the sound file should be played. Nil or default for standardVolumeOutput (0.1 to 1.0).
-- Starts playing a sound locally on a single client, which is the source of the event.
RegisterNetEvent('SHM-Sounds_SV:PlayOnTargetSource')
AddEventHandler('SHM-Sounds_SV:PlayOnTargetSource', function(audioFile, audioVolume)
    TriggerClientEvent('SHM-Sounds_CL:PlayOnTarget', source, audioFile, audioVolume)
end)

-- RegisterServerEvent SHM-Sounds_SV:PlayGlobally
-- Triggers -> ClientEvent SHM-Sounds_CL:PlayGlobally
--
-- @param audioFile     - The name of the sound file within the client/html/sounds/ folder.
-- @param audioVolume   - The volume at which the sound file should be played. Nil or default for standardVolumeOutput (0.1 to 1.0).
-- Starts playing a sound on all clients who are online in the server.
RegisterNetEvent('SHM-Sounds_SV:PlayGlobally')
AddEventHandler('SHM-Sounds_SV:PlayGlobally', function(audioFile, audioVolume)
    TriggerClientEvent('SHM-Sounds_CL:PlayGlobally', -1, audioFile, audioVolume)
end)

-- RegisterServerEvent SHM-Sounds_SV:PlaySpatially
-- Triggers -> ClientEvent SHM-Sounds_CL:PlaySpatially
--
-- @param playOnEntity    - The entity network id of the entity for which the max distance is drawn.
-- @param maxDistance     - The maximum distance to allow the player to hear the sound file being played.
-- @param audioFile       - The name of the sound file within the client/html/sounds/ folder.
-- @param audioVolume     - The volume at which the sound file should be played. Nil or default for standardVolumeOutput (0.1 to 1.0).
-- Starts playing a sound on a client if within the specified maxDistance from the playOnEntity.
-- @TODO Change sound volume based on the distance the player is away from the playOnEntity.
RegisterNetEvent('SHM-Sounds_SV:PlaySpatially')
AddEventHandler('SHM-Sounds_SV:PlaySpatially', function(maxDistance, audioFile, audioVolume)
    local src = source
    local distanceLimit = Config.DistanceLimit

    if maxDistance < distanceLimit then
        TriggerClientEvent('SHM-Sounds_CL:PlaySpatially', -1, GetEntityCoords(GetPlayerPed(src)), maxDistance, audioFile, audioVolume)
    else
      WarningPrint("%s attempted to trigger SHM-Sounds_SV:PlaySpatially over the distance limit " .. distanceLimit):format(GetPlayerName(src))    end
end)


-- RegisterServerEvent SHM-Sounds_SV:PlaySpatiallyAtCoords
-- Triggers -> ClientEvent SHM-Sounds_SV:PlaySpatiallyAtCoords
--
-- @param maxDistance     - The maximum distance to allow the player to hear the sound file being played.
-- @param audioFile       - The name of the sound file within the client/html/sounds/ folder.
-- @param audioVolume     - The volume at which the sound file should be played. Nil or default for standardVolumeOutput (0.1 to 1.0).
-- @param coords          - The coordinates from which the distance is calculated.
-- Starts playing a sound on a client if within the specified maxDistance from the coords.
-- @TODO Change sound volume based on the distance the player is away from the coords.
RegisterServerEvent('SHM-Sounds_SV:PlaySpatiallyAtCoords')
AddEventHandler('SHM-Sounds_SV:PlaySpatiallyAtCoords', function(maxDistance, audioFile, audioVolume, coords)
    local source = source
    local distance = #(coords - GetEntityCoords(GetPlayerPed(GetPlayerPed(src))))

    if distance < maxDistance then
        TriggerClientEvent('SHM-Sounds_CL:PlaySpatiallyAtCoords', source, audioFile, audioVolume, coords)
    end
end)


function ErrorPrint(msg)
  print(("[^1ERROR^7] ^3%s^7: %s"):format(GetCurrentResourceName(), msg))
end

RegisterNetEvent(GetCurrentResourceName() .. ":ErrorPrint")
AddEventHandler(GetCurrentResourceName() .. ":ErrorPrint", function(msg)
  ErrorPrint(msg)
end)

function WarningPrint(msg)
  print(("[^3WARNING^7] ^3%s^7: %s"):format(GetCurrentResourceName(), msg))
end

RegisterNetEvent(GetCurrentResourceName() .. ":WarningPrint")
AddEventHandler(GetCurrentResourceName() .. ":WarningPrint", function(msg)
  WarningPrint(msg)
end)

-- Function to log changelog information
local function LogChangelog(changelog)
  print("Changelog:")
  print(changelog)
  print("End of Changelog\n")
end

-- Function to log update status
local function LogUpdateStatus(_type, message)
  -- Define color codes for success and error messages
  local color = (_type == 'success') and '^2' or '^1'
  local formattedMessage = string.format(
      "[%sUPDATE^7] ^3%s^7: %s%s^7", 
      color, 
      GetCurrentResourceName(), 
      color, 
      message
  )
  print(formattedMessage)
end

-- Function to log changelog information
local function LogChangelog(changelog)
  print(changelog)
end

-- Function to parse version and changelog from version.txt
local function ParseVersionAndChangelog(text)
  local versions = {}
  for version, changelog in text:gmatch("Version:%s*(.-)\n\nChangelog:%s*(.-)\n\nEnd of Changelog") do
      versions[version:gsub("%s+", "")] = changelog
  end
  return versions
end


AddEventHandler('onResourceStart', function(resource)
  -- Check if the current resource is the one being started
  if GetCurrentResourceName() == resource then
      -- Make an HTTP request to check for updates
      PerformHttpRequest('https://raw.githubusercontent.com/SkyHighModifications/SHM-Sounds/main/version.txt', function(err, text, headers)
          if not text then
              LogUpdateStatus('error', 'Update check encountered an issue.')
              return
          end

          local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
          local versions = ParseVersionAndChangelog(text)

          LogUpdateStatus('success', string.format("Currently Installed Version: ^6%s^7", currentVersion))

          -- Check if the current version is in the list
          if versions[currentVersion] then
              LogChangelog(versions[currentVersion])
          else
              LogUpdateStatus('error', "Changelog not found for the currently installed version.")
          end
      end)
  end
end)
