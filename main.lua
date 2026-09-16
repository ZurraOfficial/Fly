local Players          = game:GetService("Players")
local CoreGui          = game:GetService("CoreGui")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera or workspace:WaitForChild("Camera", 5)

local CONFIG = {
    Name = "HALLWAYZ HUB",
    Subtitle = "MAVERICK",
    Version = "v1.0.0",
    KeysURL = "https://raw.githubusercontent.com/ZurraOfficial/Fly/main/keys.txt",
    Developer = {
        TikTok  = "@zurraofficial",
        Discord = "discord.gg/hallwayz",
        YouTube = "@zurraofficial",
        Roblox  = "ZurraOfficial",
    },
    DefaultTheme = "Black Metal",
}

local Icons = {
    Logo = "rbxassetid://132293597304547",
}

local Themes = {
    ["Black Metal"] = { name="Black Metal", BG=Color3.fromRGB(0,0,0), Sidebar=Color3.fromRGB(18,18,18), Card=Color3.fromRGB(26,26,26), CardHover=Color3.fromRGB(38,38,38), Border=Color3.fromRGB(45,45,45), BorderHover=Color3.fromRGB(70,70,70), Text=Color3.fromRGB(230,230,230), TextMuted=Color3.fromRGB(150,150,150), Accent=Color3.fromRGB(192,192,192), AccentDark=Color3.fromRGB(150,150,150), AccentGlow=Color3.fromRGB(220,220,220), Success=Color3.fromRGB(100,200,100), Error=Color3.fromRGB(230,80,80), Warning=Color3.fromRGB(255,200,50), Divider=Color3.fromRGB(35,35,35) },
    Amethyst = { name="Amethyst", BG=Color3.fromRGB(11,11,16), Sidebar=Color3.fromRGB(15,15,22), Card=Color3.fromRGB(20,20,30), CardHover=Color3.fromRGB(26,26,38), Border=Color3.fromRGB(30,30,44), BorderHover=Color3.fromRGB(48,48,66), Text=Color3.fromRGB(232,232,240), TextMuted=Color3.fromRGB(105,105,128), Accent=Color3.fromRGB(150,100,255), AccentDark=Color3.fromRGB(110,70,200), AccentGlow=Color3.fromRGB(180,150,255), Success=Color3.fromRGB(74,222,128), Error=Color3.fromRGB(248,113,113), Warning=Color3.fromRGB(250,204,21), Divider=Color3.fromRGB(26,26,38) },
    Gold = { name="Gold", BG=Color3.fromRGB(14,12,8), Sidebar=Color3.fromRGB(20,17,11), Card=Color3.fromRGB(28,24,15), CardHover=Color3.fromRGB(38,32,20), Border=Color3.fromRGB(45,38,22), BorderHover=Color3.fromRGB(65,55,30), Text=Color3.fromRGB(245,240,225), TextMuted=Color3.fromRGB(140,125,90), Accent=Color3.fromRGB(255,200,60), AccentDark=Color3.fromRGB(210,160,30), AccentGlow=Color3.fromRGB(255,230,150), Success=Color3.fromRGB(180,220,100), Error=Color3.fromRGB(240,100,90), Warning=Color3.fromRGB(255,180,50), Divider=Color3.fromRGB(35,30,18) },
    Ocean = { name="Ocean", BG=Color3.fromRGB(8,12,18), Sidebar=Color3.fromRGB(11,16,25), Card=Color3.fromRGB(15,22,34), CardHover=Color3.fromRGB(20,30,45), Border=Color3.fromRGB(24,36,55), BorderHover=Color3.fromRGB(38,55,80), Text=Color3.fromRGB(225,235,245), TextMuted=Color3.fromRGB(95,115,140), Accent=Color3.fromRGB(60,160,255), AccentDark=Color3.fromRGB(35,120,200), AccentGlow=Color3.fromRGB(130,200,255), Success=Color3.fromRGB(80,220,180), Error=Color3.fromRGB(240,100,100), Warning=Color3.fromRGB(250,200,60), Divider=Color3.fromRGB(20,30,45) },
    Emerald = { name="Emerald", BG=Color3.fromRGB(8,14,11), Sidebar=Color3.fromRGB(11,20,15), Card=Color3.fromRGB(15,27,20), CardHover=Color3.fromRGB(20,36,27), Border=Color3.fromRGB(24,42,32), BorderHover=Color3.fromRGB(36,60,46), Text=Color3.fromRGB(225,245,232), TextMuted=Color3.fromRGB(90,130,108), Accent=Color3.fromRGB(60,220,130), AccentDark=Color3.fromRGB(30,160,90), AccentGlow=Color3.fromRGB(130,255,180), Success=Color3.fromRGB(100,240,150), Error=Color3.fromRGB(240,100,100), Warning=Color3.fromRGB(250,210,60), Divider=Color3.fromRGB(20,34,25) },
    Crimson = { name="Crimson", BG=Color3.fromRGB(14,8,10), Sidebar=Color3.fromRGB(20,11,14), Card=Color3.fromRGB(28,15,19), CardHover=Color3.fromRGB(38,20,26), Border=Color3.fromRGB(45,24,30), BorderHover=Color3.fromRGB(65,35,44), Text=Color3.fromRGB(245,225,228), TextMuted=Color3.fromRGB(140,95,108), Accent=Color3.fromRGB(240,55,80), AccentDark=Color3.fromRGB(190,35,55), AccentGlow=Color3.fromRGB(255,140,160), Success=Color3.fromRGB(90,220,130), Error=Color3.fromRGB(255,100,100), Warning=Color3.fromRGB(255,190,60), Divider=Color3.fromRGB(35,20,25) },
    Rose = { name="Rose", BG=Color3.fromRGB(14,10,14), Sidebar=Color3.fromRGB(20,14,20), Card=Color3.fromRGB(28,20,28), CardHover=Color3.fromRGB(38,26,38), Border=Color3.fromRGB(46,32,46), BorderHover=Color3.fromRGB(66,46,66), Text=Color3.fromRGB(245,228,242), TextMuted=Color3.fromRGB(140,105,135), Accent=Color3.fromRGB(255,120,200), AccentDark=Color3.fromRGB(200,80,155), AccentGlow=Color3.fromRGB(255,180,225), Success=Color3.fromRGB(90,220,140), Error=Color3.fromRGB(245,100,120), Warning=Color3.fromRGB(255,200,80), Divider=Color3.fromRGB(36,25,36) },
    Sunset = { name="Sunset", BG=Color3.fromRGB(15,10,8), Sidebar=Color3.fromRGB(22,14,10), Card=Color3.fromRGB(30,20,14), CardHover=Color3.fromRGB(42,27,18), Border=Color3.fromRGB(50,32,22), BorderHover=Color3.fromRGB(72,46,30), Text=Color3.fromRGB(248,235,225), TextMuted=Color3.fromRGB(150,115,90), Accent=Color3.fromRGB(255,140,60), AccentDark=Color3.fromRGB(210,100,30), AccentGlow=Color3.fromRGB(255,190,130), Success=Color3.fromRGB(150,220,100), Error=Color3.fromRGB(240,100,90), Warning=Color3.fromRGB(255,210,80), Divider=Color3.fromRGB(38,24,16) },
    Mint = { name="Mint", BG=Color3.fromRGB(8,14,14), Sidebar=Color3.fromRGB(11,20,20), Card=Color3.fromRGB(15,27,27), CardHover=Color3.fromRGB(20,36,36), Border=Color3.fromRGB(24,42,42), BorderHover=Color3.fromRGB(36,60,60), Text=Color3.fromRGB(220,245,245), TextMuted=Color3.fromRGB(90,135,135), Accent=Color3.fromRGB(60,220,210), AccentDark=Color3.fromRGB(30,165,160), AccentGlow=Color3.fromRGB(140,255,245), Success=Color3.fromRGB(120,240,180), Error=Color3.fromRGB(240,100,120), Warning=Color3.fromRGB(255,210,100), Divider=Color3.fromRGB(20,34,34) },
    Lavender = { name="Lavender", BG=Color3.fromRGB(12,10,16), Sidebar=Color3.fromRGB(18,15,23), Card=Color3.fromRGB(25,21,32), CardHover=Color3.fromRGB(34,28,43), Border=Color3.fromRGB(42,35,52), BorderHover=Color3.fromRGB(60,50,74), Text=Color3.fromRGB(238,232,248), TextMuted=Color3.fromRGB(125,110,150), Accent=Color3.fromRGB(200,170,255), AccentDark=Color3.fromRGB(155,125,210), AccentGlow=Color3.fromRGB(230,210,255), Success=Color3.fromRGB(120,220,180), Error=Color3.fromRGB(240,110,140), Warning=Color3.fromRGB(255,215,130), Divider=Color3.fromRGB(32,27,42) },
    Ice = { name="Ice", BG=Color3.fromRGB(10,12,14), Sidebar=Color3.fromRGB(14,17,20), Card=Color3.fromRGB(20,24,28), CardHover=Color3.fromRGB(27,33,38), Border=Color3.fromRGB(35,42,48), BorderHover=Color3.fromRGB(50,60,68), Text=Color3.fromRGB(230,240,245), TextMuted=Color3.fromRGB(100,115,130), Accent=Color3.fromRGB(120,220,240), AccentDark=Color3.fromRGB(80,170,200), AccentGlow=Color3.fromRGB(180,240,255), Success=Color3.fromRGB(130,230,180), Error=Color3.fromRGB(240,120,120), Warning=Color3.fromRGB(255,220,130), Divider=Color3.fromRGB(28,34,40) },
    Fire = { name="Fire", BG=Color3.fromRGB(15,8,6), Sidebar=Color3.fromRGB(22,11,8), Card=Color3.fromRGB(30,15,11), CardHover=Color3.fromRGB(42,20,14), Border=Color3.fromRGB(50,24,18), BorderHover=Color3.fromRGB(70,35,25), Text=Color3.fromRGB(250,230,220), TextMuted=Color3.fromRGB(150,100,85), Accent=Color3.fromRGB(255,90,40), AccentDark=Color3.fromRGB(200,60,20), AccentGlow=Color3.fromRGB(255,160,100), Success=Color3.fromRGB(140,210,100), Error=Color3.fromRGB(255,100,90), Warning=Color3.fromRGB(255,200,60), Divider=Color3.fromRGB(40,20,14) },
    Monochrome = { name="Monochrome", BG=Color3.fromRGB(10,10,10), Sidebar=Color3.fromRGB(15,15,15), Card=Color3.fromRGB(22,22,22), CardHover=Color3.fromRGB(30,30,30), Border=Color3.fromRGB(38,38,38), BorderHover=Color3.fromRGB(55,55,55), Text=Color3.fromRGB(235,235,235), TextMuted=Color3.fromRGB(120,120,120), Accent=Color3.fromRGB(255,255,255), AccentDark=Color3.fromRGB(200,200,200), AccentGlow=Color3.fromRGB(240,240,240), Success=Color3.fromRGB(180,220,180), Error=Color3.fromRGB(230,130,130), Warning=Color3.fromRGB(230,210,130), Divider=Color3.fromRGB(30,30,30) },
}

