--[[
    Hallwayz Fly — Dynamic Edition
    Load: loadstring(game:HttpGet("https://raw.githubusercontent.com/ZurraOfficial/Fly/main/main.lua"))()
    Edit by ZurraOfficial
    Version: 1.0.0
]]

print("[Hallwayz] Loading...")

-- ============================================================
-- SERVICES
-- ============================================================
local Players          = game:GetService("Players")
local CoreGui          = game:GetService("CoreGui")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local HttpService      = game:GetService("HttpService")
local StarterGui       = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera or workspace:WaitForChild("Camera", 5)

-- ============================================================
-- CONFIG
-- ============================================================
local CONFIG = {
    Name = "Hallwayz",
    Subtitle = "Edit by ZurraOfficial",
    Version = "v1.0.0",
    KeysURL = "https://raw.githubusercontent.com/ZurraOfficial/Fly/main/keys.txt",
    Developer = {
        TikTok = "@zurraofficial",
        Discord = "discord.gg/hallwayz",
        YouTube = "@zurraofficial",
        Roblox = "ZurraOfficial",
    },
    DefaultTheme = "Amethyst",
}

-- ============================================================
-- THEME MODULE (12 WARNA)
-- ============================================================
local Themes = {
    Amethyst = {
        name = "Amethyst",
        BG = Color3.fromRGB(11, 11, 16),
        Sidebar = Color3.fromRGB(15, 15, 22),
        Card = Color3.fromRGB(20, 20, 30),
        CardHover = Color3.fromRGB(26, 26, 38),
        Border = Color3.fromRGB(30, 30, 44),
        BorderHover = Color3.fromRGB(48, 48, 66),
        Text = Color3.fromRGB(232, 232, 240),
        TextMuted = Color3.fromRGB(105, 105, 128),
        Accent = Color3.fromRGB(150, 100, 255),
        AccentDark = Color3.fromRGB(110, 70, 200),
        AccentGlow = Color3.fromRGB(180, 150, 255),
        Success = Color3.fromRGB(74, 222, 128),
        Error = Color3.fromRGB(248, 113, 113),
        Warning = Color3.fromRGB(250, 204, 21),
        Divider = Color3.fromRGB(26, 26, 38),
    },
    Gold = {
        name = "Gold",
        BG = Color3.fromRGB(14, 12, 8),
        Sidebar = Color3.fromRGB(20, 17, 11),
        Card = Color3.fromRGB(28, 24, 15),
        CardHover = Color3.fromRGB(38, 32, 20),
        Border = Color3.fromRGB(45, 38, 22),
        BorderHover = Color3.fromRGB(65, 55, 30),
        Text = Color3.fromRGB(245, 240, 225),
        TextMuted = Color3.fromRGB(140, 125, 90),
        Accent = Color3.fromRGB(255, 200, 60),
        AccentDark = Color3.fromRGB(210, 160, 30),
        AccentGlow = Color3.fromRGB(255, 230, 150),
        Success = Color3.fromRGB(180, 220, 100),
        Error = Color3.fromRGB(240, 100, 90),
        Warning = Color3.fromRGB(255, 180, 50),
        Divider = Color3.fromRGB(35, 30, 18),
    },
    Ocean = {
        name = "Ocean",
        BG = Color3.fromRGB(8, 12, 18),
        Sidebar = Color3.fromRGB(11, 16, 25),
        Card = Color3.fromRGB(15, 22, 34),
        CardHover = Color3.fromRGB(20, 30, 45),
        Border = Color3.fromRGB(24, 36, 55),
        BorderHover = Color3.fromRGB(38, 55, 80),
        Text = Color3.fromRGB(225, 235, 245),
        TextMuted = Color3.fromRGB(95, 115, 140),
        Accent = Color3.fromRGB(60, 160, 255),
        AccentDark = Color3.fromRGB(35, 120, 200),
        AccentGlow = Color3.fromRGB(130, 200, 255),
        Success = Color3.fromRGB(80, 220, 180),
        Error = Color3.fromRGB(240, 100, 100),
        Warning = Color3.fromRGB(250, 200, 60),
        Divider = Color3.fromRGB(20, 30, 45),
    },
    Emerald = {
        name = "Emerald",
        BG = Color3.fromRGB(8, 14, 11),
        Sidebar = Color3.fromRGB(11, 20, 15),
        Card = Color3.fromRGB(15, 27, 20),
        CardHover = Color3.fromRGB(20, 36, 27),
        Border = Color3.fromRGB(24, 42, 32),
        BorderHover = Color3.fromRGB(36, 60, 46),
        Text = Color3.fromRGB(225, 245, 232),
        TextMuted = Color3.fromRGB(90, 130, 108),
        Accent = Color3.fromRGB(60, 220, 130),
        AccentDark = Color3.fromRGB(30, 160, 90),
        AccentGlow = Color3.fromRGB(130, 255, 180),
        Success = Color3.fromRGB(100, 240, 150),
        Error = Color3.fromRGB(240, 100, 100),
        Warning = Color3.fromRGB(250, 210, 60),
        Divider = Color3.fromRGB(20, 34, 25),
    },
    Crimson = {
        name = "Crimson",
        BG = Color3.fromRGB(14, 8, 10),
        Sidebar = Color3.fromRGB(20, 11, 14),
        Card = Color3.fromRGB(28, 15, 19),
        CardHover = Color3.fromRGB(38, 20, 26),
        Border = Color3.fromRGB(45, 24, 30),
        BorderHover = Color3.fromRGB(65, 35, 44),
        Text = Color3.fromRGB(245, 225, 228),
        TextMuted = Color3.fromRGB(140, 95, 108),
        Accent = Color3.fromRGB(240, 55, 80),
        AccentDark = Color3.fromRGB(190, 35, 55),
        AccentGlow = Color3.fromRGB(255, 140, 160),
        Success = Color3.fromRGB(90, 220, 130),
        Error = Color3.fromRGB(255, 100, 100),
        Warning = Color3.fromRGB(255, 190, 60),
        Divider = Color3.fromRGB(35, 20, 25),
    },
    Rose = {
        name = "Rose",
        BG = Color3.fromRGB(14, 10, 14),
        Sidebar = Color3.fromRGB(20, 14, 20),
        Card = Color3.fromRGB(28, 20, 28),
        CardHover = Color3.fromRGB(38, 26, 38),
        Border = Color3.fromRGB(46, 32, 46),
        BorderHover = Color3.fromRGB(66, 46, 66),
        Text = Color3.fromRGB(245, 228, 242),
        TextMuted = Color3.fromRGB(140, 105, 135),
        Accent = Color3.fromRGB(255, 120, 200),
        AccentDark = Color3.fromRGB(200, 80, 155),
        AccentGlow = Color3.fromRGB(255, 180, 225),
        Success = Color3.fromRGB(90, 220, 140),
        Error = Color3.fromRGB(245, 100, 120),
        Warning = Color3.fromRGB(255, 200, 80),
        Divider = Color3.fromRGB(36, 25, 36),
    },
    Sunset = {
        name = "Sunset",
        BG = Color3.fromRGB(15, 10, 8),
        Sidebar = Color3.fromRGB(22, 14, 10),
        Card = Color3.fromRGB(30, 20, 14),
        CardHover = Color3.fromRGB(42, 27, 18),
        Border = Color3.fromRGB(50, 32, 22),
        BorderHover = Color3.fromRGB(72, 46, 30),
        Text = Color3.fromRGB(248, 235, 225),
        TextMuted = Color3.fromRGB(150, 115, 90),
        Accent = Color3.fromRGB(255, 140, 60),
        AccentDark = Color3.fromRGB(210, 100, 30),
        AccentGlow = Color3.fromRGB(255, 190, 130),
        Success = Color3.fromRGB(150, 220, 100),
        Error = Color3.fromRGB(240, 100, 90),
        Warning = Color3.fromRGB(255, 210, 80),
        Divider = Color3.fromRGB(38, 24, 16),
    },
    Mint = {
        name = "Mint",
        BG = Color3.fromRGB(8, 14, 14),
        Sidebar = Color3.fromRGB(11, 20, 20),
        Card = Color3.fromRGB(15, 27, 27),
        CardHover = Color3.fromRGB(20, 36, 36),
        Border = Color3.fromRGB(24, 42, 42),
        BorderHover = Color3.fromRGB(36, 60, 60),
        Text = Color3.fromRGB(220, 245, 245),
        TextMuted = Color3.fromRGB(90, 135, 135),
        Accent = Color3.fromRGB(60, 220, 210),
        AccentDark = Color3.fromRGB(30, 165, 160),
        AccentGlow = Color3.fromRGB(140, 255, 245),
        Success = Color3.fromRGB(120, 240, 180),
        Error = Color3.fromRGB(240, 100, 120),
        Warning = Color3.fromRGB(255, 210, 100),
        Divider = Color3.fromRGB(20, 34, 34),
    },
    Lavender = {
        name = "Lavender",
        BG = Color3.fromRGB(12, 10, 16),
        Sidebar = Color3.fromRGB(18, 15, 23),
        Card = Color3.fromRGB(25, 21, 32),
        CardHover = Color3.fromRGB(34, 28, 43),
        Border = Color3.fromRGB(42, 35, 52),
        BorderHover = Color3.fromRGB(60, 50, 74),
        Text = Color3.fromRGB(238, 232, 248),
        TextMuted = Color3.fromRGB(125, 110, 150),
        Accent = Color3.fromRGB(200, 170, 255),
        AccentDark = Color3.fromRGB(155, 125, 210),
        AccentGlow = Color3.fromRGB(230, 210, 255),
        Success = Color3.fromRGB(120, 220, 180),
        Error = Color3.fromRGB(240, 110, 140),
        Warning = Color3.fromRGB(255, 215, 130),
        Divider = Color3.fromRGB(32, 27, 42),
    },
    Ice = {
        name = "Ice",
        BG = Color3.fromRGB(10, 12, 14),
        Sidebar = Color3.fromRGB(14, 17, 20),
        Card = Color3.fromRGB(20, 24, 28),
        CardHover = Color3.fromRGB(27, 33, 38),
        Border = Color3.fromRGB(35, 42, 48),
        BorderHover = Color3.fromRGB(50, 60, 68),
        Text = Color3.fromRGB(230, 240, 245),
        TextMuted = Color3.fromRGB(100, 115, 130),
        Accent = Color3.fromRGB(120, 220, 240),
        AccentDark = Color3.fromRGB(80, 170, 200),
        AccentGlow = Color3.fromRGB(180, 240, 255),
        Success = Color3.fromRGB(130, 230, 180),
        Error = Color3.fromRGB(240, 120, 120),
        Warning = Color3.fromRGB(255, 220, 130),
        Divider = Color3.fromRGB(28, 34, 40),
    },
    Fire = {
        name = "Fire",
        BG = Color3.fromRGB(15, 8, 6),
        Sidebar = Color3.fromRGB(22, 11, 8),
        Card = Color3.fromRGB(30, 15, 11),
        CardHover = Color3.fromRGB(42, 20, 14),
        Border = Color3.fromRGB(50, 24, 18),
        BorderHover = Color3.fromRGB(70, 35, 25),
        Text = Color3.fromRGB(250, 230, 220),
        TextMuted = Color3.fromRGB(150, 100, 85),
        Accent = Color3.fromRGB(255, 90, 40),
        AccentDark = Color3.fromRGB(200, 60, 20),
        AccentGlow = Color3.fromRGB(255, 160, 100),
        Success = Color3.fromRGB(140, 210, 100),
        Error = Color3.fromRGB(255, 100, 90),
        Warning = Color3.fromRGB(255, 200, 60),
        Divider = Color3.fromRGB(40, 20, 14),
    },
    Monochrome = {
        name = "Monochrome",
        BG = Color3.fromRGB(10, 10, 10),
        Sidebar = Color3.fromRGB(15, 15, 15),
        Card = Color3.fromRGB(22, 22, 22),
        CardHover = Color3.fromRGB(30, 30, 30),
        Border = Color3.fromRGB(38, 38, 38),
        BorderHover = Color3.fromRGB(55, 55, 55),
        Text = Color3.fromRGB(235, 235, 235),
        TextMuted = Color3.fromRGB(120, 120, 120),
        Accent = Color3.fromRGB(255, 255, 255),
        AccentDark = Color3.fromRGB(200, 200, 200),
        AccentGlow = Color3.fromRGB(240, 240, 240),
        Success = Color3.fromRGB(180, 220, 180),
        Error = Color3.fromRGB(230, 130, 130),
        Warning = Color3.fromRGB(230, 210, 130),
        Divider = Color3.fromRGB(30, 30, 30),
    },
}

