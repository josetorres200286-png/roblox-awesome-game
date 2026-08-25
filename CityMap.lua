--[[
    CITY MAP AND THRONE ROOM GENERATION
    Place this in ServerScriptService
    Auto-generates the complete city with buildings and throne room
]]

local Workspace = game.Workspace
local Players = game:GetService("Players")

-- Map configuration
local MAP_CONFIG = {
    CitySize = 500,
    BuildingHeight = 30,
    StreetWidth = 20,
}

-- Function to create a building
local function CreateBuilding(position, size, name)
    local building = Instance.new("Model")
    building.Name = name
    
    -- Main structure
    local mainPart = Instance.new("Part")
    mainPart.Shape = Enum.PartType.Block
    mainPart.Size = size
    mainPart.Position = position
    mainPart.BrickColor = BrickColor.new("Dark stone grey")
    mainPart.TopSurface = Enum.SurfaceType.Smooth
    mainPart.BottomSurface = Enum.SurfaceType.Smooth
    mainPart.Parent = building
    
    -- Door
    local door = Instance.new("Part")
    door.Shape = Enum.PartType.Block
    door.Size = Vector3.new(5, 10, 1)
    door.Position = position + Vector3.new(0, 5, size.Z/2 + 0.5)
    door.BrickColor = BrickColor.new("Dark wood grey")
    door.Parent = building
    
    -- Roof
    local roof = Instance.new("Part")
    roof.Shape = Enum.PartType.Block
    roof.Size = Vector3.new(size.X, 2, size.Z)
    roof.Position = position + Vector3.new(0, size.Y/2 + 1, 0)
    roof.BrickColor = BrickColor.new("Bright red")
    roof.Parent = building
    
    building.Parent = Workspace
    return building
end

-- Function to create the throne room
local function CreateThroneRoom()
    local throneRoom = Instance.new("Model")
    throneRoom.Name = "ThroneRoom"
    
    -- Floor
    local floor = Instance.new("Part")
    floor.Shape = Enum.PartType.Block
    floor.Size = Vector3.new(80, 2, 60)
    floor.Position = Vector3.new(0, 0, 0)
    floor.BrickColor = BrickColor.new("Dark stone grey")
    floor.TopSurface = Enum.SurfaceType.Smooth
    floor.BottomSurface = Enum.SurfaceType.Smooth
    floor.Material = Enum.Material.Marble
    floor.Parent = throneRoom
    
    -- Pillars (4 corners)
    local pillarPositions = {
        Vector3.new(-30, 0, -20),
        Vector3.new(30, 0, -20),
        Vector3.new(-30, 0, 20),
        Vector3.new(30, 0, 20)
    }
    
    for _, pos in ipairs(pillarPositions) do
        local pillar = Instance.new("Part")
        pillar.Shape = Enum.PartType.Cylinder
        pillar.Size = Vector3.new(8, 40, 8)
        pillar.Position = pos + Vector3.new(0, 20, 0)
        pillar.BrickColor = BrickColor.new("Medium stone grey")
        pillar.Material = Enum.Material.Marble
        pillar.BottomSurface = Enum.SurfaceType.Smooth
        pillar.TopSurface = Enum.SurfaceType.Smooth
        pillar.Parent = throneRoom
    end
    
    -- Throne Chair
    local throne = Instance.new("Model")
    throne.Name = "Throne"
    
    -- Throne seat
    local seat = Instance.new("Part")
    seat.Shape = Enum.PartType.Block
    seat.Size = Vector3.new(15, 3, 15)
    seat.Position = Vector3.new(0, 15, 0)
    seat.BrickColor = BrickColor.new("Dark stone grey")
    seat.Material = Enum.Material.Marble
    seat.Parent = throne
    
    -- Throne back
    local back = Instance.new("Part")
    back.Shape = Enum.PartType.Block
    back.Size = Vector3.new(15, 25, 3)
    back.Position = Vector3.new(0, 25, -8)
    back.BrickColor = BrickColor.new("Really red")
    back.Material = Enum.Material.Marble
    back.Parent = throne
    
    -- Crown decoration on top
    local crown = Instance.new("Part")
    crown.Shape = Enum.PartType.Block
    crown.Size = Vector3.new(12, 4, 12)
    crown.Position = Vector3.new(0, 43, -8)
    crown.BrickColor = BrickColor.new("Bright yellow")
    crown.Material = Enum.Material.Marble
    crown.Parent = throne
    
    throne.Parent = throneRoom
    
    -- Treasure Vault
    local vault = Instance.new("Model")
    vault.Name = "TreasureVault"
    
    local vaultBox = Instance.new("Part")
    vaultBox.Shape = Enum.PartType.Block
    vaultBox.Size = Vector3.new(20, 15, 20)
    vaultBox.Position = Vector3.new(0, 7.5, 25)
    vaultBox.BrickColor = BrickColor.new("Dark stone grey")
    vaultBox.Material = Enum.Material.Concrete
    vaultBox.Parent = vault
    
    local vaultGold = Instance.new("Part")
    vaultGold.Shape = Enum.PartType.Block
    vaultGold.Size = Vector3.new(18, 2, 18)
    vaultGold.Position = Vector3.new(0, 15, 25)
    vaultGold.BrickColor = BrickColor.new("Bright yellow")
    vaultGold.Material = Enum.Material.Neon
    vaultGold.Parent = vault
    
    vault.Parent = throneRoom
    
    -- Walls
    local wallBack = Instance.new("Part")
    wallBack.Shape = Enum.PartType.Block
    wallBack.Size = Vector3.new(100, 50, 2)
    wallBack.Position = Vector3.new(0, 25, -30)
    wallBack.BrickColor = BrickColor.new("Dark stone grey")
    wallBack.TopSurface = Enum.SurfaceType.Smooth
    wallBack.BottomSurface = Enum.SurfaceType.Smooth
    wallBack.Parent = throneRoom
    
    throneRoom.Parent = Workspace
    return throneRoom
