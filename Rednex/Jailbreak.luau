local repo = 'https://raw.githubusercontent.com/deividcomsono/Obsidian/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local MainESP, CullingSystem = loadstring(game:HttpGet('https://raw.githubusercontent.com/ImNotWhyLclc/Rendex/refs/heads/main/esp.luau'))()
local NumberlinkSolver = loadstring(game:HttpGet("https://raw.githubusercontent.com/Introvert1337/RobloxReleases/main/Scripts/Jailbreak/NumberlinkSolver.lua"))()
local Options = Library.Options
local Toggles = Library.Toggles

local time = tick()
Library:Notify("Loading")

MainESP.Options = {
  Enabled = false,
  Box = false,
  Health = false,
  Tracer = false,
  TracerOrigin = "Bottom",
  Name = false,
  Distance = false,
  Direction = false,
  Skeleton = false,
  TextOutline = false,
  Color = Color3.new(1, 1, 1),
  UseTeamColor = true,
  Rainbow = false,
  Font = 3,
  FontSize = 15,
  TeamCheck = false,
  BoxThickness = 0,
  TracerThickness = 0,
  DirectionThickness = 0,
  SkeletonThickness = 0,
  Bounties = false,
}
MainESP.CrateOptions = {
  Enabled = false,
  Tracer = false,
  TextOutline = false,
  Distance = false,
  Name = false,
  Font = 3,
  FontSize = 20,
  Rainbow = false,
  Color = Color3.fromRGB(148, 96, 69),
  TracerOrigin = "Bottom",
  TracerThickness = 0,
  BoxThickness = 1,
}

CullingSystem.maxRenderDistance = 20000
CullingSystem.nearDistance = 10000
CullingSystem.farDistance = 15000

local setclipboard = setclipboard or toclipboard or set_clipboard or nil
local setthreadcontext = setthreadidentity or set_thread_identity or setthreadcontext or set_thread_context or
    function() Library:Notify("missing setthreadidentity/sethreadcontext") end
local firesignal = firesignal or function() Library:Notify("missing firesignal") end

local workspace = game:GetService("Workspace")
local camera = workspace.CurrentCamera
local replicatedstorage = game:GetService("ReplicatedStorage")
local marketplaceservice = game:GetService("MarketplaceService")
local players = game:GetService("Players")
local localplayer = game:GetService("Players").LocalPlayer
local collectionservice = game:GetService("CollectionService")
local runservice = game:GetService("RunService")
local userinputservice = game:GetService("UserInputService")

configs = {
  player = {
    fspeed = 10,
    ftog = false,
    walktog = false,
    walkval = 0,
    infjump = false,
    pickpocketaura = {
      enabled = false,
    },
    arrestaura = {
      enabled = false,
      showtargeted = false,
    },
    breakoutaura = {
      enabled = false,
    },
    nofall = false,
    norag = false,
    noislow = false,
    nosky = false,
    nostun = false,
    norwait = false,
    nocslow = false,
    nocircwait = false,
    circleclip = false,
    nopwait = false,
    noclip = false,
    doornoreq = false,
    alwayssilentp = false,
    alwaysp = false,
    alwayssp = false,
    juiced = false,
    enableroll = false,
    crawlequip = false,
    antilocked = false,
  },
  vehicle = {
    fspeed = 10,
    ftog = false,
    engine = false,
    enginesp = 0,
    brake = false,
    brakesp = 0,
    suspension = false,
    suspensionhe = 0,
    turnsp = 0,
    turn = false,
    inftrac = false,
    reducebounce = false,
    tirepop = false,
    nopop = false,
    infnitro = false,
    nojumpcd = false,
    autoloadslot = false,
    autoloadlast = false,
    showfavorited = false,
    rinfnitro = false,
    autoflip = false,
    helibreak = false,
    helienginesp = 0,
    heliverticalsp = 0,
    heliturnsp = 0,
    heliengine = false,
    helipick = false,
    -- helivertical = false;
    -- heliturn = false;
    heliheight = false,
    instanttow = false,
    driveonwater = false,
    tanksus = false,
    tanksushe = 5.3,
    tankengine = false,
    tankenginesp = 0,
    --voltengine = false;
    voltenginesp = 0,
    voltnopop = false,
  },
  robbery = {
    guardnodmg = false,
    bank = {
      disablelasers = false,
      autodynamite = false,
    },
    jewelry = {
      disablelasers = false,
    },
    casino = {
      autodoor = false,
      autonotifycode = false,
      disablelasers = false,
      fixcomputer = false,
      autocollect = false,
      elevatorfloor = Ground,
    },
    museum = {
      disablelasers = false,
    },
    tomb = {
      disableplanks = false,
      disablespikes = false,
      disablesdarts = false,
      bridgebreak = false,
      disablelava = false,
    },
    oilrig = {
      disablelasers = false,
      nooilblow = false,
      disableturret = false,
    },
    cargoship = {
      disableturret = false,
    },
    mansion = {
      disablelasers = false,
      disabletraps = false,
      autoelevator = false,
    },
    powerplant = {
      disablelasers = false,
      disablepistons = false,
      autosolve = false,
    },
  },
  combat = {
    noequipt = false,
    nospread = false,
    norecoil = false,
    nobulletg = false,
    alwaysauto = false,
    alwaysheadshot = false,
    pistolswat = false,
    snipernoblur = false,
    snipernogui = false,
    nogrenadesmoke = false,
    nogrenadesmokelimit = false,
    tasermodz = false,
    instantreload = false,
    instantrocketseek = false,
    forcefieldnomiss = false,
    increasetakedowndamage = false,
    forcefieldreload = false,
    shootthroughforce = false,
    instantc4throw = false,
    antic4limit = false,
    instantbullethit = false,
    getweapon = false,
    plasmawallbang = false,
    silentaim = {
      enabled = false,
      targetnpcs = false,
      radius = 50,
      range = 300,
      wallcheck = false,
      fovcirc = false,
      fovthick = 5,
      fovtransp = 0,
    },
    batonsword = {
      noreloadtime = false,
      spamlunge = false,
      spamswoosh = false,
    },
  },
  nametags = {},
  others = {
    disablehometurret = false,
    disablemilitaryturret = false,
    opendoor = false,
    prisonelevator = false,
    breakelevator = false,
    opensewer = false,
  },
  settings = {
    serverhop = false,
  },
} 
local client = {
  bettertablefind = function(tbl, n)
    for i, v in next, tbl do
        if tostring(v) == tostring(n) then return i end
    end
    return nil
  end,
  gc = {},
  autofavorite = nil,
  minimapmarker = {},
  playermarker = nil,
  extraMarkerGroup = nil,
  extraMarkers = {},
  iconsDetected = false,
  copicon = 7028057307,
  crimicon = 7028057307,
  antilocked = nil,
  instantreload = nil,
  instantreloadprocess = false,
  alwaysjuiced = nil,
  lastcode = "",
  autonotify = false,
  solvedelay = 0.1,
  disabletombdarts = false,
  tankdata = {},
  lastvehiclestats = {
    GarageEngineSpeed = nil,
    GarageBrakes = nil,
    Height = nil,
    TurnSpeed = nil,
  },
  lastmotorcyclestats = {
    f = nil,
    Height = nil,
  },
  lastvehiclemodel = nil,
  vehicleEntered = false,
  originalequippeddata = {},
  activeaction = {},
  stdraycast = require(replicatedstorage.Std.Raycast),
  vaultbinder = require(replicatedstorage.Casino.VaultDoorPuzzleBinder),
  bankinit = getupvalue(require(replicatedstorage.Game.Robbery.RobberyBank.RobberyBank).Init, 1),
  puzzleflow = require(replicatedstorage.Game.Robbery.PuzzleFlow),
  simulatedphysicsprojectile = require(replicatedstorage.Module.SimulatedPhysicsProjectile),
  npcconsts = require(replicatedstorage.NPC.NPCConsts),
  guardnpcconsts = require(replicatedstorage.GuardNPC.GuardNPCConsts),
  guardnpcbinder = require(replicatedstorage.GuardNPC.GuardNPCBinder)._constructor,
  bossnpcconsts = require(replicatedstorage.MansionRobbery.BossNPCConsts),
  bossnpcutils = require(replicatedstorage.MansionRobbery.BossNPCUtils),  
  combatconst = require(replicatedstorage.Combat.CombatConsts),
  militaryturretconst = require(replicatedstorage.Game.MilitaryTurret.MilitaryTurretConsts),
  combatutils = require(replicatedstorage.Combat.CombatUtils),
  playerutil = require(replicatedstorage.Game.PlayerUtils),
  actionbuttonservice = require(replicatedstorage.ActionButton.ActionButtonService),
  settingss = require(replicatedstorage.Resource.Settings),
  characterutil = require(replicatedstorage.Game.CharacterUtil),
  stdcharacterutils = require(replicatedstorage.Std.CharacterUtils),
  paraglide = require(replicatedstorage.Game.Paraglide),
  alexchassis = require(replicatedstorage.Module.AlexChassis),
  alexchassis2 = require(replicatedstorage.Module.AlexChassis2),
  gamepasssystem = require(replicatedstorage.Gamepass.GamepassSystem),
  pistolitem = require(replicatedstorage.Game.Item.Pistol),
  tase = require(replicatedstorage.Game.Item.Taser),
  plasmagun = require(replicatedstorage.Game.Item.PlasmaGun),
  itemgun = require(replicatedstorage.Game.Item.Gun),
  itemsys = require(replicatedstorage.Game.ItemSystem.ItemSystem),
  gunutil = require(replicatedstorage.Game.GunShop.GunUtils),
  hotbarsystem = require(replicatedstorage.Hotbar.HotbarItemSystem),
  hotbarutils = require(replicatedstorage.Hotbar.HotbarItemUtils),
  smokegrenadeitem = require(replicatedstorage.Game.SmokeGrenade.SmokeGrenade),
  movementrollservice = require(replicatedstorage.MovementRoll.MovementRollService),
  ratelimiter = require(replicatedstorage.Std.RateLimiter),
  circleac = require(replicatedstorage.Module.UI).CircleAction,
  geomUtils = require(replicatedstorage.Std.GeomUtils),
  vehiclelinkbinder = require(replicatedstorage.VehicleLink.VehicleLinkBinder),
  controlmodule = require(players.LocalPlayer.PlayerScripts.PlayerModule.ControlModule),
  duck = require(replicatedstorage.Game.Robbery.TombRobbery.TombRobberySystem).duck,
  vehicleutils = require(replicatedstorage.Vehicle.VehicleUtils),
  onvehicleentered = require(replicatedstorage.Vehicle.VehicleUtils).OnVehicleEntered,
  onvehicleexited = require(replicatedstorage.Vehicle.VehicleUtils).OnVehicleExited,
  onlocalitemequipped = require(replicatedstorage.Game.ItemSystem.ItemSystem).OnLocalItemEquipped,
  onlocalitemunequipped = require(replicatedstorage.Game.ItemSystem.ItemSystem).OnLocalItemUnequipped,
  raycast = require(replicatedstorage.Module.RayCast),
  bulletemitter = require(replicatedstorage.Game.ItemSystem.BulletEmitter),
  c4 = require(replicatedstorage.Game.Item.C4),
  wheel = require(replicatedstorage.Module.Wheel.Wheel),
  localization = require(replicatedstorage.Module.Localization),
  rocketconsts = require(replicatedstorage.RocketLauncher.RocketLauncherConsts),
  dartdispenser = require(replicatedstorage.Game.DartDispenser.DartDispenser),
  rocketworld = require(replicatedstorage.Game.RocketWorld),
  turret = require(replicatedstorage.Turret2.Turret),
  oilrigbinder = require(replicatedstorage.OilRig.OilRigBinder)._constructor,
  gunshopui = require(replicatedstorage.Game.GunShop.GunShopUI),
  spotlightbinder = require(replicatedstorage.TrackingSpotlight.TrackingSpotlightBinder),
  inventoryitemsystem = require(replicatedstorage.Inventory.InventoryItemSystem),
  inventoryitemutils = require(replicatedstorage.Inventory.InventoryItemUtils),
  inventoryitemconsts = require(replicatedstorage.Inventory.InventoryItemConsts),
  interval = require(replicatedstorage.Std.Interval),
  tankbinder = require(replicatedstorage.Tank.TankBinder)._constructor,
  forcefieldservice = require(replicatedstorage.Forcefield.ForcefieldService),
  store = require(replicatedstorage.App.store),
  worldmarker = require(replicatedstorage.Game.WorldMarker.WorldMarker),
  minimapservice = require(replicatedstorage.App.MinimapService),
  worldmarkergroup = require(replicatedstorage.Game.WorldMarker.WorldMarkerGroup),
  worldmarkersystem = require(replicatedstorage.Game.WorldMarker.WorldMarkerSystem),
  playermarkersystem = require(replicatedstorage.Game.PlayerMarkerSystem)
}

client.ori = {
  collidable = clonefunction(client.stdraycast.collidable),
  hookNearest = client.vehiclelinkbinder._constructor._hookNearest,
  bulletemitteronlocalhitplayer = client.itemgun.BulletEmitterOnLocalHitPlayer,
  hittargetwithspeed = client.simulatedphysicsprojectile.HitTargetWithSpeed,
  isflying = client.paraglide.IsFlying,
  tase = client.tase.Tase,
  doesplayerowncached = client.gamepasssystem.doesPlayerOwnCached,
  update = client.circleac.UpdateLogic,
  getequiptime = client.gunutil.getEquipTime,
  rayignorenon = client.raycast.RayIgnoreNonCollide,
  plasmashootother = client.plasmagun.ShootOther,
  pistolsetupmodel = client.pistolitem.SetupModel,
  rayignore = client.raycast.RayIgnoreNonCollideWithIgnoreList,
  shoot = client.itemgun.Shoot,
  circleactionpress = client.circleac.Press,
  oillaunchblow = client.oilrigbinder._launchBlowUp,
  getLocked = client.inventoryitemutils.getLocked,
  setLocked = client.inventoryitemutils.setLocked,
};

client._noclipConn = nil
client._noclipCache = {}

for i, v in next, client.ori do
  client.ori[i] = clonefunction(v)
end

for _, v in next, getgc() do
    if type(v) == "table" and rawget(v, "Nitro") and rawget(v, "NitroLastMax") and not client.nitroTable then
        client.nitroTable = v
    end

    if type(v) == "function" and islclosure(v) then
        local ok, constants = pcall(getconstants, v)
        if not ok then continue end

        local ok2, info = pcall(getinfo, v)
        local infoname = ""
        local scriptName = ""
        if ok2 and info ~= nil then
            infoname = tostring(info.name or "")
            local ok3, env = pcall(getfenv, v)
            if ok3 and env and env.script then
                scriptName = tostring(env.script)
            end
        end

        if scriptName == "LocalScript" then
            if client.bettertablefind(constants, "StartRagdolling") then client.stunnedragdoll = v end
            if client.bettertablefind(constants, "PlusCash") then client.cashthingy = v end
            if infoname == "AttemptArrest" then client.attemptarrest = v end
            if infoname == "AttemptVehicleEject" then client.attemptvehicleeject = v end
            if infoname == "AttemptPickPocket" then client.attemptpickpocket = v end
            if infoname == "AttemptBreakout" then client.attemptbreakout = v end
            if infoname == "UpdatePlayer" then client.updateplayer = v end
            if infoname == "Update" and client.bettertablefind(constants, "IsLocalInSpotlight") then
                client.walkspeedfun = v
            end
            if infoname == "StartNitro" then
                client.startnitro = v
                client.nitro = getupvalue(v, 8)
            end
            if infoname == "StopNitro" then client.stopnitro = v end
            if infoname == "CheatCheck" then
                pcall(setupvalue, v, 1, true)
            elseif client.bettertablefind(constants, "FailedPcall") then
                pcall(setupvalue, v, 2, true)
            end
        end

        if not client.gc.vehicleactionstart and client.bettertablefind(constants, "_lastUsed") then
            local ok4, upvals = pcall(getupvalues, v)
            if ok4 and #upvals > 10 then
                client.gc.vehicleactionstart = v
            end
        end
    end
end

for i, v in next, getconnections(runservice.Heartbeat) do
  if v.Function and islclosure(v.Function) then
    if getconstants(v.Function)[13] == "Time/UI" then
      client.walkspeedfun = getupvalue(v.Function, 6)
    end
    if getconstants(v.Function)[4] == "LQVehicle Heartbeat" then
      setconstant(v.Function, 27, "plzdie")
      setconstant(v.Function, 28, "plzdie")
    end
  end
end

task.spawn(function() 
  hookfunction(getcallbackvalue(replicatedstorage.HawkeyeRemoteFunction, "OnClientInvoke"), function() end)
end)

client.rayParamsVehicleEnter = getupvalue(client.alexchassis.VehicleEnter, 17)
client.originalIgnoreWater = client.rayParamsVehicleEnter.IgnoreWater

client.tagfuninstance = getupvalue(
    getconnections(collectionservice:GetInstanceAddedSignal("SewerHatch"))[1].Function, 3)
