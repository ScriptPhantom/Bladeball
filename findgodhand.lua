if game.PlaceId == 6403373529 then
    local teleportFunc = queueonteleport or queue_on_teleport or syn and syn.queue_on_teleport
    if teleportFunc then
        teleportFunc([[ 
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end
        repeat task.wait() until game.Players.LocalPlayer
        wait(0.25)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ScriptPhantom/Scripts/refs/heads/main/findgodhand.lua"))()
        ]])
    end
end
local function checkGloveForGod()
    local foundGod = false
    -- Проходим по всем игрокам
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then
            local gloveValue = leaderstats:FindFirstChild("Glove")
            -- Проверяем, если Glove существует и содержит "God"
            if gloveValue and string.match(gloveValue.Value, "God") then
                foundGod = true
                break
            end
        end
    end
    return foundGod
end

local function teleportToAvailableServer()
    local serverList = {}

    -- Получаем список серверов
    for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
        -- Проверяем, если сервер не заполнен
        if v.playing and type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
            serverList[#serverList + 1] = v.id
        end
    end

    -- Если есть свободные сервера, телепортируемся
    if #serverList > 0 then
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, serverList[math.random(1, #serverList)])
        return true -- Успешная телепортация
    else
        warn("No available servers found for teleportation.")
        return false -- Не удалось телепортироваться
    end
end

-- Бесконечный цикл телепортации, пока не будет найден "God"
while true do
    if not checkGloveForGod() then
        print('Бога не найдено, телепортируемся на другой сервер...')
        teleportToAvailableServer()
        wait(5) -- Ждем 5 секунд перед следующей попыткой
    else
        -- Если "God" найдено хотя бы у одного игрока, выполняем указанный скрипт
        print('НАШЕЛ БОГА!')
        
        if not game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2125950512) then
            game:GetService("StarterGui"):SetCore("SendNotification", {Title = "[ Giang ]", Text = "📢 [ You have not issued Bob, and not badge bob ] 🇻🇳.", Icon = "rbxassetid://7733658504", Duration = 10})
            fireclickdetector(workspace.Lobby.Replica.ClickDetector)
            wait(0.25)
            firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 0)
            firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 1)
            wait(0.4)

            if _G.SlappleFarm == true then
                if game.Players.LocalPlayer.Character:FindFirstChild("entered") then
                    for i, v in pairs(workspace.Arena.island5.Slapples:GetChildren()) do
                        if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("entered") and (v.Name == "Slapple" or v.Name == "GoldenSlapple") and v:FindFirstChild("Glove") and v.Glove:FindFirstChildWhichIsA("TouchTransmitter") then
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Glove, 0)
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Glove, 1)
                        end
                    end
                end
            end

            if _G.CandyFarm == true then
                for i, v in pairs(game.Workspace.CandyCorns:GetChildren()) do
                    if game.Players.LocalPlayer.Character:FindFirstChild("Head") and v:FindFirstChildWhichIsA("TouchTransmitter") then
                        firetouchinterest(game.Players.LocalPlayer.Character.Head, v, 0)
                        firetouchinterest(game.Players.LocalPlayer.Character.Head, v, 1)
                    end
                end
            end

            wait(0.4)
            for i = 1, 4000 do
                game:GetService("ReplicatedStorage").Duplicate:FireServer(true)
            end

            -- Проверяем, если не телепортировались
            while not teleportToAvailableServer() do
                wait(5) -- Ждем 5 секунд перед следующей попыткой
            end
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {Title = "[ Giang ]", Text = "📢 [ You Got Badge Bob, Meaning you already have Bob ] 🇻🇳.", Icon = "rbxassetid://7733658504", Duration = 10})
        end
        break -- Выход из основного цикла, так как "God" найден
    end
end