local ThemeOrder = {
    "Amethyst", "Gold", "Ocean", "Emerald",
    "Crimson", "Rose", "Sunset", "Mint",
    "Lavender", "Ice", "Fire", "Monochrome",
}

local Theme = Themes[CONFIG.DefaultTheme]

-- ============================================================
-- THEME REGISTRY (untuk dynamic update)
-- ============================================================
local ThemeRegistry = {
    frames = {},
    strokes = {},
    texts = {},
    accents = {},
    accentsDark = {},
    accentsGlow = {},
    borders = {},
    cards = {},
    sidebars = {},
    dividers = {},
    textMuted = {},
}

local function reg(list, obj)
    table.insert(list, obj)
    return obj
end

local function new(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do obj[k] = v end
    return obj
end

local function corner(r, p)
    return new("UICorner", { CornerRadius = UDim.new(0, r or 8), Parent = p })
end

local function stroke(color, thickness, parent)
    local s = new("UIStroke", {
        Color = color,
        Thickness = thickness or 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent,
    })
    return s
end

local function tween(o, t, p)
    local tw = TweenService:Create(o, TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), p)
    tw:Play(); return tw
end

-- Apply theme ke semua objek terdaftar
local function applyTheme(themeName)
    local newTheme = Themes[themeName]
    if not newTheme then return end
    Theme = newTheme

    for _, f in pairs(ThemeRegistry.frames)      do f.BackgroundColor3 = Theme.BG end
    for _, s in pairs(ThemeRegistry.sidebars)    do s.BackgroundColor3 = Theme.Sidebar end
    for _, c in pairs(ThemeRegistry.cards)       do c.BackgroundColor3 = Theme.Card end
    for _, d in pairs(ThemeRegistry.dividers)    do d.BackgroundColor3 = Theme.Divider end
    for _, s in pairs(ThemeRegistry.borders)     do s.Color = Theme.Border end
    for _, s in pairs(ThemeRegistry.strokes)     do s.Color = Theme.Border end
    for _, t in pairs(ThemeRegistry.texts)       do t.TextColor3 = Theme.Text end
    for _, t in pairs(ThemeRegistry.textMuted)   do t.TextColor3 = Theme.TextMuted end
    for _, a in pairs(ThemeRegistry.accents)     do
        if a:IsA("TextButton") or a:IsA("Frame") then
            a.BackgroundColor3 = Theme.Accent
        elseif a:IsA("TextLabel") then
            a.TextColor3 = Theme.Accent
        elseif a:IsA("UIStroke") then
            a.Color = Theme.Accent
        end
    end
    for _, a in pairs(ThemeRegistry.accentsDark) do
        if a:IsA("TextButton") or a:IsA("Frame") then
            a.BackgroundColor3 = Theme.AccentDark
        end
    end