client.dooraddedsignal = getconnections(collectionservice:GetInstanceAddedSignal("Door"))[1].Function
client.doors = getupvalue(client.dooraddedsignal, 1)
client.oilexplosion = workspace.OilRig.OpenCloseSignal.Explosion

client.rocketworld.yousuck = (function() end)

client.getnumactivec4 = getupvalue(client.c4.ShootBegin, 4)
client.gethrowablesmokegrenade = getupvalue(
  require(replicatedstorage.Game.Item.SmokeGrenade).ShootBegin, 1)
client.getnearestplayer = getupvalue(require(replicatedstorage.Home.HomeItem.Fabricate.Turret).setup,
  12)
client.motorupdatewheel = getupvalue(client.alexchassis2.UpdateHQ, 15)
client.circleupdateui = getupvalue(client.circleac.UpdateLogic, 1)

client.rollratelimiter = getupvalue(client.movementrollservice.attemptRoll, 6)
client.vclasses = client.vehicleutils.Classes
client.ori.heliupdate = client.vclasses.Heli.Update
client.ori.voltupdate = client.vclasses.Volt.Update
client.ori.chassisupdate = client.vclasses.Chassis.UpdateEngine

setreadonly(client.combatconst, isreadonly(client.combatconst) and false)
setreadonly(client.militaryturretconst, isreadonly(client.militaryturretconst) and false)
setreadonly(client.rocketconsts, isreadonly(client.rocketconsts) and false)
setconstant(client.motorupdatewheel, 17, "die")

if client.gc.vehicleactionstart then
    client.constindex = client.constindex or {}
    client.constindex.vehicleactionstart = {}
    client.constindex.vehicleactionstart.GarageEngineSpeed = client.bettertablefind(getconstants(client.gc.vehicleactionstart), "CanJump")
    client.constindex.vehicleactionstart.cooldown = client.bettertablefind(getupvalues(client.gc.vehicleactionstart), 15)

    if client.constindex.vehicleactionstart.cooldown == nil then
        Library:Notify("jump action index is nil, initializing shitty backup mode.")
        for i, v in next, getupvalues(client.gc.vehicleactionstart) do
            if type(v) == "number" and v == 15 then
                client.constindex.vehicleactionstart.cooldown = i
                print(i)
            end
        end
    end

    if client.constindex.vehicleactionstart.cooldown == nil then
        Library:Notify("jump action index is still nil, idk what the fuck happened...")
    end
end

client.getBankDynamiteKey = function()
    if client.bankdynamitekey then return client.bankdynamitekey end
    
    for _, v in next, getgc(true) do
        if type(v) == "function" and islclosure(v) then
            local ok, constants = pcall(getconstants, v)
            if ok then
                for _, const in next, constants do
                    if type(const) == "string" and #const > 7 and #const < 20 and const:match("^[a-zA-Z0-9]+$") then
                        client.bankdynamitekey = const
                        return const
                    end
                end
            end
        end
    end
    return "vnvxink3"
end

for i, v in next, client.actionbuttonservice.active do
  if table.find(v.keyCodes, Enum.KeyCode.V) then
    client.activeaction.flip = v
  end
  if table.find(v.keyCodes, Enum.KeyCode.LeftControl) then
    client.activeaction.roll = v
  end
end

local itemConfigClone = replicatedstorage.Game.ItemConfig:Clone()
itemConfigClone.Name = "ItemConfigBackup"

local Circle = MainESP.CreateCircle()
Circle.Radius = configs.combat.silentaim.radius
Circle.Color = Color3.fromRGB(255, 255, 255)
Circle.Position = MainESP.TracerOrigins.Middle
Circle.NumSides = 500

local CircleOutline = MainESP.CreateCircle()
CircleOutline.Radius = configs.combat.silentaim.radius + 2
CircleOutline.Color = Color3.fromRGB(0, 0, 0)
CircleOutline.Filled = false
CircleOutline.Visible = false
CircleOutline.Position = MainESP.TracerOrigins.Middle
CircleOutline.NumSides = 500

local CircleFilled = MainESP.CreateCircle()
CircleFilled.Radius = configs.combat.silentaim.radius - 1
CircleFilled.Color = Color3.fromRGB(0, 0, 0)
CircleFilled.Filled = true
CircleFilled.Visible = false
CircleFilled.Transparency = 0.5
CircleFilled.Position = MainESP.TracerOrigins.Middle
CircleFilled.NumSides = 500

client.getremotekeyfromdecompiledsource = (function(decompiledstr, keytabletoremove)
  local strkey = {}
  for i, v in ipairs(string.split(decompiledstr, "\n")) do
    if string.find(v, ":FireServer", 0) then
      local currentstr = string.gsub(string.gsub(tostring(v), ":FireServer", ""), " ", "")
      for i2, v2 in next, keytabletoremove do
        currentstr = string.gsub(currentstr, v2, "")
      end
      strkey[#strkey + 1] = loadstring("return" .. currentstr:sub(2, currentstr:len() - 1))()
    end
  end
  return strkey
end)

client.getBankDynamiteKey = function()
    return client.bankdynamitekey or "vnvxink3"
end

client.ispc = (function()
  if userinputservice.TouchEnabled and not userinputservice.KeyboardEnabled and not userinputservice.MouseEnabled then
    return false
  elseif not userinputservice.TouchEnabled and userinputservice.KeyboardEnabled and userinputservice.MouseEnabled then
    return true
  end
  return false
end)

client.flipLoop = (function()
  repeat
    task.wait(.1)
    pcall(function()
      for i, v in next, client.actionbuttonservice.active do
        if table.find(v.keyCodes, Enum.KeyCode.V) then
          v.onPressed(true)
        end
      end
    end)
  until configs.vehicle.autoflip == false
end)
client.smokeGrenadeHook = (function(boolean)
  if boolean then
    hookfunction(client.smokegrenadeitem._playExplosionFx, function() end)
  else
    if isfunctionhooked(client.smokegrenadeitem._playExplosionFx) then
      restorefunction(client.smokegrenadeitem
        ._playExplosionFx)
    end
  end
end)
client.getNearestPlayerHook = (function(boolean)
  if boolean then
    hookfunction(client.getnearestplayer, function() return nil end)
  else
    if isfunctionhooked(client.getnearestplayer) then restorefunction(client.getnearestplayer) end
  end
end)
client.isCrawlingLoop = (function()
  repeat
    task.wait(.1)
    if client.characterutil.IsCrawling then
      client.characterutil.IsCrawling = false
    end
  until configs.player.crawlequip == false
end)
client.ori.spotlighttrackplayer = client.spotlightbinder._constructor.TrackPlayer

client.spotlightbinder._constructor.TrackPlayer = function(self, playerToTrack)
    if configs.player.nopslow and playerToTrack == players.LocalPlayer then
        return
    end
    return client.ori.spotlighttrackplayer(self, playerToTrack)
end
client.setnpcignorelp = function(a)
  for i, v in next, getupvalue(client.itemsys.GetEquipped, 1) do
    if v.Character and v.BulletEmitter and v.BulletEmitter.IgnoreGuards then
      v.BulletEmitter.IgnoreLocalPlayer = a
    end
  end
end
client.npcnodamageloop = function()
  repeat
    task.wait(0.1)
    client.setnpcignorelp(true)
  until configs.robbery.guardnodmg == false
end
client.nitroLoop = function()
    if not client.nitroTable then
        for _, v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "Nitro") and rawget(v, "NitroLastMax") then
                client.nitroTable = v
                break
            end
        end
        if not client.nitroTable then
            Library:Notify("Nitro table not loaded yet. Toggle again in a moment.")
            return
        end
    end

    local connection
    connection = runservice.Heartbeat:Connect(function()
        if not configs.vehicle.infnitro then
            connection:Disconnect()
            return
        end
        client.nitroTable.NitroLastMax = 250
        client.nitroTable.Nitro = configs.vehicle.rinfnitro and math.random(10, 249) or 249
        client.nitroTable.NitroForceUIUpdate = true
    end)
end
client.sprintLoop = (function()
  repeat
    task.wait()
    setupvalue(client.walkspeedfun, 9, true)
  until not configs.player.alwayssp
end)
client.juicedLoop = function()
    if configs.player.juiced then
        if not client.alwaysjuiced then
            client.alwaysjuiced = runservice.Heartbeat:Connect(function()
                client.characterutil.IsJuiced = true
                client.characterutil.WalkSpeedSpring:Accelerate(0.05)
            end)
        end
    else
        if client.alwaysjuiced then
            client.alwaysjuiced:Disconnect()
            client.alwaysjuiced = nil
            client.characterutil.IsJuiced = false
            client.characterutil.WalkSpeedSpring:Accelerate(-0)
        end
    end
end 
client.roll = function(a)
    if a then
        if not client.ori.attemptRoll then
            client.ori.attemptRoll = client.movementrollservice.attemptRoll
        end
        replicatedstorage:SetAttribute("RollingEnabled", true)
        local rollButton = nil
        for _, btn in pairs(client.actionbuttonservice.getButtonsFor(players.LocalPlayer)) do
            if btn.priority == 600 then
                rollButton = btn
                break
            end
        end
        if rollButton then
            client.actionbuttonservice.setButtonEnabled(rollButton, true)
        end
        local newRollRateLimiter = client.ratelimiter.new(1, 0.1)
        client.movementrollservice.attemptRoll = function()
            if newRollRateLimiter(1) then
                local remote = replicatedstorage:WaitForChild("ReplicateMovementRollRemote")
                remote:FireServer()
                return true
            end
            return false
        end
    else
        if client.ori.attemptRoll then
            client.movementrollservice.attemptRoll = client.ori.attemptRoll
            client.ori.attemptRoll = nil
        end
        replicatedstorage:SetAttribute("RollingEnabled", false)
        local rollButton = nil
        for _, btn in pairs(client.actionbuttonservice.getButtonsFor(players.LocalPlayer)) do
            if btn.priority == 600 then
                rollButton = btn
                break
            end
        end
       
            client.actionbuttonservice.setButtonEnabled(rollButton, false)
        end
    end
client.launchPlayerFlight = (function()
    local Character = localplayer.Character or localplayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    local Humanoid = Character:WaitForChild("Humanoid")
    
    Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
    
    repeat
        task.wait()
        local moveDir = Vector3.zero
        local cam = workspace.CurrentCamera
        local direction = client.controlmodule:GetMoveVector()
        
        if cam then
            moveDir += cam.CFrame.RightVector * direction.X
            moveDir -= cam.CFrame.LookVector * direction.Z
            local up = userinputservice:IsKeyDown(Enum.KeyCode.Space) or userinputservice:IsKeyDown(Enum.KeyCode.ButtonA) or userinputservice:IsKeyDown(Enum.KeyCode.DPadUp)
            local down = userinputservice:IsKeyDown(Enum.KeyCode.LeftShift) or userinputservice:IsKeyDown(Enum.KeyCode.ButtonB) or userinputservice:IsKeyDown(Enum.KeyCode.DPadDown)
            moveDir += Vector3.yAxis * (up and 1 or 0)
            moveDir -= Vector3.yAxis * (down and 1 or 0)
        end

        HumanoidRootPart.AssemblyLinearVelocity = moveDir.Magnitude > 0 and moveDir.Unit * configs.player.fspeed or Vector3.zero
    until configs.player.ftog == false
    
    Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
end)
client.launchVehicleFlight = (function()
    local Character = localplayer.Character or localplayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    
    repeat
        task.wait()
        local moveDir = Vector3.zero
        local cam = workspace.CurrentCamera
        local direction = client.controlmodule:GetMoveVector()
        
        if cam then
            moveDir += cam.CFrame.RightVector * direction.X
            moveDir -= cam.CFrame.LookVector * direction.Z
            local up = userinputservice:IsKeyDown(Enum.KeyCode.Space) or userinputservice:IsKeyDown(Enum.KeyCode.ButtonA) or userinputservice:IsKeyDown(Enum.KeyCode.DPadUp)
            local down = userinputservice:IsKeyDown(Enum.KeyCode.LeftShift) or userinputservice:IsKeyDown(Enum.KeyCode.ButtonB) or userinputservice:IsKeyDown(Enum.KeyCode.DPadDown)
            moveDir += Vector3.yAxis * (up and 1 or 0)
            moveDir -= Vector3.yAxis * (down and 1 or 0)
        end

        HumanoidRootPart.AssemblyLinearVelocity = moveDir.Magnitude > 0 and moveDir.Unit * configs.vehicle.fspeed or Vector3.zero
    until client.vehicleEntered == false or configs.vehicle.ftog == false
end)
client.getOldWeaponData = (function(name, dataname)
  return rawget(require(itemConfigClone[name]), dataname)
end)
client.setBatonSwordTime = (function(bool)
  local baton = require(replicatedstorage.Game.Item.Baton)
  local sword = require(replicatedstorage.Game.Item.Sword)
  getupvalue(baton.new, 2).ReloadTime = bool and 0 or 0.5
  getupvalue(sword.new, 2).ReloadTime = bool and 0 or 0.5
end)
client.spamBatonSwordSwoosh = (function()
  repeat
    task.wait()
    local a = client.itemsys.GetLocalEquipped()
    if a and (a.__ClassName == "Sword" or a.__ClassName == "Baton") then
      require(replicatedstorage.Game.Item[a.__ClassName]).SwingSwoosh(a)
    end
  until configs.combat.batonsword.spamswoosh == false
end)
client.spamBatonSwordLunge = (function()
  repeat
    task.wait()
    local a = client.itemsys.GetLocalEquipped()
    if a and (a.__ClassName == "Sword" or a.__ClassName == "Baton") then
      require(replicatedstorage.Game.Item[a.__ClassName]).SwingLunge(a)
    end
  until configs.combat.batonsword.spamlunge == false
end)
client.notInWall = (function(pos, ilist, wallCheck)
  if not wallCheck then
    return true
  end
  local camera = workspace.CurrentCamera or nil
  if camera == nil then
    return false
  end
  local direction = (pos - camera.CFrame.Position).Unit * (pos - camera.CFrame.Position).Magnitude
  local rayParams = RaycastParams.new()
  rayParams.FilterType = Enum.RaycastFilterType.Blacklist
  rayParams.FilterDescendantsInstances = ilist or {}
  rayParams.IgnoreWater = true
  local result = workspace:Raycast(camera.CFrame.Position, direction, rayParams)
  return result == nil
end)
client.isEnemies = (function(a, b)
  local a, b = tostring(a), tostring(b)
  if a == "Criminal" and b == "Police" then
    return true
  elseif a == "Criminal" and b == "Prisoner" then
    return false
  elseif a == "Police" and b == "Criminal" then
    return true
  elseif a == "Police" and b == "Prisoner" then
    return false
  elseif a == "Prisoner" and b == "Police" then
    return true
  elseif a == "Prisoner" and b == "Criminal" then
    return false
  end
end)
client.getNearestToCursor = function()
    local Target = nil
    local notInWall = client.notInWall
    local isEnemies = client.isEnemies
    local middlepos = MainESP.TracerOrigins.Middle
    local Camera = workspace.CurrentCamera
    local LocalPlayer = players.LocalPlayer
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    local lhrp = LocalPlayer.Character.HumanoidRootPart

    for _, v in next, players:GetPlayers() do
        if not isEnemies(LocalPlayer.Team, v.Team) then continue end
        if v == LocalPlayer then continue end
        local char = v.Character
        if not char then continue end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if not hrp or not hum or hum.Health == 0 then continue end
        if (lhrp.Position - hrp.Position).Magnitude > configs.combat.silentaim.range then continue end
        local targetPart = char:FindFirstChild("Head") or hrp
        local targetPoint, targetOnScreen = Camera:WorldToViewportPoint(targetPart.Position)
        if not targetOnScreen then continue end
        if not notInWall(targetPart.Position, {LocalPlayer.Character, char}, configs.combat.silentaim.wallcheck) then continue end
        local dist = (Vector2.new(targetPoint.X, targetPoint.Y) - Vector2.new(middlepos.X, middlepos.Y)).Magnitude
        if dist < configs.combat.silentaim.radius then
            return {Character = char, TargetPart = targetPart, IsNPC = false}
        end
    end

    if configs.combat.silentaim.targetnpcs then
        local npcs = {}
        local mansion = workspace:FindFirstChild("MansionRobbery")
        if mansion then
            local boss = mansion:FindFirstChild("ActiveBoss")
            if boss and boss:FindFirstChild("Head_GEO") and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                table.insert(npcs, {Character = boss, TargetPart = boss.Head_GEO})
            end
            local guardsFolder = mansion:FindFirstChild("GuardsFolder")
            if guardsFolder then
                for _, guard in next, guardsFolder:GetChildren() do
                    if guard:IsA("Model") and guard:FindFirstChild("HumanoidRootPart") and guard:FindFirstChild("Humanoid") and guard.Humanoid.Health > 0 then
                        table.insert(npcs, {Character = guard, TargetPart = guard:FindFirstChild("Head") or guard.HumanoidRootPart})
                    end
                end
            end
        end
        local drop = workspace:FindFirstChild("Drop")
        if drop and drop:FindFirstChild("NPCs") then
            for _, npc in next, drop.NPCs:GetChildren() do
                if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                    table.insert(npcs, {Character = npc, TargetPart = npc:FindFirstChild("Head") or npc.HumanoidRootPart})
                end
            end
        end
        local oilrig = workspace:FindFirstChild("OilRig")
        if oilrig and oilrig:FindFirstChild("GuardsFolder") then
            for _, guard in next, oilrig.GuardsFolder:GetChildren() do
                if guard:IsA("Model") and guard:FindFirstChild("HumanoidRootPart") and guard:FindFirstChild("Humanoid") and guard.Humanoid.Health > 0 then
                    table.insert(npcs, {Character = guard, TargetPart = guard:FindFirstChild("Head") or guard.HumanoidRootPart})
                end
            end
        end
        for _, npc in next, npcs do
            if (lhrp.Position - npc.TargetPart.Position).Magnitude > configs.combat.silentaim.range then continue end
            local targetPoint, targetOnScreen = Camera:WorldToViewportPoint(npc.TargetPart.Position)
            if not targetOnScreen then continue end
            if not notInWall(npc.TargetPart.Position, {LocalPlayer.Character}, configs.combat.silentaim.wallcheck) then continue end
            local dist = (Vector2.new(targetPoint.X, targetPoint.Y) - Vector2.new(middlepos.X, middlepos.Y)).Magnitude
            if dist < configs.combat.silentaim.radius then
                return {Character = npc.Character, TargetPart = npc.TargetPart, IsNPC = true}
            end
        end
    end

    return Target