local ThemeOrder = { "Black Metal", "Amethyst", "Gold", "Ocean", "Emerald", "Crimson", "Rose", "Sunset", "Mint", "Lavender", "Ice", "Fire", "Monochrome" }
local Theme = Themes[CONFIG.DefaultTheme]

local function new(c, p)
    local o = Instance.new(c)
    for k, v in pairs(p or {}) do o[k] = v end
    return o
end
local function corner(r, p) return new("UICorner", { CornerRadius = UDim.new(0, r or 8), Parent = p }) end
local function stroke(c, t, p) return new("UIStroke", { Color = c, Thickness = t or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = p }) end
local function tween(o, t, p, s, d)
    local tw = TweenService:Create(o, TweenInfo.new(t, s or Enum.EasingStyle.Quad, d or Enum.EasingDirection.Out), p)
    tw:Play(); return tw
end

local Tracked = { bg = {}, text = {}, stroke = {} }
local function tBG(o, k) table.insert(Tracked.bg, { obj = o, key = k }) end
local function tTX(o, k) table.insert(Tracked.text, { obj = o, key = k }) end
local function tST(o, k) table.insert(Tracked.stroke, { obj = o, key = k }) end

local function applyTheme(name)
    if not Themes[name] then return end
    Theme = Themes[name]
    for _, e in ipairs(Tracked.bg) do
        if e.obj and e.obj.Parent then e.obj.BackgroundColor3 = Theme[e.key] or e.obj.BackgroundColor3 end
    end
    for _, e in ipairs(Tracked.text) do
        if e.obj and e.obj.Parent then e.obj.TextColor3 = Theme[e.key] or e.obj.TextColor3 end
    end
    for _, e in ipairs(Tracked.stroke) do
        if e.obj and e.obj.Parent then e.obj.Color = Theme[e.key] or e.obj.Color end
    end
end

local VI = {}
local function rframe(p, s, pos, c, r, rot)
    local f = new("Frame", { Size = s, Position = pos, BackgroundColor3 = c, BorderSizePixel = 0, Rotation = rot or 0, Parent = p })
    corner(r or 2, f)
    return f
end
function VI.Info(p, c)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = p })
    rframe(h, UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), c, 100)
    rframe(h, UDim2.new(1,-4,1,-4), UDim2.new(0,2,0,2), Theme.Card, 100)
    rframe(h, UDim2.new(0,2,0,2), UDim2.new(0.5,-1,0,3), c, 1)
    rframe(h, UDim2.new(0,2,0,6), UDim2.new(0.5,-1,0,7), c, 1)
    return h
end
function VI.Fly(p, c)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = p })
    rframe(h, UDim2.new(0,14,0,3), UDim2.new(0,2,0,3), c, 3, -22)
    rframe(h, UDim2.new(0,12,0,3), UDim2.new(0,2,0,8), c, 3, -12)
    rframe(h, UDim2.new(0,9,0,3), UDim2.new(0,2,0,13), c, 3, 0)
    rframe(h, UDim2.new(0,2,0,2), UDim2.new(0,16,0,2), c, 1)
    return h
end
function VI.Palette(p, c)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = p })
    rframe(h, UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), c, 100)
    rframe(h, UDim2.new(1,-3,1,-3), UDim2.new(0,1.5,0,1.5), Theme.Card, 100)
    rframe(h, UDim2.new(0,4,0,4), UDim2.new(0,3,0,3), c, 4)
    rframe(h, UDim2.new(0,4,0,4), UDim2.new(1,-7,0,3), c, 4)
    rframe(h, UDim2.new(0,4,0,4), UDim2.new(0,3,1,-7), c, 4)
    rframe(h, UDim2.new(0,4,0,4), UDim2.new(1,-7,1,-7), c, 4)
    return h
end
function VI.Speed(p, c)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = p })
    rframe(h, UDim2.new(0,16,0,2), UDim2.new(0,0,0,4), c, 1)
    rframe(h, UDim2.new(0,11,0,2), UDim2.new(0,0,0,8), c, 1)
    rframe(h, UDim2.new(0,16,0,2), UDim2.new(0,0,0,12), c, 1)
    rframe(h, UDim2.new(0,5,0,1), UDim2.new(1,-6,0,8), c, 1, -35)
    return h
end
function VI.Key(p, c)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = p })
    local head = rframe(h, UDim2.new(0,9,0,9), UDim2.new(0,0,0,3), c, 100)
    rframe(head, UDim2.new(0,3,0,3), UDim2.new(0.5,-1.5,0.5,-1.5), Theme.Card, 100)
    rframe(h, UDim2.new(0,9,0,2), UDim2.new(0,8,0,7), c, 1)
    rframe(h, UDim2.new(0,2,0,4), UDim2.new(0,12,0,7), c, 1)
    rframe(h, UDim2.new(0,2,0,3), UDim2.new(0,15,0,7), c, 1)
    return h
end
function VI.Close(p, c)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = p })
    rframe(h, UDim2.new(0,12,0,2.5), UDim2.new(0,1,0,5.7), c, 2, 45)
    rframe(h, UDim2.new(0,12,0,2.5), UDim2.new(0,1,0,5.7), c, 2, -45)
    return h
end
function VI.Minimize(p, c)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = p })
    rframe(h, UDim2.new(0,12,0,2.5), UDim2.new(0,1,0,6.7), c, 2)
    return h
end
function VI.Check(p, c)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = p })
    rframe(h, UDim2.new(0,7,0,2.5), UDim2.new(0,1,0,7), c, 2, 45)
    rframe(h, UDim2.new(0,12,0,2.5), UDim2.new(0,4,0,5), c, 2, -45)
    return h
end

local function makeIcon(parent, key, fb, color)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    local link = Icons[key]
    if link and link ~= "" and link:find("rbxassetid://") then
        new("ImageLabel", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Image = link, ImageColor3 = color or Theme.Text, Parent = h })
    else
        local fn = VI[fb]
        if fn then fn(h, color or Theme.Text) end
    end
    return h
end