end

-- ============================================================
-- ICONS — GANTI DI SINI PAKAI LINK TELEGRAPH KAMU
-- ============================================================
-- Format: IconName = "https://telegra.ph/file/xxxxx.png" (atau raw link apapun)
local Icons = {
    Logo = "", -- isi link logo kamu
    Info = "", -- isi link icon info
    Fly = "",  -- isi link icon fly
    Palette = "", -- isi link icon palette/theme
    Speed = "", -- isi link icon speed
    Key = "", -- isi link icon key
    Close = "", -- isi link icon close
    Minimize = "",
}

-- Fallback vector (kalau Icons masih kosong)
local function drawFallbackIcon(parent, kind, color)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    if kind == "close" then
        new("Frame", { Size = UDim2.new(0,12,0,2), Position = UDim2.new(0,1,0,6), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = 45, Parent = h })
        new("Frame", { Size = UDim2.new(0,12,0,2), Position = UDim2.new(0,1,0,6), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = -45, Parent = h })
    elseif kind == "minimize" then
        new("Frame", { Size = UDim2.new(0,12,0,2), Position = UDim2.new(0,1,0,7), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    elseif kind == "info" then
        local outer = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h }); corner(100, outer)
        local inner = new("Frame", { Size = UDim2.new(1,-4,1,-4), Position = UDim2.new(0,2,0,2), BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = h }); corner(100, inner)
        new("Frame", { Size = UDim2.new(0,2,0,2), Position = UDim2.new(0.5,-1,0,3), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
        new("Frame", { Size = UDim2.new(0,2,0,6), Position = UDim2.new(0.5,-1,0,7), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    elseif kind == "fly" then
        new("Frame", { Size = UDim2.new(0,14,0,3), Position = UDim2.new(0,1,0,4), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = -20, Parent = h })
        new("Frame", { Size = UDim2.new(0,12,0,3), Position = UDim2.new(0,1,0,8), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = -10, Parent = h })
        new("Frame", { Size = UDim2.new(0,9,0,3), Position = UDim2.new(0,1,0,12), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = 5, Parent = h })
    elseif kind == "palette" then
        local c1 = new("Frame", { Size = UDim2.new(0,6,0,6), Position = UDim2.new(0,1,0,1), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h }); corner(100, c1)
        local c2 = new("Frame", { Size = UDim2.new(0,6,0,6), Position = UDim2.new(0,9,0,1), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h }); corner(100, c2)
        local c3 = new("Frame", { Size = UDim2.new(0,6,0,6), Position = UDim2.new(0,1,0,9), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h }); corner(100, c3)
        local c4 = new("Frame", { Size = UDim2.new(0,6,0,6), Position = UDim2.new(0,9,0,9), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h }); corner(100, c4)
    elseif kind == "speed" then
        new("Frame", { Size = UDim2.new(0,14,0,2), Position = UDim2.new(0,1,0,4), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
        new("Frame", { Size = UDim2.new(0,10,0,2), Position = UDim2.new(0,1,0,8), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
        new("Frame", { Size = UDim2.new(0,14,0,2), Position = UDim2.new(0,1,0,12), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    end
    return h
end

-- Buat icon (asset link kalau ada, fallback vector kalau kosong)
local function makeIcon(parent, iconKey, fallbackKind, color)
    local holder = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    local link = Icons[iconKey]
    if link and link ~= "" then
        new("ImageLabel", {
            Size = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
            Image = link,
            ImageColor3 = color or Theme.Text,
            Parent = holder,
        })
    else
        drawFallbackIcon(holder, fallbackKind, color or Theme.Text)
    end
    return holder
end

-- Logo Hallwayz (fallback — pakai bentuk segitiga/parallelogram)
local function buildLogo(parent, size)
    size = size or 30
    local holder = new("Frame", { Size = UDim2.new(0, size, 0, size), BackgroundTransparency = 1, Parent = parent })
    if Icons.Logo and Icons.Logo ~= "" then
        new("ImageLabel", {
            Size = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
            Image = Icons.Logo,
            Parent = holder,
        })
        return holder
    end
    local sk = size / 32
    reg(ThemeRegistry.accents, new("Frame", { Size = UDim2.new(0, 8*sk, 0, 13*sk), Position = UDim2.new(0, 6*sk, 0, 3*sk), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Rotation = 20, Parent = holder }))
    reg(ThemeRegistry.accents, new("Frame", { Size = UDim2.new(0, 8*sk, 0, 13*sk), Position = UDim2.new(0, 6*sk, 0, 16*sk), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Rotation = 20, Parent = holder }))
    reg(ThemeRegistry.accents, new("Frame", { Size = UDim2.new(0, 9*sk, 0, 26*sk), Position = UDim2.new(0, 17*sk, 0, 3*sk), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Rotation = 20, Parent = holder }))
    reg(ThemeRegistry.accentsGlow, new("Frame", { Size = UDim2.new(0, 11*sk, 0, 2*sk), Position = UDim2.new(0, 7*sk, 0, 15*sk), BackgroundColor3 = Theme.AccentGlow, BorderSizePixel = 0, Rotation = -25, Parent = holder }))
    return holder
end

-- ============================================================
-- FPS COUNTER (MODULE)
-- ============================================================
local FPSModule = { value = 60, listeners = {} }
task.spawn(function()
    while true do
        local t = tick()
        RunService.RenderStepped:Wait()
        local delta = tick() - t
        if delta > 0 then
            FPSModule.value = math.floor(1 / delta)
            for _, cb in pairs(FPSModule.listeners) do
                pcall(cb, FPSModule.value)
            end
        end
    end
end)

-- ============================================================
-- THUMBNAIL MODULE (foto profil roblox)
-- ============================================================
local ThumbnailCache = {}
local function getHeadshot(userId)
    if ThumbnailCache[userId] then return ThumbnailCache[userId] end
    local url = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(userId) .. "&w=150&h=150"
    ThumbnailCache[userId] = url
    return url
end

-- ============================================================
-- FLY ENGINE — Infinite Yield (asli)
-- ============================================================
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
    local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    local SPEED = 0

    local function FLY()
        FLYING = true
        local BG = Instance.new('BodyGyro')
        local BV = Instance.new('BodyVelocity')
        BG.P = 9e4
        BG.Parent = T
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
                    lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
                elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
                    BV.Velocity = ((camera.CFrame.LookVector * (lCONTROL.F + lCONTROL.B)) + ((camera.CFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - camera.CFrame.p)) * SPEED
                else
                    BV.Velocity = Vector3.new(0, 0, 0)
                end
                BG.CFrame = camera.CFrame
            until not FLYING
            CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            SPEED = 0
            BG:Destroy()
            BV:Destroy()
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

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- ============================================================
-- KEY VALIDATION
-- ============================================================
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

-- ============================================================
-- SCREEN GUI
-- ============================================================
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

-- ============================================================
-- KEY UI
-- ============================================================
local function buildKeyUI(onSuccess)
    local Dim = reg(ThemeRegistry.frames, new("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Parent = ScreenGui,
    }))

    local KeyCard = reg(ThemeRegistry.frames, new("Frame", {
        Size = UDim2.new(0, 380, 0, 290),
        Position = UDim2.new(0.5, -190, 0.5, -145),
        BackgroundColor3 = Theme.BG,
        BorderSizePixel = 0,
        Parent = Dim,
    }))
    corner(14, KeyCard)
    local KeyStroke = reg(ThemeRegistry.strokes, stroke(Theme.Border, 1, KeyCard))

    local glow = new("UIStroke", { Color = Theme.Accent, Thickness = 1.5, Transparency = 0.7, Parent = KeyCard })
    reg(ThemeRegistry.accents, glow)
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

    local Header = reg(ThemeRegistry.sidebars, new("Frame", {
        Size = UDim2.new(1, 0, 0, 64),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0,
        Parent = KeyCard,
    }))
    corner(14, Header)
    reg(ThemeRegistry.sidebars, new("Frame", { Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 1, -14), BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = Header }))

    local logoHolder = new("Frame", { Size = UDim2.new(0, 32, 0, 32), Position = UDim2.new(0, 16, 0.5, -16), BackgroundTransparency = 1, Parent = Header })
    buildLogo(logoHolder, 32)

    reg(ThemeRegistry.texts, new("TextLabel", {
        Size = UDim2.new(1, -70, 0, 18), Position = UDim2.new(0, 58, 0, 12),
        BackgroundTransparency = 1, Text = CONFIG.Name .. " " .. CONFIG.Version,
        TextColor3 = Theme.Text, TextSize = 14, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = Header,
    }))
    reg(ThemeRegistry.textMuted, new("TextLabel", {
        Size = UDim2.new(1, -70, 0, 14), Position = UDim2.new(0, 58, 0, 33),
        BackgroundTransparency = 1, Text = CONFIG.Subtitle,
        TextColor3 = Theme.TextMuted, TextSize = 10, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = Header,
    }))

    local keyClose = reg(ThemeRegistry.cards, new("TextButton", {
        Size = UDim2.new(0, 26, 0, 26), Position = UDim2.new(1, -38, 0, 19),
        BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Text = "", Parent = Header,
    }))
    corner(6, keyClose)
    local kcHolder = new("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0.5, -7, 0.5, -7), BackgroundTransparency = 1, Parent = keyClose })
    makeIcon(kcHolder, "Close", "close", Theme.TextMuted)
    keyClose.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    local Body = new("Frame", {
        Size = UDim2.new(1, -28, 1, -84),
        Position = UDim2.new(0, 14, 0, 80),
        BackgroundTransparency = 1, Parent = KeyCard,
    })

    reg(ThemeRegistry.texts, new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 16), BackgroundTransparency = 1,
        Text = "Enter key to continue",
        TextColor3 = Theme.Text, TextSize = 11, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = Body,
    }))

    local InputBox = reg(ThemeRegistry.cards, new("Frame", {
        Size = UDim2.new(1, 0, 0, 40), Position = UDim2.new(0, 0, 0, 24),
        BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = Body,
    }))
    corner(8, InputBox)
    local inputStroke = reg(ThemeRegistry.strokes, stroke(Theme.Border, 1, InputBox))

    local keyIconHolder = new("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 12, 0.5, -7), BackgroundTransparency = 1, Parent = InputBox })
    makeIcon(keyIconHolder, "Key", "info", Theme.TextMuted)

    local KeyInput = reg(ThemeRegistry.texts, new("TextBox", {
        Size = UDim2.new(1, -102, 1, 0), Position = UDim2.new(0, 34, 0, 0),
        BackgroundTransparency = 1, Text = "",
        PlaceholderText = "XXXX-XXXX-XXXX-XXXX",
        PlaceholderColor3 = Theme.TextMuted, TextColor3 = Theme.Text,
        TextSize = 12, Font = Enum.Font.Code, ClearTextOnFocus = false,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = InputBox,
    }))

    local pasteBtn = reg(ThemeRegistry.cards, new("TextButton", {
        Size = UDim2.new(0, 52, 0, 26), Position = UDim2.new(1, -58, 0.5, -13),
        BackgroundColor3 = Theme.CardHover, BorderSizePixel = 0,
        Text = "Paste", TextColor3 = Theme.Text, TextSize = 10,
        Font = Enum.Font.GothamBold, Parent = InputBox,
    }))
    corner(6, pasteBtn)
    pasteBtn.MouseButton1Click:Connect(function()
        local ok, clip = pcall(function() return game:GetService("GuiService"):GetClipboard() end)
        if ok and clip and clip ~= "" then KeyInput.Text = clip end
    end)

    local StatusLabel = reg(ThemeRegistry.textMuted, new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 16), Position = UDim2.new(0, 0, 0, 74),
        BackgroundTransparency = 1, Text = "", TextColor3 = Theme.TextMuted,
        TextSize = 10, Font = Enum.Font.Gotham, Parent = Body,
    }))

    local verifyBtn = reg(ThemeRegistry.accents, new("TextButton", {
        Size = UDim2.new(1, 0, 0, 42), Position = UDim2.new(0, 0, 0, 96),
        BackgroundColor3 = Theme.Accent, BorderSizePixel = 0,
        Text = "VERIFY", TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 12, Font = Enum.Font.GothamBlack, Parent = Body,
    }))
    corner(8, verifyBtn)
    verifyBtn.MouseEnter:Connect(function() tween(verifyBtn, 0.12, { BackgroundColor3 = Theme.AccentDark }) end)
    verifyBtn.MouseLeave:Connect(function() tween(verifyBtn, 0.12, { BackgroundColor3 = Theme.Accent }) end)

    reg(ThemeRegistry.textMuted, new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 1, -18),
        BackgroundTransparency = 1, Text = CONFIG.Subtitle,
        TextColor3 = Theme.TextMuted, TextSize = 9, Font = Enum.Font.GothamBold, Parent = Body,
    }))

    local function submit()
        local key = KeyInput.Text
        if key == "" then
            StatusLabel.Text = "Key required"
            StatusLabel.TextColor3 = Theme.Error
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
            task.wait(0.35)
            tween(Dim, 0.3, { BackgroundTransparency = 1 })
            tween(KeyCard, 0.3, { BackgroundTransparency = 1, Size = UDim2.new(0,0,0,0), Position = UDim2.new(0.5,0,0.5,0) })
            task.wait(0.3)
            Dim:Destroy()
            onSuccess()
        else
            StatusLabel.Text = msg
            StatusLabel.TextColor3 = Theme.Error
            verifyBtn.Text = "VERIFY"
        end
    end
    verifyBtn.MouseButton1Click:Connect(submit)
    KeyInput.FocusLost:Connect(function(enter) if enter then submit() end end)
end

-- ============================================================
-- MAIN UI — Sidebar + Pages
-- ============================================================
local function buildMainUI()
    local Main = reg(ThemeRegistry.frames, new("Frame", {
        Size = UDim2.new(0, 620, 0, 420),
        Position = UDim2.new(0.5, -310, 0.5, -210),
        BackgroundColor3 = Theme.BG,
        BorderSizePixel = 0,
        Parent = ScreenGui,
    }))
    corner(14, Main)
    local mainStroke = reg(ThemeRegistry.strokes, stroke(Theme.Border, 1, Main))

    -- UIScale responsive
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

    Main.Size = UDim2.new(0, 0, 0, 0)
    tween(Main, 0.3, { Size = UDim2.new(0, 620, 0, 420) })

    -- Draggable
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

    -- ============================================================
    -- SIDEBAR (kiri)
    -- ============================================================
    local Sidebar = reg(ThemeRegistry.sidebars, new("Frame", {
        Size = UDim2.new(0, 160, 1, 0),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0,
        Parent = Main,
    }))
    corner(14, Sidebar)
    reg(ThemeRegistry.sidebars, new("Frame", {
        Size = UDim2.new(0, 14, 1, 0), Position = UDim2.new(1, -14, 0, 0),
        BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = Sidebar,
    }))

    -- Brand
    local brand = new("Frame", { Size = UDim2.new(1, 0, 0, 60), BackgroundTransparency = 1, Parent = Sidebar })
    local brandLogo = new("Frame", { Size = UDim2.new(0, 32, 0, 32), Position = UDim2.new(0, 14, 0.5, -16), BackgroundTransparency = 1, Parent = brand })
    buildLogo(brandLogo, 32)

    reg(ThemeRegistry.texts, new("TextLabel", {
        Size = UDim2.new(1, -60, 0, 18), Position = UDim2.new(0, 54, 0, 14),
        BackgroundTransparency = 1, Text = CONFIG.Name,
        TextColor3 = Theme.Text, TextSize = 14, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = brand,
    }))
    reg(ThemeRegistry.textMuted, new("TextLabel", {
        Size = UDim2.new(1, -60, 0, 14), Position = UDim2.new(0, 54, 0, 32),
        BackgroundTransparency = 1, Text = CONFIG.Subtitle,
        TextColor3 = Theme.TextMuted, TextSize = 9, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = brand,
    }))

    reg(ThemeRegistry.dividers, new("Frame", {
        Size = UDim2.new(1, -24, 0, 1), Position = UDim2.new(0, 12, 0, 60),
        BackgroundColor3 = Theme.Divider, BorderSizePixel = 0, Parent = Sidebar,
    }))

    -- Sidebar list
    local ListFrame = new("ScrollingFrame", {
        Size = UDim2.new(1, -12, 1, -60 - 130),
        Position = UDim2.new(0, 6, 0, 64),
        BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0,0,0,0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = Sidebar,
    })
    new("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, Parent = ListFrame })

    -- ============================================================
    -- FPS + DISPLAY NAME (bottom sidebar)
    -- ============================================================
    local StatusBox = reg(ThemeRegistry.cards, new("Frame", {
        Size = UDim2.new(1, -16, 0, 56),
        Position = UDim2.new(0, 8, 1, -64),
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        Parent = Sidebar,
    }))
    corner(8, StatusBox)
    reg(ThemeRegistry.strokes, stroke(Theme.Border, 1, StatusBox))

    local fpsLabel = reg(ThemeRegistry.accents, new("TextLabel", {
        Size = UDim2.new(1, -16, 0, 16), Position = UDim2.new(0, 12, 0, 8),
        BackgroundTransparency = 1, Text = "FPS: 60",
        TextColor3 = Theme.Accent, TextSize = 12, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = StatusBox,
    }))
    local nameLabel = reg(ThemeRegistry.texts, new("TextLabel", {
        Size = UDim2.new(1, -16, 0, 14), Position = UDim2.new(0, 12, 0, 26),
        BackgroundTransparency = 1, Text = LocalPlayer.DisplayName,
        TextColor3 = Theme.Text, TextSize = 11, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = StatusBox,
    }))
    local userLabel = reg(ThemeRegistry.textMuted, new("TextLabel", {
        Size = UDim2.new(1, -16, 0, 12), Position = UDim2.new(0, 12, 0, 40),
        BackgroundTransparency = 1, Text = "@" .. LocalPlayer.Name,
        TextColor3 = Theme.TextMuted, TextSize = 9, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = StatusBox,
    }))

    FPSModule.listeners[#FPSModule.listeners + 1] = function(v)
        fpsLabel.Text = "FPS: " .. v
        -- warna berubah sesuai fps
        if v >= 55 then fpsLabel.TextColor3 = Theme.Success
        elseif v >= 30 then fpsLabel.TextColor3 = Theme.Warning
        else fpsLabel.TextColor3 = Theme.Error end
    end

    -- ============================================================
    -- CONTENT AREA
    -- ============================================================
    local Content = new("Frame", {
        Size = UDim2.new(1, -160, 1, 0),
        Position = UDim2.new(0, 160, 0, 0),
        BackgroundTransparency = 1,
        Parent = Main,
    })

    -- Top bar
    local TopBar = new("Frame", { Size = UDim2.new(1, 0, 0, 54), BackgroundTransparency = 1, Parent = Content })

    local pageTitle = reg(ThemeRegistry.texts, new("TextLabel", {
        Size = UDim2.new(0, 260, 0, 18), Position = UDim2.new(0, 18, 0, 12),
        BackgroundTransparency = 1, Text = "Info",
        TextColor3 = Theme.Text, TextSize = 14, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = TopBar,
    }))
    local pageSub = reg(ThemeRegistry.textMuted, new("TextLabel", {
        Size = UDim2.new(0, 340, 0, 14), Position = UDim2.new(0, 18, 0, 30),
        BackgroundTransparency = 1, Text = "Server & developer info",
        TextColor3 = Theme.TextMuted, TextSize = 10, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = TopBar,
    }))

    -- Window buttons
    local function winBtn(iconKey, fallbackKind, xOffset)
        local b = reg(ThemeRegistry.cards, new("TextButton", {
            Size = UDim2.new(0, 26, 0, 26), Position = UDim2.new(1, xOffset, 0, 14),
            BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Text = "", Parent = TopBar,
        }))
        corner(6, b)
        local holder = new("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0.5, -7, 0.5, -7), BackgroundTransparency = 1, Parent = b })
        makeIcon(holder, iconKey, fallbackKind, Theme.TextMuted)
        b.MouseEnter:Connect(function() tween(b, 0.12, { BackgroundColor3 = Theme.CardHover }) end)
        b.MouseLeave:Connect(function() tween(b, 0.12, { BackgroundColor3 = Theme.Card }) end)
        return b
    end

    local MinBtn = winBtn("Minimize", "minimize", -64)
    local CloseBtn = winBtn("Close", "close", -34)
    CloseBtn.MouseButton1Click:Connect(function()
        NOFLY()
        ScreenGui:Destroy()
    end)

    reg(ThemeRegistry.dividers, new("Frame", {
        Size = UDim2.new(1, -28, 0, 1), Position = UDim2.new(0, 14, 0, 54),
        BackgroundColor3 = Theme.Divider, BorderSizePixel = 0, Parent = Content,
    }))

    -- Pages container
    local Pages = new("Frame", {
        Size = UDim2.new(1, -20, 1, -62), Position = UDim2.new(0, 10, 0, 60),
        BackgroundTransparency = 1, Parent = Content,
    })

    -- ============================================================
    -- PAGE: INFO
    -- ============================================================
    local PageInfo = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = Pages })

    local InfoScroll = new("ScrollingFrame", {
        Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, BorderSizePixel = 0,
        ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.Border,
        CanvasSize = UDim2.new(0,0,0,0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = PageInfo,
    })
    new("UIPadding", { PaddingTop = UDim.new(0,6), PaddingLeft = UDim.new(0,6), PaddingRight = UDim.new(0,6), PaddingBottom = UDim.new(0,6), Parent = InfoScroll })
    new("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = InfoScroll })

    -- ---- CARD: MY PROFILE ----
    local ProfileCard = reg(ThemeRegistry.cards, new("Frame", {
        Size = UDim2.new(1, 0, 0, 96),
        BackgroundColor3 = Theme.Card, BorderSizePixel = 0, LayoutOrder = 1,
        Parent = InfoScroll,
    }))
    corner(12, ProfileCard)
    reg(ThemeRegistry.strokes, stroke(Theme.Border, 1, ProfileCard))

    -- Avatar sendiri
    local myAvatarFrame = new("Frame", {
        Size = UDim2.new(0, 64, 0, 64), Position = UDim2.new(0, 16, 0.5, -32),
        BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = ProfileCard,
    })
    corner(32, myAvatarFrame)
    new("ImageLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Image = getHeadshot(LocalPlayer.UserId),
        Parent = myAvatarFrame,
    })
    local myAvatarCorner = new("UICorner", { CornerRadius = UDim.new(1, 0), Parent = myAvatarFrame })
    myAvatarFrame:FindFirstChildOfClass("ImageLabel"):FindFirstChildOfClass("UICorner") or new("UICorner", { CornerRadius = UDim.new(1,0), Parent = myAvatarFrame:FindFirstChildOfClass("ImageLabel") })

    reg(ThemeRegistry.texts, new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 20), Position = UDim2.new(0, 96, 0, 18),
        BackgroundTransparency = 1, Text = LocalPlayer.DisplayName,
        TextColor3 = Theme.Text, TextSize = 15, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = ProfileCard,
    }))
    reg(ThemeRegistry.textMuted, new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 14), Position = UDim2.new(0, 96, 0, 40),
        BackgroundTransparency = 1, Text = "@" .. LocalPlayer.Name,
        TextColor3 = Theme.TextMuted, TextSize = 11, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = ProfileCard,
    }))
    reg(ThemeRegistry.accents, new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 14), Position = UDim2.new(0, 96, 0, 58),
        BackgroundTransparency = 1, Text = "User ID: " .. LocalPlayer.UserId,
        TextColor3 = Theme.Accent, TextSize = 10, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = ProfileCard,
    }))

    -- ---- CARD: SERVER PLAYERS ----
    local PlayersCard = reg(ThemeRegistry.cards, new("Frame", {
        Size = UDim2.new(1, 0, 0, 320),
        BackgroundColor3 = Theme.Card, BorderSizePixel = 0, LayoutOrder = 2,
        Parent = InfoScroll,
    }))
    corner(12, PlayersCard)
    reg(ThemeRegistry.strokes, stroke(Theme.Border, 1, PlayersCard))

    reg(ThemeRegistry.texts, new("TextLabel", {
        Size = UDim2.new(1, -24, 0, 20), Position = UDim2.new(0, 16, 0, 14),
        BackgroundTransparency = 1, Text = "Players in Server",
        TextColor3 = Theme.Text, TextSize = 13, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = PlayersCard,
    }))
    local playerCountLabel = reg(ThemeRegistry.accents, new("TextLabel", {
        Size = UDim2.new(0, 100, 0, 20), Position = UDim2.new(1, -116, 0, 14),
        BackgroundTransparency = 1, Text = "0 / 0",
        TextColor3 = Theme.Accent, TextSize = 12, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Right, Parent = PlayersCard,
    }))

    local PlayerList = new("ScrollingFrame", {
        Size = UDim2.new(1, -16, 1, -50), Position = UDim2.new(0, 8, 0, 42),
        BackgroundTransparency = 1, BorderSizePixel = 0,
        ScrollBarThickness = 3, ScrollBarImageColor3 = Theme.Border,
        CanvasSize = UDim2.new(0,0,0,0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = PlayersCard,
    })
    new("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, Parent = PlayerList })

    local function buildPlayerRow(plr, index)
        local Row = reg(ThemeRegistry.cards, new("Frame", {
            Size = UDim2.new(1, -6, 0, 44),
            BackgroundColor3 = Theme.CardHover, BorderSizePixel = 0,
            LayoutOrder = index, Parent = PlayerList,
        }))
        corner(8, Row)
        reg(ThemeRegistry.strokes, stroke(Theme.Border, 1, Row))

        local avFrame = new("Frame", {
            Size = UDim2.new(0, 32, 0, 32), Position = UDim2.new(0, 8, 0.5, -16),
            BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = Row,
        })
        corner(16, avFrame)
        local img = new("ImageLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Image = getHeadshot(plr.UserId),
            Parent = avFrame,
        })
        corner(16, img)

        reg(ThemeRegistry.texts, new("TextLabel", {
            Size = UDim2.new(1, -70, 0, 16), Position = UDim2.new(0, 48, 0, 6),
            BackgroundTransparency = 1, Text = plr.DisplayName,
            TextColor3 = Theme.Text, TextSize = 11, Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = Row,
        }))
        reg(ThemeRegistry.textMuted, new("TextLabel", {
            Size = UDim2.new(1, -70, 0, 14), Position = UDim2.new(0, 48, 0, 24),
            BackgroundTransparency = 1, Text = "@" .. plr.Name,
            TextColor3 = Theme.TextMuted, TextSize = 9, Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = Row,
        }))
    end

    local function refreshPlayers()
        for _, c in pairs(PlayerList:GetChildren()) do
            if c:IsA("Frame") then c:Destroy() end
        end
        local all = Players:GetPlayers()
        table.sort(all, function(a, b) return a.DisplayName:lower() < b.DisplayName:lower() end)
        for i, plr in ipairs(all) do
            buildPlayerRow(plr, i)
        end
        playerCountLabel.Text = #all .. " / " .. Players.MaxPlayers
    end

    refreshPlayers()
    Players.PlayerAdded:Connect(function() task.wait(0.5); refreshPlayers() end)
    Players.PlayerRemoving:Connect(function() task.wait(0.5); refreshPlayers() end)

    -- ---- CARD: DEVELOPER INFO ----
    local DevCard = reg(ThemeRegistry.cards, new("Frame", {
        Size = UDim2.new(1, 0, 0, 150),
        BackgroundColor3 = Theme.Card, BorderSizePixel = 0, LayoutOrder = 3,
        Parent = InfoScroll,
    }))
    corner(12, DevCard)
    reg(ThemeRegistry.strokes, stroke(Theme.Border, 1, DevCard))

    reg(ThemeRegistry.texts, new("TextLabel", {
        Size = UDim2.new(1, -24, 0, 20), Position = UDim2.new(0, 16, 0, 14),
        BackgroundTransparency = 1, Text = "Developer Info",
        TextColor3 = Theme.Text, TextSize = 13, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = DevCard,
    }))

    local function devRow(y, label, value, url)
        local row = reg(ThemeRegistry.cards, new("TextButton", {
            Size = UDim2.new(1, -24, 0, 28), Position = UDim2.new(0, 12, 0, y),
            BackgroundColor3 = Theme.CardHover, BorderSizePixel = 0,
            Text = "", Parent = DevCard,
        }))
        corner(6, row)
        reg(ThemeRegistry.strokes, stroke(Theme.Border, 1, row))
        reg(ThemeRegistry.texts, new("TextLabel", {
            Size = UDim2.new(0, 80, 1, 0), Position = UDim2.new(0, 10, 0, 0),
            BackgroundTransparency = 1, Text = label,
            TextColor3 = Theme.Text, TextSize = 10, Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = row,
        }))
        reg(ThemeRegistry.accents, new("TextLabel", {
            Size = UDim2.new(1, -100, 1, 0), Position = UDim2.new(0, 90, 0, 0),
            BackgroundTransparency = 1, Text = value,
            TextColor3 = Theme.Accent, TextSize = 10, Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = row,
        }))
        row.MouseButton1Click:Connect(function()
            pcall(function() game:GetService("GuiService"):OpenBrowserWindow(url) end)
        end)
    end

    devRow(44, "TikTok", CONFIG.Developer.TikTok, "https://tiktok.com/" .. CONFIG.Developer.TikTok)
    devRow(76, "Discord", CONFIG.Developer.Discord, "https://" .. CONFIG.Developer.Discord)
    devRow(108, "YouTube", CONFIG.Developer.YouTube, "https://youtube.com/" .. CONFIG.Developer.YouTube)

    -- ============================================================
    -- PAGE: MAIN (FLY)
    -- ============================================================
    local PageMain = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Visible = false, Parent = Pages })

    local MainScroll = new("ScrollingFrame", {
        Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, BorderSizePixel = 0,
        ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.Border,
        CanvasSize = UDim2.new(0,0,0,0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = PageMain,
    })
    new("UIPadding", { PaddingTop = UDim.new(0,6), PaddingLeft = UDim.new(0,6), PaddingRight = UDim.new(0,6), PaddingBottom = UDim.new(0,6), Parent = MainScroll })
    new("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = MainScroll })

    -- FLY TOGGLE CARD
    local FlyToggle = reg(ThemeRegistry.cards, new("Frame", {
        Size = UDim2.new(1, 0, 0, 68),
        BackgroundColor3 = Theme.Card, BorderSizePixel = 0, LayoutOrder = 1,
        Parent = MainScroll,
    }))
    corner(12, FlyToggle)
    local flyStroke = reg(ThemeRegistry.strokes, stroke(Theme.Border, 1, FlyToggle))

    local flyIconHolder = new("Frame", { Size = UDim2.new(0, 20, 0, 20), Position = UDim2.new(0, 16, 0.5, -10), BackgroundTransparency = 1, Parent = FlyToggle })
    makeIcon(flyIconHolder, "Fly", "fly", Theme.Accent)

    reg(ThemeRegistry.texts, new("TextLabel", {
        Size = UDim2.new(1, -130, 0, 18), Position = UDim2.new(0, 48, 0, 14),
        BackgroundTransparency = 1, Text = "FLY",
        TextColor3 = Theme.Text, TextSize = 15, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = FlyToggle,
    }))
    local flyStateText = reg(ThemeRegistry.textMuted, new("TextLabel", {
        Size = UDim2.new(1, -130, 0, 14), Position = UDim2.new(0, 48, 0, 36),
        BackgroundTransparency = 1, Text = "Disabled",
        TextColor3 = Theme.TextMuted, TextSize = 10, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = FlyToggle,
    }))

    local toggleBg = reg(ThemeRegistry.sidebars, new("TextButton", {
        Size = UDim2.new(0, 52, 0, 28), Position = UDim2.new(1, -68, 0.5, -14),
        BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Text = "", Parent = FlyToggle,
    }))
    corner(100, toggleBg)
    local toggleDot = reg(ThemeRegistry.textMuted, new("Frame", {
        Size = UDim2.new(0, 22, 0, 22), Position = UDim2.new(0, 3, 0.5, -11),
        BackgroundColor3 = Theme.TextMuted, BorderSizePixel = 0, Parent = toggleBg,
    }))
    corner(100, toggleDot)

    local flyOn = false
    local function updateToggle()
        if flyOn then
            tween(toggleBg, 0.15, { BackgroundColor3 = Theme.Accent })
            tween(toggleDot, 0.15, { Position = UDim2.new(1, -25, 0.5, -11), BackgroundColor3 = Color3.fromRGB(255,255,255) })
            flyStateText.Text = "Enabled"
            flyStateText.TextColor3 = Theme.Success
            flyStroke.Color = Theme.Accent
            flyStateText:FindFirstChildOfClass("UIStroke")
        else
            tween(toggleBg, 0.15, { BackgroundColor3 = Theme.Sidebar })
            tween(toggleDot, 0.15, { Position = UDim2.new(0, 3, 0.5, -11), BackgroundColor3 = Theme.TextMuted })
            flyStateText.Text = "Disabled"
            flyStateText.TextColor3 = Theme.TextMuted
            flyStroke.Color = Theme.Border
        end
    end

    toggleBg.MouseButton1Click:Connect(function()
        flyOn = not flyOn
        updateToggle()
        if flyOn then
            NOFLY(); task.wait(0.05); sFLY()
        else
            NOFLY()
        end
    end)

    -- SPEED CARD (max 1000)
    local SpeedCard = reg(ThemeRegistry.cards, new("Frame", {
        Size = UDim2.new(1, 0, 0, 100),
        BackgroundColor3 = Theme.Card, BorderSizePixel = 0, LayoutOrder = 2,
        Parent = MainScroll,
    }))
    corner(12, SpeedCard)
    reg(ThemeRegistry.strokes, stroke(Theme.Border, 1, SpeedCard))

    local speedIconHolder = new("Frame", { Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(0, 16, 0, 14), BackgroundTransparency = 1, Parent = SpeedCard })
    makeIcon(speedIconHolder, "Speed", "speed", Theme.Text)

    reg(ThemeRegistry.texts, new("TextLabel", {
        Size = UDim2.new(1, -140, 0, 16), Position = UDim2.new(0, 46, 0, 14),
        BackgroundTransparency = 1, Text = "Fly Speed",
        TextColor3 = Theme.Text, TextSize = 13, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = SpeedCard,
    }))

    local speedValue = reg(ThemeRegistry.accents, new("TextLabel", {
        Size = UDim2.new(0, 80, 0, 16), Position = UDim2.new(1, -96, 0, 14),
        BackgroundTransparency = 1, Text = "1",
        TextColor3 = Theme.Accent, TextSize = 13, Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Right, Parent = SpeedCard,
    }))

    local sliderBar = reg(ThemeRegistry.sidebars, new("Frame", {
        Size = UDim2.new(1, -32, 0, 6), Position = UDim2.new(0, 16, 0, 62),
        BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = SpeedCard,
    }))
    corner(100, sliderBar)
    local sliderFill = reg(ThemeRegistry.accents, new("Frame", {
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Parent = sliderBar,
    }))
    corner(100, sliderFill)
    local sliderDot = new("Frame", {
        Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, -7, 0.5, -7),
        BackgroundColor3 = Color3.fromRGB(255,255,255), BorderSizePixel = 0, Parent = sliderBar,
    })
    corner(100, sliderDot)

    reg(ThemeRegistry.textMuted, new("TextLabel", {
        Size = UDim2.new(1, -32, 0, 14), Position = UDim2.new(0, 16, 0, 76),
        BackgroundTransparency = 1, Text = "1                                        1000",
        TextColor3 = Theme.TextMuted, TextSize = 9, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Center, Parent = SpeedCard,
    }))

    local sDrag = false
    local MIN_SPD, MAX_SPD = 1, 1000

    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        local val = math.floor(MIN_SPD + (MAX_SPD - MIN_SPD) * pos)
        iyflyspeed = val
        vehicleflyspeed = val
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        sliderDot.Position = UDim2.new(pos, -7, 0.5, -7)
        speedValue.Text = tostring(val)
    end
    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sDrag = true; updateSlider(input)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if sDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sDrag = false
        end
    end)

    -- Quick buttons
    local quickRow = new("Frame", {
        Size = UDim2.new(1, 0, 0, 32), BackgroundTransparency = 1,
        LayoutOrder = 3, Parent = MainScroll,
    })
    new("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, Parent = quickRow })

    for _, preset in ipairs({1, 10, 50, 100, 500, 1000}) do
        local pb = reg(ThemeRegistry.cards, new("TextButton", {
            Size = UDim2.new(0, 88, 0, 32),
            BackgroundColor3 = Theme.Card, BorderSizePixel = 0,
            Text = tostring(preset), TextColor3 = Theme.Text,
            TextSize = 11, Font = Enum.Font.GothamBlack,
            LayoutOrder = preset, Parent = quickRow,
        }))
        corner(8, pb)
        local pbs = reg(ThemeRegistry.strokes, stroke(Theme.Border, 1, pb))
        pb.MouseButton1Click:Connect(function()
            iyflyspeed = preset
            vehicleflyspeed = preset
            local pos = (preset - MIN_SPD) / (MAX_SPD - MIN_SPD)
            sliderFill.Size = UDim2.new(pos, 0, 1, 0)
            sliderDot.Position = UDim2.new(pos, -7, 0.5, -7)
            speedValue.Text = tostring(preset)
        end)
        pb.MouseEnter:Connect(function()
            tween(pb, 0.12, { BackgroundColor3 = Theme.CardHover })
        end)
        pb.MouseLeave:Connect(function()
            tween(pb, 0.12, { BackgroundColor3 = Theme.Card })
        end)
    end

    -- ============================================================
    -- PAGE: THEME
    -- ============================================================
    local PageTheme = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Visible = false, Parent = Pages })

    local ThemeScroll = new("ScrollingFrame", {
        Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, BorderSizePixel = 0,
        ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.Border,
        CanvasSize = UDim2.new(0,0,0,0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = PageTheme,
    })
    new("UIPadding", { PaddingTop = UDim.new(0,6), PaddingLeft = UDim.new(0,6), PaddingRight = UDim.new(0,6), PaddingBottom = UDim.new(0,6), Parent = ThemeScroll })
    new("UIGridLayout", {
        CellSize = UDim2.new(0.5, -6, 0, 60),
        CellPadding = UDim2.new(0, 10, 0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = ThemeScroll,
    })

    for i, themeName in ipairs(ThemeOrder) do
        local th = Themes[themeName]
        local card = reg(ThemeRegistry.cards, new("TextButton", {
            BackgroundColor3 = Theme.Card, BorderSizePixel = 0,
            Text = "", LayoutOrder = i, Parent = ThemeScroll,
        }))
        corner(10, card)
        reg(ThemeRegistry.strokes, stroke(Theme.Border, 1, card))

        -- color swatch
        local swatch = new("Frame", {
            Size = UDim2.new(0, 22, 0, 22), Position = UDim2.new(0, 14, 0.5, -11),
            BackgroundColor3 = th.Accent, BorderSizePixel = 0, Parent = card,
        })
        corner(11, swatch)

        local nameLabel = reg(ThemeRegistry.texts, new("TextLabel", {
            Size = UDim2.new(1, -60, 0, 18), Position = UDim2.new(0, 46, 0, 12),
            BackgroundTransparency = 1, Text = th.name,
            TextColor3 = Theme.Text, TextSize = 12, Font = Enum.Font.GothamBlack,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = card,
        }))
        local accentLabel = reg(ThemeRegistry.textMuted, new("TextLabel", {
            Size = UDim2.new(1, -60, 0, 14), Position = UDim2.new(0, 46, 0, 32),
            BackgroundTransparency = 1, Text = "Tap to apply",
            TextColor3 = Theme.TextMuted, TextSize = 9, Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = card,
        }))

        card.MouseEnter:Connect(function() tween(card, 0.12, { BackgroundColor3 = Theme.CardHover }) end)
        card.MouseLeave:Connect(function() tween(card, 0.12, { BackgroundColor3 = Theme.Card }) end)

        card.MouseButton1Click:Connect(function()
            applyTheme(themeName)
            -- update semua swatch dynamic (background of card)
            for _, c in pairs(ThemeScroll:GetChildren()) do
                if c:IsA("TextButton") then
                    c.BackgroundColor3 = Theme.Card
                    local s = c:FindFirstChildOfClass("UIStroke")
                    if s then s.Color = Theme.Border end
                end
            end
        end)
    end

    -- ============================================================
    -- SIDEBAR BUTTONS
    -- ============================================================
    local Pages_ = {
        { id = "info", label = "Info", icon = "Info", fallback = "info", page = PageInfo, title = "Info", sub = "Server & developer info" },
        { id = "main", label = "Main", icon = "Fly", fallback = "fly", page = PageMain, title = "Main", sub = "Fly feature" },
        { id = "theme", label = "Theme", icon = "Palette", fallback = "palette", page = PageTheme, title = "Theme", sub = "Pick your color" },
    }

    local sidebarButtons = {}

    local function selectPage(id)
        for _, p in ipairs(Pages_) do
            p.page.Visible = (p.id == id)
        end
        for _, b in pairs(sidebarButtons) do
            local active = (b._id == id)
            tween(b, 0.12, { BackgroundColor3 = active and Theme.CardHover or Theme.Sidebar })
            tween(b._label, 0.12, { TextColor3 = active and Theme.Text or Theme.TextMuted })
            b._indicator.Visible = active
        end
    end

    for i, p in ipairs(Pages_) do
        local Btn = reg(ThemeRegistry.sidebars, new("TextButton", {
            Size = UDim2.new(1, 0, 0, 38),
            BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0,
            Text = "", LayoutOrder = i, Parent = ListFrame,
        }))
        corner(8, Btn)

        -- active indicator (bar kiri)
        local indicator = reg(ThemeRegistry.accents, new("Frame", {
            Size = UDim2.new(0, 3, 0, 22), Position = UDim2.new(0, 0, 0.5, -11),
            BackgroundColor3 = Theme.Accent, BorderSizePixel = 0,
            Visible = false, Parent = Btn,
        }))
        corner(2, indicator)

        local iconHolder = new("Frame", {
            Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(0, 14, 0.5, -9),
            BackgroundTransparency = 1, Parent = Btn,
        })
        makeIcon(iconHolder, p.icon, p.fallback, Theme.TextMuted)

        local label = reg(ThemeRegistry.textMuted, new("TextLabel", {
            Size = UDim2.new(1, -50, 1, 0), Position = UDim2.new(0, 40, 0, 0),
            BackgroundTransparency = 1, Text = p.label,
            TextColor3 = Theme.TextMuted, TextSize = 12, Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = Btn,
        }))

        Btn._id = p.id
        Btn._label = label
        Btn._indicator = indicator

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

        table.insert(sidebarButtons, Btn)
    end

    selectPage("info")
end

-- ============================================================
-- START
-- ============================================================
buildKeyUI(function()
    buildMainUI()
end)

print("[Hallwayz] Loaded — Dynamic Edition v" .. CONFIG.Version)
