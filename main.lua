--[[
    Hallwayz Fly
    Load: loadstring(game:HttpGet("https://raw.githubusercontent.com/ZurraOfficial/Hallwayz/main/main.lua"))()
]]

local CONFIG = {
    Name = "FLY NA SAGAPUNG BRO",
    Subtitle = "BY ARYA X SALMAN SAGAPUNG",
    Version = "v1.0.0",
    KeysURL = "https://raw.githubusercontent.com/ZurraOfficial/Fly/main/keys.txt",
    DiscordURL = "https://discord.gg/GANTI_INVITE",
}

local Theme = {
    BG          = Color3.fromRGB(11, 11, 16),
    Sidebar     = Color3.fromRGB(15, 15, 22),
    Card        = Color3.fromRGB(20, 20, 30),
    CardHover   = Color3.fromRGB(26, 26, 38),
    Border      = Color3.fromRGB(30, 30, 44),
    BorderHover = Color3.fromRGB(48, 48, 66),
    Text        = Color3.fromRGB(232, 232, 240),
    TextMuted   = Color3.fromRGB(105, 105, 128),
    Accent      = Color3.fromRGB(107, 127, 255),
    AccentDark  = Color3.fromRGB(75, 95, 220),
    AccentGlow  = Color3.fromRGB(140, 155, 255),
    Success     = Color3.fromRGB(74, 222, 128),
    Error       = Color3.fromRGB(248, 113, 113),
    Warning     = Color3.fromRGB(250, 204, 21),
    Divider     = Color3.fromRGB(26, 26, 38),
}

local Players           = game:GetService("Players")
local CoreGui           = game:GetService("CoreGui")
local TweenService      = game:GetService("TweenService")
local UserInputService  = game:GetService("UserInputService")
local RunService        = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

for _, obj in pairs(CoreGui:GetChildren()) do
    if obj.Name == "HallwayzFly" then obj:Destroy() end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HallwayzFly"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = CoreGui

-- ============================================================
-- HELPERS
-- ============================================================
local function new(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do obj[k] = v end
    return obj
end

local function corner(r, p) return new("UICorner", { CornerRadius = UDim.new(0, r or 8), Parent = p }) end
local function stroke(c, t, p) return new("UIStroke", { Color = c, Thickness = t or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = p }) end
local function tween(o, t, p)
    local tw = TweenService:Create(o, TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), p)
    tw:Play(); return tw
end

-- ============================================================
-- VECTOR ICONS
-- ============================================================
local IconLib = {}

function IconLib.Close(parent, color)
    local holder = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    new("Frame", { Size = UDim2.new(0,12,0,2), Position = UDim2.new(0,1,0,6), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = 45, Parent = holder })
    new("Frame", { Size = UDim2.new(0,12,0,2), Position = UDim2.new(0,1,0,6), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = -45, Parent = holder })
    return holder
end

function IconLib.Minimize(parent, color)
    local holder = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    new("Frame", { Size = UDim2.new(0,12,0,2), Position = UDim2.new(0,1,0,7), BackgroundColor3 = color, BorderSizePixel = 0, Parent = holder })
    return holder
end

function IconLib.Search(parent, color)
    local holder = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    local circle = new("Frame", { Size = UDim2.new(0,10,0,10), Position = UDim2.new(0,1,0,1), BackgroundColor3 = color, BorderSizePixel = 0, Parent = holder })
    corner(100, circle)
    local hole = new("Frame", { Size = UDim2.new(0,6,0,6), Position = UDim2.new(0,2,0,2), BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = circle })
    corner(100, hole)
    new("Frame", { Size = UDim2.new(0,2,0,6), Position = UDim2.new(0,10,0,10), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = -45, Parent = holder })
    return holder
end

function IconLib.Key(parent, color)
    local holder = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    local head = new("Frame", { Size = UDim2.new(0,8,0,8), Position = UDim2.new(0,1,0,4), BackgroundColor3 = color, BorderSizePixel = 0, Parent = holder })
    corner(100, head)
    local hole = new("Frame", { Size = UDim2.new(0,3,0,3), Position = UDim2.new(0.5,-1.5,0.5,-1.5), BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = head })
    corner(100, hole)
    new("Frame", { Size = UDim2.new(0,9,0,2), Position = UDim2.new(0,8,0,8), BackgroundColor3 = color, BorderSizePixel = 0, Parent = holder })
    new("Frame", { Size = UDim2.new(0,2,0,3), Position = UDim2.new(0,12,0,8), BackgroundColor3 = color, BorderSizePixel = 0, Parent = holder })
    new("Frame", { Size = UDim2.new(0,2,0,3), Position = UDim2.new(0,15,0,8), BackgroundColor3 = color, BorderSizePixel = 0, Parent = holder })
    return holder
end

function IconLib.Wing(parent, color)
    local holder = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    new("Frame", { Size = UDim2.new(0,14,0,3), Position = UDim2.new(0,1,0,4), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = -20, Parent = holder })
    new("Frame", { Size = UDim2.new(0,12,0,3), Position = UDim2.new(0,1,0,8), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = -10, Parent = holder })
    new("Frame", { Size = UDim2.new(0,9,0,3), Position = UDim2.new(0,1,0,12), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = 5, Parent = holder })
    return holder
end

function IconLib.Speed(parent, color)
    local holder = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    new("Frame", { Size = UDim2.new(0,14,0,2), Position = UDim2.new(0,1,0,4), BackgroundColor3 = color, BorderSizePixel = 0, Parent = holder })
    new("Frame", { Size = UDim2.new(0,10,0,2), Position = UDim2.new(0,1,0,8), BackgroundColor3 = color, BorderSizePixel = 0, Parent = holder })
    new("Frame", { Size = UDim2.new(0,14,0,2), Position = UDim2.new(0,1,0,12), BackgroundColor3 = color, BorderSizePixel = 0, Parent = holder })
    return holder
end

function IconLib.Setting(parent, color)
    local holder = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    local outer = new("Frame", { Size = UDim2.new(0,12,0,12), Position = UDim2.new(0,2,0,2), BackgroundColor3 = color, BorderSizePixel = 0, Parent = holder })
    corner(100, outer)
    local inner = new("Frame", { Size = UDim2.new(0,4,0,4), Position = UDim2.new(0.5,-2,0.5,-2), BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = outer })
    corner(100, inner)
    return holder