local function buildLogo(parent, size)
    size = size or 30
    local h = new("Frame", { Size = UDim2.new(0, size, 0, size), BackgroundTransparency = 1, Parent = parent })
    local link = Icons.Logo
    if link and link ~= "" and link:find("rbxassetid://") then
        new("ImageLabel", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Image = link, Parent = h })
        return h
    end
    local sk = size / 32
    rframe(h, UDim2.new(0, 8*sk, 0, 13*sk), UDim2.new(0, 6*sk, 0, 3*sk), Theme.Accent, 1, 20)
    rframe(h, UDim2.new(0, 8*sk, 0, 13*sk), UDim2.new(0, 6*sk, 0, 16*sk), Theme.Accent, 1, 20)
    rframe(h, UDim2.new(0, 9*sk, 0, 26*sk), UDim2.new(0, 17*sk, 0, 3*sk), Theme.Accent, 1, 20)
    rframe(h, UDim2.new(0, 11*sk, 0, 2*sk), UDim2.new(0, 7*sk, 0, 15*sk), Theme.AccentGlow, 1, -25)
    return h
end

local FPSModule = { value = 60, listeners = {}, samples = {} }
task.spawn(function()
    while true do
        local t = tick()
        RunService.RenderStepped:Wait()
        local d = tick() - t
        if d > 0 then
            table.insert(FPSModule.samples, 1/d)
            if #FPSModule.samples > 30 then table.remove(FPSModule.samples) end
            local sum = 0
            for _, v in ipairs(FPSModule.samples) do sum = sum + v end
            local avg = sum / #FPSModule.samples
            if math.abs(avg - FPSModule.value) > 0.5 then
                FPSModule.value = math.floor(avg + 0.5)
                for _, cb in pairs(FPSModule.listeners) do pcall(cb, FPSModule.value) end
            end
        end
    end
end)

local ThumbCache = {}
local function getHeadshot(uid)
    if ThumbCache[uid] then return ThumbCache[uid] end
    local url = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(uid) .. "&w=150&h=150"
    ThumbCache[uid] = url
    return url
end

FLYING = false
QEfly = true
iyflyspeed = 1
vehicleflyspeed = 1

function sFLY(vfly)
    local plr = Players.LocalPlayer
    local char = plr.Character or plr.CharacterAdded:Wait()
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        repeat task.wait() until char:FindFirstChildOfClass("Humanoid")
        humanoid = char:FindFirstChildOfClass("Humanoid")
    end
    if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
    local T = humanoid.RootPart
    local CONTROL = {F=0, B=0, L=0, R=0, Q=0, E=0}
    local lCONTROL = {F=0, B=0, L=0, R=0, Q=0, E=0}
    local SPEED = 0
    local function FLY()
        FLYING = true
        local BG = Instance.new('BodyGyro')
        local BV = Instance.new('BodyVelocity')
        BG.P = 9e4; BG.Parent = T
        BV.Parent = T
        BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        BG.CFrame = T.CFrame
        BV.Velocity = Vector3.new(0, 0, 0)
        BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        task.spawn(function()
            repeat task.wait()
                local camera = workspace.CurrentCamera
                if not vfly and humanoid then humanoid.PlatformStand = true end
                if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                    SPEED = 50
                elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
                    SPEED = 0
                end
                if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
                    BV.Velocity = ((camera.CFrame.LookVector * (CONTROL.F + CONTROL.B)) + ((camera.CFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - camera.CFrame.p)) * SPEED
                    lCONTROL = {F=CONTROL.F, B=CONTROL.B, L=CONTROL.L, R=CONTROL.R}
                elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
                    BV.Velocity = ((camera.CFrame.LookVector * (lCONTROL.F + lCONTROL.B)) + ((camera.CFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - camera.CFrame.p)) * SPEED
                else
                    BV.Velocity = Vector3.new(0, 0, 0)
                end
                BG.CFrame = camera.CFrame
            until not FLYING
            CONTROL = {F=0, B=0, L=0, R=0, Q=0, E=0}
            lCONTROL = {F=0, B=0, L=0, R=0, Q=0, E=0}
            SPEED = 0
            BG:Destroy(); BV:Destroy()
            if humanoid then humanoid.PlatformStand = false end
        end)
    end
    flyKeyDown = UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.W then CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
        elseif input.KeyCode == Enum.KeyCode.S then CONTROL.B = -(vfly and vehicleflyspeed or iyflyspeed)
        elseif input.KeyCode == Enum.KeyCode.A then CONTROL.L = -(vfly and vehicleflyspeed or iyflyspeed)
        elseif input.KeyCode == Enum.KeyCode.D then CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
        elseif input.KeyCode == Enum.KeyCode.E and QEfly then CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
        elseif input.KeyCode == Enum.KeyCode.Q and QEfly then CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
        end
        pcall(function() Camera.CameraType = Enum.CameraType.Track end)
    end)
    flyKeyUp = UserInputService.InputEnded:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.W then CONTROL.F = 0
        elseif input.KeyCode == Enum.KeyCode.S then CONTROL.B = 0
        elseif input.KeyCode == Enum.KeyCode.A then CONTROL.L = 0
        elseif input.KeyCode == Enum.KeyCode.D then CONTROL.R = 0
        elseif input.KeyCode == Enum.KeyCode.E then CONTROL.Q = 0
        elseif input.KeyCode == Enum.KeyCode.Q then CONTROL.E = 0
        end
    end)
    FLY()
end

function NOFLY()
    FLYING = false
    if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
    if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
        Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
    end
    pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

local function tryClipboard()
    local funcs = {
        function() return getclipboard() end,
        function() return game:GetService("GuiService"):GetClipboard() end,
        function() return tostring(getclipboard()) end,
        function() return tostring(clipboard) end,
    }
    for _, fn in ipairs(funcs) do
        local ok, res = pcall(fn)
        if ok and res and res ~= "" and tostring(res) ~= "nil" and tostring(res) ~= "Nil" then
            return tostring(res)
        end
    end
    return nil
end

local function fetchValidKeys()
    if not CONFIG.KeysURL or CONFIG.KeysURL == "" then return {} end
    local ok, result = pcall(game.HttpGet, game, CONFIG.KeysURL, true)
    if not ok or not result then return {} end
    local keys = {}
    for line in result:gmatch("[^\r\n]+") do
        line = line:gsub("%s+", "")
        if line ~= "" and not line:match("^#") then keys[line:lower()] = true end
    end
    return keys
end

local function validateKey(inputKey)
    if not inputKey or inputKey == "" then return false, "Key required" end
    local vk = fetchValidKeys()
    if vk[inputKey:lower()] then return true, "Key valid" end
    return false, "Invalid key"
end

pcall(function()
    for _, obj in pairs(CoreGui:GetChildren()) do
        if obj.Name == "HallwayzUI" then obj:Destroy() end
    end
end)

local ScreenGui = new("ScreenGui", {
    Name = "HallwayzUI",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    IgnoreGuiInset = true,
    DisplayOrder = 999,
})
local okCore = pcall(function() ScreenGui.Parent = CoreGui end)
if not okCore or not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local ToastContainer = new("Frame", {
    Size = UDim2.new(0, 300, 1, -40),
    Position = UDim2.new(1, -320, 0, 20),
    BackgroundTransparency = 1,
    Parent = ScreenGui,
})
new("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Top,
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    Parent = ToastContainer,
})

local function showToast(title, desc, kind)
    kind = kind or "info"
    local color = Theme.Accent
    if kind == "success" then color = Theme.Success
    elseif kind == "error" then color = Theme.Error
    elseif kind == "warning" then color = Theme.Warning end

    local toast = new("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundColor3 = Theme.Card,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = ToastContainer,
    })
    tBG(toast, "Card")
    corner(10, toast)
    local ts = stroke(Theme.Border, 1, toast)
    tST(ts, "Border")

    new("Frame", { Size = UDim2.new(0, 4, 1, 0), BackgroundColor3 = color, BorderSizePixel = 0, Parent = toast })
        :FindFirstChildOfClass("Frame") or corner(2, new("Frame", { Size = UDim2.new(0, 4, 1, 0), BackgroundColor3 = color, BorderSizePixel = 0, Parent = toast }))
    local bar = new("Frame", { Size = UDim2.new(0, 4, 1, 0), BackgroundColor3 = color, BorderSizePixel = 0, Parent = toast })
    corner(2, bar)

    local iconBox = new("Frame", { Size = UDim2.new(0, 22, 0, 22), Position = UDim2.new(0, 16, 0, 14), BackgroundTransparency = 1, Parent = toast })
    if kind == "success" then VI.Check(iconBox, color)
    elseif kind == "error" then VI.Close(iconBox, color)
    else VI.Info(iconBox, color) end

    local titleLbl = new("TextLabel", {
        Size = UDim2.new(1, -56, 0, 18), Position = UDim2.new(0, 46, 0, 12),
        BackgroundTransparency = 1, Text = title, TextColor3 = Theme.Text,
        TextSize = 13, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = toast,
    })
    tTX(titleLbl, "Text")

    local descLbl = new("TextLabel", {
        Size = UDim2.new(1, -56, 0, 32), Position = UDim2.new(0, 46, 0, 30),
        BackgroundTransparency = 1, Text = desc, TextColor3 = Theme.TextMuted,
        TextSize = 10, Font = Enum.Font.Gotham, TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
        Parent = toast,
    })
    tTX(descLbl, "TextMuted")

    local progBg = new("Frame", {
        Size = UDim2.new(1, -20, 0, 2), Position = UDim2.new(0, 10, 1, -6),
        BackgroundColor3 = Theme.Border, BorderSizePixel = 0, Parent = toast,
    })
    corner(100, progBg)
    local progFill = new("Frame", { Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = color, BorderSizePixel = 0, Parent = progBg })
    corner(100, progFill)

    tween(toast, 0.4, { Size = UDim2.new(1, 0, 0, 72), BackgroundTransparency = 0 }, Enum.EasingStyle.Back)
    tween(progFill, 3.2, { Size = UDim2.new(0, 0, 1, 0) }, Enum.EasingStyle.Linear)

    task.delay(3.4, function()
        if toast and toast.Parent then
            tween(toast, 0.3, { Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1 })
            task.wait(0.35)
            if toast then toast:Destroy() end
        end
    end)
