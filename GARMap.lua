--[[
    GRAND ARMY OF THE REPUBLIC - MAP GENERATION
    Republic Base, Jedi Temple, and Battle Arena
]]

local Workspace = game.Workspace

-- Function to create Republic Base
local function CreateRepublicBase()
    local base = Instance.new("Model")
    base.Name = "RepublicBase"
    
    -- Command Center
    local commandCenter = Instance.new("Part")
    commandCenter.Shape = Enum.PartType.Block
    commandCenter.Size = Vector3.new(60, 40, 50)
    commandCenter.Position = Vector3.new(-100, 0, -150)
    commandCenter.BrickColor = BrickColor.new("Cyan")
    commandCenter.Material = Enum.Material.Concrete
    commandCenter.TopSurface = Enum.SurfaceType.Smooth
    commandCenter.BottomSurface = Enum.SurfaceType.Smooth
    commandCenter.Parent = base
    
    -- Turret Tower
    local tower = Instance.new("Part")
    tower.Shape = Enum.PartType.Block
    tower.Size = Vector3.new(15, 50, 15)
    tower.Position = Vector3.new(-130, 25, -180)
    tower.BrickColor = BrickColor.new("Cyan")
    tower.Material = Enum.Material.Concrete
    tower.TopSurface = Enum.SurfaceType.Smooth
    tower.BottomSurface = Enum.SurfaceType.Smooth
    tower.Parent = base
    
    -- Barracks
    local barracks = Instance.new("Part")
    barracks.Shape = Enum.PartType.Block
    barracks.Size = Vector3.new(50, 25, 60)
    barracks.Position = Vector3.new(-70, 0, -80)
    barracks.BrickColor = BrickColor.new("Dark stone grey")
    barracks.Material = Enum.Material.Concrete
    barracks.TopSurface = Enum.SurfaceType.Smooth
    barracks.BottomSurface = Enum.SurfaceType.Smooth
    barracks.Parent = base
    
    -- Hangar
    local hangar = Instance.new("Part")
    hangar.Shape = Enum.PartType.Block
    hangar.Size = Vector3.new(80, 30, 40)
    hangar.Position = Vector3.new(0, 0, -200)
    hangar.BrickColor = BrickColor.new("Medium stone grey")
    hangar.Material = Enum.Material.Concrete
    hangar.TopSurface = Enum.SurfaceType.Smooth
    hangar.BottomSurface = Enum.SurfaceType.Smooth
    hangar.Parent = base
    
    base.Parent = Workspace
    print("✅ Republic Base constructed")
end

-- Function to create Jedi Temple
local function CreateJediTemple()
    local temple = Instance.new("Model")
    temple.Name = "JediTemple"
    
    -- Main Temple Structure
    local mainStructure = Instance.new("Part")
    mainStructure.Shape = Enum.PartType.Block
    mainStructure.Size = Vector3.new(70, 60, 70)
    mainStructure.Position = Vector3.new(100, 0, -150)
    mainStructure.BrickColor = BrickColor.new("Bright red")
    mainStructure.Material = Enum.Material.Marble
    mainStructure.TopSurface = Enum.SurfaceType.Smooth
    mainStructure.BottomSurface = Enum.SurfaceType.Smooth
    mainStructure.Parent = temple
    
    -- Spire 1
    local spire1 = Instance.new("Part")
    spire1.Shape = Enum.PartType.Block
    spire1.Size = Vector3.new(10, 80, 10)
    spire1.Position = Vector3.new(60, 40, -120)
    spire1.BrickColor = BrickColor.new("Bright red")
    spire1.Material = Enum.Material.Marble
    spire1.TopSurface = Enum.SurfaceType.Smooth
    spire1.BottomSurface = Enum.SurfaceType.Smooth
    spire1.Parent = temple
    
    -- Spire 2
    local spire2 = Instance.new("Part")
    spire2.Shape = Enum.PartType.Block
    spire2.Size = Vector3.new(10, 80, 10)
    spire2.Position = Vector3.new(140, 40, -120)
    spire2.BrickColor = BrickColor.new("Bright red")
    spire2.Material = Enum.Material.Marble
    spire2.TopSurface = Enum.SurfaceType.Smooth
    spire2.BottomSurface = Enum.SurfaceType.Smooth
    spire2.Parent = temple
    
    -- Meditation Chamber
    local chamber = Instance.new("Part")
    chamber.Shape = Enum.PartType.Block
    chamber.Size = Vector3.new(40, 35, 40)
    chamber.Position = Vector3.new(100, 30, -100)
    chamber.BrickColor = BrickColor.new("Bright red")
    chamber.Material = Enum.Material.Neon
    chamber.Transparency = 0.3
    chamber.TopSurface = Enum.SurfaceType.Smooth
    chamber.BottomSurface = Enum.SurfaceType.Smooth
    chamber.Parent = temple
    
    -- Medical Bay
    local medBay = Instance.new("Part")
    medBay.Shape = Enum.PartType.Block
    medBay.Size = Vector3.new(50, 25, 60)
    medBay.Position = Vector3.new(100, 0, -220)
    medBay.BrickColor = BrickColor.new("Bright green")
    medBay.Material = Enum.Material.Concrete
    medBay.TopSurface = Enum.SurfaceType.Smooth
    medBay.BottomSurface = Enum.SurfaceType.Smooth
    medBay.Parent = temple
    
    temple.Parent = Workspace
    print("✅ Jedi Temple erected")
end