end

function IconLib.Info(parent, color)
    local holder = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    local outer = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundColor3 = color, BorderSizePixel = 0, Parent = holder })
    corner(100, outer)
    local inner = new("Frame", { Size = UDim2.new(1,-4,1,-4), Position = UDim2.new(0,2,0,2), BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = holder })
    corner(100, inner)
    new("Frame", { Size = UDim2.new(0,2,0,2), Position = UDim2.new(0.5,-1,0,3), BackgroundColor3 = color, BorderSizePixel = 0, Parent = holder })
    new("Frame", { Size = UDim2.new(0,2,0,6), Position = UDim2.new(0.5,-1,0,7), BackgroundColor3 = color, BorderSizePixel = 0, Parent = holder })
    return holder
end

-- ============================================================
-- LOGO
-- ============================================================
local function buildLogo(parent, size)
    size = size or 30
    local holder = new("Frame", { Size = UDim2.new(0, size, 0, size), BackgroundTransparency = 1, Parent = parent })
    local sk = size / 32
    new("Frame", { Size = UDim2.new(0, 8*sk, 0, 13*sk), Position = UDim2.new(0, 6*sk, 0, 3*sk), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Rotation = 20, Parent = holder })
    new("Frame", { Size = UDim2.new(0, 8*sk, 0, 13*sk), Position = UDim2.new(0, 6*sk, 0, 16*sk), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Rotation = 20, Parent = holder })
    new("Frame", { Size = UDim2.new(0, 9*sk, 0, 26*sk), Position = UDim2.new(0, 17*sk, 0, 3*sk), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Rotation = 20, Parent = holder })
    new("Frame", { Size = UDim2.new(0, 11*sk, 0, 2*sk), Position = UDim2.new(0, 7*sk, 0, 15*sk), BackgroundColor3 = Theme.AccentGlow, BorderSizePixel = 0, Rotation = -25, Parent = holder })
    return holder
end

-- ============================================================
-- FLY MODULE (Infinite Yield style, works all games)
-- ============================================================
local FlyState = {
    Enabled = false,
    Speed = 100,
    Keys = {
        Forward  = Enum.KeyCode.W,
        Backward = Enum.KeyCode.S,
        Left     = Enum.KeyCode.A,
        Right    = Enum.KeyCode.D,
        Up       = Enum.KeyCode.Space,
        Down     = Enum.KeyCode.LeftControl,
    },
    Connection = nil,
    BodyVelocity = nil,
    BodyGyro = nil,
}

local function cleanupFly()
    if FlyState.Connection then
        FlyState.Connection:Disconnect()
        FlyState.Connection = nil
    end
    if FlyState.BodyVelocity then
        pcall(function() FlyState.BodyVelocity:Destroy() end)
        FlyState.BodyVelocity = nil
    end
    if FlyState.BodyGyro then
        pcall(function() FlyState.BodyGyro:Destroy() end)
        FlyState.BodyGyro = nil
    end

    -- Restore humanoid state
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            hum.PlatformStand = false
        end
    end
end

local function startFly()
    cleanupFly()

    local char = LocalPlayer.Character
    if not char then return end

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root then return end

    -- Set humanoid to platform stand (like IY)
    humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    humanoid.PlatformStand = true

    -- BodyVelocity
    local bv = Instance.new("BodyVelocity")
    bv.Name = "HallwayzFlyVelocity"
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Velocity = Vector3.zero
    bv.P = 1250
    bv.Parent = root

    -- BodyGyro (stabilisasi)
    local bg = Instance.new("BodyGyro")
    bg.Name = "HallwayzFlyGyro"
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.P = 1250
    bg.D = 50
    bg.CFrame = root.CFrame
    bg.Parent = root

    FlyState.BodyVelocity = bv
    FlyState.BodyGyro = bg

    -- Update loop
    FlyState.Connection = RunService.RenderStepped:Connect(function()
        if not FlyState.Enabled then return end
        if not root or not root.Parent then return end
        if not Camera then return end

        local camCF = Camera.CFrame
        local dir = Vector3.zero

        if UserInputService:IsKeyDown(FlyState.Keys.Forward) then
            dir = dir + camCF.LookVector
        end
        if UserInputService:IsKeyDown(FlyState.Keys.Backward) then
            dir = dir - camCF.LookVector
        end
        if UserInputService:IsKeyDown(FlyState.Keys.Left) then
            dir = dir - camCF.RightVector
        end
        if UserInputService:IsKeyDown(FlyState.Keys.Right) then
            dir = dir + camCF.RightVector
        end
        if UserInputService:IsKeyDown(FlyState.Keys.Up) then
            dir = dir + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(FlyState.Keys.Down) then
            dir = dir - Vector3.new(0, 1, 0)
        end

        if dir.Magnitude > 0 then
            bv.Velocity = dir.Unit * FlyState.Speed
        else
            bv.Velocity = Vector3.zero
        end

        bg.CFrame = camCF
    end)

    -- Auto cleanup on death
    humanoid.Died:Connect(function()
        FlyState.Enabled = false
        cleanupFly()
    end)

    char.AncestryChanged:Connect(function(_, parent)
        if not parent then
            FlyState.Enabled = false
            cleanupFly()
        end
    end)
end

local function setFly(enabled)
    if enabled then
        FlyState.Enabled = true
        startFly()
    else
        FlyState.Enabled = false
        cleanupFly()
    end
end

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
    if not inputKey or inputKey == "" then return false, "Key tidak boleh kosong" end
    local vk = fetchValidKeys()
    if vk[inputKey:lower()] then return true, "Key valid" end
    return false, "Key tidak valid"
end