end

local function showConfirm(title, desc, onConfirm, onCancel)
    local overlay = new("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BackgroundTransparency = 0.5, BorderSizePixel = 0, ZIndex = 100,
        Parent = ScreenGui,
    })
    local card = new("Frame", {
        Size = UDim2.new(0, 340, 0, 170),
        Position = UDim2.new(0.5, -170, 0.5, -85),
        BackgroundColor3 = Theme.BG, BorderSizePixel = 0, ZIndex = 101,
        Parent = overlay,
    })
    tBG(card, "BG")
    corner(14, card)
    local cs = stroke(Theme.Border, 1, card)
    tST(cs, "Border")

    local t = new("TextLabel", {
        Size = UDim2.new(1, -32, 0, 24), Position = UDim2.new(0, 16, 0, 18),
        BackgroundTransparency = 1, Text = title, TextColor3 = Theme.Text,
        TextSize = 15, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 102, Parent = card,
    })
    tTX(t, "Text")
    local d = new("TextLabel", {
        Size = UDim2.new(1, -32, 0, 40), Position = UDim2.new(0, 16, 0, 46),
        BackgroundTransparency = 1, Text = desc, TextColor3 = Theme.TextMuted,
        TextSize = 11, Font = Enum.Font.Gotham, TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
        ZIndex = 102, Parent = card,
    })
    tTX(d, "TextMuted")

    local cb = new("TextButton", {
        Size = UDim2.new(0, 140, 0, 36), Position = UDim2.new(0, 16, 1, -52),
        BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Text = "Cancel",
        TextColor3 = Theme.Text, TextSize = 12, Font = Enum.Font.GothamBlack,
        ZIndex = 102, Parent = card,
    })
    tBG(cb, "Card"); tTX(cb, "Text"); corner(8, cb)
    local confirm = new("TextButton", {
        Size = UDim2.new(0, 140, 0, 36), Position = UDim2.new(1, -156, 1, -52),
        BackgroundColor3 = Theme.Error, BorderSizePixel = 0, Text = "Confirm",
        TextColor3 = Color3.fromRGB(255,255,255), TextSize = 12,
        Font = Enum.Font.GothamBlack, ZIndex = 102, Parent = card,
    })
    corner(8, confirm)

    card.Size = UDim2.new(0, 0, 0, 0)
    card.Position = UDim2.new(0.5, 0, 0.5, 0)
    tween(card, 0.4, { Size = UDim2.new(0, 340, 0, 170), Position = UDim2.new(0.5, -170, 0.5, -85) }, Enum.EasingStyle.Back)

    local function close(fn)
        tween(card, 0.25, { Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 1 })
        tween(overlay, 0.25, { BackgroundTransparency = 1 })
        task.wait(0.28)
        overlay:Destroy()
        if fn then fn() end
    end
    confirm.MouseButton1Click:Connect(function() close(onConfirm) end)
    cb.MouseButton1Click:Connect(function() close(onCancel) end)
end

local function buildKeyUI(onSuccess)
    local Dim = new("Frame", {
        Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.5, BorderSizePixel = 0, Parent = ScreenGui,
    })

    local KeyCard = new("Frame", {
        Size = UDim2.new(0, 380, 0, 290), Position = UDim2.new(0.5, -190, 0.5, -145),
        BackgroundColor3 = Theme.BG, BorderSizePixel = 0, Parent = Dim,
    })
    tBG(KeyCard, "BG")
    corner(14, KeyCard)
    local kst = stroke(Theme.Border, 1, KeyCard)
    tST(kst, "Border")

    local glow = new("UIStroke", { Color = Theme.Accent, Thickness = 1.5, Transparency = 0.7, Parent = KeyCard })
    tST(glow, "Accent")
    task.spawn(function()
        while KeyCard.Parent do
            tween(glow, 2, { Transparency = 0.2 }); task.wait(2)
            tween(glow, 2, { Transparency = 0.85 }); task.wait(2)
        end
    end)

    local uk = new("UIScale", { Scale = 1, Parent = KeyCard })
    local function updScale()
        local cam = workspace.CurrentCamera; if not cam then return end
        local vp = cam.ViewportSize
        uk.Scale = math.min((vp.X * 0.9) / 380, (vp.Y * 0.9) / 290, 1)
    end
    updScale()
    if workspace.CurrentCamera then
        workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updScale)
    end

    local Header = new("Frame", {
        Size = UDim2.new(1, 0, 0, 64), BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0, Parent = KeyCard,
    })
    tBG(Header, "Sidebar")
    corner(14, Header)
    local hf = new("Frame", { Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 1, -14), BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = Header })
    tBG(hf, "Sidebar")

    local lh = new("Frame", { Size = UDim2.new(0, 32, 0, 32), Position = UDim2.new(0, 16, 0.5, -16), BackgroundTransparency = 1, Parent = Header })
    buildLogo(lh, 32)

    local kt = new("TextLabel", {
        Size = UDim2.new(1, -70, 0, 18), Position = UDim2.new(0, 58, 0, 12),
        BackgroundTransparency = 1, Text = CONFIG.Name .. " " .. CONFIG.Version,
        TextColor3 = Theme.Text, TextSize = 14, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = Header,
    })
    tTX(kt, "Text")
    local ks = new("TextLabel", {
        Size = UDim2.new(1, -70, 0, 14), Position = UDim2.new(0, 58, 0, 33),
        BackgroundTransparency = 1, Text = CONFIG.Subtitle, TextColor3 = Theme.TextMuted,
        TextSize = 10, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = Header,
    })
    tTX(ks, "TextMuted")

    local keyClose = new("TextButton", {
        Size = UDim2.new(0, 26, 0, 26), Position = UDim2.new(1, -38, 0, 19),
        BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Text = "", Parent = Header,
    })
    tBG(keyClose, "Card")
    corner(6, keyClose)
    local kch = new("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0.5, -7, 0.5, -7), BackgroundTransparency = 1, Parent = keyClose })
    makeIcon(kch, "Close", "Close", Theme.TextMuted)
    keyClose.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    local Body = new("Frame", {
        Size = UDim2.new(1, -28, 1, -84), Position = UDim2.new(0, 14, 0, 80),
        BackgroundTransparency = 1, Parent = KeyCard,
    })

    local khint = new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 16), BackgroundTransparency = 1,
        Text = "Enter key to continue", TextColor3 = Theme.Text,
        TextSize = 11, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = Body,
    })
    tTX(khint, "Text")

    local InputBox = new("Frame", {
        Size = UDim2.new(1, 0, 0, 40), Position = UDim2.new(0, 0, 0, 24),
        BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = Body,
    })
    tBG(InputBox, "Card")
    corner(8, InputBox)
    local is = stroke(Theme.Border, 1, InputBox)
    tST(is, "Border")

    local ki = new("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 12, 0.5, -7), BackgroundTransparency = 1, Parent = InputBox })
    makeIcon(ki, "Key", "Key", Theme.TextMuted)

    local KeyInput = new("TextBox", {
        Size = UDim2.new(1, -102, 1, 0), Position = UDim2.new(0, 34, 0, 0),
        BackgroundTransparency = 1, Text = "", PlaceholderText = "XXXX-XXXX-XXXX-XXXX",
        PlaceholderColor3 = Theme.TextMuted, TextColor3 = Theme.Text,
        TextSize = 12, Font = Enum.Font.Code, ClearTextOnFocus = false,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = InputBox,
    })
    tTX(KeyInput, "Text")

    local pasteBtn = new("TextButton", {
        Size = UDim2.new(0, 52, 0, 26), Position = UDim2.new(1, -58, 0.5, -13),
        BackgroundColor3 = Theme.CardHover, BorderSizePixel = 0,
        Text = "Paste", TextColor3 = Theme.Text, TextSize = 10,
        Font = Enum.Font.GothamBold, Parent = InputBox,
    })
    tBG(pasteBtn, "CardHover"); tTX(pasteBtn, "Text"); corner(6, pasteBtn)

    pasteBtn.MouseButton1Click:Connect(function()
        local clip = tryClipboard()
        if clip then
            KeyInput.Text = clip
        else
            showToast("Paste Failed", "Clipboard tidak bisa dibaca", "error")
        end
    end)

    local StatusLabel = new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 16), Position = UDim2.new(0, 0, 0, 74),
        BackgroundTransparency = 1, Text = "", TextColor3 = Theme.TextMuted,
        TextSize = 10, Font = Enum.Font.Gotham, Parent = Body,
    })
    tTX(StatusLabel, "TextMuted")

    local verifyBtn = new("TextButton", {
        Size = UDim2.new(1, 0, 0, 42), Position = UDim2.new(0, 0, 0, 96),
        BackgroundColor3 = Theme.Accent, BorderSizePixel = 0,
        Text = "VERIFY", TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 12, Font = Enum.Font.GothamBlack, Parent = Body,
    })
    tBG(verifyBtn, "Accent")
    corner(8, verifyBtn)

    local function submit()
        local key = KeyInput.Text
        if key == "" then
            StatusLabel.Text = "Key required"
            StatusLabel.TextColor3 = Theme.Error
            showToast("Verify", "Key tidak boleh kosong", "error")
            return
        end
        StatusLabel.Text = "Verifying..."
        StatusLabel.TextColor3 = Theme.Warning
        verifyBtn.Text = "..."
        task.wait(0.4)
        local valid, msg = validateKey(key)
        if valid then
            StatusLabel.Text = msg
            StatusLabel.TextColor3 = Theme.Success
            showToast("Success", "Key valid, welcome!", "success")
            task.wait(0.55)
            tween(Dim, 0.3, { BackgroundTransparency = 1 })
            tween(KeyCard, 0.3, { BackgroundTransparency = 1, Size = UDim2.new(0,0,0,0), Position = UDim2.new(0.5,0,0.5,0) })
            task.wait(0.3)
            Dim:Destroy()
            onSuccess()
        else
            StatusLabel.Text = msg
            StatusLabel.TextColor3 = Theme.Error
            verifyBtn.Text = "VERIFY"
            showToast("Verify Failed", msg, "error")
        end
    end
    verifyBtn.MouseButton1Click:Connect(submit)
    KeyInput.FocusLost:Connect(function(enter) if enter then submit() end end)
