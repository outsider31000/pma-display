local isTalking = false
local voiceMode = 2
local show = true

local function doUpdate()
    SendNUIMessage({
        show = show,
        talking = isTalking,
        muted = false,
        mode = voiceMode
    })
end

AddStateBagChangeHandler('proximity', ('player:%s'):format(GetPlayerServerId(PlayerId())), function(_, _, value)
    if not value then return end
    voiceMode = value.index or 2
    doUpdate()
end)

AddEventHandler('pma-voice:setTalkingMode', function(newMode)
    voiceMode = newMode
    doUpdate()
end)

exports('toggleDisplay', function(visible)
    show = visible
    doUpdate()
end)

RegisterNetEvent('pma-display:toggle')
AddEventHandler('pma-display:toggle', function(visible)
    show = visible
    doUpdate()
end)


CreateThread(function()
    repeat Wait(5000) until LocalPlayer.state.IsInSession
    doUpdate()
        
    while true do
        local sleep = 700
        if not IsPlayerDead(PlayerId()) then
            sleep = 200
            local talking = MumbleIsPlayerTalking(PlayerId()) == 1
            if talking ~= isTalking then
               isTalking = talking
               doUpdate()
            end
        end         
        Wait(sleep)    
    end
end)
