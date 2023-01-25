Heap = {
    Medics = {}
}

Citizen.CreateThread(function()
    while not Heap.ESX do
        Heap.ESX = exports["es_extended"]:getSharedObject()

        Citizen.Wait(100)
    end

    Initialized()
end)

Citizen.CreateThread(function()
    while true do
        local sleepThread = 5000

        local newPed = PlayerPedId()

        if Heap.Ped ~= newPed then
            Heap.Ped = newPed
        end

        Citizen.Wait(sleepThread)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(500)

    while true do
        local sleepThread = 500

        local ped = Heap.Ped
        local pedCoords = GetEntityCoords(ped)

        for medicIndex, medic in ipairs(Medics) do
            local dstCheck = #(pedCoords - medic.Location)

            if dstCheck <= 3.0 then
                sleepThread = 5

                local usable = not Heap.Medics[medicIndex]

                local displayText = usable and "[~y~E~s~] to get ~b~medical treatment~s~ (~g~$" .. medic.Price .. "~s~)" or "~b~Medic~s~ is currently ~r~unavailable~s~, please wait."

                if usable and IsControlJustPressed(0, 38) then
                    TryToGetMedicalTreatment(medicIndex)
                end

                DrawScriptText(medic.Location, displayText)
            end
        end

        Citizen.Wait(sleepThread)
    end
end)
