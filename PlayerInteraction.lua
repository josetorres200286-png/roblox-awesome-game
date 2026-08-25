--[[
    PLAYER INTERACTION AND GAMEPLAY MECHANICS
    Place this in ServerScriptService
    Handles collectibles, leaderboard, and player actions
]]

local Players = game:GetService("Players")
local Workspace = game.Workspace

-- Leaderboard data
local leaderboard = {}
local POINTS_PER_GEM = 10

-- Function to update leaderboard
local function UpdateLeaderboard(player, points)
    if not leaderboard[player.UserId] then
        leaderboard[player.UserId] = {
            Name = player.Name,
            Points = 0,
            GemsCollected = 0
        }
    end
    
    leaderboard[player.UserId].Points = leaderboard[player.UserId].Points + points
    leaderboard[player.UserId].GemsCollected = leaderboard[player.UserId].GemsCollected + 1
    
    print("💰 " .. player.Name .. " earned " .. points .. " points! Total: " .. leaderboard[player.UserId].Points)
end

-- Function to create collectible interaction
local function SetupCollectibles()
    local collectiblesFolder = Workspace:FindFirstChild("Collectibles")
    
    if not collectiblesFolder then return end
    
    for _, gem in ipairs(collectiblesFolder:GetChildren()) do
        local alreadyCollected = {}
        
        local touchConnection
        touchConnection = gem.Touched:Connect(function(hit)
            local humanoid = hit.Parent:FindFirstChild("Humanoid")
            if not humanoid then return end
            
            local player = Players:GetPlayerFromCharacter(hit.Parent)
            if not player then return end
            
            -- Prevent double collection
            if alreadyCollected[player.UserId] then return end
            alreadyCollected[player.UserId] = true
            
            -- Award points
            UpdateLeaderboard(player, POINTS_PER_GEM)
            
            -- Remove gem
            gem:Destroy()
            touchConnection:Disconnect()
        end)
    end
end

-- Function to create leaderboard GUI
local function CreateLeaderboardGUI()
    -- This will be visible in-game
    print("📊 Leaderboard System Active")
end

-- Function to add player to game
local function OnPlayerAdded(player)
    print("🎮 " .. player.Name .. " joined the game!")
    
    -- Initialize player in leaderboard
    leaderboard[player.UserId] = {
        Name = player.Name,
        Points = 0,
        GemsCollected = 0
    }
    
    -- Set spawn location
    player.CharacterAdded:Connect(function(character)
        local spawnPad = Workspace:FindFirstChild("SpawnArea")
        if spawnPad then
            local spawnPart = spawnPad:FindFirstChild("Part") or spawnPad:GetChildren()[1]
            if spawnPart then
                character:MoveTo(spawnPart.Position + Vector3.new(0, 5, 0))
            end
        end
        
        -- Add player humanoid properties
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.MaxHealth = 100
        humanoid.Health = 100
    end)
end

-- Function to display top players
local function GetTopPlayers(count)
    local sortedLeaderboard = {}
    
    for userId, playerData in pairs(leaderboard) do
        table.insert(sortedLeaderboard, playerData)
    end
    
    -- Sort by points (descending)
    table.sort(sortedLeaderboard, function(a, b)
        return a.Points > b.Points
    end)
    
    print("\n🏆 TOP PLAYERS 🏆")
    for i = 1, math.min(count, #sortedLeaderboard) do
        local player = sortedLeaderboard[i]
        print(i .. ". " .. player.Name .. " - " .. player.Points .. " points (" .. player.GemsCollected .. " gems)")
    end
    print("")
end

-- Function to create safe zones
local function CreateSafeZones()
    local throneRoom = Workspace:FindFirstChild("ThroneRoom")
    if throneRoom then
        -- Mark throne room as safe zone
        local safeZone = Instance.new("Part")
        safeZone.Name = "SafeZone"
        safeZone.Transparency = 1
        safeZone.CanCollide = false
        safeZone.Size = Vector3.new(100, 50, 60)
        safeZone.Position = Vector3.new(0, 25, 0)
        safeZone.Parent = throneRoom
    end
end

-- Function to add victory points for throne room visit
local function SetupThroneRoomInteraction()
    local throneRoom = Workspace:FindFirstChild("ThroneRoom")
    if not throneRoom then return end
    
    local throne = throneRoom:FindFirstChild("Throne")
    if not throne then return end
    
    local seat = throne:FindFirstChild("Part") or throne:GetChildren()[1]
    if not seat then return end
    
    -- Award bonus points for visiting throne
    local visitedPlayers = {}
    
    seat.Touched:Connect(function(hit)
        local humanoid = hit.Parent:FindFirstChild("Humanoid")
        if not humanoid then return end
        
        local player = Players:GetPlayerFromCharacter(hit.Parent)
        if not player then return end
        
        if not visitedPlayers[player.UserId] then
            visitedPlayers[player.UserId] = true
            UpdateLeaderboard(player, 50) -- Bonus 50 points for throne visit
            print("👑 " .. player.Name .. " visited the throne! +50 bonus points!")
        end
    end)
end

-- Connect players
Players.PlayerAdded:Connect(OnPlayerAdded)

-- Handle player removal
Players.PlayerRemoving:Connect(function(player)
    print("👋 " .. player.Name .. " left the game!")
end)

-- Initialize all systems
wait(2) -- Wait for map to load
SetupCollectibles()
CreateLeaderboardGUI()
CreateSafeZones()
SetupThroneRoomInteraction()

-- Print leaderboard every 30 seconds
while true do
    wait(30)
    GetTopPlayers(5)
end
