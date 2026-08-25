--[[
    GRAND ARMY OF THE REPUBLIC - COMBAT SYSTEM
    Blaster mechanics, damage, and battle features
]]

local Players = game:GetService("Players")
local Workspace = game.Workspace
local Debris = game:GetService("Debris")

-- Combat configuration
local COMBAT_CONFIG = {
    BlasterDamage = 25,
    BlasterFireRate = 0.5, -- seconds between shots
    BlasterRange = 200,
    MuzzleVelocity = 100,
    HeadshotDamage = 50,
}

-- Function to create blaster tool
local function CreateBlasterTool()
    local blaster = Instance.new("Tool")
    blaster.Name = "DC-15 Blaster"
    blaster.CanBeDropped = false
    blaster.RequiresHandle = true
    
    -- Handle/Grip
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Shape = Enum.PartType.Block
    handle.Size = Vector3.new(0.8, 0.8, 3)
    handle.BrickColor = BrickColor.new("Dark stone grey")
    handle.Material = Enum.Material.Metal
    handle.TopSurface = Enum.SurfaceType.Smooth
    handle.BottomSurface = Enum.SurfaceType.Smooth
    handle.Parent = blaster
    
    -- Barrel
    local barrel = Instance.new("Part")
    barrel.Name = "Barrel"
    barrel.Shape = Enum.PartType.Cylinder
    barrel.Size = Vector3.new(0.3, 0.3, 2)
    barrel.BrickColor = BrickColor.new("Dark stone grey")
    barrel.Material = Enum.Material.Metal
    barrel.CanCollide = false
    barrel.Parent = blaster
    
    local barrelWeld = Instance.new("WeldConstraint")
    barrelWeld.Part0 = handle
    barrelWeld.Part1 = barrel
    barrelWeld.Parent = barrel
    barrel.Position = handle.Position + Vector3.new(0, 0, 1.5)
    
    -- Ammo counter
    local ammoValue = Instance.new("IntValue")
    ammoValue.Name = "Ammo"
    ammoValue.Value = 999
    ammoValue.Parent = blaster
    
    -- Equipped event
    blaster.Equipped:Connect(function(mouse)
        print("🔫 Blaster equipped by " .. Players:GetPlayerFromCharacter(blaster.Parent).Name)
        
        -- Fire on mouse click
        local lastFire = 0
        
        mouse.Button1Down:Connect(function()
            local now = tick()
            if now - lastFire < COMBAT_CONFIG.BlasterFireRate then return end
            lastFire = now
            
            local player = Players:GetPlayerFromCharacter(blaster.Parent)
            if not player then return end
            
            FireBlaster(blaster, mouse, player)
        end)
    end)
    
    return blaster
end

-- Function to fire blaster
function FireBlaster(blaster, mouse, player)
    local character = blaster.Parent
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    -- Create energy bolt
    local bolt = Instance.new("Part")
    bolt.Name = "EnergyBolt"
    bolt.Shape = Enum.PartType.Ball
    bolt.Size = Vector3.new(0.6, 0.6, 0.6)
    bolt.BrickColor = BrickColor.new("Bright yellow")
    bolt.Material = Enum.Material.Neon
    bolt.CanCollide = false
    bolt.CFrame = humanoidRootPart.CFrame + humanoidRootPart.CFrame.LookVector * 10
    
    -- Add velocity
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = humanoidRootPart.CFrame.LookVector * COMBAT_CONFIG.MuzzleVelocity
    bodyVelocity.Parent = bolt
    
    bolt.Parent = Workspace
    
    print("💥 Blaster fired by " .. player.Name)
    
    -- Detect hits
    local function OnTouched(hit)
        if hit:IsDescendantOf(character) then return end
        
        local targetHumanoid = hit.Parent:FindFirstChild("Humanoid")
        if not targetHumanoid then return end
        
        local targetPlayer = Players:GetPlayerFromCharacter(hit.Parent)
        
        -- Don't damage teammates
        if targetPlayer and targetPlayer.Team == player.Team then return end
        
        -- Calculate damage
        local damage = COMBAT_CONFIG.BlasterDamage
        
        -- Headshot bonus
        if hit.Name == "Head" then
            damage = COMBAT_CONFIG.HeadshotDamage
            print("🎯 HEADSHOT! " .. player.Name .. " hit " .. hit.Parent.Name)
        else
            print("💥 Hit! " .. player.Name .. " damaged " .. hit.Parent.Name)
        end
        
        targetHumanoid:TakeDamage(damage)
        
        -- Destroy bolt
        bolt:Destroy()
    end
    
    bolt.Touched:Connect(OnTouched)
    
    -- Auto-destroy after 10 seconds
    Debris:AddItem(bolt, 10)
end

-- Function to setup player with blaster
local function EquipPlayerWithBlaster(character, player)
    local blaster = CreateBlasterTool()
    blaster.Parent = character
    
    -- Equip on spawn
    local humanoid = character:WaitForChild("Humanoid")
    wait(0.1)
    
    if character:FindFirstChild(blaster.Name) then
        character.Humanoid:EquipTool(blaster)
    end
end

-- Function to create killstreak system
local killstreaks = {}

local function OnPlayerKill(killer, victim)
    if not killer or not victim then return end
    
    killstreaks[killer.UserId] = (killstreaks[killer.UserId] or 0) + 1
    killstreaks[victim.UserId] = 0
    
    local streak = killstreaks[killer.UserId]
    
    if streak == 5 then
        print("🔥 " .. killer.Name .. " has a KILLSTREAK x5!")
    elseif streak == 10 then
        print("💀 " .. killer.Name .. " UNSTOPPABLE x10!")
    elseif streak == 20 then
        print("👑 " .. killer.Name .. " LEGENDARY x20!")
    end
end

-- Connect to player humanoid deaths
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        
        -- Equip blaster
        EquipPlayerWithBlaster(character, player)
        
        -- Track deaths
        humanoid.Died:Connect(function()
            killstreaks[player.UserId] = 0
            print("💀 " .. player.Name .. " has been defeated")
        end)
    end)
end)

-- Function to display combat info
local function DisplayCombatInfo()
    print("\n⚔️  ========== COMBAT SYSTEM ACTIVE ==========")
    print("🔫 DC-15 Blaster equipped to all troops")
    print("💥 Damage per shot: " .. COMBAT_CONFIG.BlasterDamage)
    print("🎯 Headshot damage: " .. COMBAT_CONFIG.HeadshotDamage)
    print("🔄 Fire rate: " .. COMBAT_CONFIG.BlasterFireRate .. "s")
    print("📏 Range: " .. COMBAT_CONFIG.BlasterRange .. " studs")
    print("🏆 Killstreak tracking: ACTIVE")
    print("==========================================\n")
end

DisplayCombatInfo()