-- ============================================================
-- KEY UI
-- ============================================================
local function buildKeyUI(onSuccess)
    local Dim = new("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Parent = ScreenGui,
    })

    local KeyCard = new("Frame", {
        Size = UDim2.new(0, 380, 0, 290),
        Position = UDim2.new(0.5, -190, 0.5, -145),
        BackgroundColor3 = Theme.BG,
        BorderSizePixel = 0,
        Parent = Dim,
    })
    corner(14, KeyCard)
    stroke(Theme.Border, 1, KeyCard)

    local glow = new("UIStroke", { Color = Theme.Accent, Thickness = 1.5, Transparency = 0.7, Parent = KeyCard })
    task.spawn(function()
        while KeyCard.Parent do
            tween(glow, 2, { Transparency = 0.2 })
            task.wait(2)
            tween(glow, 2, { Transparency = 0.85 })
            task.wait(2)
        end
    end)

    local uk = new("UIScale", { Scale = 1, Parent = KeyCard })
    local function updScale()
        local vp = Camera.ViewportSize
        uk.Scale = math.min((vp.X * 0.9) / 380, (vp.Y * 0.9) / 290, 1)
    end
    updScale()
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(updScale)

    local Header = new("Frame", {
        Size = UDim2.new(1, 0, 0, 64),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0,
        Parent = KeyCard,
    })
    corner(14, Header)
    new("Frame", { Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 1, -14), BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = Header })

    local logoHolder = new("Frame", { Size = UDim2.new(0, 32, 0, 32), Position = UDim2.new(0, 16, 0.5, -16), BackgroundTransparency = 1, Parent = Header })
    buildLogo(logoHolder, 32)

    new("TextLabel", {
        Size = UDim2.new(1, -70, 0, 18),
        Position = UDim2.new(0, 58, 0, 15),
        BackgroundTransparency = 1,
        Text = CONFIG.Name,
        TextColor3 = Theme.Text,
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Header,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -70, 0, 13),
        Position = UDim2.new(0, 58, 0, 34),
        BackgroundTransparency = 1,
        Text = "Key System • " .. CONFIG.Version,
        TextColor3 = Theme.TextMuted,
        TextSize = 10,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Header,
    })

    local keyClose = new("TextButton", {
        Size = UDim2.new(0, 26, 0, 26),
        Position = UDim2.new(1, -38, 0, 19),
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        Text = "",
        Parent = Header,
    })
    corner(6, keyClose)
    local kcHolder = new("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0.5, -7, 0.5, -7), BackgroundTransparency = 1, Parent = keyClose })
    IconLib.Close(kcHolder, Theme.TextMuted)

    keyClose.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
    keyClose.MouseEnter:Connect(function() tween(keyClose, 0.12, { BackgroundColor3 = Theme.CardHover }) end)
    keyClose.MouseLeave:Connect(function() tween(keyClose, 0.12, { BackgroundColor3 = Theme.Card }) end)

    local Body = new("Frame", {
        Size = UDim2.new(1, -28, 1, -84),
        Position = UDim2.new(0, 14, 0, 80),
        BackgroundTransparency = 1,
        Parent = KeyCard,
    })

    new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 16),
        BackgroundTransparency = 1,
        Text = "Masukkan key untuk melanjutkan",
        TextColor3 = Theme.Text,
        TextSize = 11,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Body,
    })

    local InputBox = new("Frame", {
        Size = UDim2.new(1, 0, 0, 40),
        Position = UDim2.new(0, 0, 0, 24),
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        Parent = Body,
    })
    corner(8, InputBox)
    local inputStroke = stroke(Theme.Border, 1, InputBox)

    local keyIconHolder = new("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 12, 0.5, -7), BackgroundTransparency = 1, Parent = InputBox })
    IconLib.Key(keyIconHolder, Theme.TextMuted)

    local KeyInput = new("TextBox", {
        Size = UDim2.new(1, -102, 1, 0),
        Position = UDim2.new(0, 34, 0, 0),
        BackgroundTransparency = 1,
        Text = "",
        PlaceholderText = "FREE_XXXXXXXXXXXXXXXX",
        PlaceholderColor3 = Theme.TextMuted,
        TextColor3 = Theme.Text,
        TextSize = 12,
        Font = Enum.Font.Code,
        ClearTextOnFocus = false,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = InputBox,
    })

    local pasteBtn = new("TextButton", {
        Size = UDim2.new(0, 52, 0, 26),
        Position = UDim2.new(1, -58, 0.5, -13),
        BackgroundColor3 = Theme.CardHover,
        BorderSizePixel = 0,
        Text = "Paste",
        TextColor3 = Theme.Text,
        TextSize = 10,
        Font = Enum.Font.GothamMedium,
        Parent = InputBox,
    })
    corner(6, pasteBtn)
    pasteBtn.MouseButton1Click:Connect(function()
        local ok, clip = pcall(function() return game:GetService("GuiService"):GetClipboard() end)
        if ok and clip and clip ~= "" then KeyInput.Text = clip end
    end)

    local StatusLabel = new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 16),
        Position = UDim2.new(0, 0, 0, 74),
        BackgroundTransparency = 1,
        Text = "",
        TextColor3 = Theme.TextMuted,
        TextSize = 10,
        Font = Enum.Font.Gotham,
        Parent = Body,
    })

    local verifyBtn = new("TextButton", {
        Size = UDim2.new(1, 0, 0, 42),
        Position = UDim2.new(0, 0, 0, 96),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        Text = "Verifikasi Key",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        Parent = Body,
    })
    corner(8, verifyBtn)
    verifyBtn.MouseEnter:Connect(function() tween(verifyBtn, 0.12, { BackgroundColor3 = Theme.AccentDark }) end)
    verifyBtn.MouseLeave:Connect(function() tween(verifyBtn, 0.12, { BackgroundColor3 = Theme.Accent }) end)

    -- Info hint
    new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 14),
        Position = UDim2.new(0, 0, 1, -18),
        BackgroundTransparency = 1,
        Text = "Dapatkan key di Discord kami",
        TextColor3 = Theme.TextMuted,
        TextSize = 9,
        Font = Enum.Font.Gotham,
        Parent = Body,
    })

    local function submit()
        local key = KeyInput.Text
        if key == "" then
            StatusLabel.Text = "Key tidak boleh kosong"
            StatusLabel.TextColor3 = Theme.Error
            tween(inputStroke, 0.15, { Color = Theme.Error })
            task.delay(1.5, function() tween(inputStroke, 0.3, { Color = Theme.Border }) end)
            return
        end
        StatusLabel.Text = "Memverifikasi..."
        StatusLabel.TextColor3 = Theme.Warning
        verifyBtn.Text = "..."
        task.wait(0.4)
        local valid, msg = validateKey(key)
        if valid then
            StatusLabel.Text = msg
            StatusLabel.TextColor3 = Theme.Success
            tween(inputStroke, 0.2, { Color = Theme.Success })
            task.wait(0.35)
            tween(Dim, 0.3, { BackgroundTransparency = 1 })
            tween(KeyCard, 0.3, { BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0) })
            task.wait(0.3)
            Dim:Destroy()
            onSuccess()
        else
            StatusLabel.Text = msg
            StatusLabel.TextColor3 = Theme.Error
            verifyBtn.Text = "Verifikasi Key"
            tween(inputStroke, 0.15, { Color = Theme.Error })
            task.delay(1.5, function() tween(inputStroke, 0.3, { Color = Theme.Border }) end)
            local orig = InputBox.Position
            for i = 1, 4 do
                InputBox.Position = orig + UDim2.new(0, (i % 2 == 0 and 6 or -6), 0, 0)
                task.wait(0.035)
            end
            InputBox.Position = orig
        end
    end

    verifyBtn.MouseButton1Click:Connect(submit)
    KeyInput.FocusLost:Connect(function(enter) if enter then submit() end end)
