--[[
    ROBLOX AWESOME GAME - Main Game Setup Script
    Place this in ServerScriptService
]]

local Players = game:GetService("Players")
local spawnLocations = {}
local activePlayers = {}

-- Configuration
local GAME_CONFIG = {
    MaxPlayers = 50,
    RespawnTime = 3,
    StartingHealth = 100,
    GameName = "Awesome Adventure"
}

-- Initialize game
local function InitializeGame()
    print("🎮 " .. GAME_CONFIG.GameName .. " - Game Started!")
    print("✅ Server is running. Players can join!")
end

-- Player joined
Players.PlayerAdded:Connect(function(player)
    print("👋 " .. player.Name .. " joined the game!")
    
    -- Create player data
    activePlayers[player.UserId] = {
        Name = player.Name,
        Health = GAME_CONFIG.StartingHealth,
        JoinedAt = tick(),
        Score = 0
    }
    
    -- Player character spawned
    player.CharacterAdded:Connect(function(character)
        print("✨ " .. player.Name .. " spawned!")
        
        -- Add humanoid health
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.MaxHealth = GAME_CONFIG.StartingHealth
        humanoid.Health = GAME_CONFIG.StartingHealth
        
        -- Handle death
        humanoid.Died:Connect(function()
            print("💀 " .. player.Name .. " died!")
            wait(GAME_CONFIG.RespawnTime)
            player:LoadCharacter()
        end)
    end)
end)

-- Player left
Players.PlayerRemoving:Connect(function(player)
    print("👋 " .. player.Name .. " left the game!")
    activePlayers[player.UserId] = nil
end)

-- Initialize the game
InitializeGame()
