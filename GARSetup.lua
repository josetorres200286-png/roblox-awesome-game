--[[
    GRAND ARMY OF THE REPUBLIC (GAR) GAME - MAIN SETUP
    Place this in ServerScriptService
    Clone Trooper spawn and faction system
]]

local Players = game:GetService("Players")
local Teams = game:GetService("Teams")

-- Game configuration
local GAR_CONFIG = {
    GameName = "Grand Army of the Republic",
    MaxPlayers = 100,
    StartingHealth = 100,
    CloneTrooperSpawn = Vector3.new(0, 50, -150),
    SeparatistSpawn = Vector3.new(200, 50, -150),
}

-- Teams setup
local function CreateTeams()
    -- GAR Team (Republic)
    local garTeam = Instance.new("Team")
    garTeam.Name = "GAR - Republic"
    garTeam.TeamColor = BrickColor.new("Cyan")
    garTeam.Parent = Teams
    
    -- Separatist Team
    local sepTeam = Instance.new("Team")
    sepTeam.Name = "Separatists"
    sepTeam.TeamColor = BrickColor.new("Really red")
    sepTeam.Parent = Teams
    
    print("✅ Teams created: GAR and Separatists")
end

-- Clone trooper character setup
local function SetupCloneTrooper(character, player)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.MaxHealth = GAR_CONFIG.StartingHealth
    humanoid.Health = GAR_CONFIG.StartingHealth
    
    -- Add blaster (tool)
    local blaster = Instance.new("Tool")
    blaster.Name = "DC-15 Blaster"
    blaster.CanBeDropped = false
    
    -- Blaster handle
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 1, 3)
    handle.BrickColor = BrickColor.new("Dark stone grey")
    handle.Parent = blaster
    
    blaster.Parent = character
    
    print("🔫 " .. player.Name .. " received DC-15 Blaster")
end

-- Player joined
Players.PlayerAdded:Connect(function(player)
    print("🪖 " .. player.Name .. " joined the GAR!")
    
    -- Assign to GAR team by default
    player.Team = Teams:FindFirstChild("GAR - Republic")
    
    player.CharacterAdded:Connect(function(character)
        print("✨ Clone Trooper " .. player.Name .. " deployed!")
        
        -- Move to spawn
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.CFrame = CFrame.new(GAR_CONFIG.CloneTrooperSpawn) + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
        
        -- Setup trooper
        SetupCloneTrooper(character, player)
        
        -- Handle death
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.Died:Connect(function()
            print("💀 Clone Trooper " .. player.Name .. " has fallen")
            wait(5)
            player:LoadCharacter()
        end)
    end)
end)

-- Player leaving
Players.PlayerRemoving:Connect(function(player)
    print("👋 Clone Trooper " .. player.Name .. " left the battlefield")
end)

-- Initialize game
local function InitializeGAR()
    print("🌟 ========== GRAND ARMY OF THE REPUBLIC ==========")
    print("📍 Republic Base Online")
    print("👁️  Jedi Council Connected")
    print("✅ Server Ready for Battle!")
    print("🪖 Awaiting Clone Trooper Deployments")
    print("================================================")
end

CreateTeams()
InitializeGAR()