end

-- Function to create city streets
local function CreateCityStreets()
    local streets = Instance.new("Model")
    streets.Name = "CityStreets"
    
    -- Main street (North-South)
    local streetNS = Instance.new("Part")
    streetNS.Shape = Enum.PartType.Block
    streetNS.Size = Vector3.new(MAP_CONFIG.StreetWidth, 1, 300)
    streetNS.Position = Vector3.new(0, -1, 0)
    streetNS.BrickColor = BrickColor.new("Dark stone grey")
    streetNS.TopSurface = Enum.SurfaceType.Smooth
    streetNS.Material = Enum.Material.Asphalt
    streetNS.Parent = streets
    
    -- Main street (East-West)
    local streetEW = Instance.new("Part")
    streetEW.Shape = Enum.PartType.Block
    streetEW.Size = Vector3.new(300, 1, MAP_CONFIG.StreetWidth)
    streetEW.Position = Vector3.new(0, -1, 0)
    streetEW.BrickColor = BrickColor.new("Dark stone grey")
    streetEW.TopSurface = Enum.SurfaceType.Smooth
    streetEW.Material = Enum.Material.Asphalt
    streetEW.Parent = streets
    
    streets.Parent = Workspace
    return streets
end

-- Function to create spawn pads
local function CreateSpawnPads()
    local spawnArea = Instance.new("Model")
    spawnArea.Name = "SpawnArea"
    
    local spawnPad = Instance.new("Part")
    spawnPad.Shape = Enum.PartType.Block
    spawnPad.Size = Vector3.new(50, 3, 50)
    spawnPad.Position = Vector3.new(0, 50, -150)
    spawnPad.BrickColor = BrickColor.new("Bright green")
    spawnPad.TopSurface = Enum.SurfaceType.Smooth
    spawnPad.BottomSurface = Enum.SurfaceType.Smooth
    spawnPad.Material = Enum.Material.Neon
    spawnPad.CanCollide = true
    spawnPad.Parent = spawnArea
    
    spawnArea.Parent = Workspace
    return spawnArea
end

-- Function to generate gems (collectibles)
local function CreateCollectibles()
    local collectibles = Instance.new("Model")
    collectibles.Name = "Collectibles"
    
    local gemPositions = {
        Vector3.new(50, 5, 50),
        Vector3.new(-50, 5, 50),
        Vector3.new(50, 5, -50),
        Vector3.new(-50, 5, -50),
        Vector3.new(0, 30, 0),
        Vector3.new(100, 5, 100),
        Vector3.new(-100, 5, -100),
    }
    
    for i, pos in ipairs(gemPositions) do
        local gem = Instance.new("Part")
        gem.Shape = Enum.PartType.Ball
        gem.Size = Vector3.new(3, 3, 3)
        gem.Position = pos
        gem.BrickColor = BrickColor.new("Bright yellow")
        gem.Material = Enum.Material.Neon
        gem.CanCollide = false
        gem.TopSurface = Enum.SurfaceType.Smooth
        gem.BottomSurface = Enum.SurfaceType.Smooth
        gem.Parent = collectibles
        
        -- Rotation animation
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = gem
    end
    
    collectibles.Parent = Workspace
    return collectibles
end

-- Main initialization
local function InitializeMap()
    print("🏗️ Building city and throne room...")
    
    -- Create ground
    local ground = Instance.new("Part")
    ground.Shape = Enum.PartType.Block
    ground.Size = Vector3.new(1000, 2, 1000)
    ground.Position = Vector3.new(0, -1, 0)
    ground.BrickColor = BrickColor.new("Dark green")
    ground.TopSurface = Enum.SurfaceType.Smooth
    ground.BottomSurface = Enum.SurfaceType.Smooth
    ground.Material = Enum.Material.Grass
    ground.CanCollide = true
    ground.Parent = Workspace
    
    -- Create city streets
    CreateCityStreets()
    
    -- Create buildings
    CreateBuilding(Vector3.new(-80, 0, -80), Vector3.new(40, MAP_CONFIG.BuildingHeight, 40), "Building1")
    CreateBuilding(Vector3.new(80, 0, -80), Vector3.new(40, MAP_CONFIG.BuildingHeight, 40), "Building2")
    CreateBuilding(Vector3.new(-80, 0, 80), Vector3.new(40, MAP_CONFIG.BuildingHeight, 40), "Building3")
    CreateBuilding(Vector3.new(80, 0, 80), Vector3.new(40, MAP_CONFIG.BuildingHeight, 40), "Building4")
    
    -- Create throne room
    CreateThroneRoom()
    
    -- Create spawn pads
    CreateSpawnPads()
    
    -- Create collectibles
    CreateCollectibles()
    
    print("✅ City and throne room created successfully!")
    print("👑 Welcome to the Awesome Game!")
end

-- Initialize on game start
InitializeMap()