end

-- ============================================================
-- MAIN FLY UI
-- ============================================================
local function buildMainUI()
    local Main = new("Frame", {
        Size = UDim2.new(0, 440, 0, 340),
        Position = UDim2.new(0.5, -220, 0.5, -170),
        BackgroundColor3 = Theme.BG,
        BorderSizePixel = 0,
        Parent = ScreenGui,
    })
    corner(12, Main)
    stroke(Theme.Border, 1, Main)

    local mScale = new("UIScale", { Scale = 1, Parent = Main })
    local function upd()
        local vp = Camera.ViewportSize
        mScale.Scale = math.min((vp.X * 0.9) / 440, (vp.Y * 0.9) / 340, 1)
    end
    upd()
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(upd)

    Main.Size = UDim2.new(0, 0, 0, 0)
    tween(Main, 0.3, { Size = UDim2.new(0, 440, 0, 340) })

    -- Drag
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

    -- Header
    local Header = new("Frame", {
        Size = UDim2.new(1, 0, 0, 56),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0,
        Parent = Main,
    })
    corner(12, Header)
    new("Frame", { Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 1, -14), BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = Header })

    local logoHolder = new("Frame", { Size = UDim2.new(0, 28, 0, 28), Position = UDim2.new(0, 16, 0.5, -14), BackgroundTransparency = 1, Parent = Header })
    buildLogo(logoHolder, 28)

    new("TextLabel", {
        Size = UDim2.new(1, -130, 0, 18),
        Position = UDim2.new(0, 54, 0, 12),
        BackgroundTransparency = 1,
        Text = CONFIG.Name,
        TextColor3 = Theme.Text,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Header,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -130, 0, 12),
        Position = UDim2.new(0, 54, 0, 30),
        BackgroundTransparency = 1,
        Text = "All Games • " .. CONFIG.Version,
        TextColor3 = Theme.TextMuted,
        TextSize = 9,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Header,
    })

    local function winBtn(iconFn, xOffset)
        local b = new("TextButton", {
            Size = UDim2.new(0, 24, 0, 24),
            Position = UDim2.new(1, xOffset, 0, 16),
            BackgroundColor3 = Theme.Card,
            BorderSizePixel = 0,
            Text = "",
            Parent = Header,
        })
        corner(6, b)
        local holder = new("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0.5, -7, 0.5, -7), BackgroundTransparency = 1, Parent = b })
        IconLib[iconFn](holder, Theme.TextMuted)
        b.MouseEnter:Connect(function() tween(b, 0.12, { BackgroundColor3 = Theme.CardHover }) end)
        b.MouseLeave:Connect(function() tween(b, 0.12, { BackgroundColor3 = Theme.Card }) end)
        return b
    end

    local MinBtn = winBtn("Minimize", -64)
    local CloseBtn = winBtn("Close", -34)
    CloseBtn.MouseButton1Click:Connect(function()
        setFly(false)
        ScreenGui:Destroy()
    end)

    -- Body
    local Body = new("Frame", {
        Size = UDim2.new(1, -24, 1, -72),
        Position = UDim2.new(0, 12, 0, 64),
        BackgroundTransparency = 1,
        Parent = Main,
    })

    -- Toggle card
    local ToggleCard = new("Frame", {
        Size = UDim2.new(1, 0, 0, 56),
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        Parent = Body,
    })
    corner(10, ToggleCard)
    stroke(Theme.Border, 1, ToggleCard)

    local wingIconHolder = new("Frame", { Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(0, 14, 0.5, -9), BackgroundTransparency = 1, Parent = ToggleCard })
    IconLib.Wing(wingIconHolder, Theme.Text)

    new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 16),
        Position = UDim2.new(0, 44, 0, 12),
        BackgroundTransparency = 1,
        Text = "Fly",
        TextColor3 = Theme.Text,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = ToggleCard,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 12),
        Position = UDim2.new(0, 44, 0, 30),
        BackgroundTransparency = 1,
        Text = "W A S D • Space / LCtrl",
        TextColor3 = Theme.TextMuted,
        TextSize = 9,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = ToggleCard,
    })

    -- Toggle switch
    local toggleBg = new("TextButton", {
        Size = UDim2.new(0, 42, 0, 22),
        Position = UDim2.new(1, -56, 0.5, -11),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0,
        Text = "",
        Parent = ToggleCard,
    })
    corner(100, toggleBg)
    local toggleDot = new("Frame", {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 3, 0.5, -8),
        BackgroundColor3 = Theme.TextMuted,
        BorderSizePixel = 0,
        Parent = toggleBg,
    })
    corner(100, toggleDot)

    local toggled = false
    local function updateToggle()
        if toggled then
            tween(toggleBg, 0.15, { BackgroundColor3 = Theme.Accent })
            tween(toggleDot, 0.15, { Position = UDim2.new(1, -19, 0.5, -8), BackgroundColor3 = Color3.fromRGB(255,255,255) })
        else
            tween(toggleBg, 0.15, { BackgroundColor3 = Theme.Sidebar })
            tween(toggleDot, 0.15, { Position = UDim2.new(0, 3, 0.5, -8), BackgroundColor3 = Theme.TextMuted })
        end
    end

    toggleBg.MouseButton1Click:Connect(function()
        toggled = not toggled
        updateToggle()
        setFly(toggled)
    end)

    -- Speed card
    local SpeedCard = new("Frame", {
        Size = UDim2.new(1, 0, 0, 100),
        Position = UDim2.new(0, 0, 0, 68),
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        Parent = Body,
    })
    corner(10, SpeedCard)
    stroke(Theme.Border, 1, SpeedCard)

    local speedIconHolder = new("Frame", { Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(0, 14, 0, 14), BackgroundTransparency = 1, Parent = SpeedCard })
    IconLib.Speed(speedIconHolder, Theme.Text)

    new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 16),
        Position = UDim2.new(0, 44, 0, 14),
        BackgroundTransparency = 1,
        Text = "Fly Speed",
        TextColor3 = Theme.Text,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = SpeedCard,
    })

    local speedValueLabel = new("TextLabel", {
        Size = UDim2.new(0, 80, 0, 16),
        Position = UDim2.new(1, -96, 0, 14),
        BackgroundTransparency = 1,
        Text = tostring(FlyState.Speed),
        TextColor3 = Theme.Accent,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = SpeedCard,
    })

    -- Slider
    local sliderBar = new("Frame", {
        Size = UDim2.new(1, -32, 0, 6),
        Position = UDim2.new(0, 16, 0, 62),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0,
        Parent = SpeedCard,
    })
    corner(100, sliderBar)

    local sliderFill = new("Frame", {
        Size = UDim2.new((FlyState.Speed - 10) / 490, 0, 1, 0),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        Parent = sliderBar,
    })
    corner(100, sliderFill)

    local sliderDot = new("Frame", {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new((FlyState.Speed - 10) / 490, -7, 0.5, -7),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Parent = sliderBar,
    })
    corner(100, sliderDot)

    new("TextLabel", {
        Size = UDim2.new(1, -32, 0, 14),
        Position = UDim2.new(0, 16, 0, 76),
        BackgroundTransparency = 1,
        Text = "10                         500",
        TextColor3 = Theme.TextMuted,
        TextSize = 9,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Center,
        Parent = SpeedCard,
    })

    -- Slider drag logic
    local sDrag = false
    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        local val = math.floor(10 + (500 - 10) * pos)
        FlyState.Speed = val
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        sliderDot.Position = UDim2.new(pos, -7, 0.5, -7)
        speedValueLabel.Text = tostring(val)
    end
    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sDrag = true
            updateSlider(input)
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

    -- Quick speed buttons
    local quickRow = new("Frame", {
        Size = UDim2.new(1, 0, 0, 32),
        Position = UDim2.new(0, 0, 0, 180),
        BackgroundTransparency = 1,
        Parent = Body,
    })
    new("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = quickRow,
    })

    for _, preset in ipairs({50, 100, 200, 350, 500}) do
        local pb = new("TextButton", {
            Size = UDim2.new(0, 72, 0, 30),
            BackgroundColor3 = Theme.Card,
            BorderSizePixel = 0,
            Text = tostring(preset),
            TextColor3 = Theme.Text,
            TextSize = 11,
            Font = Enum.Font.GothamBold,
            LayoutOrder = preset,
            Parent = quickRow,
        })
        corner(8, pb)
        local pbs = stroke(Theme.Border, 1, pb)
        pb.MouseButton1Click:Connect(function()
            FlyState.Speed = preset
            local pos = (preset - 10) / 490
            sliderFill.Size = UDim2.new(pos, 0, 1, 0)
            sliderDot.Position = UDim2.new(pos, -7, 0.5, -7)
            speedValueLabel.Text = tostring(preset)
        end)
        pb.MouseEnter:Connect(function()
            tween(pb, 0.12, { BackgroundColor3 = Theme.CardHover })
            tween(pbs, 0.12, { Color = Theme.BorderHover })
        end)
        pb.MouseLeave:Connect(function()
            tween(pb, 0.12, { BackgroundColor3 = Theme.Card })
            tween(pbs, 0.12, { Color = Theme.Border })
        end)
    end

    -- Info card
    local InfoCard = new("Frame", {
        Size = UDim2.new(1, 0, 0, 40),
        Position = UDim2.new(0, 0, 0, 220),
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        Parent = Body,
    })
    corner(10, InfoCard)
    stroke(Theme.Border, 1, InfoCard)

    local infoIconHolder = new("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 14, 0.5, -7), BackgroundTransparency = 1, Parent = InfoCard })
    IconLib.Info(infoIconHolder, Theme.TextMuted)

    new("TextLabel", {
        Size = UDim2.new(1, -44, 1, 0),
        Position = UDim2.new(0, 36, 0, 0),
        BackgroundTransparency = 1,
        Text = "Kontrol: W/A/S/D gerak, Space naik, LCtrl turun",
        TextColor3 = Theme.TextMuted,
        TextSize = 10,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = InfoCard,
    })
end

-- ============================================================
-- START
-- ============================================================
buildKeyUI(function()
    buildMainUI()
end)

print("[Hallwayz Fly] Loaded.")ot = char:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root then return end

    -- Set humanoid to platform stand (like IY)
    humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    humanoid.PlatformStand = true

    -- BodyVelocity
    local bv = Instance.new("BodyVelocity")
    bv.Name = "HallwayzFlyVelocity"
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Velocity = Vector3.zero
    bv.P = 1250
    bv.Parent = root

    -- BodyGyro (stabilisasi)
    local bg = Instance.new("BodyGyro")
    bg.Name = "HallwayzFlyGyro"
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.P = 1250
    bg.D = 50
    bg.CFrame = root.CFrame
    bg.Parent = root

    FlyState.BodyVelocity = bv
    FlyState.BodyGyro = bg

    -- Update loop
    FlyState.Connection = RunService.RenderStepped:Connect(function()
        if not FlyState.Enabled then return end
        if not root or not root.Parent then return end
        if not Camera then return end

        local camCF = Camera.CFrame
        local dir = Vector3.zero

        if UserInputService:IsKeyDown(FlyState.Keys.Forward) then
            dir = dir + camCF.LookVector
        end
        if UserInputService:IsKeyDown(FlyState.Keys.Backward) then
            dir = dir - camCF.LookVector
        end
        if UserInputService:IsKeyDown(FlyState.Keys.Left) then
            dir = dir - camCF.RightVector
        end
        if UserInputService:IsKeyDown(FlyState.Keys.Right) then
            dir = dir + camCF.RightVector
        end
        if UserInputService:IsKeyDown(FlyState.Keys.Up) then
            dir = dir + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(FlyState.Keys.Down) then
            dir = dir - Vector3.new(0, 1, 0)
        end

        if dir.Magnitude > 0 then
            bv.Velocity = dir.Unit * FlyState.Speed
        else
            bv.Velocity = Vector3.zero
        end

        bg.CFrame = camCF
    end)

    -- Auto cleanup on death
    humanoid.Died:Connect(function()
        FlyState.Enabled = false
        cleanupFly()
    end)

    char.AncestryChanged:Connect(function(_, parent)
        if not parent then
            FlyState.Enabled = false
            cleanupFly()
        end
    end)
end

local function setFly(enabled)
    if enabled then
        FlyState.Enabled = true
        startFly()
    else
        FlyState.Enabled = false
        cleanupFly()
    end
end

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
    if not inputKey or inputKey == "" then return false, "Key tidak boleh kosong" end
    local vk = fetchValidKeys()
    if vk[inputKey:lower()] then return true, "Key valid" end
    return false, "Key tidak valid"
end

-- ============================================================
-- KEY UI
-- ============================================================
local function buildKeyUI(onSuccess)
    local Dim = new("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Parent = ScreenGui,
    })

    local KeyCard = new("Frame", {
        Size = UDim2.new(0, 380, 0, 290),
        Position = UDim2.new(0.5, -190, 0.5, -145),
        BackgroundColor3 = Theme.BG,
        BorderSizePixel = 0,
        Parent = Dim,
    })
    corner(14, KeyCard)
    stroke(Theme.Border, 1, KeyCard)

    local glow = new("UIStroke", { Color = Theme.Accent, Thickness = 1.5, Transparency = 0.7, Parent = KeyCard })
    task.spawn(function()
        while KeyCard.Parent do
            tween(glow, 2, { Transparency = 0.2 })
            task.wait(2)
            tween(glow, 2, { Transparency = 0.85 })
            task.wait(2)
        end
    end)

    local uk = new("UIScale", { Scale = 1, Parent = KeyCard })
    local function updScale()
        local vp = Camera.ViewportSize
        uk.Scale = math.min((vp.X * 0.9) / 380, (vp.Y * 0.9) / 290, 1)
    end
    updScale()
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(updScale)

    local Header = new("Frame", {
        Size = UDim2.new(1, 0, 0, 64),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0,
        Parent = KeyCard,
    })
    corner(14, Header)
    new("Frame", { Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 1, -14), BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = Header })

    local logoHolder = new("Frame", { Size = UDim2.new(0, 32, 0, 32), Position = UDim2.new(0, 16, 0.5, -16), BackgroundTransparency = 1, Parent = Header })
    buildLogo(logoHolder, 32)

    new("TextLabel", {
        Size = UDim2.new(1, -70, 0, 18),
        Position = UDim2.new(0, 58, 0, 15),
        BackgroundTransparency = 1,
        Text = CONFIG.Name,
        TextColor3 = Theme.Text,
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Header,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -70, 0, 13),
        Position = UDim2.new(0, 58, 0, 34),
        BackgroundTransparency = 1,
        Text = "Key System • " .. CONFIG.Version,
        TextColor3 = Theme.TextMuted,
        TextSize = 10,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Header,
    })

    local keyClose = new("TextButton", {
        Size = UDim2.new(0, 26, 0, 26),
        Position = UDim2.new(1, -38, 0, 19),
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        Text = "",
        Parent = Header,
    })
    corner(6, keyClose)
    local kcHolder = new("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0.5, -7, 0.5, -7), BackgroundTransparency = 1, Parent = keyClose })
    IconLib.Close(kcHolder, Theme.TextMuted)

    keyClose.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
    keyClose.MouseEnter:Connect(function() tween(keyClose, 0.12, { BackgroundColor3 = Theme.CardHover }) end)
    keyClose.MouseLeave:Connect(function() tween(keyClose, 0.12, { BackgroundColor3 = Theme.Card }) end)

    local Body = new("Frame", {
        Size = UDim2.new(1, -28, 1, -84),
        Position = UDim2.new(0, 14, 0, 80),
        BackgroundTransparency = 1,
        Parent = KeyCard,
    })

    new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 16),
        BackgroundTransparency = 1,
        Text = "Masukkan key untuk melanjutkan",
        TextColor3 = Theme.Text,
        TextSize = 11,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Body,
    })

    local InputBox = new("Frame", {
        Size = UDim2.new(1, 0, 0, 40),
        Position = UDim2.new(0, 0, 0, 24),
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        Parent = Body,
    })
    corner(8, InputBox)
    local inputStroke = stroke(Theme.Border, 1, InputBox)

    local keyIconHolder = new("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 12, 0.5, -7), BackgroundTransparency = 1, Parent = InputBox })
    IconLib.Key(keyIconHolder, Theme.TextMuted)

    local KeyInput = new("TextBox", {
        Size = UDim2.new(1, -102, 1, 0),
        Position = UDim2.new(0, 34, 0, 0),
        BackgroundTransparency = 1,
        Text = "",
        PlaceholderText = "FREE_XXXXXXXXXXXXXXXX",
        PlaceholderColor3 = Theme.TextMuted,
        TextColor3 = Theme.Text,
        TextSize = 12,
        Font = Enum.Font.Code,
        ClearTextOnFocus = false,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = InputBox,
    })

    local pasteBtn = new("TextButton", {
        Size = UDim2.new(0, 52, 0, 26),
        Position = UDim2.new(1, -58, 0.5, -13),
        BackgroundColor3 = Theme.CardHover,
        BorderSizePixel = 0,
        Text = "Paste",
        TextColor3 = Theme.Text,
        TextSize = 10,
        Font = Enum.Font.GothamMedium,
        Parent = InputBox,
    })
    corner(6, pasteBtn)
    pasteBtn.MouseButton1Click:Connect(function()
        local ok, clip = pcall(function() return game:GetService("GuiService"):GetClipboard() end)
        if ok and clip and clip ~= "" then KeyInput.Text = clip end
    end)

    local StatusLabel = new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 16),
        Position = UDim2.new(0, 0, 0, 74),
        BackgroundTransparency = 1,
        Text = "",
        TextColor3 = Theme.TextMuted,
        TextSize = 10,
        Font = Enum.Font.Gotham,
        Parent = Body,
    })

    local verifyBtn = new("TextButton", {
        Size = UDim2.new(1, 0, 0, 42),
        Position = UDim2.new(0, 0, 0, 96),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        Text = "Verifikasi Key",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        Parent = Body,
    })
    corner(8, verifyBtn)
    verifyBtn.MouseEnter:Connect(function() tween(verifyBtn, 0.12, { BackgroundColor3 = Theme.AccentDark }) end)
    verifyBtn.MouseLeave:Connect(function() tween(verifyBtn, 0.12, { BackgroundColor3 = Theme.Accent }) end)

    -- Info hint
    new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 14),
        Position = UDim2.new(0, 0, 1, -18),
        BackgroundTransparency = 1,
        Text = "Dapatkan key di Discord kami",
        TextColor3 = Theme.TextMuted,
        TextSize = 9,
        Font = Enum.Font.Gotham,
        Parent = Body,
    })

    local function submit()
        local key = KeyInput.Text
        if key == "" then
            StatusLabel.Text = "Key tidak boleh kosong"
            StatusLabel.TextColor3 = Theme.Error
            tween(inputStroke, 0.15, { Color = Theme.Error })
            task.delay(1.5, function() tween(inputStroke, 0.3, { Color = Theme.Border }) end)
            return
        end
        StatusLabel.Text = "Memverifikasi..."
        StatusLabel.TextColor3 = Theme.Warning
        verifyBtn.Text = "..."
        task.wait(0.4)
        local valid, msg = validateKey(key)
        if valid then
            StatusLabel.Text = msg
            StatusLabel.TextColor3 = Theme.Success
            tween(inputStroke, 0.2, { Color = Theme.Success })
            task.wait(0.35)
            tween(Dim, 0.3, { BackgroundTransparency = 1 })
            tween(KeyCard, 0.3, { BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0) })
            task.wait(0.3)
            Dim:Destroy()
            onSuccess()
        else
            StatusLabel.Text = msg
            StatusLabel.TextColor3 = Theme.Error
            verifyBtn.Text = "Verifikasi Key"
            tween(inputStroke, 0.15, { Color = Theme.Error })
            task.delay(1.5, function() tween(inputStroke, 0.3, { Color = Theme.Border }) end)
            local orig = InputBox.Position
            for i = 1, 4 do
                InputBox.Position = orig + UDim2.new(0, (i % 2 == 0 and 6 or -6), 0, 0)
                task.wait(0.035)
            end
            InputBox.Position = orig
        end
    end

    verifyBtn.MouseButton1Click:Connect(submit)
    KeyInput.FocusLost:Connect(function(enter) if enter then submit() end end)
