--[[
    Hallwayz Fly
    Load: loadstring(game:HttpGet("https://raw.githubusercontent.com/ZurraOfficial/Fly/main/main.lua"))()
    Fly engine: Infinite Yield (EdgeIY)
]]

print("[Hallwayz Fly] Script started...")

-- ============================================================
-- SERVICES
-- ============================================================
local Players          = game:GetService("Players")
local CoreGui          = game:GetService("CoreGui")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local HttpService      = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera or workspace:WaitForChild("Camera", 5)

-- ============================================================
-- CONFIG
-- ============================================================
local CONFIG = {
    Name = "Hallwayz Fly",
    Subtitle = "BY ARYA X SALMAN",
    Version = "v1.0.2",
    KeysURL = "https://raw.githubusercontent.com/ZurraOfficial/Fly/main/keys.txt",
}

-- ============================================================
-- THEME
-- ============================================================
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

-- ============================================================
-- CLEANUP
-- ============================================================
pcall(function()
    for _, obj in pairs(CoreGui:GetChildren()) do
        if obj.Name == "HallwayzFly" then obj:Destroy() end
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HallwayzFly"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999

local okCore = pcall(function() ScreenGui.Parent = CoreGui end)
if not okCore or not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

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
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    new("Frame", { Size = UDim2.new(0,12,0,2), Position = UDim2.new(0,1,0,6), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = 45, Parent = h })
    new("Frame", { Size = UDim2.new(0,12,0,2), Position = UDim2.new(0,1,0,6), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = -45, Parent = h })
    return h
end

function IconLib.Minimize(parent, color)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    new("Frame", { Size = UDim2.new(0,12,0,2), Position = UDim2.new(0,1,0,7), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    return h
end

function IconLib.Key(parent, color)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    local head = new("Frame", { Size = UDim2.new(0,8,0,8), Position = UDim2.new(0,1,0,4), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    corner(100, head)
    local hole = new("Frame", { Size = UDim2.new(0,3,0,3), Position = UDim2.new(0.5,-1.5,0.5,-1.5), BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = head })
    corner(100, hole)
    new("Frame", { Size = UDim2.new(0,9,0,2), Position = UDim2.new(0,8,0,8), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    new("Frame", { Size = UDim2.new(0,2,0,3), Position = UDim2.new(0,12,0,8), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    new("Frame", { Size = UDim2.new(0,2,0,3), Position = UDim2.new(0,15,0,8), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    return h
end

function IconLib.Wing(parent, color)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    new("Frame", { Size = UDim2.new(0,14,0,3), Position = UDim2.new(0,1,0,4), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = -20, Parent = h })
    new("Frame", { Size = UDim2.new(0,12,0,3), Position = UDim2.new(0,1,0,8), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = -10, Parent = h })
    new("Frame", { Size = UDim2.new(0,9,0,3), Position = UDim2.new(0,1,0,12), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = 5, Parent = h })
    return h
end

function IconLib.Speed(parent, color)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    new("Frame", { Size = UDim2.new(0,14,0,2), Position = UDim2.new(0,1,0,4), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    new("Frame", { Size = UDim2.new(0,10,0,2), Position = UDim2.new(0,1,0,8), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    new("Frame", { Size = UDim2.new(0,14,0,2), Position = UDim2.new(0,1,0,12), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    return h
end

function IconLib.Info(parent, color)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    local outer = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    corner(100, outer)
    local inner = new("Frame", { Size = UDim2.new(1,-4,1,-4), Position = UDim2.new(0,2,0,2), BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = h })
    corner(100, inner)
    new("Frame", { Size = UDim2.new(0,2,0,2), Position = UDim2.new(0.5,-1,0,3), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    new("Frame", { Size = UDim2.new(0,2,0,6), Position = UDim2.new(0.5,-1,0,7), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    return h
end

local function buildLogo(parent, size)
    size = size or 30
    local h = new("Frame", { Size = UDim2.new(0, size, 0, size), BackgroundTransparency = 1, Parent = parent })
    local sk = size / 32
    new("Frame", { Size = UDim2.new(0, 8*sk, 0, 13*sk), Position = UDim2.new(0, 6*sk, 0, 3*sk), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Rotation = 20, Parent = h })
    new("Frame", { Size = UDim2.new(0, 8*sk, 0, 13*sk), Position = UDim2.new(0, 6*sk, 0, 16*sk), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Rotation = 20, Parent = h })
    new("Frame", { Size = UDim2.new(0, 9*sk, 0, 26*sk), Position = UDim2.new(0, 17*sk, 0, 3*sk), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Rotation = 20, Parent = h })
    new("Frame", { Size = UDim2.new(0, 11*sk, 0, 2*sk), Position = UDim2.new(0, 7*sk, 0, 15*sk), BackgroundColor3 = Theme.AccentGlow, BorderSizePixel = 0, Rotation = -25, Parent = h })
    return h
end

-- ============================================================
-- ============================================================
-- FLY ENGINE — DIAMBIL DARI INFINITE YIELD
-- ============================================================
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

    if flyKeyDown or flyKeyUp then
        flyKeyDown:Disconnect()
        flyKeyUp:Disconnect()
    end

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
                if not vfly and humanoid then
                    humanoid.PlatformStand = true
                end

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
        if input.KeyCode == Enum.KeyCode.W then
            CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
        elseif input.KeyCode == Enum.KeyCode.S then
            CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
        elseif input.KeyCode == Enum.KeyCode.A then
            CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
        elseif input.KeyCode == Enum.KeyCode.D then
            CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
        elseif input.KeyCode == Enum.KeyCode.E and QEfly then
            CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
        elseif input.KeyCode == Enum.KeyCode.Q and QEfly then
            CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
        end
        pcall(function() Camera.CameraType = Enum.CameraType.Track end)
    end)

    flyKeyUp = UserInputService.InputEnded:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.W then
            CONTROL.F = 0
        elseif input.KeyCode == Enum.KeyCode.S then
            CONTROL.B = 0
        elseif input.KeyCode == Enum.KeyCode.A then
            CONTROL.L = 0
        elseif input.KeyCode == Enum.KeyCode.D then
            CONTROL.R = 0
        elseif input.KeyCode == Enum.KeyCode.E then
            CONTROL.Q = 0
        elseif input.KeyCode == Enum.KeyCode.Q then
            CONTROL.E = 0
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

-- Mobile fly (untuk HP)
local velocityHandlerName = "HallwayzFlyBV"
local gyroHandlerName = "HallwayzFlyBG"
local mfly1
local mfly2

local unmobilefly = function(speaker)
    pcall(function()
        FLYING = false
        local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local bv = root:FindFirstChild(velocityHandlerName)
            if bv then bv:Destroy() end
            local bg = root:FindFirstChild(gyroHandlerName)
            if bg then bg:Destroy() end
        end
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = false end
        if mfly1 then mfly1:Disconnect() end
        if mfly2 then mfly2:Disconnect() end
    end)
end

local mobilefly = function(speaker, vfly)
    unmobilefly(speaker)
    FLYING = true

    local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local camera = workspace.CurrentCamera
    local v3none = Vector3.new()
    local v3zero = Vector3.new(0, 0, 0)
    local v3inf = Vector3.new(9e9, 9e9, 9e9)

    local controlModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))

    local bv = Instance.new("BodyVelocity")
    bv.Name = velocityHandlerName
    bv.Parent = root
    bv.MaxForce = v3zero
    bv.Velocity = v3zero

    local bg = Instance.new("BodyGyro")
    bg.Name = gyroHandlerName
    bg.Parent = root
    bg.MaxTorque = v3inf
    bg.P = 1000
    bg.D = 50

    mfly1 = LocalPlayer.CharacterAdded:Connect(function()
        local bvNew = Instance.new("BodyVelocity")
        bvNew.Name = velocityHandlerName
        bvNew.Parent = root
        bvNew.MaxForce = v3zero
        bvNew.Velocity = v3zero

        local bgNew = Instance.new("BodyGyro")
        bgNew.Name = gyroHandlerName
        bgNew.Parent = root
        bgNew.MaxTorque = v3inf
        bgNew.P = 1000
        bgNew.D = 50
    end)

    mfly2 = RunService.RenderStepped:Connect(function()
        root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        camera = workspace.CurrentCamera
        if LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid") and root and root:FindFirstChild(velocityHandlerName) and root:FindFirstChild(gyroHandlerName) then
            local humanoid = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
            local VelocityHandler = root:FindFirstChild(velocityHandlerName)
            local GyroHandler = root:FindFirstChild(gyroHandlerName)

            VelocityHandler.MaxForce = v3inf
            GyroHandler.MaxTorque = v3inf
            if not vfly then humanoid.PlatformStand = true end
            GyroHandler.CFrame = camera.CoordinateFrame
            VelocityHandler.Velocity = v3none

            local direction = controlModule:GetMoveVector()
            if direction.X > 0 then
                VelocityHandler.Velocity = VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * ((vfly and vehicleflyspeed or iyflyspeed) * 50))
            end
            if direction.X < 0 then
                VelocityHandler.Velocity = VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * ((vfly and vehicleflyspeed or iyflyspeed) * 50))
            end
            if direction.Z > 0 then
                VelocityHandler.Velocity = VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * ((vfly and vehicleflyspeed or iyflyspeed) * 50))
            end
            if direction.Z < 0 then
                VelocityHandler.Velocity = VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * ((vfly and vehicleflyspeed or iyflyspeed) * 50))
            end
        end
    end)
end

-- Detect mobile
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Wrapper functions (dipanggil dari UI)
local function doFly()
    if not isMobile then
        NOFLY()
        task.wait(0.05)
        sFLY()
    else
        mobilefly(LocalPlayer)
    end
end

local function doUnfly()
    if not isMobile then
        NOFLY()
    else
        unmobilefly(LocalPlayer)
    end
end

-- ============================================================
-- ============================================================
-- KEY VALIDATION
-- ============================================================
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
            tween(glow, 2, { Transparency = 0.2 }); task.wait(2)
            tween(glow, 2, { Transparency = 0.85 }); task.wait(2)
        end
    end)

    local uk = new("UIScale", { Scale = 1, Parent = KeyCard })
    local function updScale()
        local cam = workspace.CurrentCamera
        if not cam then return end
        local vp = cam.ViewportSize
        uk.Scale = math.min((vp.X * 0.9) / 380, (vp.Y * 0.9) / 290, 1)
    end
    updScale()
    if workspace.CurrentCamera then
        workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updScale)
    end

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
        Size = UDim2.new(1, -70, 0, 18), Position = UDim2.new(0, 58, 0, 12),
        BackgroundTransparency = 1, Text = CONFIG.Name,
        TextColor3 = Theme.Text, TextSize = 13, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = Header,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -70, 0, 13), Position = UDim2.new(0, 58, 0, 32),
        BackgroundTransparency = 1, Text = CONFIG.Subtitle,
        TextColor3 = Theme.TextMuted, TextSize = 9, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = Header,
    })

    local keyClose = new("TextButton", {
        Size = UDim2.new(0, 26, 0, 26), Position = UDim2.new(1, -38, 0, 19),
        BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Text = "", Parent = Header,
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
        BackgroundTransparency = 1, Parent = KeyCard,
    })

    new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 16), BackgroundTransparency = 1,
        Text = "Masukkan key untuk melanjutkan",
        TextColor3 = Theme.Text, TextSize = 11, Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = Body,
    })

    local InputBox = new("Frame", {
        Size = UDim2.new(1, 0, 0, 40), Position = UDim2.new(0, 0, 0, 24),
        BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = Body,
    })
    corner(8, InputBox)
    local inputStroke = stroke(Theme.Border, 1, InputBox)

    local keyIconHolder = new("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 12, 0.5, -7), BackgroundTransparency = 1, Parent = InputBox })
    IconLib.Key(keyIconHolder, Theme.TextMuted)

    local KeyInput = new("TextBox", {
        Size = UDim2.new(1, -102, 1, 0), Position = UDim2.new(0, 34, 0, 0),
        BackgroundTransparency = 1, Text = "",
        PlaceholderText = "FREE_XXXXXXXXXXXXXXXX",
        PlaceholderColor3 = Theme.TextMuted, TextColor3 = Theme.Text,
        TextSize = 12, Font = Enum.Font.Code, ClearTextOnFocus = false,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = InputBox,
    })

    local pasteBtn = new("TextButton", {
        Size = UDim2.new(0, 52, 0, 26), Position = UDim2.new(1, -58, 0.5, -13),
        BackgroundColor3 = Theme.CardHover, BorderSizePixel = 0,
        Text = "Paste", TextColor3 = Theme.Text, TextSize = 10,
        Font = Enum.Font.GothamMedium, Parent = InputBox,
    })
    corner(6, pasteBtn)
    pasteBtn.MouseButton1Click:Connect(function()
        local ok, clip = pcall(function() return game:GetService("GuiService"):GetClipboard() end)
        if ok and clip and clip ~= "" then KeyInput.Text = clip end
    end)

    local StatusLabel = new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 16), Position = UDim2.new(0, 0, 0, 74),
        BackgroundTransparency = 1, Text = "", TextColor3 = Theme.TextMuted,
        TextSize = 10, Font = Enum.Font.Gotham, Parent = Body,
    })

    local verifyBtn = new("TextButton", {
        Size = UDim2.new(1, 0, 0, 42), Position = UDim2.new(0, 0, 0, 96),
        BackgroundColor3 = Theme.Accent, BorderSizePixel = 0,
        Text = "Verifikasi Key", TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 12, Font = Enum.Font.GothamBold, Parent = Body,
    })
    corner(8, verifyBtn)
    verifyBtn.MouseEnter:Connect(function() tween(verifyBtn, 0.12, { BackgroundColor3 = Theme.AccentDark }) end)
    verifyBtn.MouseLeave:Connect(function() tween(verifyBtn, 0.12, { BackgroundColor3 = Theme.Accent }) end)

    new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 1, -18),
        BackgroundTransparency = 1, Text = "Dapatkan key di Discord kami",
        TextColor3 = Theme.TextMuted, TextSize = 9, Font = Enum.Font.Gotham, Parent = Body,
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
        local cam = workspace.CurrentCamera
        if not cam then return end
        local vp = cam.ViewportSize
        mScale.Scale = math.min((vp.X * 0.9) / 440, (vp.Y * 0.9) / 340, 1)
    end
    upd()
    if workspace.CurrentCamera then
        workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(upd)
    end

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
        BorderSizePixel = 0, Parent = Main,
    })
    corner(12, Header)
    new("Frame", { Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 1, -14), BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = Header })

    local logoHolder = new("Frame", { Size = UDim2.new(0, 28, 0, 28), Position = UDim2.new(0, 16, 0.5, -14), BackgroundTransparency = 1, Parent = Header })
    buildLogo(logoHolder, 28)

    new("TextLabel", {
        Size = UDim2.new(1, -130, 0, 18), Position = UDim2.new(0, 54, 0, 12),
        BackgroundTransparency = 1, Text = CONFIG.Name,
        TextColor3 = Theme.Text, TextSize = 12, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = Header,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -130, 0, 12), Position = UDim2.new(0, 54, 0, 30),
        BackgroundTransparency = 1, Text = CONFIG.Subtitle .. " • " .. CONFIG.Version,
        TextColor3 = Theme.TextMuted, TextSize = 9, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = Header,
    })

    local function winBtn(iconFn, xOffset)
        local b = new("TextButton", {
            Size = UDim2.new(0, 24, 0, 24), Position = UDim2.new(1, xOffset, 0, 16),
            BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Text = "", Parent = Header,
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
        doUnfly()
        ScreenGui:Destroy()
    end)

    local Body = new("Frame", {
        Size = UDim2.new(1, -24, 1, -72),
        Position = UDim2.new(0, 12, 0, 64),
        BackgroundTransparency = 1, Parent = Main,
    })

    -- Toggle Card
    local ToggleCard = new("Frame", {
        Size = UDim2.new(1, 0, 0, 56),
        BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = Body,
    })
    corner(10, ToggleCard)
    stroke(Theme.Border, 1, ToggleCard)

    local wingIconHolder = new("Frame", { Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(0, 14, 0.5, -9), BackgroundTransparency = 1, Parent = ToggleCard })
    IconLib.Wing(wingIconHolder, Theme.Text)

    new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 16), Position = UDim2.new(0, 44, 0, 12),
        BackgroundTransparency = 1, Text = "Fly",
        TextColor3 = Theme.Text, TextSize = 13, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = ToggleCard,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 12), Position = UDim2.new(0, 44, 0, 30),
        BackgroundTransparency = 1, Text = "W A S D • Space / LCtrl",
        TextColor3 = Theme.TextMuted, TextSize = 9, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = ToggleCard,
    })

    local toggleBg = new("TextButton", {
        Size = UDim2.new(0, 42, 0, 22), Position = UDim2.new(1, -56, 0.5, -11),
        BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Text = "", Parent = ToggleCard,
    })
    corner(100, toggleBg)
    local toggleDot = new("Frame", {
        Size = UDim2.new(0, 16, 0, 16), Position = UDim2.new(0, 3, 0.5, -8),
        BackgroundColor3 = Theme.TextMuted, BorderSizePixel = 0, Parent = toggleBg,
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
        if toggled then doFly() else doUnfly() end
    end)

    -- Speed Card
    local SpeedCard = new("Frame", {
        Size = UDim2.new(1, 0, 0, 100),
        Position = UDim2.new(0, 0, 0, 68),
        BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = Body,
    })
    corner(10, SpeedCard)
    stroke(Theme.Border, 1, SpeedCard)

    local speedIconHolder = new("Frame", { Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(0, 14, 0, 14), BackgroundTransparency = 1, Parent = SpeedCard })
    IconLib.Speed(speedIconHolder, Theme.Text)

    new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 16), Position = UDim2.new(0, 44, 0, 14),
        BackgroundTransparency = 1, Text = "Fly Speed",
        TextColor3 = Theme.Text, TextSize = 13, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = SpeedCard,
    })

    local speedValueLabel = new("TextLabel", {
        Size = UDim2.new(0, 80, 0, 16), Position = UDim2.new(1, -96, 0, 14),
        BackgroundTransparency = 1, Text = "1",
        TextColor3 = Theme.Accent, TextSize = 13, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Right, Parent = SpeedCard,
    })

    local sliderBar = new("Frame", {
        Size = UDim2.new(1, -32, 0, 6), Position = UDim2.new(0, 16, 0, 62),
        BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = SpeedCard,
    })
    corner(100, sliderBar)

    local sliderFill = new("Frame", {
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Parent = sliderBar,
    })
    corner(100, sliderFill)

    local sliderDot = new("Frame", {
        Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, -7, 0.5, -7),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Parent = sliderBar,
    })
    corner(100, sliderDot)

    new("TextLabel", {
        Size = UDim2.new(1, -32, 0, 14), Position = UDim2.new(0, 16, 0, 76),
        BackgroundTransparency = 1, Text = "1                              50",
        TextColor3 = Theme.TextMuted, TextSize = 9, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Center, Parent = SpeedCard,
    })

    local sDrag = false
    local MIN_SPD, MAX_SPD = 1, 50

    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        local val = math.floor(MIN_SPD + (MAX_SPD - MIN_SPD) * pos)
        iyflyspeed = val
        vehicleflyspeed = val
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
        Size = UDim2.new(1, 0, 0, 32), Position = UDim2.new(0, 0, 0, 180),
        BackgroundTransparency = 1, Parent = Body,
    })
    new("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder, Parent = quickRow,
    })

    for _, preset in ipairs({1, 3, 5, 10, 20}) do
        local pb = new("TextButton", {
            Size = UDim2.new(0, 72, 0, 30),
            BackgroundColor3 = Theme.Card, BorderSizePixel = 0,
            Text = tostring(preset), TextColor3 = Theme.Text,
            TextSize = 11, Font = Enum.Font.GothamBold,
            LayoutOrder = preset, Parent = quickRow,
        })
        corner(8, pb)
        local pbs = stroke(Theme.Border, 1, pb)
        pb.MouseButton1Click:Connect(function()
            iyflyspeed = preset
            vehicleflyspeed = preset
            local pos = (preset - MIN_SPD) / (MAX_SPD - MIN_SPD)
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
        Size = UDim2.new(1, 0, 0, 40), Position = UDim2.new(0, 0, 0, 220),
        BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = Body,
    })
    corner(10, InfoCard)
    stroke(Theme.Border, 1, InfoCard)

    local infoIconHolder = new("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 14, 0.5, -7), BackgroundTransparency = 1, Parent = InfoCard })
    IconLib.Info(infoIconHolder, Theme.TextMuted)

    new("TextLabel", {
        Size = UDim2.new(1, -44, 1, 0), Position = UDim2.new(0, 36, 0, 0),
        BackgroundTransparency = 1, Text = "Kontrol: W/A/S/D gerak, Q/E naik turun",
        TextColor3 = Theme.TextMuted, TextSize = 10, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = InfoCard,
    })
end

-- ============================================================
-- START
-- ============================================================
buildKeyUI(function()
    buildMainUI()
end)

print("[Hallwayz Fly] UI built successfully.")
