local showEventMessage = false
local alpha = 0
local displayDuration = 5000
local fadeDuration = 1000
local startTime = 0

RegisterNetEvent("tpall:teleport")
AddEventHandler("tpall:teleport", function(coords)
    local playerPed = PlayerPedId()
    SetEntityCoords(playerPed, coords.x, coords.y, coords.z, false, false, false, false)

    SendNUIMessage({ action = "playEventSound" })

    showEventMessage = true
    startTime = GetGameTimer()
    alpha = 0
end)

CreateThread(function()
    while true do
        Wait(0)
        if showEventMessage then
            local now = GetGameTimer()
            local elapsed = now - startTime

            -- fade in/out שקיפות
            if elapsed < fadeDuration then
                alpha = math.floor((elapsed / fadeDuration) * 255)
            elseif elapsed > displayDuration - fadeDuration then
                alpha = math.floor(((displayDuration - elapsed) / fadeDuration) * 255)
            else
                alpha = 255
            end

            if elapsed >= displayDuration then
                showEventMessage = false
            end

            
            local r = math.floor(127 + 127 * math.sin(now / 250))
            local g = math.floor(127 + 127 * math.sin(now / 400))
            local b = math.floor(127 + 127 * math.sin(now / 550))

            
            local shakeX = math.sin(now / 80) * 0.006
            local shakeY = math.cos(now / 100) * 0.006

            
            local waveOffset = math.sin(now / 180) * 0.02

            
            local blinkAlpha = alpha * (0.6 + 0.4 * math.sin(now / 90))

            
            local rotateAngle = math.sin(now / 500) * 5 

            
            DrawAdvancedTextRotated(
                "Welcome to Ryzo Scripts",
                0.5 + shakeX + waveOffset,
                0.45 + shakeY,
                1.8,
                r, g, b,
                blinkAlpha,
                rotateAngle
            )
        end
    end
end)

function DrawAdvancedTextRotated(text, x, y, scale, r, g, b, a, angle)
    SetTextFont(7)
    SetTextProportional(1)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, math.floor(a))
    SetTextCentre(true)
    SetTextDropShadow()
    SetTextOutline()

    
    local screenX, screenY = GetActiveScreenResolution()
    local px = x * screenX
    local py = y * screenY

    SetTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)



    EndTextCommandDisplayText(x, y)
end