end

-- ============================================================
-- MAIN FLY UI
-- ============================================================
local function buildMainUI()
    local Main = new("Frame", {
        Size = UDim2.new(0, 440, 0, 340),
        Position = UDim2.new(0.5, -220, 0.5, -170),
        BackgroundColor3 = Theme.BG,
        BorderSizePixel = 0,
        Parent = ScreenGui,
    })
    corner(12, Main)
    stroke(Theme.Border, 1, Main)

    local mScale = new("UIScale", { Scale = 1, Parent = Main })
    local function upd()
        local vp = Camera.ViewportSize
        mScale.Scale = math.min((vp.X * 0.9) / 440, (vp.Y * 0.9) / 340, 1)
    end
    upd()
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(upd)

    Main.Size = UDim2.new(0, 0, 0, 0)
    tween(Main, 0.3, { Size = UDim2.new(0, 440, 0, 340) })

    -- Drag
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

    -- Header
    local Header = new("Frame", {
        Size = UDim2.new(1, 0, 0, 56),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0,
        Parent = Main,
    })
    corner(12, Header)
    new("Frame", { Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 1, -14), BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = Header })

    local logoHolder = new("Frame", { Size = UDim2.new(0, 28, 0, 28), Position = UDim2.new(0, 16, 0.5, -14), BackgroundTransparency = 1, Parent = Header })
    buildLogo(logoHolder, 28)

    new("TextLabel", {
        Size = UDim2.new(1, -130, 0, 18),
        Position = UDim2.new(0, 54, 0, 12),
        BackgroundTransparency = 1,
        Text = CONFIG.Name,
        TextColor3 = Theme.Text,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Header,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -130, 0, 12),
        Position = UDim2.new(0, 54, 0, 30),
        BackgroundTransparency = 1,
        Text = "All Games • " .. CONFIG.Version,
        TextColor3 = Theme.TextMuted,
        TextSize = 9,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Header,
    })

    local function winBtn(iconFn, xOffset)
        local b = new("TextButton", {
            Size = UDim2.new(0, 24, 0, 24),
            Position = UDim2.new(1, xOffset, 0, 16),
            BackgroundColor3 = Theme.Card,
            BorderSizePixel = 0,
            Text = "",
            Parent = Header,
        })
        corner(6, b)
        local holder = new("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0.5, -7, 0.5, -7), BackgroundTransparency = 1, Parent = b })
        IconLib[iconFn](holder, Theme.TextMuted)
        b.MouseEnter:Connect(function() tween(b, 0.12, { BackgroundColor3 = Theme.CardHover }) end)
        b.MouseLeave:Connect(function() tween(b, 0.12, { BackgroundColor3 = Theme.Card }) end)
        return b
    end

    local MinBtn = winBtn("Minimize", -64)
    local CloseBtn = winBtn("Close", -34)
    CloseBtn.MouseButton1Click:Connect(function()
        setFly(false)
        ScreenGui:Destroy()
    end)

    -- Body
    local Body = new("Frame", {
        Size = UDim2.new(1, -24, 1, -72),
        Position = UDim2.new(0, 12, 0, 64),
        BackgroundTransparency = 1,
        Parent = Main,
    })

    -- Toggle card
    local ToggleCard = new("Frame", {
        Size = UDim2.new(1, 0, 0, 56),
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        Parent = Body,
    })
    corner(10, ToggleCard)
    stroke(Theme.Border, 1, ToggleCard)

    local wingIconHolder = new("Frame", { Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(0, 14, 0.5, -9), BackgroundTransparency = 1, Parent = ToggleCard })
    IconLib.Wing(wingIconHolder, Theme.Text)

    new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 16),
        Position = UDim2.new(0, 44, 0, 12),
        BackgroundTransparency = 1,
        Text = "Fly",
        TextColor3 = Theme.Text,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = ToggleCard,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 12),
        Position = UDim2.new(0, 44, 0, 30),
        BackgroundTransparency = 1,
        Text = "W A S D • Space / LCtrl",
        TextColor3 = Theme.TextMuted,
        TextSize = 9,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = ToggleCard,
    })

    -- Toggle switch
    local toggleBg = new("TextButton", {
        Size = UDim2.new(0, 42, 0, 22),
        Position = UDim2.new(1, -56, 0.5, -11),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0,
        Text = "",
        Parent = ToggleCard,
    })
    corner(100, toggleBg)
    local toggleDot = new("Frame", {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 3, 0.5, -8),
        BackgroundColor3 = Theme.TextMuted,
        BorderSizePixel = 0,
        Parent = toggleBg,
    })
    corner(100, toggleDot)

    local toggled = false
    local function updateToggle()
        if toggled then
            tween(toggleBg, 0.15, { BackgroundColor3 = Theme.Accent })
            tween(toggleDot, 0.15, { Position = UDim2.new(1, -19, 0.5, -8), BackgroundColor3 = Color3.fromRGB(255,255,255) })
        else
            tween(toggleBg, 0.15, { BackgroundColor3 = Theme.Sidebar })
            tween(toggleDot, 0.15, { Position = UDim2.new(0, 3, 0.5, -8), BackgroundColor3 = Theme.TextMuted })
        end
    end

    toggleBg.MouseButton1Click:Connect(function()
        toggled = not toggled
        updateToggle()
        setFly(toggled)
    end)

    -- Speed card
    local SpeedCard = new("Frame", {
        Size = UDim2.new(1, 0, 0, 100),
        Position = UDim2.new(0, 0, 0, 68),
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        Parent = Body,
    })
    corner(10, SpeedCard)
    stroke(Theme.Border, 1, SpeedCard)

    local speedIconHolder = new("Frame", { Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(0, 14, 0, 14), BackgroundTransparency = 1, Parent = SpeedCard })
    IconLib.Speed(speedIconHolder, Theme.Text)

    new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 16),
        Position = UDim2.new(0, 44, 0, 14),
        BackgroundTransparency = 1,
        Text = "Fly Speed",
        TextColor3 = Theme.Text,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = SpeedCard,
    })

    local speedValueLabel = new("TextLabel", {
        Size = UDim2.new(0, 80, 0, 16),
        Position = UDim2.new(1, -96, 0, 14),
        BackgroundTransparency = 1,
        Text = tostring(FlyState.Speed),
        TextColor3 = Theme.Accent,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = SpeedCard,
    })

    -- Slider
    local sliderBar = new("Frame", {
        Size = UDim2.new(1, -32, 0, 6),
        Position = UDim2.new(0, 16, 0, 62),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0,
        Parent = SpeedCard,
    })
    corner(100, sliderBar)

    local sliderFill = new("Frame", {
        Size = UDim2.new((FlyState.Speed - 10) / 490, 0, 1, 0),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        Parent = sliderBar,
    })
    corner(100, sliderFill)

    local sliderDot = new("Frame", {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new((FlyState.Speed - 10) / 490, -7, 0.5, -7),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Parent = sliderBar,
    })
    corner(100, sliderDot)

    new("TextLabel", {
        Size = UDim2.new(1, -32, 0, 14),
        Position = UDim2.new(0, 16, 0, 76),
        BackgroundTransparency = 1,
        Text = "10                         500",
        TextColor3 = Theme.TextMuted,
        TextSize = 9,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Center,
        Parent = SpeedCard,
    })

    -- Slider drag logic
    local sDrag = false
    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        local val = math.floor(10 + (500 - 10) * pos)
        FlyState.Speed = val
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        sliderDot.Position = UDim2.new(pos, -7, 0.5, -7)
        speedValueLabel.Text = tostring(val)
    end
    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sDrag = true
            updateSlider(input)
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

    -- Quick speed buttons
    local quickRow = new("Frame", {
        Size = UDim2.new(1, 0, 0, 32),
        Position = UDim2.new(0, 0, 0, 180),
        BackgroundTransparency = 1,
        Parent = Body,
    })
    new("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = quickRow,
    })

    for _, preset in ipairs({50, 100, 200, 350, 500}) do
        local pb = new("TextButton", {
            Size = UDim2.new(0, 72, 0, 30),
            BackgroundColor3 = Theme.Card,
            BorderSizePixel = 0,
            Text = tostring(preset),
            TextColor3 = Theme.Text,
            TextSize = 11,
            Font = Enum.Font.GothamBold,
            LayoutOrder = preset,
            Parent = quickRow,
        })
        corner(8, pb)
        local pbs = stroke(Theme.Border, 1, pb)
        pb.MouseButton1Click:Connect(function()
            FlyState.Speed = preset
            local pos = (preset - 10) / 490
            sliderFill.Size = UDim2.new(pos, 0, 1, 0)
            sliderDot.Position = UDim2.new(pos, -7, 0.5, -7)
            speedValueLabel.Text = tostring(preset)
        end)
        pb.MouseEnter:Connect(function()
            tween(pb, 0.12, { BackgroundColor3 = Theme.CardHover })
            tween(pbs, 0.12, { Color = Theme.BorderHover })
        end)
        pb.MouseLeave:Connect(function()
            tween(pb, 0.12, { BackgroundColor3 = Theme.Card })
            tween(pbs, 0.12, { Color = Theme.Border })
        end)
    end

    -- Info card
    local InfoCard = new("Frame", {
        Size = UDim2.new(1, 0, 0, 40),
        Position = UDim2.new(0, 0, 0, 220),
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        Parent = Body,
    })
    corner(10, InfoCard)
    stroke(Theme.Border, 1, InfoCard)

    local infoIconHolder = new("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 14, 0.5, -7), BackgroundTransparency = 1, Parent = InfoCard })
    IconLib.Info(infoIconHolder, Theme.TextMuted)

    new("TextLabel", {
        Size = UDim2.new(1, -44, 1, 0),
        Position = UDim2.new(0, 36, 0, 0),
        BackgroundTransparency = 1,
        Text = "Kontrol: W/A/S/D gerak, Space naik, LCtrl turun",
        TextColor3 = Theme.TextMuted,
        TextSize = 10,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = InfoCard,
    })
end

-- ============================================================
-- START
-- ============================================================
buildKeyUI(function()
    buildMainUI()
end)

print("[Hallwayz Fly] Loaded.")