end
client.getPlayerVehicle = (function(plrname)
  local uh = nil
  for i, v in next, collectionservice:GetTagged("Vehicle") do
    for i2, v2 in next, v:GetChildren() do
      if v2.Name == "Seat" or v2.Name == "Passenger" then
        local whateverSeatName = v2:FindFirstChild("PlayerName")
        if whateverSeatName and whateverSeatName.Value == plrname then
          return uh
        end
      end
    end
  end
  return uh
end)
client.getNearestVehicle = (function()
  local char = players.LocalPlayer.Character
  local target, distance = nil, 100
  for i, v in next, collectionservice:GetTagged("Vehicle") do
    if v:FindFirstChild("Seat") or v:FindFirstChild("Passenger") then
      local targetDistance = (char:FindFirstChild("HumanoidRootPart").Position - v:GetModelCFrame().Position).magnitude
      if targetDistance < distance then
        distance = targetDistance
        target = v
      end
    end
  end
  return target
end)
client.getNearestPlayerNoCuffed = (function() 
    local maxdistance = 18
    local player = nil;
    for i,v in next, players:GetPlayers() do
        if tostring(v.Team) == "Criminal" then
            local character = v.Character or nil
            if character ~= nil and not v.Character:GetAttribute("Handcuffs") then
                local hrp = character:FindFirstChild("Head") or nil
                local hum = character:FindFirstChild("Humanoid") or nil
                if hrp ~= nil and hum ~= nil then
                    local mag = (players.LocalPlayer.Character:GetModelCFrame().Position - hrp.Position).magnitude
                    if mag < maxdistance then
                        player = v
                        if player ~= nil then
                            return player
                        end
                    end
                end
            end
        end
    end
	return false
end)
client.launchArrestAura = (function()
	local getNearestPlayerNoCuffed = client.getNearestPlayerNoCuffed
	repeat task.wait(0.15)
        pcall(function()
            local plr = getNearestPlayerNoCuffed()
            if plr then
                client.attemptarrest(players:FindFirstChild(tostring(plr)))		
            end
        end)
	until configs.player.arrestaura.enabled == false
end)
client.launchPickPocketAura = function()
    repeat
        task.wait(0.2)
        pcall(function()
            for _, v in next, players:GetPlayers() do
                if v ~= players.LocalPlayer and v.Character then
                    local char = v.Character
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local dist = (players.LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                        if dist < 10 then
                            client.attemptpickpocket(v)
                        end
                    end
                end
            end
        end)
    until configs.player.pickpocketaura.enabled == false
end
client.launchBreakoutAura = function()
    repeat task.wait(20)
        pcall(function()
            local lhrp = players.LocalPlayer.Character and players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not lhrp then return end
            
            for _, v in next, players:GetPlayers() do
                if v ~= players.LocalPlayer and v.Character and v.Folder and v.Folder:FindFirstChild("Cuffed") then
                    if tostring(v.Team) ~= "Police" then
                        local hrp = v.Character:FindFirstChild("HumanoidRootPart")
                        if hrp and (lhrp.Position - hrp.Position).Magnitude < 18 then
                            client.attemptbreakout(v)
                        end
                    end
                end
            end
        end)
    until configs.player.breakoutaura.enabled == false
end
client.updateToOriginalChassisStats = (function()
  local gvp = require(replicatedstorage.Vehicle.VehicleUtils).GetLocalVehiclePacket()
  if gvp ~= nil and client.lastvehiclestats ~= nil and client.lastvehiclemodel ~= nil and gvp.Model ~= gvp.lastvehiclemodel then
    local stats = client.lastvehiclestats
    if configs.vehicle.engine == false then
      gvp.GarageEngineSpeed = stats.GarageEngineSpeed
    end
    if configs.vehicle.brake == false then
      gvp.GarageBrakes = stats.GarageBrakes
    end
    if configs.vehicle.suspension == false then
      gvp.Height = stats.Height
    end
    if configs.vehicle.turn == false then
      gvp.TurnSpeed = stats.TurnSpeed
    end
  end
end)

client.onHitSurfaceHook = (function()
  local a = client.itemsys.GetLocalEquipped()
  a.FakeName = "Sniper"
  if configs.combat.increasetakedowndamage and a.BulletEmitter ~= nil then
    for i, v in next, getconstants(a.BulletEmitter.OnHitSurface._handlerListHead._fn) do
      if v == "__ClassName" then
        setconstant(a.BulletEmitter.OnHitSurface._handlerListHead._fn, i, "FakeName")
      end
    end
  elseif configs.combat.increasetakedowndamage == false and a.BulletEmitter ~= nil then
    for i, v in next, getconstants(a.BulletEmitter.OnHitSurface._handlerListHead._fn) do
      if v == "FakeName" then
        setconstant(a.BulletEmitter.OnHitSurface._handlerListHead._fn, i, "__ClassName")
      end
    end
  end
end)

client.opendoorloop = (function()
  repeat
    for i, v in next, client.tagfuninstance do
      v["Fun"]()
    end
    task.wait(1.5)
  until configs.others.opendoor == false
end)

client.getprisonelevator = (function()
  for i, v in next, workspace:GetChildren() do
    if v:IsA("Model") and v.Name == "Elevator" and v:FindFirstChild("Car") and v.Car:FindFirstChild("InnerModel") and v.Car.InnerModel:FindFirstChild("Calls") and v.Car.InnerModel.Calls[1]:FindFirstChild("SurfaceGui").TextLabel.Text == "1*" then
      return v
    end
  end
  return nil
end)

client.callprisonelevator = (function(flor)
  pcall(function()
    --fireclickdetector(collectionservice:GetTagged("Elevator")[1].Floors[flor].Call.ClickDetector)
    if client.getprisonelevator() ~= nil then
      fireclickdetector(client.getprisonelevator().Car.InnerModel.Calls[1].ClickDetector)
    end
  end)
end)

client.prisonelevatorloop = (function()
  repeat
    task.wait(0.5)
    client.callprisonelevator(1)
  until configs.others.prisonelevator == false
end)

client.showgunstore = (function()
  setthreadcontext(2)
  client.gunshopui.open()
  setthreadcontext(10)
end)

client.getallgun = (function()
  local grabguns = (function()
    for i, v in next, players.LocalPlayer.PlayerGui.GunShopGui.Container.Container.Main.Container.Slider:GetChildren() do
      if v.ClassName == "ImageLabel" and v.Bottom.Action.Text == "EQUIP" then
        firesignal(v.Bottom.Action.MouseButton1Down)
      end
    end
  end)
  client.showgunstore()
  for i, v in next, players.LocalPlayer.PlayerGui.GunShopGui.Container.Container.Sidebar:GetChildren() do
    if v.ClassName == "ImageButton" then
      task.wait()
      for i = 1, 3 do
        grabguns()
      end
      firesignal(v.MouseButton1Down)
    end
  end
  client.gunshopui.close()
end)

local function applyToParts(parts, enable)
    for _, p in ipairs(parts) do
        if p:IsA("BasePart") then
            if enable then
                if p:GetAttribute("trans") == nil then
                    p:SetAttribute("trans", p.Transparency)
                end
                p.Transparency = 0.8
                p.CanTouch = false
                p.CanQuery = false
            else
                local orig = p:GetAttribute("trans")
                if orig ~= nil then
                    p.Transparency = orig
                    p:SetAttribute("trans", nil)
                end
                p.CanTouch = true
                p.CanQuery = true
            end
        end
    end
end

local function isLikelyLaser(part)
    if not part:IsA("BasePart") then return false end
    if part:FindFirstChild("TouchInterest") then return true end
    local name = part.Name:lower()
    if name:find("laser") or name:find("barbed") or name:find("wire") then return true end
    return false
end

local function getDescendantsOfClass(inst, class)
    local list = {}
    for _, d in ipairs(inst:GetDescendants()) do
        if d:IsA(class) then table.insert(list, d) end
    end
    return list
end

client.disableBankLasers = function(enabled)
    local Banks = workspace:FindFirstChild("Banks")
    if not Banks then return end
    local allLasers = {}
    for _, bank in ipairs(Banks:GetChildren()) do
        if bank:IsA("Model") and bank:FindFirstChild("Layout") then
            for _, layout in ipairs(bank.Layout:GetChildren()) do
                if layout:FindFirstChild("Lasers") then
                    for _, part in ipairs(getDescendantsOfClass(layout.Lasers, "BasePart")) do
                        if isLikelyLaser(part) then
                            table.insert(allLasers, part)
                        end
                    end
                end
            end
        end
    end
    applyToParts(allLasers, enabled)
end

client.autoDynamiteLoop = function()
    local key = client.getBankDynamiteKey()
    
    repeat
        task.wait(0.1)
        for _, part in next, collectionservice:GetTagged("BankDoorEscapeRoute") do
            if part:GetAttribute("Open") == nil then
                pcall(function()
                    client.bankinit:FireServer(key, part)
                end)
            end
        end
    until configs.robbery.bank.autodynamite == false
end

client.disableJewelryLasers = function(enabled)
    local Jewelrys = workspace:FindFirstChild("Jewelrys")
    if not Jewelrys then return end
    local allLasers = {}
    local Jewelry = Jewelrys:FindFirstChild("Jewelry")
    if not Jewelry then return end
    local Floors = Jewelry:FindFirstChild("Floors")
    if Floors and Floors:FindFirstChild("Model") then
        local Model = Floors.Model
        local Lasers = Model:FindFirstChild("Lasers")
        if Lasers then
            for _, laser in ipairs(Lasers:GetChildren()) do
                if laser.Name == "Laser" and laser:FindFirstChild("InnerModel") then
                    for _, part in ipairs(laser.InnerModel:GetChildren()) do
                        if isLikelyLaser(part) then table.insert(allLasers, part) end
                    end
                end
            end
        end
        local InteractiveButtonLasers = Model:FindFirstChild("InteractiveButtonLasers")
        if InteractiveButtonLasers then
            for _, laserFloor in ipairs(InteractiveButtonLasers:GetChildren()) do
                if laserFloor.Name == "LaserFloor" then
                    for _, child in ipairs(laserFloor:GetChildren()) do
                        if isLikelyLaser(child) then table.insert(allLasers, child) end
                    end
                end
            end
        end
        for _, part in ipairs(Model:GetChildren()) do
            if isLikelyLaser(part) then
                local r = math.floor(part.Color.R * 255 + 0.5)
                local g = math.floor(part.Color.G * 255 + 0.5)
                local b = math.floor(part.Color.B * 255 + 0.5)
                if (r == 255 and g == 63 and b == 84) or (r == 171 and g == 89 and b == 72) then
                    table.insert(allLasers, part)
                end
            end
        end
    end

    local TARGET_NAME = "BarbedWire"
    local POSITION_TOLERANCE = 0.5
    local targetCFrames = {
        CFrame.new(123.227493, 16.2156315, 1307.91064, -0.984813809, 8.60951559e-08, -0.173613802, 7.22449727e-08, 1, 8.60951559e-08, 0.173613802, 7.22449727e-08, -0.984813809),
        CFrame.new(125.946198, -2.58436966, 1294.53528, -0.984812617, 0, -0.173621148, 0, 1, 0, 0.173621148, 0, -0.984812617),
        CFrame.new(131.763382, -2.58436966, 1327.526, -0.984812617, 0, -0.173621148, 0, 1, 0, 0.173621148, 0, -0.984812617),
        CFrame.new(125.573204, 16.2156315, 1331.86755, -0.984812617, 0, -0.173621148, 0, 1, 0, 0.173621148, 0, -0.984812617)
    }
    for _, descendant in ipairs(Jewelrys:GetDescendants()) do
        if isLikelyLaser(descendant) and descendant.Name == TARGET_NAME then
            for _, targetCFrame in ipairs(targetCFrames) do
                if (descendant.Position - targetCFrame.Position).Magnitude <= POSITION_TOLERANCE then
                    table.insert(allLasers, descendant)
                    break
                end
            end
        end
    end

    applyToParts(allLasers, enabled)
end

client.disableMuseumLasers = function(enabled)
    local Museum = workspace:FindFirstChild("Museum")
    if not Museum then return end
    local Lights = Museum:FindFirstChild("Lights")
    if not Lights then return end
    local allLasers = {}
    for _, spotlightModel in ipairs(Lights:GetChildren()) do
        if spotlightModel.Name == "Spotlight" and spotlightModel:IsA("Model") then
            local lightPart = spotlightModel:FindFirstChild("Light")
            if lightPart and isLikelyLaser(lightPart) then table.insert(allLasers, lightPart) end
        end
    end
    applyToParts(allLasers, enabled)
end

client.disableCasinoLasers = function(enabled)
    local Casino = workspace:FindFirstChild("Casino")
    if not Casino then return end
    local allLasers = {}
    local carousel = Casino:FindFirstChild("LaserCarousel")
    if carousel and carousel:FindFirstChild("InnerModel") then
        for _, p in ipairs(getDescendantsOfClass(carousel.InnerModel, "BasePart")) do
            if isLikelyLaser(p) then table.insert(allLasers, p) end
        end
    end
    local lasers = Casino:FindFirstChild("Lasers")
    if lasers then
        for _, p in ipairs(getDescendantsOfClass(lasers, "BasePart")) do
            if isLikelyLaser(p) then table.insert(allLasers, p) end
        end
    end
    for _, folder in ipairs({ Casino:FindFirstChild("CamerasMoving"), Casino:FindFirstChild("LasersMoving") }) do
        if folder then
            for _, child in ipairs(folder:GetChildren()) do
                local im = child:FindFirstChild("InnerModel")
                if im then
                    local part = im:FindFirstChild("Part")
                    if part and isLikelyLaser(part) then table.insert(allLasers, part) end
                end
            end
        end
    end
    local vaultLaserControl = Casino:FindFirstChild("VaultLaserControl")
    if vaultLaserControl then
        for _, laser in ipairs(vaultLaserControl:GetChildren()) do
            if laser.Name == "Laser" and laser:FindFirstChild("InnerModel") then
                for _, part in ipairs(laser.InnerModel:GetChildren()) do
                    if isLikelyLaser(part) then table.insert(allLasers, part) end
                end
            end
        end
        for _, part in ipairs(vaultLaserControl:GetChildren()) do
            if isLikelyLaser(part) and part.Name == "Part" then table.insert(allLasers, part) end
        end
    end
    applyToParts(allLasers, enabled)
end

client.getcasinoelevator = (function()
  local Casino = workspace:FindFirstChild("Casino")
  if not Casino then return nil end
  local Elevator = Casino:FindFirstChild("Elevator")
  if not Elevator or not Elevator:FindFirstChild("Car") then return nil end
  return Elevator
end)

client.callcasinoelevator = (function(floor)
  pcall(function()
    local elevator = client.getcasinoelevator()
    if elevator and elevator.Car and elevator.Car.InnerModel and elevator.Car.InnerModel.Calls then
      local callButton = elevator.Car.InnerModel.Calls[tostring(floor)]
      if callButton and callButton:FindFirstChild("ClickDetector") then
        fireclickdetector(callButton.ClickDetector)
      end
    end
  end)
end)

client.casinoelevatorloop = (function()
  repeat
    task.wait(0.1)
    local elevator = client.getcasinoelevator()
    if elevator and elevator.Car and elevator.Car.InnerModel and elevator.Car.InnerModel.Calls then
      local callButton = elevator.Car.InnerModel.Calls["4"]
      if callButton and callButton:FindFirstChild("ClickDetector") then
        fireclickdetector(callButton.ClickDetector)
      end
    end
  until configs.others.breakelevator == false
end)

client.fixCasinoComputerLoop = (function()
  repeat
    task.wait(0.1)
    local char = players.LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local Casino = workspace:FindFirstChild("Casino")
    if hrp and Casino and Casino.Computers then
      for _, computer in ipairs(Casino.Computers:GetChildren()) do
        local remote = computer:FindFirstChild("CasinoComputerHack")
        local part = computer:FindFirstChild("Part") or computer.PrimaryPart
        if remote and part and (hrp.Position - part.Position).Magnitude < 10 then
          pcall(function() remote:FireServer() end)
        end
      end
    end
  until configs.robbery.casino.fixcomputer == false
end)

client.autoCollectCasinoCash = function()
    task.spawn(function()
        while configs.robbery.casino.autocollectcash do
            task.wait(0.5)
            if tostring(players.LocalPlayer.Team) == "Police" then continue end
            local char = players.LocalPlayer.Character
            if not char or not char.PrimaryPart then continue end
            local hrp = char.PrimaryPart
            local casino = workspace:FindFirstChild("Casino")
            if not casino or not casino.Loots then continue end

            local inRange = false
            for _, loot in ipairs(casino.Loots:GetChildren()) do
                if (hrp.Position - loot.Position).Magnitude <= 20 then
                    inRange = true
                    break
                end
            end

            if inRange then
                for _, spec in ipairs(client.circleac.Specs) do
                    if spec.Name and spec.Name:find("Collect") then
                        spec:Callback(true)
                    end
                end
            end
        end
    end)
end

client.casinokeycode = function()
    local casino = workspace:FindFirstChild("Casino")
    if not casino then return "Waiting for Casino..." end
    local codes = casino:FindFirstChild("RobberyDoor") and casino.RobberyDoor:FindFirstChild("Codes")
    if not codes then return "Loading codes..." end
    
    local parts = {}
    for _, v in ipairs(codes:GetDescendants()) do
        if v:IsA("TextLabel") and #v.Text > 0 then
            table.insert(parts, { text = v.Text, pos = v.Parent.Parent.Position.Z })
        end
    end
    
    table.sort(parts, function(a, b) return a.pos > b.pos end)
    local code = ""
    for _, v in ipairs(parts) do code = code .. v.text end
    return #code > 0 and code or "Searching..."
end

client.nearcasinodoor = function()
    local char = players.LocalPlayer.Character
    if not char then return false end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    local casino = workspace:FindFirstChild("Casino")
    if not casino then return false end
    for _, v in next, casino.RobberyDoor:GetDescendants() do
        if v.Name == "Region" and (v.Position - root.Position).Magnitude < 15 then
            return true
        end
    end
    return false
end

client.autocasinodoor = function()
    task.spawn(function()
        while configs.robbery.casino.autodoor do
            task.wait(1)
            pcall(function()
                if client.nearcasinodoor() then
                    local code = client.casinokeycode()
                    if code ~= "" then
                        local pad = collectionservice:GetTagged("CasinoKeypadPrompt")[1]
                        if pad then
                            local submit = pad:FindFirstChild("CasinoKeypadSubmit")
                            if submit then
                                submit:FireServer(code)
                                submit:FireServer(code:reverse())
                            end
                        end
                    end
                end
            end)
        end
    end)
end

client.disableOilRigLasers = function(enabled)
    local oilRig = workspace:FindFirstChild("OilRig")
    if not oilRig then return end
    local allLasers = {}
    local movingLasers = oilRig:FindFirstChild("MovingLasers")
    if movingLasers then
        for _, laser in ipairs(movingLasers:GetChildren()) do
            if laser.Name == "Laser" and laser:FindFirstChild("InnerModel") then
                local part = laser.InnerModel:FindFirstChild("Part")
                if part and isLikelyLaser(part) then table.insert(allLasers, part) end
            end
        end
    end
    applyToParts(allLasers, enabled)
end

client.disableTombPlanks = function(enabled)
    local tomb = workspace:FindFirstChild("RobberyTomb")
    if not tomb or not tomb:FindFirstChild("Cart") then return end
    local planks = tomb.Cart:FindFirstChild("Planks")
    if not planks then return end
    local allPlanks = {}
    for _, child in ipairs(planks:GetChildren()) do
        if child.Name == "Wood" and child:IsA("BasePart") then table.insert(allPlanks, child) end
    end
    applyToParts(allPlanks, enabled)
end

client.disableTombSpikes = function(enabled)
    local tomb = workspace:FindFirstChild("RobberyTomb")
    if not tomb or not tomb:FindFirstChild("SpikeRoom") then return end
    local spikes = tomb.SpikeRoom:FindFirstChild("Spikes")
    if not spikes then return end
    local allSpikes = {}
    for i = 1, 11 do
        local spike = spikes:FindFirstChild(tostring(i))
        if spike then
            for _, tile in ipairs(spike:GetChildren()) do
                if tile.Name == "Tile" and tile:IsA("Model") and tile:FindFirstChild("Model") then
                    local innerModel = tile.Model:FindFirstChild("InnerModel")
                    if innerModel then
                        local door = innerModel:FindFirstChild("Door")
                        if door and door:IsA("BasePart") then table.insert(allSpikes, door) end
                        local spikePart = innerModel:FindFirstChild("Spikes")
                        if spikePart and spikePart:IsA("BasePart") then table.insert(allSpikes, spikePart) end
                    end
                end
            end
        end
    end
    applyToParts(allSpikes, enabled)
end

client.disabledarts = function(enabled)
    client.disabletombdarts = enabled
    
    if enabled then
        if not client.ori.dartfire then
            client.ori.dartfire = client.dartdispenser._fire
        end
        client.dartdispenser._fire = newcclosure(function(...)
            return task.wait(9e9)
        end)
    else
        if client.ori.dartfire then
            client.dartdispenser._fire = client.ori.dartfire
            client.ori.dartfire = nil
        end
    end
end

client.disableTombBridgeBreak = function(enabled)
    local tomb = workspace:FindFirstChild("RobberyTomb")
    if not tomb then return end
    local bridge = tomb:FindFirstChild("Bridge")
    if not bridge then return end
    
    for _, plankModel in ipairs(bridge:GetChildren()) do
        if plankModel.Name == "Plank" and plankModel:IsA("Model") then
            local innerModel = plankModel:FindFirstChild("InnerModel")
            if innerModel then
                local plankPart = innerModel:FindFirstChild("Plank")
                if plankPart and plankPart:IsA("BasePart") then
                    if enabled then
                        if plankPart:GetAttribute("Rendex_OrigCanTouch") == nil then
                            plankPart:SetAttribute("Rendex_OrigCanTouch", plankPart.CanTouch)
                            plankPart:SetAttribute("Rendex_OrigCanQuery", plankPart.CanQuery)
                        end
                        plankPart.CanTouch = false
                        plankPart.CanQuery = false
                    else
                        local origTouch = plankPart:GetAttribute("Rendex_OrigCanTouch")
                        local origQuery = plankPart:GetAttribute("Rendex_OrigCanQuery")
                        if origTouch ~= nil then
                            plankPart.CanTouch = origTouch
                            plankPart.CanQuery = origQuery
                            plankPart:SetAttribute("Rendex_OrigCanTouch", nil)
                            plankPart:SetAttribute("Rendex_OrigCanQuery", nil)
                        end
                    end
                end
            end
        end
    end
end

client.disableTombLava = function(enabled)
    local tomb = workspace:FindFirstChild("RobberyTomb")
    if not tomb then return end
    local killFolder = tomb:FindFirstChild("Kill")
    if not killFolder then return end
    
    local lavaParts = {}
    for _, part in ipairs(killFolder:GetChildren()) do
        if part.Name == "LavaKill" and part:IsA("BasePart") then
            table.insert(lavaParts, part)
        end
    end
    
    applyToParts(lavaParts, enabled)
end

client.disableMansionLasers = function(enabled)
    local MansionRobbery = workspace:FindFirstChild("MansionRobbery")
    local matchedParts = {}
    
    if MansionRobbery then
        local lasersParent = MansionRobbery:FindFirstChild("Lasers")
        if lasersParent then
            for i = 1, 7 do
                local doorNumber = lasersParent:FindFirstChild(tostring(i))
                if doorNumber then
                    local innerModel = doorNumber:FindFirstChild("Door") and doorNumber.Door:FindFirstChild("InnerModel")
                    if innerModel then
                        local laserPart = innerModel:FindFirstChild("Laser")
                        if laserPart and laserPart:IsA("BasePart") then
                            table.insert(matchedParts, laserPart)
                        end
                    end
                end
            end
        end
    end

    local TARGET_NAME = "BarbedWire"
    local targetCFrames = {
        CFrame.new(3116.83716, 63.2906342, -4607.11865, 1, 0, 0, 0, 1, 0, 0, 0, 1),
        CFrame.new(3136.83716, 63.2906189, -4607.11865, 1, 0, 0, 0, 1, 0, 0, 0, 1),
        CFrame.new(3146.83716, 63.2906189, -4607.11865, 1, 0, 0, 0, 1, 0, 0, 0, 1),
        CFrame.new(3156.83716, 63.2906036, -4607.11865, 1, 0, 0, 0, 1, 0, 0, 0, 1),
        CFrame.new(3166.83716, 63.2906036, -4607.11865, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    }
    
    for _, targetCFrame in ipairs(targetCFrames) do
        local partsInBox = workspace:GetPartBoundsInBox(targetCFrame, Vector3.new(2, 2, 2))
        for _, part in ipairs(partsInBox) do
            if part.Name == TARGET_NAME and part:IsA("BasePart") then
                table.insert(matchedParts, part)
                break -- Found one for this CFrame, move to next
            end
        end
    end

    applyToParts(matchedParts, enabled, "Mansion_Laser_")
end

client.disableMansionTraps = function(enabled)
    local MansionRobbery = workspace:FindFirstChild("MansionRobbery")
    if not MansionRobbery then return end
    local LaserTraps = MansionRobbery:FindFirstChild("LaserTraps")
    if not LaserTraps then return end
    local allParts = {}
    for _, trapModel in ipairs(LaserTraps:GetChildren()) do
        if trapModel.Name == "Trap" and trapModel:IsA("Model") then
            local trapLasers = trapModel:FindFirstChild("Lasers")
            if trapLasers then
                for _, part in ipairs(trapLasers:GetChildren()) do
                    if part.Name == "Part" and part:IsA("BasePart") then table.insert(allParts, part) end
                end
            end
            local trapButtons = trapModel:FindFirstChild("Buttons")
            if trapButtons then
                for _, btnModel in ipairs(trapButtons:GetChildren()) do
                    if btnModel.Name == "TrapButton" and btnModel:IsA("Model") then
                        local touchPart = btnModel:FindFirstChild("InnerModel") and btnModel.InnerModel:FindFirstChild("Touch")
                        if touchPart and touchPart:IsA("BasePart") then table.insert(allParts, touchPart) end
                    end
                end
            end
        end
    end
    applyToParts(allParts, enabled)
end

client.autoEnterElevator = function()
    task.spawn(function()
        while configs.robbery.mansion.autoelevator do
            task.wait(0.1)
            pcall(function()
                local mansion = workspace:FindFirstChild("MansionRobbery")
                if not mansion then return end
                local elevatorTouch = mansion:FindFirstChild("Lobby") and mansion.Lobby:FindFirstChild("EntranceElevator") and mansion.Lobby.EntranceElevator:FindFirstChild("TouchToEnter")
                if not elevatorTouch then return end

                local char = players.LocalPlayer.Character
                if not char or not char.PrimaryPart then return end
                local hrp = char.PrimaryPart

                local x, y, z = hrp.Position.X, hrp.Position.Y, hrp.Position.Z
                if x >= 3103 and x <= 3225 and y >= 56 and y <= 104 and z >= -4691 and z <= -4520 then
                    firetouchinterest(elevatorTouch, hrp, 0)
                    firetouchinterest(elevatorTouch, hrp, 1)
                end
            end)
        end
    end)
end

client.getinvites = function()
    local ok, count = pcall(function()
        return tonumber(string.match(workspace.MansionRobbery.InviteCount.SurfaceGui.TextLabel.Text, "%d+")) or 0
    end)
    return ok and count or 0
end

client.disablePowerPlantLasers = function(enabled)
    local matchedParts = {}
    local TARGET_NAME = "BarbedWire"
    local targetCFrames = {
        CFrame.new(201.134583, 8.7912941, 2226.79565, 5.60283661e-06, -0.920468092, 0.390817702, 1, 5.60283661e-06, -1.14738941e-06, -1.14738941e-06, 0.390817702, 0.920468092),
        CFrame.new(177.883255, -0.408716589, 2172.02539, 5.60283661e-06, -0.920468092, 0.390817702, 1, 5.60283661e-06, -1.14738941e-06, -1.14738941e-06, 0.390817702, 0.920468092),
        CFrame.new(14.8432236, -16.90872, 2070.28516, 1.49607658e-05, -0.615643799, -0.788024604, 1, 1.49607658e-05, 7.33137131e-06, 7.33137131e-06, -0.788024604, 0.61564374),
        CFrame.new(-14.0820312, -16.90872, 2121.41284, -5.51939011e-05, -0.992548525, -0.121850133, 1, -5.51939011e-05, -3.37511301e-06, -3.37511301e-06, -0.121850133, 0.992548525),
        CFrame.new(138.27652, -16.9087276, 2140.1167, -5.51939011e-05, 0.992548525, 0.121850133, 1, 5.51342964e-05, 3.37511301e-06, -3.37511301e-06, 0.121850133, -0.992548585),
        CFrame.new(122.57695, -16.9087162, 2083.51099, 4.12464142e-05, 0.78799355, -0.615683556, 1, -4.12464142e-05, 1.41859055e-05, -1.41859055e-05, -0.615683556, -0.787993431),
        CFrame.new(71.4491959, -16.90872, 2054.58569, -1.09672546e-05, 0.121821433, -0.992551982, 1, 1.09672546e-05, -9.7155571e-06, 9.7155571e-06, -0.992551982, -0.121821404),
        CFrame.new(102.09169, 13.4912453, 2264.30322, -4.12464142e-05, -0.78799355, 0.615683556, 1, -4.12464142e-05, 1.41859055e-05, 1.41859055e-05, 0.615683556, 0.78799355),
        CFrame.new(-38.9317017, -17.214201, 2146.35767, -0.61564374, 0.788024604, -7.33137131e-06, -7.33137131e-06, -1.50203705e-05, -1, -0.788024604, -0.615643799, 1.49607658e-05),
        CFrame.new(-26.9293518, -10.8141727, 2099.67188, 0.78799355, 0.615683556, -1.41859055e-05, 1.41859055e-05, -4.12464142e-05, -1, -0.615683556, 0.78799355, -4.12464142e-05),
        CFrame.new(61.812912, -10.8642235, 2212.4458, -0.787993431, -0.615683556, 1.41859055e-05, 1.41859055e-05, -4.12464142e-05, -1, 0.615683556, -0.78799355, 4.12464142e-05),
        CFrame.new(126.630295, -18.0151043, 2052.87598, 0.920516789, 0.390703052, -3.81469727e-06, 3.81469727e-06, -1.87158585e-05, -1, -0.390703052, 0.920516789, -1.87158585e-05)
    }
    
    local targetColors = {
        {167, 78, 87},
        {182, 100, 103},
        {156, 33, 24}
    }

    for _, targetCFrame in ipairs(targetCFrames) do
        local partsInBox = workspace:GetPartBoundsInBox(targetCFrame, Vector3.new(2, 2, 2))
        for _, part in ipairs(partsInBox) do
            if part:IsA("BasePart") then
                if part.Name == TARGET_NAME or part.Name == "PowerWire" then
                    table.insert(matchedParts, part)
                else
                    local r = math.floor(part.Color.R * 255 + 0.5)
                    local g = math.floor(part.Color.G * 255 + 0.5)
                    local b = math.floor(part.Color.B * 255 + 0.5)
                    for _, col in ipairs(targetColors) do
                        if r == col[1] and g == col[2] and b == col[3] then
                            table.insert(matchedParts, part)
                            break
                        end
                    end
                end
            end
        end
    end

    applyToParts(matchedParts, enabled)
end

client.disablePowerPlantPistons = function(enabled)
    local powerPlant = workspace:FindFirstChild("PowerPlant")
    if not powerPlant then return end

    local matchedParts = {}

    for _, child in ipairs(powerPlant:GetChildren()) do
        if child.Name == "Piston" and child:IsA("Model") then
            for _, descendant in ipairs(child:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    table.insert(matchedParts, descendant)
                end
            end
        end
    end

    applyToParts(matchedParts, enabled, "PowerPlant_Piston_")
end

client.autosolvepuzzle = function()
    local ui = getupvalue(client.puzzleflow.Init, 3)

    if not ui.IsOpen or not ui.Grid then
        return
    end

    local inputGrid = {}
    for i, row in ipairs(ui.Grid) do
        inputGrid[i] = {}
        for j, val in ipairs(row) do
            inputGrid[i][j] = val + 1
        end
    end

    local solved = NumberlinkSolver(inputGrid)
    if not solved then
        Library:Notify("uhhh something went wrong")
        return
    end

    for i, row in ipairs(solved) do
        for j, val in ipairs(row) do
            ui.Grid[i][j] = val - 1
        end
    end

    ui.OnConnection()
end

client.disableMilitaryTurrets = function(state)
  if state then
    client.militaryturretconst.FIRE_RATE = math.huge
  else
    client.militaryturretconst.FIRE_RATE = 1
  end
end

client.opensewerhatch = (function()
  for i, v in next, client.tagfuninstance do
    if v["_DEBUG"] == "SewerHatch" then
      v["Fun"]()
    end
  end
end)

client.oepnsewerloop = (function()
  repeat
    task.wait(0.05)
    client.opensewerhatch()
  until configs.others.opensewer == false
end)

client.dropall = (function()
  for i, v in next, client.inventoryitemsystem.getInventoryItemsFor(players.LocalPlayer) do
    local ignore = { "Bag", "Crate", "Gem", "Taser", "Handcuffs", "RoadSpike", "MansionInvite", "Nigger" }
    if not table.find(ignore, v.obj.Name) then
      v:AttemptSetEquipped(true)
      v:AttemptDrop()
    end
  end
end)

client.antilockeditems = function(a)
    if a then
        client.inventoryitemutils.getLocked = function() return false end
        client.inventoryitemutils.setLocked = function() end
        
        if not client.antilocked then
            client.antilocked = runservice.Heartbeat:Connect(function()
                if not configs.player.antilocked then
                    client.antilocked:Disconnect()
                    client.antilocked = nil
                    return
                end
                for _, item in ipairs(collectionservice:GetTagged(client.inventoryitemconsts.TAG_NAME)) do
                    if item:IsDescendantOf(players.LocalPlayer) and item:GetAttribute(client.inventoryitemconsts.LOCKED_ATTR_NAME) then
                        item:SetAttribute(client.inventoryitemconsts.LOCKED_ATTR_NAME, false)
                    end
                end
            end)
        end
    else
        client.inventoryitemutils.getLocked = client.ori.getLocked
        client.inventoryitemutils.setLocked = client.ori.setLocked
        
        if client.antilocked then
            client.antilocked:Disconnect()
            client.antilocked = nil
        end
    end
end

hookfunction(client.stdraycast.collidable, function(pos, dir, len, params, collidablefunc)
    if configs.vehicle.heliheight and debug.traceback():find("Heli") then
        return CFrame.new(pos)
    end
    
    if configs.combat.plasmawallbang and typeof(dir) == "Vector3" and dir.Y > -0.9 then
        return client.ori.collidable(pos, dir, len, params, function(inst)
            return client.stdcharacterutils.getAncestorPartHumanoid(inst) ~= nil
        end)
    end
    
    return client.ori.collidable(pos, dir, len, params, collidablefunc)
end)

  client.simulatedphysicsprojectile.HitTargetWithSpeed = (function(...)
    local args = { ... }
    if configs.combat.forcefieldnomiss and args[3] == 75 then
      args[3] = 1
    end
    return client.ori.hittargetwithspeed(unpack(args))
  end)

  client.itemgun.BulletEmitterOnLocalHitPlayer = (function(...)
    local args = { ... }
    if configs.combat.alwaysheadshot then
      args[15].isHeadshot = true
    end
    return client.ori.bulletemitteronlocalhitplayer(unpack(args))
  end)

client.itemgun.Shoot = (function(self, a)
    if configs.combat.silentaim.enabled then
        local targetData = client.getNearestToCursor()
        local character = targetData and targetData.Character
        local targetPart = targetData and targetData.TargetPart
        local aimPart = character and (targetPart or character:FindFirstChild("HumanoidRootPart"))
        if aimPart then
            self.TipDirection = (aimPart.Position - self.Tip.Position).Unit
        end
    end
    local oldLastUpdate = self.BulletEmitter.LastUpdate
    self.BulletEmitter.LastUpdate = configs.combat.instantbullethit and -9e9 or oldLastUpdate
    client.ori.shoot(self, a)
end)

client.plasmagun.ShootOther = (function(self, a)
    if configs.combat.silentaim.enabled and configs.combat.silentaim.includeplasma then
        local targetData = client.getNearestToCursor()
        local character = targetData and targetData.Character
        local targetPart = targetData and targetData.TargetPart
        local aimPart = character and (targetPart or character:FindFirstChild("HumanoidRootPart"))
        if aimPart then
            self.TipDirection = (aimPart.Position - self.Tip.Position).Unit
        end
    end
    client.ori.plasmashootother(self, a)
end)

  client.tase.Tase = (function(self, ...)
    if configs.combat.tasermodz then
      self._lastDraw = 0
    end
    return client.ori.tase(self, ...)
  end)

client.raycast.RayIgnoreNonCollideWithIgnoreList = (function(...)
    if debug.traceback():find("Taser") and configs.combat.silentaim.enabled and configs.combat.silentaim.includetaser then
        local targetData = client.getNearestToCursor()
        local character = targetData and targetData.Character
        local targetPart = targetData and targetData.TargetPart
        local aimPart = character and (targetPart or character:FindFirstChild("HumanoidRootPart"))
        if aimPart then
            return aimPart, aimPart.Position, aimPart.Position, ...
        end
    end
    return client.ori.rayignore(...)
end)

do
  local originalVehicleEnter = client.alexchassis.VehicleEnter
    client.ori.alexchassisvehicleenter = originalVehicleEnter

    client.alexchassis.VehicleEnter = function(self, ...)
      local result = originalVehicleEnter(self, ...)

      if configs.vehicle.driveonwater then
        local upvalue17 = getupvalue(originalVehicleEnter, 17)
        if upvalue17 and upvalue17.IgnoreWater ~= nil then
          upvalue17.IgnoreWater = false
        end
      end

      return result
    end
  end

  client.gamepasssystem.doesPlayerOwnCached = (function(...)
    local args = { ... }
    if configs.combat.pistolswat and tostring(args[1]) == players.LocalPlayer.Name and debug.traceback():find("tem.Pistol") then
      return true
    end
    return client.ori.doesplayerowncached(...)
  end)

  client.gunutil.getEquipTime = (function(...)
    return configs.combat.noequipt and 0 or client.ori.getequiptime(...)
  end)

  client.paraglide.IsFlying = (function(...)
    return configs.player.nosky and debug.traceback():find("Falling") and true or client.ori.isflying(...)
  end)

  client.getMarkerColor = function(player)
    return tostring(player.Team) == "Police" and Color3.fromRGB(84, 215, 253) or Color3.fromRGB(253, 148, 81)
  end

client.forceWorldMarkerVisible = function(marker)
    if not marker then return end
    pcall(function()
        if type(marker.SetVisible) == "function" then marker:SetVisible(true) end
        if marker.Frame then marker.Frame.BackgroundTransparency = 1 end
        if marker.FrameInner then
            marker.FrameInner.Visible = true
            marker.FrameInner.ImageTransparency = 0
            marker.FrameInner.BackgroundTransparency = 1
        end
        if marker.FrameOuter then
            marker.FrameOuter.ImageTransparency = 1
            marker.FrameOuter.BackgroundTransparency = 1
        end
    end)
  end

  client.createExtraMarker = function(player)
    if player == players.LocalPlayer or client.extraMarkers[player.UserId] or not client.isEnemies(players.LocalPlayer.Team, player.Team) then return end
    local marker = client.worldmarker.new()
    marker:SetScreenGui(client.worldmarkersystem.gui)
    marker:SetSizes({4, {24, 0}, {math.huge, 8}})
    pcall(function() marker:SetIcon(tostring(player.Team) == "Police" and client.copicon or client.crimicon) end)
    client.extraMarkerGroup:Add(marker)
    pcall(function()
        marker.FrameInner.ImageColor3 = client.getMarkerColor(player)
        marker.FrameInner.BackgroundTransparency = 1
    end)
    client.forceWorldMarkerVisible(marker)
    client.extraMarkers[player.UserId] = { worldMarker = marker, player = player }
  end

  client.removeExtraMarker = function(player)
    local data = client.extraMarkers[player.UserId]
    if data then
        pcall(function()
            client.extraMarkerGroup:Remove(data.worldMarker)
            data.worldMarker:Destroy()
        end)
        client.extraMarkers[player.UserId] = nil
    end
  end

  client.detectIcons = function()
    if client.iconsDetected then return end
    local gui = client.worldmarkersystem.gui
    if not gui then return end
    local foundCop, foundCrim = false, false
    for _, frame in pairs(gui:GetDescendants()) do
        if frame:IsA("ImageLabel") and frame.Name == "FrameInner" then
            local color = frame.ImageColor3
            if color then
                local idString = string.match(frame.Image, "%d+")
                if idString then
                    local id = tonumber(idString)
                    if color.R * 255 < 150 and color.B * 255 > 150 and not foundCop then
                        client.copicon = id; foundCop = true
                    elseif color.R * 255 > 200 and color.B * 255 < 150 and not foundCrim then
                        client.crimicon = id; foundCrim = true
                    end
                end
            end
        end
    end
    if foundCop and foundCrim then client.iconsDetected = true end
  end

client.toggleAntiMinimapFlash = function(enabled)
    if client.minimapFlashConn then
        client.minimapFlashConn:Disconnect()
        client.minimapFlashConn = nil
    end

    if not enabled then
        for marker, connections in pairs(client.minimapmarker) do
            for _, conn in pairs(connections) do
                pcall(function() conn:Disconnect() end)
            end
        end
        client.minimapmarker = {}

        pcall(function()
            local state = client.store:getState()
            if state.minimapPoints then
                for _, point in ipairs(state.minimapPoints) do
                    local plr = players:FindFirstChild(point.name)
                    if not plr then
                        for _, p in ipairs(players:GetPlayers()) do
                            if p.DisplayName == point.name then plr = p break end
                        end
                    end
                    if plr and client.isEnemies(players.LocalPlayer.Team, plr.Team) then
                        point.flash = true
                        if point._updateVisible then
                            point._updateVisible(false)
                        end
                    end
                end
            end
        end)

        pcall(function()
            local pointsFrame = players.LocalPlayer.PlayerGui.AppUI.Buttons.Minimap.Map.Container.Points
            for _, child in pairs(pointsFrame:GetChildren()) do
                if child:IsA("ImageLabel") and child.Name ~= "_you" then
                    local plr = players:FindFirstChild(child.Name)
                    if not plr then
                        for _, p in ipairs(players:GetPlayers()) do
                            if p.DisplayName == child.Name then plr = p break end
                        end
                    end
                    if plr and client.isEnemies(players.LocalPlayer.Team, plr.Team) then
                        child.Visible = false
                    end
                end
            end
        end)
        return
    end

    pcall(function()
        local state = client.store:getState()
        if state.minimapPoints then
            for _, point in ipairs(state.minimapPoints) do
                local plr = players:FindFirstChild(point.name)
                if not plr then
                    for _, p in ipairs(players:GetPlayers()) do
                        if p.DisplayName == point.name then plr = p break end
                    end
                end
                if plr and client.isEnemies(players.LocalPlayer.Team, plr.Team) then
                    point.flash = false
                    if point._visible and point._updateVisible then
                        point._updateVisible(true)
                    end
                end
            end
        end
    end)

    local function hookPointsFrame()
        local ok, pointsFrame = pcall(function()
            return players.LocalPlayer.PlayerGui.AppUI.Buttons.Minimap.Map.Container.Points
        end)
        if not ok or not pointsFrame then return false end

        local function forceChild(child)
            if child:IsA("ImageLabel") and child.Name ~= "_you" then
                local plr = players:FindFirstChild(child.Name)
                if not plr then
                    for _, p in ipairs(players:GetPlayers()) do
                        if p.DisplayName == child.Name then plr = p break end
                    end
                end
                
                if plr and client.isEnemies(players.LocalPlayer.Team, plr.Team) then
                    child.BackgroundTransparency = 1
                    child.Visible = true
                    
                    if not client.minimapmarker[child] then
                        local connections = {}
                        local conn1 = child:GetPropertyChangedSignal("Visible"):Connect(function()
                            if configs.others.antiminimapflash and not child.Visible then
                                child.Visible = true
                            end
                        end)
                        table.insert(connections, conn1)
                        client.minimapmarker[child] = connections
                    end
                end
            end
        end

        for _, child in pairs(pointsFrame:GetChildren()) do
            forceChild(child)
        end

        pointsFrame.ChildAdded:Connect(function(child)
            task.wait()
            forceChild(child)
        end)

        return true
    end

    hookPointsFrame()

    client.minimapFlashConn = runservice.Heartbeat:Connect(function()
        pcall(function()
            local state = client.store:getState()
            if state.minimapPoints then
                for _, point in ipairs(state.minimapPoints) do
                    local plr = players:FindFirstChild(point.name)
                    if not plr then
                        for _, p in ipairs(players:GetPlayers()) do
                            if p.DisplayName == point.name then plr = p break end
                        end
                    end
                    if plr and client.isEnemies(players.LocalPlayer.Team, plr.Team) then
                        point.flash = false
                        if point._visible and not point._visible:getValue() then
                            if point._updateVisible then
                                point._updateVisible(true)
                            end
                        end
                    end
                end
            end
        end)

        pcall(function()
            local pointsFrame = players.LocalPlayer.PlayerGui.AppUI.Buttons.Minimap.Map.Container.Points
            for _, child in pairs(pointsFrame:GetChildren()) do
                if child:IsA("ImageLabel") and child.Name ~= "_you" then
                    local plr = players:FindFirstChild(child.Name)
                    if not plr then
                        for _, p in ipairs(players:GetPlayers()) do
                            if p.DisplayName == child.Name then plr = p break end
                        end
                    end
                    if plr and client.isEnemies(players.LocalPlayer.Team, plr.Team) then
                        child.Visible = true
                        child.BackgroundTransparency = 1
                    end
                end
            end
        end)
    end)
end

  client.toggleShowPlayerMarkers = function(enabled)
    if client.playermarker then
      client.playermarker:Disconnect()
      client.playermarker = nil
  end
    
  if not enabled then
      if client.originalPlayerMarkerDraw then
          client.playermarkersystem._draw = client.originalPlayerMarkerDraw
          client.originalPlayerMarkerDraw = nil
        end
        for userId, data in pairs(client.extraMarkers) do
            pcall(function()
                client.extraMarkerGroup:Remove(data.worldMarker)
                data.worldMarker:Destroy()
            end)
        end
        table.clear(client.extraMarkers)
        
        pcall(function()
            for _, data in pairs(client.playermarkersystem._mapPlayerIdPlayerMarker) do
                if data._worldMarker then
                    if data._worldMarker.Frame then data._worldMarker.Frame.Visible = true end
                    if data._worldMarker.FrameInner then
                      data._worldMarker.FrameInner.Visible = true
                      data._worldMarker.FrameInner.ImageTransparency = 0
                  end
              end
          end
      end)
      return
  end

    if not client.extraMarkerGroup then
        client.extraMarkerGroup = client.worldmarkergroup.new()
        client.worldmarkersystem.addGroup(client.extraMarkerGroup)
    end
    
    if not client.originalPlayerMarkerDraw then
        client.originalPlayerMarkerDraw = client.playermarkersystem._draw
    end

    client.playermarkersystem._draw = function()
        for _, data in pairs(client.playermarkersystem._mapPlayerIdPlayerMarker) do
            local plr = data._player
            if plr then
                local character = plr.Character
                if character and character.PrimaryPart then
                    data._worldMarker:SetPosition(character.PrimaryPart.Position)
                end
                if client.isEnemies(players.LocalPlayer.Team, plr.Team) then
                    pcall(function()
                        if data._worldMarker then
                            if data._worldMarker.Frame then data._worldMarker.Frame.Visible = false end
                            if data._worldMarker.FrameInner then
                                data._worldMarker.FrameInner.Visible = false
                                data._worldMarker.FrameInner.ImageTransparency = 1
                            end
                        end
                    end)
                else
                    client.forceWorldMarkerVisible(data._worldMarker)
                end
            end
        end
    end

    client.detectIcons()
    for _, plr in pairs(players:GetPlayers()) do client.createExtraMarker(plr) end

    client.playermarker = runservice.Heartbeat:Connect(function()
        if not client.iconsDetected then
            client.detectIcons()
            if client.iconsDetected then
                for _, data in pairs(client.extraMarkers) do
                    pcall(function() data.worldMarker:SetIcon(tostring(data.player.Team) == "Police" and client.copicon or client.crimicon) end)
                end
            end
        end

        pcall(function()
            for _, data in pairs(client.playermarkersystem._mapPlayerIdPlayerMarker) do
                if data._worldMarker then
                    if data._worldMarker.Frame then data._worldMarker.Frame.BackgroundTransparency = 1 end
                    if data._worldMarker.FrameInner then data._worldMarker.FrameInner.BackgroundTransparency = 1 end
                    if data._worldMarker.FrameOuter then data._worldMarker.FrameOuter.BackgroundTransparency = 1 end
                end
            end
        end)

        local toRemove = {}
        for userId, data in pairs(client.extraMarkers) do
            local plr = data.player
            if plr and plr.Parent and client.isEnemies(players.LocalPlayer.Team, plr.Team) then
                local char = plr.Character
                if char and char.PrimaryPart then
                    data.worldMarker:SetPosition(char.PrimaryPart.Position)
                    pcall(function()
                        data.worldMarker.FrameInner.ImageColor3 = client.getMarkerColor(plr)
                        data.worldMarker.FrameInner.BackgroundTransparency = 1
                        data.worldMarker.FrameOuter.BackgroundTransparency = 1
                    end)
                end
            else
                table.insert(toRemove, plr)
            end
        end
        for _, plr in pairs(toRemove) do client.removeExtraMarker(plr) end
        for _, plr in pairs(players:GetPlayers()) do
            if client.isEnemies(players.LocalPlayer.Team, plr.Team) and not client.extraMarkers[plr.UserId] then
                client.createExtraMarker(plr)
            end
        end
    end)
  end

  client.vehiclelinkbinder._constructor._hookNearest = (function(...)
    local args = { ... }
    local rope = args[1].obj
    local obj = args[1].nearestObj
    local requestLink = args[1].manifest.reqLinkRemote
    if configs.vehicle.helipick and rope.Name == "RopePull" then
      local cf = obj.PrimaryPart.CFrame:PointToObjectSpace(
        client.geomUtils.closestPointInPart(obj.PrimaryPart, rope.Position), rope.Position)
      requestLink:FireServer(obj, cf)
      return
    elseif configs.vehicle.instanttow and rope.Name == "MetalHook" then
      local cf = obj.PrimaryPart.CFrame:PointToObjectSpace(
        client.geomUtils.closestPointInPart(obj.PrimaryPart, rope.Position), rope.Position)
      requestLink:FireServer(obj, cf)
      return
    end
    return client.ori.hookNearest(...)
  end)

  client.vclasses.Heli.Update = (function(self, ...)
    --Vector3.new(configs.vehicle.helienginesp, configs.vehicle.heliverticalsp, configs.vehicle.helienginesp)
    client.ori.heliupdate(self, ...)
    if configs.vehicle.heliengine then
      self.Velocity.Velocity *= Vector3.new(configs.vehicle.helienginesp, configs.vehicle.heliverticalsp,
        configs.vehicle.helienginesp)
      --self.Rotate.AngularVelocity *= Vector3.new(configs.vehicle.heliturnsp, configs.vehicle.heliturnsp, configs.vehicle.heliturnsp)
    end
  end)

client.vclasses.Volt.Update = function(volt)
    client.ori.voltupdate(volt)
    if configs.vehicle.voltnopop then
        volt.AreTiresPopped = false
        if volt.WheelWorld and volt.WheelWorld.Wheels then
            for _, wheel in ipairs(volt.WheelWorld.Wheels) do
                wheel:SetForwardFriction(volt._defaultForwardFriction or 0.01)
            end
        end
    end
    volt.Force.Force = volt.Force.Force * (1 + configs.vehicle.voltenginesp)
end

  local blacklistedaction = {
    "Rob",
    "Hack",
    "Open Crate",
    "Break In",
    "Pull Lever",
    "Place TNT",
    "Switch",
    "Crack",
    "Change Direction"
  }
  client.circleac.Press = (function()
    local spec = getupvalue(client.ori.circleactionpress, 1).Spec
    if configs.player.nocircwait and spec and not table.find(blacklistedaction, spec.Name) then
      spec:Callback(true)
    end
    return client.ori.circleactionpress()
  end)

  client.oilrigbinder._launchBlowUp = (function(a)
    if configs.robbery.nooilblow then
      return
    end
    return client.ori.oillaunchblow(a)
  end)

  players.LocalPlayer:GetMouse().Move:Connect(function()
    if client.ispc() then
      local Mouse = userinputservice:GetMouseLocation()
      Circle.Position = Vector2.new(Mouse.X, Mouse.Y)
      CircleFilled.Position = Vector2.new(Mouse.X, Mouse.Y)
      CircleOutline.Position = Vector2.new(Mouse.X, Mouse.Y)
    end
  end)

players.LocalPlayer.CharacterAdded:Connect(function(a)
    local hrp = players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    if hrp then
        if configs.player.nofall then
            hrp:AddTag("NoFallDamage")
        end
        if configs.player.norag then
            hrp:AddTag("NoRagdoll")
        end
    end
    
    for part, state in pairs(client._noclipCache) do
        if part and part.Parent then
            part.CanCollide = state
        end
    end
    client._noclipCache = {}
    
    if configs.combat.getweapon then
        task.delay(0.1, function()
            client.getallgun()
        end)
    end
end)

client.noclipLoop = (function()
    repeat
        task.wait()
        local char = players.LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    if configs.player.noclip then
                        if client._noclipCache[part] == nil then
                            client._noclipCache[part] = part.CanCollide
                        end
                        part.CanCollide = false
                    else
                        if client._noclipCache[part] ~= nil then
                            part.CanCollide = client._noclipCache[part]
                            client._noclipCache[part] = nil
                        end
                    end
                end
            end
        end
    until not configs.player.noclip
end)
  userinputservice.JumpRequest:Connect(function()
    if configs.player.infjump then
      players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
  end)
  game.Lighting.ChildAdded:connect(function(marlow)
    if configs.combat.snipernoblur and marlow.Name == "Blur" then
      marlow:GetPropertyChangedSignal("Size"):connect(function()
        marlow.Enabled = false
      end)
    end
  end)
client.alwaysfavorited = function(enabled)
    if client.autofavorite then
        client.autofavorite = false
    end
    
    if not enabled then return end
    
    client.autofavorite = true
    
    task.spawn(function()
        while client.autofavorite do
            task.wait(0.1)
            local ok, star = pcall(function()
                return players.LocalPlayer.PlayerGui.AppUI.Garage.Center.Portal.Top.FavoritedCheckbox.Star
            end)
            if ok and star then
                local garageVis = false
                pcall(function() garageVis = players.LocalPlayer.PlayerGui.AppUI.Garage.Visible end)
                if garageVis then
                    if star.ImageColor3.R < 0.9 then
                        local conns = getconnections(star.Activated)
                        if conns[1] then
                            conns[1].Function()
                        end
                    end
                end
            end
        end
    end)
end
client.onvehicleentered:Connect(function(arg1)
    client.vehicleEntered = true
    if arg1.Model ~= client.lastvehiclemodel and arg1.Type == "Chassis" then
        client.lastvehiclemodel = arg1.Model
        client.lastvehiclestats.GarageEngineSpeed = arg1.GarageEngineSpeed
        client.lastvehiclestats.GarageBrakes = arg1.GarageBrakes
        client.lastvehiclestats.TurnSpeed = arg1.TurnSpeed
        client.lastvehiclestats.Height = arg1.Height
    end
    if configs.vehicle.ftog then
        client.launchVehicleFlight()
    end
    if arg1.Type == "Heli" then
        arg1.MaxHeight = configs.vehicle.heliheight and 9e9 or 400
        arg1.FallOutOfSkyDuration = configs.vehicle.helibreak and 0 or 10
        arg1.DisableDuration = configs.vehicle.helibreak and 0 or 10
    elseif arg1.Type == "Chassis" then
        arg1.TirePopDuration = configs.vehicle.nopop and 0 or 7.5
        arg1.DisableDuration = configs.vehicle.nopop and 0 or 7.5
        arg1.TirePopProportion = configs.vehicle.nopop and 0 or 0.5
    elseif arg1.Type == "Volt" or arg1.Type == "Custom" then
        arg1.DisableDuration = configs.vehicle.voltnopop and 0 or 7.5
    end
end)

client.onvehicleexited:Connect(function()
    client.vehicleEntered = false
end)
players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
    if child.Name == "GarageGui" or child.Name == "Garage" then
        task.defer(function()
            if configs.vehicle.showfavorited then
                client.toggleFavoritedFilter(true)
            end
        end)
    end
end)
client.instantreloadlmao = function()
    if client.instantreload then
        client.instantreload:Disconnect()
        client.instantreload = nil
    end

    if not configs.combat.instantreload then return end

    client.instantreload = runservice.Heartbeat:Connect(function()
        if client.instantreloadprocess then return end
        if not configs.combat.instantreload then
            client.instantreload:Disconnect()
            client.instantreload = nil
            return
        end

        local gun = client.itemsys.GetLocalEquipped()
        if gun and gun.BulletEmitter and (gun.IsReloading or (gun.AmmoGui and gun.AmmoGui.FlagOutOfAmmo)) then
            local name = gun.__ClassName
            if not name or table.find({"C4", "RocketLauncher", "Grenade", "SmokeGrenade", "unknown"}, name) then return end

            local oldSlot
            for i, v in ipairs(client.hotbarsystem.getSortedHotbarItemsFor(players.LocalPlayer) or {}) do
                if v.obj and tostring(v.obj) == name then
                    oldSlot = i
                    break
                end
            end

            client.instantreloadprocess = true
            task.spawn(function()
                for _, v in ipairs(client.inventoryitemsystem.getInventoryItemsFor(players.LocalPlayer) or {}) do
                    if v.obj and v.obj.Name == name and v.AttemptDrop then 
                        v:AttemptDrop() 
                        break 
                    end
                end
                
                task.wait(0.15)
                
                while configs.combat.instantreload and not client.itemsys.GetLocalEquipped() do
                    local root = players.LocalPlayer.Character and players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if root and client.circleac.Specs then
                        for _, v in ipairs(client.circleac.Specs) do
                            if v.Part and v.Enabled and v.Name and string.find(v.Name:lower(), "pick") and (root.Position - v.Part.Position).Magnitude < 25 then
                                v:Callback(true)
                            end
                        end
                    end
                    task.wait()
                end

                if oldSlot and configs.combat.instantreload then
                    for i, v in ipairs(client.hotbarsystem.getSortedHotbarItemsFor(players.LocalPlayer) or {}) do
                        if v.obj and tostring(v.obj) == name then
                            pcall(function()
                                client.hotbarutils.setDisplayOrder(v.obj, oldSlot)
                            end)
                            break
                        end
                    end
                end

                client.instantreloadprocess = false
            end)
        end
    end)
end
  client.onlocalitemequipped:Connect(function(equippeddata)
    --client.originalequippeddata = equippeddata
    local getdata = client.getOldWeaponData
    local a = client.itemsys.GetLocalEquipped()
    a.FakeName = "Sniper"
    task.spawn(function()
      client.onHitSurfaceHook()
    end)
    if getdata(a.__ClassName, "FireAuto") ~= nil then
      a.Config.FireAuto = configs.combat.alwaysauto and true or getdata(a.__ClassName, "FireAuto")
    end
    if getdata(a.__ClassName, "BulletSpread") ~= nil then
      a.Config.BulletSpread = configs.combat.nospread and 0 or getdata(a.__ClassName, "BulletSpread")
    end
    if getdata(a.__ClassName, "CamShakeMagnitude") ~= nil then
      a.Config.CamShakeMagnitude = configs.combat.norecoil and 0 or getdata(a.__ClassName, "CamShakeMagnitude")
    end
    if a.__ClassName == "Taser" and getdata(a.__ClassName, "ReloadTimeHit") ~= nil and getdata(a.__ClassName, "ReloadTime") ~= nil then
      a.Config.ReloadTimeHit = configs.combat.tasermodz and 0 or getdata(a.__ClassName, "ReloadTimeHit")
      a.Config.ReloadTime = configs.combat.tasermodz and 0 or getdata(a.__ClassName, "ReloadTime")
    end
    if a and a.BulletEmitter and a.BulletEmitter.GravityVector then
      a.BulletEmitter.GravityVector = configs.combat.nobulletg and nil or Vector3.new(0, -workspace.Gravity / 10, 0)
    end
    if a.__ClassName == "ForcefieldLauncher" then
      a.Config.Reload = configs.combat.forcefieldreload and 0 or 4
    end
end)

  task.spawn(function()
    while true do
      task.wait(.1)
      pcall(function()
        local humanoid = players.LocalPlayer.Character.Humanoid or nil
        local gvp = require(replicatedstorage.Vehicle.VehicleUtils).GetLocalVehiclePacket() or nil
        if humanoid ~= nil and gvp ~= nil and client.vehicleEntered then
          if gvp.Type == "Chassis" then
            if configs.vehicle.engine then
              gvp.GarageEngineSpeed = configs.vehicle.enginesp
            end
            if configs.vehicle.brake then
              gvp.GarageBrakes = configs.vehicle.brakesp
            end
            if configs.vehicle.suspension then
              gvp.Height = configs.vehicle.suspensionhe
            end
            if configs.vehicle.turn then
              gvp.TurnSpeed = configs.vehicle.turnsp
            end
          end
        end
        if configs.player.norwait then
          table.clear(client.movementrollservice.mapLastRollTime)
        end
      end)
    end
  end)

AddToggle = (function(groupboxes, txt, clbck, default, tootip, customId)
    default = default or false
    tootip = type(tootip) == "string" and tootip or false
    
    local id = customId or string.gsub(txt, " ", "")
    local tbl = {
        Text = txt,
        Default = default,
        Callback = function(a)
            task.spawn(function() clbck(a) end)
        end
    }
    if tootip then tbl.Tooltip = tootip end
    
    return groupboxes:AddToggle(id, tbl)
end)

AddSlider = (function(groupboxes, txt, clbck, default, min, max, round, tootip, customId)
    default = default or 0
    tootip = type(tootip) == "string" and tootip or nil
    round = round or 0
    
    local id = customId or string.gsub(txt, " ", "")
    
    local tbl = {
        Text     = txt,
        Default  = default,
        Max      = max,
        Min      = min,
        Rounding = round,
        Callback = clbck
    }
    
    if tootip then 
        tbl.Tooltip = tootip 
    end
    
    return groupboxes:AddSlider(id, tbl)
end)

Library.ForceCheckbox = true

local Loading = Library:CreateLoading({
    Title = "Rendex",
    Icon = 104882957553580,
    TotalSteps = 5
})
 
Loading:SetMessage("Initializing...")
Loading:SetDescription("Waiting for game to load...")
task.wait(.5)
 
Loading:SetCurrentStep(1)
Loading:SetDescription("Connecting to server...")
task.wait(.5)

Loading:SetCurrentStep(2)
Loading:SetDescription("Shitting on jailbreak...")
task.wait(.5)
 
Loading:SetCurrentStep(3)
Loading:ShowSidebarPage(true)
Loading.Sidebar:AddLabel("User: " .. players.LocalPlayer.Name)
Loading.Sidebar:AddLabel("Version: 0.0.7")
Loading.Sidebar:AddLabel("Game: Jailbreak")
task.wait(.5)
 
Loading:SetCurrentStep(4)
Loading:SetDescription("Almost finished!")
task.wait(.5)
 
Loading:SetCurrentStep(5)
Loading:Continue()

local Window = Library:CreateWindow({
  Title = "Rendex",
  Footer = "Rendex | Jailbreak | 0.0.7",
  Icon = 'rbxassetid://104882957553580',
  CornerRadius = 10,
  SidebarCompacted = true,
  Center = true,
  AutoShow = false,
  Resizable = true,
  ShowCustomCursor = true,
  NotifySide = "Right",
  TabPadding = 1,
  MenuFadeTime = 0.2,
  EnableSidebarResize = true,
  ShowToggleFrameInKeybinds = true,
  GlobalSearch = true,
  Size = UDim2.fromOffset(600, 450)
})

local tab = Window:AddTab("Player", "user", "Bunch of options for yourself.")

local group = tab:AddLeftGroupbox("Movement")
local PlayerFlightToggle = group:AddToggle("PlayerFlightKey", {
  Text = "Player Flight",
  Tooltip = "Allows you to fly as a player",
  Default = configs.player.ftog,
  Callback = function(a)
    configs.player.ftog = a
    if a then
      client.launchPlayerFlight()
    end
  end
})
AddSlider(group, "Flight Speed", function(a)
    configs.player.fspeed = a
end, 0, 0, 150, 0, nil, "PlayerFlightSpeed")
AddToggle(group, "Always Sprinting", function(a)
  configs.player.alwayssp = a
  if a then
    client.sprintLoop()
  end
end, false, "Makes you always sprint")
local AlwaysJuicedToggle = group:AddToggle("AlwaysJuicedKey", {
  Text = "Always Juiced",
  Tooltip = "Makes you always juiced to be faster",
  Default = configs.player.juiced,
  Callback = function(a)
    configs.player.juiced = a
    client.juicedLoop()
  end
})
local NoclipToggle = group:AddToggle("NoclipKey", {
  Text = "Noclip",
  Tooltip = "Allows you to noclip certain areas",
  Default = configs.player.noclip,
  Callback = function(a)
    configs.player.noclip = a
    if a then
        client.noclipLoop()
    else
        for part, state in pairs(client._noclipCache) do
            if part and part.Parent then
                part.CanCollide = state
            end
        end
        client._noclipCache = {}
    end
  end
})
local InfJumpToggle = group:AddToggle("InfJumpKey", {
  Text = "Infinite Jump",
  Tooltip = "son it says it right there",
  Default = configs.player.infjump,
  Callback = function(a)
    configs.player.infjump = a
  end
})

local group = tab:AddLeftGroupbox("Interactions")
AddToggle(group, "Pickpocket Aura", function(a)
    configs.player.pickpocketaura.enabled = a
    if a then client.launchPickPocketAura() 
  end
end)
AddToggle(group, "Arrest Aura", function(a)
    configs.player.arrestaura.enabled = a
    if a then client.launchArrestAura() 
  end
end)
AddToggle(group, "Breakout Aura", function(a)
    configs.player.breakoutaura.enabled = a
    if a then task.spawn(client.launchBreakoutAura) end
end)

local group = tab:AddRightGroupbox("Mechanics")
AddToggle(group, "Anti Ragdoll", function(a)
  configs.player.norag = a
  local hrp = players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") or nil
  if configs.player.norag == false and hrp ~= nil then
    hrp:RemoveTag("NoRagdoll")
  elseif configs.player.norag == true and hrp ~= nil then
    hrp:AddTag("NoRagdoll")
  end
end, false, "Prevents you from ragdolling")
AddToggle(group, "Anti Fall Injury", function(a)
  configs.player.nofall = a
  local hrp = players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") or nil
  if configs.player.nofall == false and hrp ~= nil then
    hrp:RemoveTag("NoFallDamage")
  elseif configs.player.nofall == true and hrp ~= nil then
    hrp:AddTag("NoFallDamage")
  end
end, false, "Prevents from taking fall damage")
AddToggle(group, "Anti Skydiving", function(a)
  configs.player.nosky = a
end, false, "Prevents you from skydiving")
AddToggle(group, "Anti Ragdoll Stun", function(a)
  configs.player.nostun = a
  client.settingss.Time.Stunned = configs.player.nostun and 0 or 5
  setupvalue(client.stunnedragdoll, 1, configs.player.nostun and nil)
end, false, "Prevents you from being stunned from tasers, etc")
AddToggle(group, "Anti Injury Slow", function(a)
  configs.player.noislow = a
  setconstant(client.walkspeedfun, 8, configs.player.noislow and 1 or 0.5)
end, false, "Prevents you from being slow while damaged")
AddToggle(group, "Anti Crawling Slow", function(a)
  configs.player.nocslow = a
  setconstant(client.walkspeedfun, 16, configs.player.nocslow and 1 or 0.4)
end, false, "Prevents you from being slow while crawling")
AddToggle(group, "Allow Equip When Crawling", function(a)
  configs.player.crawlequip = a
  if configs.player.crawlequip then
    client.isCrawlingLoop()
  end
end, false, "Allow you to equip items while crawling")
AddToggle(group, "Anti Locked Items", function(a)
    configs.player.antilocked = a
    client.antilockeditems(a)
end, false, "Allows you to unequip any item")
AddToggle(group, "Anti Spotlight Slow", function(a)
    configs.player.nopslow = a
    if not a then
        for _, v in ipairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "StopTracking") and rawget(v, "playerToTrack") == players.LocalPlayer then
                pcall(function() v:StopTracking() end)
            end
        end
    end
end, false, "Prevents spotlight from slowing you down")

group:AddDivider()

AddToggle(group, "Enable Movement Roll", function(a)
    configs.player.enableroll = a
    client.roll(a)
end, false, "Enables rolling")

AddToggle(group, "No Roll Cooldown", function(a)
  configs.player.norwait = a
  client.activeaction.roll.useEvery = configs.player.norwait and 0 or 5
  client.rollratelimiter._budgetPerWindow = configs.player.norwait and 9e9 or 10
  client.rollratelimiter._budgetWindowDuration = configs.player.norwait and 9e9 or 10
end, false, "Makes rolling have no cooldown basically")

group:AddDivider()

local NoCircleHoldToggle = group:AddToggle("NoCircleHoldKey", {
  Text = "No Circle Action Wait",
  Tooltip = "Prevents you from circle action wait",
  Default = configs.player.nocircwait,
  Callback = function(a)
    configs.player.nocircwait = a
    setconstant(client.updateplayer, 44, a and 0 or 0.5)
  end
})
AddToggle(group, "Circle Anti Clipping", function(a)
  setconstant(client.circleupdateui, 42, a and "Duration" or "NoRay")
end, false, "Makes you able to use circle action behind walls")

local group = tab:AddLeftGroupbox("Minimap")
AddToggle(group, "Anti Minimap Flash", function(a)
    configs.others.antiminimapflash = a
    client.toggleAntiMinimapFlash(a)
end, false, "Removes minimap flash delay")
AddToggle(group, "Always Show Player Marker", function(a)
    configs.others.showplayermarkers = a
    client.toggleShowPlayerMarkers(a)
end, false, "Shows all player markers if they arent on your team")

local tab = Window:AddTab("Vehicle", "car", "Vehicle modifications and stuff")

local group = tab:AddLeftGroupbox("General")
local VehicleFlightToggle = group:AddToggle("VehicleFlightKey", {
  Text = "Vehicle Flight",
  Tooltip = "Allows you to fly your vehicle",
  Default = configs.vehicle.ftog,
  Callback = function(a)
    configs.vehicle.ftog = a
    if a and client.vehicleEntered == true then
      client.launchVehicleFlight()
    end
  end
})
AddSlider(group, "Flight Speed", function(a)
    configs.vehicle.fspeed = a
end, 0, 0, 500, 0, nil, "VehicleFlightSpeed")

group:AddDivider()

AddToggle(group, "Add Jump Action", function(a)
    setconstant(client.gc.vehicleactionstart, client.constindex.vehicleactionstart.GarageEngineSpeed, a and "GarageEngineSpeed" or "CanJump")
end, false, "Adds the jump action to every car")
AddToggle(group, "Anti Jump Action Wait", function(a)
    setupvalue(client.gc.vehicleactionstart, client.constindex.vehicleactionstart.cooldown, a and 0.1 or 15)
end, false, "Removes cooldown from jump action")
AddToggle(group, "Infinite Nitro", function(a)
  configs.vehicle.infnitro = a
  if configs.vehicle.infnitro then
    client.nitroLoop()
  end
end, false, "Gives you infinite nitro forever")
local group = tab:AddLeftGroupbox("Car")
AddSlider(group, "Engine Speed", function(a)
  configs.vehicle.enginesp = a
end, configs.vehicle.enginesp, 0, 200, 0)
AddToggle(group, "Apply Engine Speed", function(a)
  configs.vehicle.engine = a
  if configs.vehicle.engine == false then
    client.updateToOriginalChassisStats()
  end
end)
AddSlider(group, "Brakes", function(a)
  configs.vehicle.brakesp = a
end, configs.vehicle.brakesp, 0, 30, 0)
AddToggle(group, "Apply Breaks", function(a)
  configs.vehicle.brake = a
  if configs.vehicle.brake == false then
    client.updateToOriginalChassisStats()
  end
end)
AddSlider(group, "Suspension Height", function(a)
  configs.vehicle.suspensionhe = a
end, configs.vehicle.suspensionhe, 0, 200, 0)
local ApplySusHeightToggle = group:AddToggle("ApplySusHeightKey", {
  Text = "Apply Suspension Height",
  Default = configs.vehicle.suspension,
  Callback = function(a)
    configs.vehicle.suspension = a
    client.updateToOriginalChassisStats()
  end
})
AddSlider(group, "Turn Speed", function(a)
  configs.vehicle.turnsp = a
end, configs.vehicle.turnsp, 0, 5, 0)
AddToggle(group, "Apply Turn Speed", function(a)
  configs.vehicle.turn = a
  if configs.vehicle.turn == false then
    client.updateToOriginalChassisStats()
  end
end)
AddToggle(group, "Anti Tire Pop", function(a)
  configs.vehicle.nopop = a
end, false, "Makes your tires immune to being popped")
AddToggle(group, "Drive On Water", function(a)
  configs.vehicle.driveonwater = a
  if client.rayParamsVehicleEnter then
    client.rayParamsVehicleEnter.IgnoreWater = not a
  end
end, false, "Be able to drive on water")
local AlwaysFlipToggle = group:AddToggle("AlwaysFlipKey", {
  Text = "Always Flip",
  Tooltip = "Always flip your vehicles",
  Default = configs.vehicle.autoflip,
  Callback = function(a)
    configs.vehicle.autoflip = a
    client.flipLoop()
  end
})
AddToggle(group, "Instant Tow", function(a)
  configs.vehicle.instanttow = a
end)

local group = tab:AddLeftGroupbox("Helicopter")
AddSlider(group, "Engine Forward Speed", function(a)
  configs.vehicle.helienginesp = a / 10
end, 0, 0, 500, 0)
AddSlider(group, "Engine Vertical Speed", function(a)
  configs.vehicle.heliverticalsp = a / 10
end, 0, 0, 300, 0)
AddToggle(group, "Apply Modification", function(a)
  configs.vehicle.heliengine = a
end)
AddToggle(group, "Instant Heli Pickup", function(a)
  configs.vehicle.helipick = a
end)
AddToggle(group, "Anti Heli Down", function(a)
  configs.vehicle.helibreak = a
end)
AddToggle(group, "Infinite Heli Height", function(a)
  configs.vehicle.heliheight = a
end)

local group = tab:AddRightGroupbox("Garage")
local slotDrop = group:AddDropdown("Slot", {
  Text = "Choose Save Slot",
  Values = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" },
  Default = 1,
})

group:AddButton("Load Save Slot", function()
  local remote = replicatedstorage:FindFirstChild("GarageSlotLoad")
  if remote then
    remote:FireServer("s" .. slotDrop.Value)
    Library:Notify("Loaded slot " .. slotDrop.Value .. "!", 2)
  else
    Library:Notify("Remote not ready!", 2)
  end
end)

AddToggle(group, "Auto Load Save Slot", function(a)
  configs.vehicle.autoloadslot = a
  if a and client.vehicleEntered then
    local remote = replicatedstorage:FindFirstChild("GarageSlotLoad")
    if remote then
      remote:FireServer("s" .. slotDrop.Value)
    end
  end
end)

AddToggle(group, "Auto Load Last Selection", function(a)
  configs.vehicle.autoloadlast = a
  if a and client.vehicleEntered then
    local remote = replicatedstorage.GarageLoadLastSelection
    remote:FireServer()
  end
end)

client.onvehicleentered:Connect(function()
    client.vehicleEntered = true
    if configs.vehicle.autoloadslot then
        local remote = replicatedstorage:FindFirstChild("GarageSlotLoad")
        if remote then
            remote:FireServer("s" .. slotDrop.Value)
        end
    end
    if configs.vehicle.autoloadlast then
        local Event = replicatedstorage.GarageLoadLastSelection
        if Event then
            Event:FireServer()
        end
    end
end)

AddToggle(group, "Always Show Favorited", function(a)
    configs.vehicle.showfavorited = a
    client.alwaysfavorited(a)
end, false, "Only show favorited vehicles in garage")

local group = tab:AddRightGroupbox("Motorbike")
AddSlider(group, "Speed Multiplier", function(a)
  setconstant(client.alexchassis2.UpdateHQ, 76, 1.2 + a)
end, 0, 0, 100, 0)
AddSlider(group, "Suspension Height Multiplier", function(a)
  setconstant(client.motorupdatewheel, 16, a)
end, 0, 0, 50, 0)

local group = tab:AddRightGroupbox("Tank")
-- AddSlider(group, "Engine Speed Multiplier", function(a)
-- 	configs.vehicle.tankenginesp = a
-- end, 0, 0, 500, 0)
-- AddToggle(group, "Apply Engine Speed", function(a)
-- 	print(configs.vehicle.tankenginesp)
-- 	setconstant(getproto(client.tankbinder._handleSeatedDriver, 4), 20, tonumber(configs.vehicle.tankenginesp))
-- 	print(getconstant(getproto(client.tankbinder._handleSeatedDriver, 4), 20))
-- end)
AddSlider(group, "Tracks Height", function(a)
  setconstant(client.tankbinder._buildWheelWorld, 28, 5.3 + a)
end, 0, 0, 50, 0)

local group = tab:AddRightGroupbox("Volt")
AddSlider(group, "Speed Multiplier", function(a)
  configs.vehicle.voltenginesp = a
end, 0, 0, 25, 0)
AddSlider(group, "Wheel Height", function(a)
  setconstant(client.vclasses.Volt.VehicleEnter, 30, 6.5 + a)
end, 0, 0, 19, 0)
AddToggle(group, "Anti Pop Tire", function(a)
    configs.vehicle.voltnopop = a
end)

local tab = Window:AddTab("Robberies", "landmark", "Allows you do robberies easier yep.")

local group = tab:AddLeftGroupbox("General")
AddToggle(group, "Disable Guard", function(a)
  configs.robbery.guardnodmg = a
  setconstant(client.guardnpcbinder._onItemEquipped, 8, a and "yeafuckyou" or "IgnoreLocalPlayer")
  if a then
    client.setnpcignorelp(true)
    task.spawn(client.npcnodamageloop)
  else
    client.setnpcignorelp(false)
  end
end)
AddToggle(group, "Auto Numberlink Solve", function(a)
    configs.robbery.powerplant.autosolve = a
    if a then
        client.autosolve = task.spawn(function()
            while configs.robbery.powerplant.autosolve do
                task.wait(client.solvedelay)
                client.autosolvepuzzle()
            end
        end)
    else
        if client.autosolve then
            task.cancel(client.autosolve)
            client.autosolve = nil
        end
    end
end, false, "Literally just solves the numberlink puzzle for you")

AddSlider(group, "Solve Delay", function(a)
    client.solvedelay = a
end, 0.1, 0.1, 5, 1)

local group = tab:AddLeftGroupbox("Bank")
AddToggle(group, "No Lasers", function(a)
    configs.robbery.bank.disablelasers = a
    client.disableBankLasers(a)
end, false, nil, "BankLasers")
AddToggle(group, "Auto Place Dynamite", function(a)
    configs.robbery.bank.autodynamite = a
    if a then task.spawn(client.autoDynamiteLoop) end
end)

local group = tab:AddLeftGroupbox("Jewelry Store")
AddToggle(group, "No Lasers", function(a)
    configs.robbery.jewelry.disablelasers = a
    client.disableJewelryLasers(a)
end, false, nil, "JewelryLasers")

local group = tab:AddLeftGroupbox("Museum")
AddToggle(group, "No Lasers", function(a)
    configs.robbery.museum.disablelasers = a
    client.disableMuseumLasers(a)
end, false, nil, "MuseumLasers")

local group = tab:AddRightGroupbox("Casino")
local casinocode = group:AddLabel("Code: Searching...", false)

group:AddButton("Copy Code", function()
    local code = client.casinokeycode()
    if setclipboard and code ~= "" and not code:find("Searching") and not code:find("Waiting") then
        setclipboard(code)
        Library:Notify("Copied: " .. code, 2)
    else
        Library:Notify("No code found son", 2)
    end
end)

AddToggle(group, "Auto Notify Code", function(a)
    configs.robbery.casino.autonotifycode = a
    client.autonotify = a
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        local code = client.casinokeycode()
        
        if casinocode then
            casinocode:SetText("Code: " .. code)
        end
        
        if client.autonotify and code ~= client.lastcode and code ~= "" and not code:find("Searching") and not code:find("Waiting") then
            client.lastcode = code
            Library:Notify("Code: " .. code, 3)
        end
    end
end)
AddToggle(group, "No Lasers", function(a)
    configs.robbery.casino.disablelasers = a
    client.disableCasinoLasers(a)
end, false, nil, "CasinoLasers")
AddToggle(group, "Hack Computer", function(a)
    configs.robbery.casino.fixcomputer = a
    if a then task.spawn(client.fixCasinoComputerLoop)
    end
end)
AddToggle(group, "Auto Collect Cash", function(a)
    configs.robbery.casino.autocollectcash = a
    if a then client.autoCollectCasinoCash() end
end)
AddToggle(group, "Auto Open Door", function(a)
    configs.robbery.casino.autodoor = a
    if a then client.autocasinodoor() 
  end
end)
local elevatorFloorDropdown = group:AddDropdown("CasinoElevatorFloor", {
  Text = "Choose Elevator Floor",
  Values = { "Vaults", "Ground", "Security", "Roof" },
  Default = 2,
  Callback = function(value)
    local floorMap = { ["Vaults"] = 1, ["Ground"] = 2, ["Security"] = 3, ["Roof"] = 4 }
    configs.robbery.casino.elevatorfloor = floorMap[value] or 2
  end
})
group:AddButton("Call Elevator", function()
  local floorNumber = configs.robbery.casino.elevatorfloor or 2
  client.callcasinoelevator(floorNumber)
end)

local group = tab:AddLeftGroupbox("Tomb")
AddToggle(group, "No Planks", function(a)
  configs.robbery.tomb.disableplanks = a
  client.disableTombPlanks(a)
end)
AddToggle(group, "No Spikes", function(a)
  configs.robbery.tomb.disablespikes = a
  client.disableTombSpikes(a)
end)
AddToggle(group, "No Darts", function(a)
  configs.robbery.tomb.disabledarts = a
  client.disabledarts(a)
end)
AddToggle(group, "Disable Bridge Break", function(a)
  configs.robbery.tomb.bridgebreak = a
  client.disableTombBridgeBreak(a)
end)
AddToggle(group, "No Lava", function(a)
  configs.robbery.tomb.disablelava = a
  client.disableTombLava(a)
end)

local group = tab:AddRightGroupbox("Oil Rig")
AddToggle(group, "No Lasers", function(a)
    configs.robbery.oilrig.disablelasers = a
    client.disableOilRigLasers(a)
end, false, nil, "OilRigLasers")
AddToggle(group, "Disable Turret", function(a)
    configs.robbery.oilrig.disableturret = a
    setconstant(client.turret.ShootLaser, 31, a and 9e9 or 0.5)
end, false, nil, "OilRigTurret")
AddToggle(group, "Disable Self Destruct", function(a)
  configs.robbery.oilrig.nooilblow = a
  client.oilexplosion.Name = a and "insert" or "Explosion"
  print(client.oilexplosion.Name)
end)

local group = tab:AddRightGroupbox("Cargo Ship")
AddToggle(group, "Disable Turret", function(a)
    configs.robbery.cargoship.disableturret = a
    setconstant(client.turret.ShootRocket, 16, a and "yousuck" or "Launch")
end, false, nil, "CargoShipTurret")

local group = tab:AddRightGroupbox("Mansion")
AddToggle(group, "No Lasers", function(a)
    configs.robbery.mansion.disablelasers = a
    client.disableMansionLasers(a)
end, false, nil, "MansionLasers")
AddToggle(group, "No Traps", function(a)
  configs.robbery.mansion.disabletraps = a
  client.disableMansionTraps(a)
end)
AddToggle(group, "Auto Enter Elevator", function(a)
    configs.robbery.mansion.autoelevator = a
    if a then client.autoEnterElevator() end
end)
local InviteLabel = group:AddLabel("Invites: 0", false)

task.spawn(function()
    while true do
        local invites = client.getinvites()
        InviteLabel:SetText(invites > 0 and ("Invites: " .. invites) or "Invites: Not Found")
        task.wait(0.5)
    end
end)

local group = tab:AddLeftGroupbox("Power Plant")
AddToggle(group, "No Lasers", function(a)
    configs.robbery.powerplant.disablelasers = a
    client.disablePowerPlantLasers(a)
end, false, nil, "PowerPlantLasers")
AddToggle(group, "No Pistons", function(a)
  configs.robbery.powerplant.disablepistons = a
  client.disablePowerPlantPistons(a)
end)

local tab = Window:AddTab("Combat", "hand-fist", "Stuff for combat like silent aim & etc.")

local group = tab:AddLeftGroupbox("Utilities")
AddToggle(group, "Instant Reload", function(a)
    configs.combat.instantreload = a
    client.instantreloadlmao()
end)
AddToggle(group, "Plasma Wallbang", function(a)
    configs.combat.plasmawallbang = a
end, false, "Shoot through walls")
AddToggle(group, "Always Auto", function(a)
  configs.combat.alwaysauto = a
end)
AddToggle(group, "Anti Recoil", function(a)
  configs.combat.norecoil = a
end)
AddToggle(group, "Anti Spread", function(a)
  configs.combat.nospread = a
end)
AddToggle(group, "Anti Equip Time", function(a)
  configs.combat.noequipt = a
end)
AddToggle(group, "Bullet Criticals", function(a)
  configs.combat.alwaysheadshot = a
end)
AddToggle(group, "Instant Bullet Hit", function(a)
  configs.combat.instantbullethit = a
end)
AddToggle(group, "Increase Takedown Damage", function(a)
  configs.combat.increasetakedowndamage = a
end)
AddToggle(group, "Shoot Through Forcefield", function(a)
    configs.combat.shootthroughforce = a
    if a then
        client.forcefieldservice.ListShieldsDisabled = {}
        setconstant(client.bulletemitter.Update, 27, "ListShieldsDisabled")
    else
        setconstant(client.bulletemitter.Update, 27, "ListShields")
    end
end)
AddToggle(group, "Rocket Instant Seek", function(a)
    configs.combat.instantrocketseek = a
    setreadonly(client.rocketconsts, false)
    client.rocketconsts.SEEKING_LOCK_MIN_DURATION = a and 0 or 2
    local equipped = client.itemsys.GetLocalEquipped()
    if equipped and equipped.__ClassName == "RocketLauncher" then
        equipped.targetPartFoundAt = a and 0 or os.clock()
    end
end)
AddToggle(group, "Free Pistol Swat", function(a)
  configs.combat.pistolswat = a
end)
AddToggle(group, "Fast Taser", function(a)
  configs.combat.tasermodz = a
end)
AddToggle(group, "Faster Forcefield Reload", function(a)
  configs.combat.forcefieldreload = a
end)
AddToggle(group, "Anti Forcefield Misses", function(a)
  configs.combat.forcefieldnomiss = a
end)
AddToggle(group, "Anti Smoke Grenande Effect", function(a)
  configs.combat.nogrenadesmoke = a
  client.smokeGrenadeHook(a)
end)
AddToggle(group, "Anti Smoke Grenade Limit", function(a)
  configs.combat.nogrenadesmokelimit = a
  setconstant(client.gethrowablesmokegrenade, 6, a and 0 or 1)
end)

local group = tab:AddLeftGroupbox("Melee")
AddToggle(group, "Anti Reload Time", function(a)
  configs.combat.batonsword.noreloadtime = a
  if configs.combat.batonsword.noreloadtime then
    client.setBatonSwordTime(configs.combat.batonsword.noreloadtime)
  end
end)
AddToggle(group, "Always Swoosh", function(a)
  configs.combat.batonsword.spamswoosh = a
  if configs.combat.batonsword.spamswoosh then
    client.spamBatonSwordSwoosh()
  end
end)
AddToggle(group, "Always Lunge", function(a)
  configs.combat.batonsword.spamlunge = a
  if configs.combat.batonsword.spamlunge then
    client.spamBatonSwordLunge()
  end
end)

local group = tab:AddRightGroupbox("Silent Aim")

AddToggle(group, "Enabled", function(a)
    configs.combat.silentaim.enabled = a
end, false, nil, "SilentAimEnabled")
AddToggle(group, "Include NPCs", function(a)
  configs.combat.silentaim.targetnpcs = a
end)
AddToggle(group, "Wallcheck", function(a)
  configs.combat.silentaim.wallcheck = a
end)
AddToggle(group, "Include Taser", function(a)
  configs.combat.silentaim.includetaser = a
end)
AddToggle(group, "Include Plasma", function(a)
  configs.combat.silentaim.includeplasma = a
end)
AddToggle(group, "FOV Circle", function(a)
  configs.combat.silentaim.fovcirc = a
  Circle.Visible = a
  CircleOutline.Visible = a
end)
AddToggle(group, "FOV Circle Filled", function(a)
  CircleFilled.Visible = a
end)
AddSlider(group, "Range", function(a)
  configs.combat.silentaim.range = a
end, 300, 50, 1000, 0)
AddSlider(group, "Radius", function(a)
  configs.combat.silentaim.radius = a
  Circle.Radius = a
  CircleOutline.Radius = a + 2
  CircleFilled.Radius = a - 1
end, 50, 10, 1000, 0)

local group = tab:AddRightGroupbox("Gun Store")
group:AddLabel("These only works near a gun store", true)
group:AddButton({
  Text = 'Get All Owned Gun',
  Func = function()
    client.getallgun()
  end,
  DoubleClick = false,
  Disabled = false,
  Visible = true
})
group:AddButton({
  Text = 'Open Gunstore UI',
  Func = function()
    client.showgunstore()
  end,
  DoubleClick = false,
  Disabled = false,
  Visible = true
})

local tab = Window:AddTab("Visual", "eye")

local group = tab:AddLeftGroupbox("ESP Options")
AddToggle(group, "Enabled", function(a)
  MainESP.Options.Enabled = a
end, false, nil, "EspEnabled")
AddToggle(group, "Bounties", function(a)
  MainESP.Options.Bounties = a
end)
AddToggle(group, "Box", function(a)
  MainESP.Options.Box = a
end)
AddToggle(group, "Tracer", function(a)
  MainESP.Options.Tracer = a
end)
AddToggle(group, "Name", function(a)
  MainESP.Options.Name = a
end)
AddToggle(group, "Distance", function(a)
  MainESP.Options.Distance = a
end)
AddToggle(group, "Health", function(a)
  MainESP.Options.Health = a
end)
AddToggle(group, "Skeleton", function(a)
  MainESP.Options.Skeleton = a
end)

local group = tab:AddRightGroupbox("ESP Settings")
AddToggle(group, "Team Check", function(a)
  MainESP.Options.Enabled = a
end)
AddToggle(group, "Use Team Color", function(a)
  MainESP.Options.UseTeamColor = a
end, true)
AddToggle(group, "Rainbow", function(a)
  MainESP.Options.Rainbow = a
end)
AddToggle(group, "Text Outline", function(a)
  MainESP.Options.TextOutline = a
end)
AddSlider(group, "Text Size", function(a)
  MainESP.Options.FontSize = a
end, 15, 1, 50, 0)
group:AddDropdown('TracerOrigins', {
  Values = { "Top", "Middle", "Bottom" },
  Default = 3,
  Multi = false,
  Text = "Tracer Origins",
  Searchable = false,
  Callback = function(Value)  
    MainESP.Options.TracerOrigin = Value
  end,
  Visible = true,
})

local group = tab:AddLeftGroupbox("Airdrop ESP Options")
AddToggle(group, "Enabled", function(a)
  MainESP.CrateOptions.Enabled = a
end, false, nil, "AirdropEnabled")
AddToggle(group, "Tracer", function(a)
  MainESP.CrateOptions.Tracer = a
end, false, nil, "AirdropTracer")
AddToggle(group, "Name", function(a)
  MainESP.CrateOptions.Name = a
end, false, nil, "AirdropName")
AddToggle(group, "Distance", function(a)
  MainESP.CrateOptions.Distance = a
end, false, nil, "AirdropDistance")

local group = tab:AddRightGroupbox("Airdrop ESP Settings")
AddToggle(group, "Rainbow", function(a)
  MainESP.CrateOptions.Rainbow = a
end, false, nil, "AirdropRainbow")
AddToggle(group, "Text Outline", function(a)
  MainESP.CrateOptions.TextOutline = a
end, false, nil, "AirdropTextOutline")
AddSlider(group, "Airdrop Text Size", function(a)
  MainESP.CrateOptions.FontSize = a
end, 15, 1, 50, 0)
group:AddDropdown('AirdropTracerOrigins', {
  Values = { "Top", "Middle", "Bottom" },
  Default = 3,
  Multi = false,
  Text = "Tracer Origins",
  Searchable = false,
  Callback = function(Value)
    MainESP.CrateOptions.TracerOrigin = Value
  end,
  Visible = true,
})

local tab = Window:AddTab("Miscellaneous", "earth")

local group = tab:AddLeftGroupbox("Military")
AddToggle(group, "Disable Military Turrets", function(a)
  configs.others.disablemilitaryturret = a
  client.disableMilitaryTurrets(a)
end, configs.others.disablemilitaryturret)

local group = tab:AddLeftGroupbox("Protections")
AddToggle(group, "Disable Home Turret", function(a)
  configs.others.disablehometurret = a
  client.getNearestPlayerHook(a)
end)
local group = tab:AddRightGroupbox("Fun")
AddToggle(group, "Open All Doors & Gates", function(a)
  configs.others.opendoor = a
  if a then
    client.opendoorloop()
  end
end)
AddToggle(group, "Open All Sewer Hatch", function(a)
  configs.others.opensewer = a
  if a then
    client.oepnsewerloop()
  end
end)
AddToggle(group, "Break Prison Elevator", function(a)
  configs.others.prisonelevator = a
  if a then
    client.prisonelevatorloop()
  else
    client.callprisonelevator(2)
  end
end)
AddToggle(group, "Break Casino Elevator", function(a)
  configs.others.breakelevator = a
  if a then
    client.casinoelevatorloop()
  else
    local elevator = client.getcasinoelevator()
      if elevator and elevator.Car and elevator.Car.InnerModel and elevator.Car.InnerModel.Calls then
        local callButton = elevator.Car.InnerModel.Calls["2"]
        if callButton and callButton:FindFirstChild("ClickDetector") then
          fireclickdetector(callButton.ClickDetector)
        end
      end
  end
end)

local Keybind = PlayerFlightToggle:AddKeyPicker("PlayerFlightKey", {
  Default = "P",
  Text = "Player Flight",
  SyncToggleState = true,
  Mode = "Toggle",
  Callback = function(a)
    configs.player.ftog = a
    if a then
      client.launchPlayerFlight()
    end
  end
})

local Keybind = VehicleFlightToggle:AddKeyPicker("VehicleFlightKey", {
  Default = "V",
  Text = "Vehicle Flight",
  SyncToggleState = true,
  Mode = "Toggle",
  Callback = function(a)
    configs.vehicle.ftog = a
    if a and client.vehicleEntered == true then
      client.launchVehicleFlight()
    end
  end
})

local Keybind = NoclipToggle:AddKeyPicker("NoclipKey", {
  Default = "N",
  Text = "Noclip",
  SyncToggleState = true,
  Mode = "Toggle",
  Callback = function(a)
    configs.player.noclip = a
    if a then
        client.noclipLoop()
    else
        for part, state in pairs(client._noclipCache) do
            if part and part.Parent then
                part.CanCollide = state
            end
        end
        client._noclipCache = {}
    end
  end
})

local Keybind = InfJumpToggle:AddKeyPicker("InfJumpKey", {
  Default = "L",
  Text = "Infinite Jump",
  SyncToggleState = true,
  Mode = "Toggle",
  Callback = function(a)
    configs.player.infjump = a
  end
})

local Keybind = AlwaysJuicedToggle:AddKeyPicker("AlwaysJuicedKey", {
  Default = "K",
  Text = "Always Juiced",
  SyncToggleState = true,
  Mode = "Toggle",
  Callback = function(a)
    configs.player.juiced = a
  end
})

local tab = Window:AddTab("Credits", "circle-user")
local group = tab:AddLeftGroupbox("Credits")
group:AddLabel("credits to codecoat for the source", true)

local tab = Window:AddTab("Settings", "settings")
local MenuGroup = tab:AddLeftGroupbox("Menu Options")
MenuGroup:AddLabel("Menu bind")
    :AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })
MenuGroup:AddToggle("KeybindMenuOpen", {
  Default = Library.KeybindFrame.Visible,
  Text = "Open Keybind Menu",
  Callback = function(value)
    Library.KeybindFrame.Visible = value
  end,
})
MenuGroup:AddDivider()
MenuGroup:AddButton({
    Text = "Join Our Discord",
    Func = function()
        pcall(function()
            game:GetService("GuiService"):OpenUrl("https://discord.gg/X4GW8N5GdW")
        end)
    end
}):AddButton({
    Text = "Copy Invite Link",
    Func = function()
        if setclipboard then
            setclipboard("https://discord.gg/X4GW8N5GdW")
            Library:Notify("Copied Discord invite!", 2)
        else
            Library:Notify("Missing setclipboard function", 2)
        end
    end
})
MenuGroup:AddButton("Unload", function() Library:Unload() end)
Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
ThemeManager:SetFolder('Rendex')
SaveManager:SetFolder('Rendex/Jailbreak')
ThemeManager:SetDefaultTheme({
    FontColor = Color3.fromRGB(255, 255, 255),
    MainColor = Color3.fromRGB(30, 30, 30),
    AccentColor = Color3.fromRGB(0, 155, 189),
    BackgroundColor = Color3.fromRGB(20, 20, 20),
    OutlineColor = Color3.fromRGB(50, 50, 50),

    FontFace = Font.new("rbxasset://fonts/families/Code.json")
})
SaveManager:BuildConfigSection(tab)
ThemeManager:ApplyToTab(tab)
SaveManager:LoadAutoloadConfig()