-- Function to create Separatist Base
local function CreateSeparatistBase()
    local sepBase = Instance.new("Model")
    sepBase.Name = "SeparatistBase"
    
    -- Main Structure
    local mainStructure = Instance.new("Part")
    mainStructure.Shape = Enum.PartType.Block
    mainStructure.Size = Vector3.new(60, 40, 50)
    mainStructure.Position = Vector3.new(300, 0, -150)
    mainStructure.BrickColor = BrickColor.new("Really red")
    mainStructure.Material = Enum.Material.Concrete
    mainStructure.TopSurface = Enum.SurfaceType.Smooth
    mainStructure.BottomSurface = Enum.SurfaceType.Smooth
    mainStructure.Parent = sepBase
    
    -- Defense Tower
    local defTower = Instance.new("Part")
    defTower.Shape = Enum.PartType.Block
    defTower.Size = Vector3.new(15, 50, 15)
    defTower.Position = Vector3.new(330, 25, -180)
    defTower.BrickColor = BrickColor.new("Really red")
    defTower.Material = Enum.Material.Concrete
    defTower.TopSurface = Enum.SurfaceType.Smooth
    defTower.BottomSurface = Enum.SurfaceType.Smooth
    defTower.Parent = sepBase
    
    sepBase.Parent = Workspace
    print("✅ Separatist Base constructed")
end

-- Function to create Battle Arena
local function CreateBattleArena()
    local arena = Instance.new("Model")
    arena.Name = "BattleArena"
    
    -- Arena Floor
    local floor = Instance.new("Part")
    floor.Shape = Enum.PartType.Block
    floor.Size = Vector3.new(200, 2, 200)
    floor.Position = Vector3.new(100, 30, 100)
    floor.BrickColor = BrickColor.new("Dark stone grey")
    floor.Material = Enum.Material.Asphalt
    floor.TopSurface = Enum.SurfaceType.Smooth
    floor.BottomSurface = Enum.SurfaceType.Smooth
    floor.Parent = arena
    
    -- Cover Objects (for combat)
    local covers = {
        Vector3.new(50, 15, 80),
        Vector3.new(150, 15, 80),
        Vector3.new(50, 15, 120),
        Vector3.new(150, 15, 120),
    }
    
    for i, pos in ipairs(covers) do
        local cover = Instance.new("Part")
        cover.Shape = Enum.PartType.Block
        cover.Size = Vector3.new(20, 20, 20)
        cover.Position = pos
        cover.BrickColor = BrickColor.new("Dark stone grey")
        cover.Material = Enum.Material.Concrete
        cover.TopSurface = Enum.SurfaceType.Smooth
        cover.BottomSurface = Enum.SurfaceType.Smooth
        cover.Parent = arena
    end
    
    arena.Parent = Workspace
    print("✅ Battle Arena created")
end

-- Function to create Spawn Pads
local function CreateSpawnPads()
    -- GAR Spawn
    local garSpawn = Instance.new("Part")
    garSpawn.Name = "GARSpawn"
    garSpawn.Shape = Enum.PartType.Block
    garSpawn.Size = Vector3.new(50, 3, 50)
    garSpawn.Position = Vector3.new(-100, 50, -150)
    garSpawn.BrickColor = BrickColor.new("Cyan")
    garSpawn.Material = Enum.Material.Neon
    garSpawn.TopSurface = Enum.SurfaceType.Smooth
    garSpawn.BottomSurface = Enum.SurfaceType.Smooth
    garSpawn.CanCollide = true
    garSpawn.Parent = Workspace
    
    -- Separatist Spawn
    local sepSpawn = Instance.new("Part")
    sepSpawn.Name = "SeparatistSpawn"
    sepSpawn.Shape = Enum.PartType.Block
    sepSpawn.Size = Vector3.new(50, 3, 50)
    sepSpawn.Position = Vector3.new(300, 50, -150)
    sepSpawn.BrickColor = BrickColor.new("Really red")
    sepSpawn.Material = Enum.Material.Neon
    sepSpawn.TopSurface = Enum.SurfaceType.Smooth
    sepSpawn.BottomSurface = Enum.SurfaceType.Smooth
    sepSpawn.CanCollide = true
    sepSpawn.Parent = Workspace
    
    print("✅ Spawn pads deployed")
end

-- Main terrain setup
local function CreateGARTerrain()
    -- Ground
    local ground = Instance.new("Part")
    ground.Name = "Ground"
    ground.Shape = Enum.PartType.Block
    ground.Size = Vector3.new(1000, 2, 1000)
    ground.Position = Vector3.new(0, -1, 0)
    ground.BrickColor = BrickColor.new("Dark green")
    ground.Material = Enum.Material.Grass
    ground.TopSurface = Enum.SurfaceType.Smooth
    ground.BottomSurface = Enum.SurfaceType.Smooth
    ground.CanCollide = true
    ground.Parent = Workspace
    
    print("✅ Terrain created")
end

-- Initialize all map elements
local function InitializeMap()
    print("\n🌟 ========== CONSTRUCTING GAR BATTLEFIELD ==========")
    wait(1)
    
    CreateGARTerrain()
    wait(0.5)
    
    CreateRepublicBase()
    wait(0.5)
    
    CreateJediTemple()
    wait(0.5)
    
    CreateSeparatistBase()
    wait(0.5)
    
    CreateBattleArena()
    wait(0.5)
    
    CreateSpawnPads()
    
    print("✅ BATTLEFIELD READY FOR COMBAT!")
    print("🪖 GAR Forces: Ready")
    print("🔴 Separatists: Standing By")
    print("⚔️  May the Force be with you")
    print("====================================================\n")
end

InitializeMap()