end

local function buildMainUI()
    local Main = new("Frame", {
        Size = UDim2.new(0, 620, 0, 420),
        Position = UDim2.new(0.5, -310, 0.5, -210),
        BackgroundColor3 = Theme.BG, BorderSizePixel = 0, Parent = ScreenGui,
    })
    tBG(Main, "BG")
    corner(14, Main)
    local mst = stroke(Theme.Border, 1, Main)
    tST(mst, "Border")

    local mScale = new("UIScale", { Scale = 1, Parent = Main })
    local function upd()
        local cam = workspace.CurrentCamera; if not cam then return end
        local vp = cam.ViewportSize
        mScale.Scale = math.min((vp.X * 0.9) / 620, (vp.Y * 0.9) / 420, 1)
    end
    upd()
    if workspace.CurrentCamera then
        workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(upd)
    end

    Main.BackgroundTransparency = 1
    local entranceScale = new("UIScale", { Scale = 0.7, Parent = Main })
    tween(Main, 0.5, { BackgroundTransparency = 0 }, Enum.EasingStyle.Quart)
    tween(entranceScale, 0.55, { Scale = 1 }, Enum.EasingStyle.Back)
    task.delay(0.5, function() if entranceScale then entranceScale:Destroy() end end)

    local dragging, dragStart, startPos = false, nil, nil
    local dragArea = new("Frame", { Size = UDim2.new(1, 0, 0, 50), BackgroundTransparency = 1, Parent = Main })
    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)

    local Sidebar = new("Frame", {
        Size = UDim2.new(0, 160, 1, 0), BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0, Parent = Main,
    })
    tBG(Sidebar, "Sidebar")
    corner(14, Sidebar)
    local sbf = new("Frame", { Size = UDim2.new(0, 14, 1, 0), Position = UDim2.new(1, -14, 0, 0), BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = Sidebar })
    tBG(sbf, "Sidebar")

    local brand = new("Frame", { Size = UDim2.new(1, 0, 0, 60), BackgroundTransparency = 1, Parent = Sidebar })
    local bl = new("Frame", { Size = UDim2.new(0, 32, 0, 32), Position = UDim2.new(0, 14, 0.5, -16), BackgroundTransparency = 1, Parent = brand })
    buildLogo(bl, 32)

    local bt = new("TextLabel", {
        Size = UDim2.new(1, -60, 0, 18), Position = UDim2.new(0, 54, 0, 14),
        BackgroundTransparency = 1, Text = CONFIG.Name, TextColor3 = Theme.Text,
        TextSize = 14, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = brand,
    })
    tTX(bt, "Text")
    local bsub = new("TextLabel", {
        Size = UDim2.new(1, -60, 0, 14), Position = UDim2.new(0, 54, 0, 32),
        BackgroundTransparency = 1, Text = CONFIG.Subtitle, TextColor3 = Theme.TextMuted,
        TextSize = 9, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = brand,
    })
    tTX(bsub, "TextMuted")

    local div = new("Frame", {
        Size = UDim2.new(1, -24, 0, 1), Position = UDim2.new(0, 12, 0, 60),
        BackgroundColor3 = Theme.Divider, BorderSizePixel = 0, Parent = Sidebar,
    })
    tBG(div, "Divider")

    local ListFrame = new("ScrollingFrame", {
        Size = UDim2.new(1, -12, 1, -60 - 130), Position = UDim2.new(0, 6, 0, 64),
        BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0,0,0,0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = Sidebar,
    })
    new("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, Parent = ListFrame })

    local StatusBox = new("Frame", {
        Size = UDim2.new(1, -16, 0, 56), Position = UDim2.new(0, 8, 1, -64),
        BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = Sidebar,
    })
    tBG(StatusBox, "Card")
    corner(8, StatusBox)
    local sbs = stroke(Theme.Border, 1, StatusBox)
    tST(sbs, "Border")

    local fpsLabel = new("TextLabel", {
        Size = UDim2.new(1, -16, 0, 16), Position = UDim2.new(0, 12, 0, 8),
        BackgroundTransparency = 1, Text = "FPS: --", TextColor3 = Theme.Accent,
        TextSize = 12, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = StatusBox,
    })
    tTX(fpsLabel, "Accent")

    local nameLbl = new("TextLabel", {
        Size = UDim2.new(1, -16, 0, 14), Position = UDim2.new(0, 12, 0, 26),
        BackgroundTransparency = 1, Text = LocalPlayer.DisplayName, TextColor3 = Theme.Text,
        TextSize = 11, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = StatusBox,
    })
    tTX(nameLbl, "Text")

    local userLbl = new("TextLabel", {
        Size = UDim2.new(1, -16, 0, 12), Position = UDim2.new(0, 12, 0, 40),
        BackgroundTransparency = 1, Text = "@" .. LocalPlayer.Name, TextColor3 = Theme.TextMuted,
        TextSize = 9, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = StatusBox,
    })
    tTX(userLbl, "TextMuted")

    FPSModule.listeners[#FPSModule.listeners + 1] = function(v)
        fpsLabel.Text = "FPS: " .. v
        if v >= 55 then fpsLabel.TextColor3 = Theme.Success
        elseif v >= 30 then fpsLabel.TextColor3 = Theme.Warning
        else fpsLabel.TextColor3 = Theme.Error end
    end

    local Content = new("Frame", {
        Size = UDim2.new(1, -160, 1, 0), Position = UDim2.new(0, 160, 0, 0),
        BackgroundTransparency = 1, Parent = Main,
    })

    local TopBar = new("Frame", { Size = UDim2.new(1, 0, 0, 54), BackgroundTransparency = 1, Parent = Content })

    local pageTitle = new("TextLabel", {
        Size = UDim2.new(0, 260, 0, 18), Position = UDim2.new(0, 18, 0, 12),
        BackgroundTransparency = 1, Text = "Info", TextColor3 = Theme.Text,
        TextSize = 14, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = TopBar,
    })
    tTX(pageTitle, "Text")
    local pageSub = new("TextLabel", {
        Size = UDim2.new(0, 340, 0, 14), Position = UDim2.new(0, 18, 0, 30),
        BackgroundTransparency = 1, Text = "Server & developer info",
        TextColor3 = Theme.TextMuted, TextSize = 10, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = TopBar,
    })
    tTX(pageSub, "TextMuted")

    local function winBtn(iconKey, fb, xOff)
        local b = new("TextButton", {
            Size = UDim2.new(0, 26, 0, 26), Position = UDim2.new(1, xOff, 0, 14),
            BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Text = "", Parent = TopBar,
        })
        tBG(b, "Card")
        corner(6, b)
        local h = new("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0.5, -7, 0.5, -7), BackgroundTransparency = 1, Parent = b })
        makeIcon(h, iconKey, fb, Theme.TextMuted)
        b.MouseEnter:Connect(function() tween(b, 0.12, { BackgroundColor3 = Theme.CardHover }) end)
        b.MouseLeave:Connect(function() tween(b, 0.12, { BackgroundColor3 = Theme.Card }) end)
        return b
    end

    local minBtn = winBtn("Minimize", "Minimize", -64)
    local closeBtn = winBtn("Close", "Close", -34)

    local floatingIcon = nil
    local floatingSavedPos = UDim2.new(0, 20, 0.5, -24)
    local isMinimized = false

    local function minimize()
        if isMinimized then return end
        isMinimized = true

        tween(Main, 0.35, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1,
        }, Enum.EasingStyle.Back)

        if floatingIcon then floatingIcon:Destroy() end

        floatingIcon = new("TextButton", {
            Size = UDim2.new(0, 0, 0, 0),
            Position = floatingSavedPos,
            BackgroundColor3 = Theme.Card,
            BorderSizePixel = 0,
            Text = "",
            ZIndex = 200,
            Parent = ScreenGui,
        })
        corner(24, floatingIcon)
        stroke(Theme.Border, 1, floatingIcon)
        local glowStroke = new("UIStroke", { Color = Theme.Accent, Thickness = 1.5, Transparency = 0.7, Parent = floatingIcon })
        task.spawn(function()
            while floatingIcon and floatingIcon.Parent do
                tween(glowStroke, 2, { Transparency = 0.2 }); task.wait(2)
                tween(glowStroke, 2, { Transparency = 0.85 }); task.wait(2)
            end
        end)
        local lh = new("Frame", { Size = UDim2.new(0, 28, 0, 28), Position = UDim2.new(0.5, -14, 0.5, -14), BackgroundTransparency = 1, Parent = floatingIcon })
        buildLogo(lh, 28)

        tween(floatingIcon, 0.4, { Size = UDim2.new(0, 48, 0, 48) }, Enum.EasingStyle.Back)

        local fdrag, fStart, fPos = false, nil, nil
        floatingIcon.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                fdrag = true; fStart = input.Position; fPos = floatingIcon.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then fdrag = false end
                end)
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if fdrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local d = input.Position - fStart
                floatingIcon.Position = UDim2.new(fPos.X.Scale, fPos.X.Offset + d.X, fPos.Y.Scale, fPos.Y.Offset + d.Y)
                floatingSavedPos = floatingIcon.Position
            end
        end)

        floatingIcon.MouseButton1Click:Connect(function()
            if isMinimized and not fdrag then
                floatingSavedPos = floatingIcon.Position
                tween(Main, 0.4, {
                    Size = UDim2.new(0, 620, 0, 420),
                    Position = UDim2.new(0.5, -310, 0.5, -210),
                    BackgroundTransparency = 0,
                }, Enum.EasingStyle.Back)
                tween(floatingIcon, 0.3, { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 })
                task.wait(0.32)
                if floatingIcon then floatingIcon:Destroy() floatingIcon = nil end
                isMinimized = false
            end
        end)
    end

    minBtn.MouseButton1Click:Connect(minimize)
    closeBtn.MouseButton1Click:Connect(function()
        showConfirm("Close Script", "Apakah kamu yakin ingin menutup Hallwayz Hub?", function()
            NOFLY()
            ScreenGui:Destroy()
        end)
    end)

    local cdiv = new("Frame", {
        Size = UDim2.new(1, -28, 0, 1), Position = UDim2.new(0, 14, 0, 54),
        BackgroundColor3 = Theme.Divider, BorderSizePixel = 0, Parent = Content,
    })
    tBG(cdiv, "Divider")

    local Pages = new("Frame", {
        Size = UDim2.new(1, -20, 1, -62), Position = UDim2.new(0, 10, 0, 60),
        BackgroundTransparency = 1, Parent = Content,
    })

    local PageInfo = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = Pages })

    local InfoScroll = new("ScrollingFrame", {
        Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, BorderSizePixel = 0,
        ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.Border,
        CanvasSize = UDim2.new(0,0,0,0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = PageInfo,
    })
    new("UIPadding", { PaddingTop = UDim.new(0,6), PaddingLeft = UDim.new(0,6), PaddingRight = UDim.new(0,6), PaddingBottom = UDim.new(0,6), Parent = InfoScroll })
    new("UIListLayout", { Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder, Parent = InfoScroll })

    local ProfileCard = new("Frame", {
        Size = UDim2.new(1, 0, 0, 96), BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0, LayoutOrder = 1, Parent = InfoScroll,
    })
    tBG(ProfileCard, "Card")
    corner(12, ProfileCard)
    local pcs = stroke(Theme.Border, 1, ProfileCard)
    tST(pcs, "Border")

    local avFrame = new("Frame", {
        Size = UDim2.new(0, 64, 0, 64), Position = UDim2.new(0, 16, 0.5, -32),
        BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = ProfileCard,
    })
    tBG(avFrame, "Sidebar")
    corner(32, avFrame)
    local avImg = new("ImageLabel", {
        Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1,
        Image = getHeadshot(LocalPlayer.UserId), Parent = avFrame,
    })
    corner(32, avImg)

    local dn = new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 20), Position = UDim2.new(0, 96, 0, 18),
        BackgroundTransparency = 1, Text = LocalPlayer.DisplayName, TextColor3 = Theme.Text,
        TextSize = 15, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = ProfileCard,
    })
    tTX(dn, "Text")
    local un = new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 14), Position = UDim2.new(0, 96, 0, 40),
        BackgroundTransparency = 1, Text = "@" .. LocalPlayer.Name, TextColor3 = Theme.TextMuted,
        TextSize = 11, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = ProfileCard,
    })
    tTX(un, "TextMuted")
    local uid = new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 14), Position = UDim2.new(0, 96, 0, 58),
        BackgroundTransparency = 1, Text = "User ID: " .. LocalPlayer.UserId,
        TextColor3 = Theme.Accent, TextSize = 10, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = ProfileCard,
    })
    tTX(uid, "Accent")

    local PlayersCard = new("Frame", {
        Size = UDim2.new(1, 0, 0, 320), BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0, LayoutOrder = 2, Parent = InfoScroll,
    })
    tBG(PlayersCard, "Card")
    corner(12, PlayersCard)
    local plcs = stroke(Theme.Border, 1, PlayersCard)
    tST(plcs, "Border")

    local plT = new("TextLabel", {
        Size = UDim2.new(1, -24, 0, 20), Position = UDim2.new(0, 16, 0, 14),
        BackgroundTransparency = 1, Text = "Players in Server", TextColor3 = Theme.Text,
        TextSize = 13, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = PlayersCard,
    })
    tTX(plT, "Text")
    local plC = new("TextLabel", {
        Size = UDim2.new(0, 100, 0, 20), Position = UDim2.new(1, -116, 0, 14),
        BackgroundTransparency = 1, Text = "0 / 0", TextColor3 = Theme.Accent,
        TextSize = 12, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Right, Parent = PlayersCard,
    })
    tTX(plC, "Accent")

    local PlayerList = new("ScrollingFrame", {
        Size = UDim2.new(1, -16, 1, -50), Position = UDim2.new(0, 8, 0, 42),
        BackgroundTransparency = 1, BorderSizePixel = 0,
        ScrollBarThickness = 3, ScrollBarImageColor3 = Theme.Border,
        CanvasSize = UDim2.new(0,0,0,0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = PlayersCard,
    })
    new("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, Parent = PlayerList })

    local function buildRow(plr, idx)
        local Row = new("Frame", {
            Size = UDim2.new(1, -8, 0, 52), BackgroundColor3 = Theme.CardHover,
            BorderSizePixel = 0, LayoutOrder = idx, Parent = PlayerList,
        })
        tBG(Row, "CardHover")
        corner(8, Row)
        local rs = stroke(Theme.Border, 1, Row)
        tST(rs, "Border")

        local avF = new("Frame", {
            Size = UDim2.new(0, 36, 0, 36), Position = UDim2.new(0, 10, 0.5, -18),
            BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = Row,
        })
        tBG(avF, "Sidebar")
        corner(18, avF)
        local ai = new("ImageLabel", {
            Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1,
            Image = getHeadshot(plr.UserId), Parent = avF,
        })
        corner(18, ai)

        local rn = new("TextLabel", {
            Size = UDim2.new(1, -80, 0, 16), Position = UDim2.new(0, 54, 0, 10),
            BackgroundTransparency = 1, Text = plr.DisplayName, TextColor3 = Theme.Text,
            TextSize = 11, Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = Row,
        })
        tTX(rn, "Text")
        local ru = new("TextLabel", {
            Size = UDim2.new(1, -80, 0, 14), Position = UDim2.new(0, 54, 0, 28),
            BackgroundTransparency = 1, Text = "@" .. plr.Name, TextColor3 = Theme.TextMuted,
            TextSize = 9, Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = Row,
        })
        tTX(ru, "TextMuted")
    end

    local function refreshPlayers()
        for _, c in pairs(PlayerList:GetChildren()) do
            if c:IsA("Frame") then c:Destroy() end
        end
        local all = Players:GetPlayers()
        table.sort(all, function(a, b) return a.DisplayName:lower() < b.DisplayName:lower() end)
        for i, plr in ipairs(all) do buildRow(plr, i) end
        plC.Text = #all .. " / " .. Players.MaxPlayers
    end
    refreshPlayers()
    Players.PlayerAdded:Connect(function() task.wait(0.5); refreshPlayers() end)
    Players.PlayerRemoving:Connect(function() task.wait(0.5); refreshPlayers() end)

    local DevCard = new("Frame", {
        Size = UDim2.new(1, 0, 0, 150), BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0, LayoutOrder = 3, Parent = InfoScroll,
    })
    tBG(DevCard, "Card")
    corner(12, DevCard)
    local dcs = stroke(Theme.Border, 1, DevCard)
    tST(dcs, "Border")

    local dvT = new("TextLabel", {
        Size = UDim2.new(1, -24, 0, 20), Position = UDim2.new(0, 16, 0, 14),
        BackgroundTransparency = 1, Text = "Social Media", TextColor3 = Theme.Text,
        TextSize = 13, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = DevCard,
    })
    tTX(dvT, "Text")

    local function devRow(y, label, value, url)
        local row = new("TextButton", {
            Size = UDim2.new(1, -24, 0, 28), Position = UDim2.new(0, 12, 0, y),
            BackgroundColor3 = Theme.CardHover, BorderSizePixel = 0,
            Text = "", Parent = DevCard,
        })
        tBG(row, "CardHover")
        corner(6, row)
        local rs = stroke(Theme.Border, 1, row)
        tST(rs, "Border")
        local l = new("TextLabel", {
            Size = UDim2.new(0, 80, 1, 0), Position = UDim2.new(0, 10, 0, 0),
            BackgroundTransparency = 1, Text = label, TextColor3 = Theme.Text,
            TextSize = 10, Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = row,
        })
        tTX(l, "Text")
        local v = new("TextLabel", {
            Size = UDim2.new(1, -100, 1, 0), Position = UDim2.new(0, 90, 0, 0),
            BackgroundTransparency = 1, Text = value, TextColor3 = Theme.Accent,
            TextSize = 10, Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = row,
        })
        tTX(v, "Accent")
        row.MouseButton1Click:Connect(function()
            pcall(function() game:GetService("GuiService"):OpenBrowserWindow(url) end)
        end)
    end
    devRow(44, "TikTok", CONFIG.Developer.TikTok, "https://tiktok.com/" .. CONFIG.Developer.TikTok)
    devRow(76, "Discord", CONFIG.Developer.Discord, "https://" .. CONFIG.Developer.Discord)
    devRow(108, "YouTube", CONFIG.Developer.YouTube, "https://youtube.com/" .. CONFIG.Developer.YouTube)

    local PageMain = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Visible = false, Parent = Pages })

    local MainScroll = new("ScrollingFrame", {
        Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, BorderSizePixel = 0,
        ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.Border,
        CanvasSize = UDim2.new(0,0,0,0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = PageMain,
    })
    new("UIPadding", { PaddingTop = UDim.new(0,6), PaddingLeft = UDim.new(0,6), PaddingRight = UDim.new(0,6), PaddingBottom = UDim.new(0,6), Parent = MainScroll })
    new("UIListLayout", { Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder, Parent = MainScroll })

    local FlyToggle = new("Frame", {
        Size = UDim2.new(1, 0, 0, 68), BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0, LayoutOrder = 1, Parent = MainScroll,
    })
    tBG(FlyToggle, "Card")
    corner(12, FlyToggle)
    local fs = stroke(Theme.Border, 1, FlyToggle)
    tST(fs, "Border")

    local fh = new("Frame", { Size = UDim2.new(0, 20, 0, 20), Position = UDim2.new(0, 16, 0.5, -10), BackgroundTransparency = 1, Parent = FlyToggle })
    makeIcon(fh, "Fly", "Fly", Theme.Accent)

    local ft = new("TextLabel", {
        Size = UDim2.new(1, -130, 0, 18), Position = UDim2.new(0, 48, 0, 14),
        BackgroundTransparency = 1, Text = "FLY", TextColor3 = Theme.Text,
        TextSize = 15, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = FlyToggle,
    })
    tTX(ft, "Text")
    local fst = new("TextLabel", {
        Size = UDim2.new(1, -130, 0, 14), Position = UDim2.new(0, 48, 0, 36),
        BackgroundTransparency = 1, Text = "Disabled", TextColor3 = Theme.TextMuted,
        TextSize = 10, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = FlyToggle,
    })
    tTX(fst, "TextMuted")

    local togBg = new("TextButton", {
        Size = UDim2.new(0, 52, 0, 28), Position = UDim2.new(1, -68, 0.5, -14),
        BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Text = "", Parent = FlyToggle,
    })
    tBG(togBg, "Sidebar")
    corner(100, togBg)
    local togDot = new("Frame", {
        Size = UDim2.new(0, 22, 0, 22), Position = UDim2.new(0, 3, 0.5, -11),
        BackgroundColor3 = Theme.TextMuted, BorderSizePixel = 0, Parent = togBg,
    })
    tBG(togDot, "TextMuted")
    corner(100, togDot)

    local flyOn = false
    local function updTog()
        if flyOn then
            tween(togBg, 0.15, { BackgroundColor3 = Theme.Accent })
            tween(togDot, 0.15, { Position = UDim2.new(1, -25, 0.5, -11), BackgroundColor3 = Color3.fromRGB(255,255,255) })
            fst.Text = "Enabled"
            fst.TextColor3 = Theme.Success
            fs.Color = Theme.Accent
        else
            tween(togBg, 0.15, { BackgroundColor3 = Theme.Sidebar })
            tween(togDot, 0.15, { Position = UDim2.new(0, 3, 0.5, -11), BackgroundColor3 = Theme.TextMuted })
            fst.Text = "Disabled"
            fst.TextColor3 = Theme.TextMuted
            fs.Color = Theme.Border
        end
    end
    togBg.MouseButton1Click:Connect(function()
        flyOn = not flyOn
        updTog()
        if flyOn then NOFLY(); task.wait(0.05); sFLY(); showToast("Fly", "Fly enabled", "success")
        else NOFLY(); showToast("Fly", "Fly disabled", "info") end
    end)

    local SpeedCard = new("Frame", {
        Size = UDim2.new(1, 0, 0, 100), BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0, LayoutOrder = 2, Parent = MainScroll,
    })
    tBG(SpeedCard, "Card")
    corner(12, SpeedCard)
    local scs = stroke(Theme.Border, 1, SpeedCard)
    tST(scs, "Border")

    local sh = new("Frame", { Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(0, 16, 0, 14), BackgroundTransparency = 1, Parent = SpeedCard })
    makeIcon(sh, "Speed", "Speed", Theme.Text)

    local stt = new("TextLabel", {
        Size = UDim2.new(1, -140, 0, 16), Position = UDim2.new(0, 46, 0, 14),
        BackgroundTransparency = 1, Text = "Fly Speed", TextColor3 = Theme.Text,
        TextSize = 13, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = SpeedCard,
    })
    tTX(stt, "Text")
    local sv = new("TextLabel", {
        Size = UDim2.new(0, 80, 0, 16), Position = UDim2.new(1, -96, 0, 14),
        BackgroundTransparency = 1, Text = "1", TextColor3 = Theme.Accent,
        TextSize = 13, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Right, Parent = SpeedCard,
    })
    tTX(sv, "Accent")

    local slBar = new("Frame", {
        Size = UDim2.new(1, -32, 0, 6), Position = UDim2.new(0, 16, 0, 62),
        BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = SpeedCard,
    })
    tBG(slBar, "Sidebar")
    corner(100, slBar)
    local slFill = new("Frame", {
        Size = UDim2.new(0, 0, 1, 0), BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0, Parent = slBar,
    })
    tBG(slFill, "Accent")
    corner(100, slFill)
    local slDot = new("Frame", {
        Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, -7, 0.5, -7),
        BackgroundColor3 = Color3.fromRGB(255,255,255), BorderSizePixel = 0, Parent = slBar,
    })
    corner(100, slDot)

    local sDrag = false
    local MIN_SPD, MAX_SPD = 1, 1000
    local function updSlider(input)
        local pos = math.clamp((input.Position.X - slBar.AbsolutePosition.X) / slBar.AbsoluteSize.X, 0, 1)
        local val = math.floor(MIN_SPD + (MAX_SPD - MIN_SPD) * pos)
        iyflyspeed = val
        vehicleflyspeed = val
        slFill.Size = UDim2.new(pos, 0, 1, 0)
        slDot.Position = UDim2.new(pos, -7, 0.5, -7)
        sv.Text = tostring(val)
    end
    slBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sDrag = true; updSlider(input)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if sDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updSlider(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sDrag = false
        end
    end)

    local quickRow = new("Frame", {
        Size = UDim2.new(1, 0, 0, 32), BackgroundTransparency = 1,
        LayoutOrder = 3, Parent = MainScroll,
    })
    new("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, Parent = quickRow })

    for _, preset in ipairs({1, 10, 50, 100, 500, 1000}) do
        local pb = new("TextButton", {
            Size = UDim2.new(0, 88, 0, 32), BackgroundColor3 = Theme.Card,
            BorderSizePixel = 0, Text = tostring(preset), TextColor3 = Theme.Text,
            TextSize = 11, Font = Enum.Font.GothamBlack,
            LayoutOrder = preset, Parent = quickRow,
        })
        tBG(pb, "Card"); tTX(pb, "Text"); corner(8, pb)
        local ps = stroke(Theme.Border, 1, pb)
        tST(ps, "Border")
        pb.MouseButton1Click:Connect(function()
            iyflyspeed = preset
            vehicleflyspeed = preset
            local pos = (preset - MIN_SPD) / (MAX_SPD - MIN_SPD)
            slFill.Size = UDim2.new(pos, 0, 1, 0)
            slDot.Position = UDim2.new(pos, -7, 0.5, -7)
            sv.Text = tostring(preset)
        end)
        pb.MouseEnter:Connect(function() tween(pb, 0.12, { BackgroundColor3 = Theme.CardHover }) end)
        pb.MouseLeave:Connect(function() tween(pb, 0.12, { BackgroundColor3 = Theme.Card }) end)
    end

    local PageMisc = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Visible = false, Parent = Pages })

    local MiscScroll = new("ScrollingFrame", {
        Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, BorderSizePixel = 0,
        ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.Border,
        CanvasSize = UDim2.new(0,0,0,0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = PageMisc,
    })
    new("UIPadding", { PaddingTop = UDim.new(0,6), PaddingLeft = UDim.new(0,6), PaddingRight = UDim.new(0,6), PaddingBottom = UDim.new(0,6), Parent = MiscScroll })
    new("UIGridLayout", {
        CellSize = UDim2.new(0.5, -6, 0, 60),
        CellPadding = UDim.new(0, 10, 0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = MiscScroll,
    })

    for i, tn in ipairs(ThemeOrder) do
        local th = Themes[tn]
        local card = new("TextButton", {
            BackgroundColor3 = Theme.Card, BorderSizePixel = 0,
            Text = "", LayoutOrder = i, Parent = MiscScroll,
        })
        tBG(card, "Card")
        corner(10, card)
        local cs2 = stroke(Theme.Border, 1, card)
        tST(cs2, "Border")

        new("Frame", {
            Size = UDim2.new(0, 22, 0, 22), Position = UDim2.new(0, 14, 0.5, -11),
            BackgroundColor3 = th.Accent, BorderSizePixel = 0, Parent = card,
        })
        corner(11, card:FindFirstChildOfClass("Frame"))

        local n = new("TextLabel", {
            Size = UDim2.new(1, -60, 0, 18), Position = UDim2.new(0, 46, 0, 12),
            BackgroundTransparency = 1, Text = th.name, TextColor3 = Theme.Text,
            TextSize = 12, Font = Enum.Font.GothamBlack,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = card,
        })
        tTX(n, "Text")
        local a = new("TextLabel", {
            Size = UDim2.new(1, -60, 0, 14), Position = UDim2.new(0, 46, 0, 32),
            BackgroundTransparency = 1, Text = "Tap to apply", TextColor3 = Theme.TextMuted,
            TextSize = 9, Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = card,
        })
        tTX(a, "TextMuted")

        card.MouseEnter:Connect(function() tween(card, 0.12, { BackgroundColor3 = Theme.CardHover }) end)
        card.MouseLeave:Connect(function() tween(card, 0.12, { BackgroundColor3 = Theme.Card }) end)
        card.MouseButton1Click:Connect(function()
            applyTheme(tn)
            showToast("Theme", "Theme applied: " .. tn, "success")
        end)
    end

    local Pages_ = {
        { id = "info", label = "Info", icon = "Info", fb = "Info", page = PageInfo, title = "Info", sub = "Server & developer info" },
        { id = "main", label = "Main", icon = "Fly", fb = "Fly", page = PageMain, title = "Main", sub = "Fly features" },
        { id = "misc", label = "Misc", icon = "Palette", fb = "Palette", page = PageMisc, title = "Misc", sub = "Theme & settings" },
    }

    local sideButtons = {}

    local function selectPage(id)
        for _, p in ipairs(Pages_) do p.page.Visible = (p.id == id) end
        for _, b in pairs(sideButtons) do
            local act = (b._id == id)
            tween(b, 0.12, { BackgroundColor3 = act and Theme.CardHover or Theme.Sidebar })
            tween(b._label, 0.12, { TextColor3 = act and Theme.Text or Theme.TextMuted })
            b._indicator.Visible = act
        end
    end

    for i, p in ipairs(Pages_) do
        local Btn = new("TextButton", {
            Size = UDim2.new(1, 0, 0, 38), BackgroundColor3 = Theme.Sidebar,
            BorderSizePixel = 0, Text = "", LayoutOrder = i, Parent = ListFrame,
        })
        tBG(Btn, "Sidebar")
        corner(8, Btn)

        local ind = new("Frame", {
            Size = UDim2.new(0, 3, 0, 22), Position = UDim2.new(0, 0, 0.5, -11),
            BackgroundColor3 = Theme.Accent, BorderSizePixel = 0,
            Visible = false, Parent = Btn,
        })
        tBG(ind, "Accent")
        corner(2, ind)

        local ih = new("Frame", {
            Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(0, 14, 0.5, -9),
            BackgroundTransparency = 1, Parent = Btn,
        })
        makeIcon(ih, p.icon, p.fb, Theme.TextMuted)

        local lbl = new("TextLabel", {
            Size = UDim2.new(1, -50, 1, 0), Position = UDim2.new(0, 40, 0, 0),
            BackgroundTransparency = 1, Text = p.label, TextColor3 = Theme.TextMuted,
            TextSize = 12, Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = Btn,
        })
        tTX(lbl, "TextMuted")

        Btn._id = p.id
        Btn._label = lbl
        Btn._indicator = ind

        Btn.Position = UDim2.new(-1, 0, 0, 0)
        task.delay(0.5 + i * 0.08, function()
            tween(Btn, 0.4, { Position = UDim2.new(0, 0, 0, 0) }, Enum.EasingStyle.Back)
        end)

        Btn.MouseEnter:Connect(function()
            if Btn._label.TextColor3 ~= Theme.Text then
                tween(Btn, 0.12, { BackgroundColor3 = Theme.Card })
            end
        end)
        Btn.MouseLeave:Connect(function()
            if Btn._label.TextColor3 ~= Theme.Text then
                tween(Btn, 0.12, { BackgroundColor3 = Theme.Sidebar })
            end
        end)
        Btn.MouseButton1Click:Connect(function()
            selectPage(p.id)
            pageTitle.Text = p.title
            pageSub.Text = p.sub
        end)
        table.insert(sideButtons, Btn)
    end

    selectPage("info")
end

buildKeyUI(function()
    buildMainUI()
    task.wait(0.6)
    showToast("Welcome", "Hallwayz Hub loaded. Selamat datang!", "success")
end)