Library.ToggleKeybind = Options.MenuKeybind

local loadTime = math.floor((tick() - time) * 100) / 100
Library:Notify("Loaded in " .. loadTime .. " seconds!", 3)
if client.ispc() then
  Library:Notify("Right shift to open", 3)
end

task.spawn(function()
    while task.wait(2) do
        local r = configs.robbery

        if r.bank.disablelasers then
          client.disableBankLasers(true)
        end

        if r.museum.disablelasers then
          client.disableMuseumLasers(true)
        end

        if r.casino.disablelasers then
          client.disableCasinoLasers(true)
        end

        if r.oilrig.disablelasers then
          client.disableOilRigLasers(true)
        end

        if r.tomb.disableplanks then
          client.disableTombPlanks(true)
        end

        if r.tomb.disablespikes then
          client.disableTombSpikes(true)
        end

        if r.tomb.bridgebreak then
          client.disableTombBridgeBreak(true)
        end

        if r.tomb.disablelava then
          client.disableTombLava(true)
        end

        if r.jewelry.disablelasers then
          client.disableJewelryLasers(true)
        end

        if r.mansion.disablelasers then
          client.disableMansionLasers(true)
        end

        if r.mansion.disabletraps then
          client.disableMansionTraps(true)
        end

        if r.powerplant.disablelasers then
          client.disablePowerPlantLasers(true)
        end

        if r.powerplant.disablepistons then
          client.disablePowerPlantPistons(true)
        end
    end
end)
