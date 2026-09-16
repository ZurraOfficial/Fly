--[[
    Hallwayz Fly — Modern UI
    Load: loadstring(game:HttpGet("https://raw.githubusercontent.com/ZurraOfficial/Fly/main/main.lua"))()
    Fly engine: Infinite Yield (EdgeIY)
]]

print("[Hallwayz] Loading...")

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
}

local Theme = {
    BG          = Color3.fromRGB(13, 13, 16),
    Header      = Color3.fromRGB(20, 20, 24),
    Card        = Color3.fromRGB(24, 24, 28),
    CardHover   = Color3.fromRGB(32, 32, 38),
    Border      = Color3.fromRGB(38, 38, 44),
    BorderHover = Color3.fromRGB(60, 60, 70),
    Text        = Color3.fromRGB(235, 235, 240),
    TextMuted   = Color3.fromRGB(120, 120, 135),
    Accent      = Color3.fromRGB(107, 127, 255),
    AccentDark  = Color3.fromRGB(75, 95, 220),
    AccentSoft  = Color3.fromRGB(140, 155, 255),
    Success     = Color3.fromRGB(74, 222, 128),
    Error       = Color3.fromRGB(248, 113, 113),
    Warning     = Color3.fromRGB(250, 204, 21),
    Divider     = Color3.fromRGB(30, 30, 36),
}

pcall(function()
    for _, obj in pairs(CoreGui:GetChildren()) do
        if obj.Name == "HallwayzUI" then obj:Destroy() end
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HallwayzUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999

local okCore = pcall(function() ScreenGui.Parent = CoreGui end)
if not okCore or not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local function new(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do pcall(function() obj[k] = v end) end
    return obj
end

local function corner(r, p) return new("UICorner", { CornerRadius = UDim.new(0, r or 8), Parent = p }) end
local function stroke(c, t, p) return new("UIStroke", { Color = c, Thickness = t or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = p }) end
local function tween(o, t, p, s, d)
    local tw = TweenService:Create(o, TweenInfo.new(t, s or Enum.EasingStyle.Quad, d or Enum.EasingDirection.Out), p)
    tw:Play(); return tw
end

-- ============================================================
-- VECTOR ICONS
-- ============================================================
local IconLib = {}

function IconLib.Close(parent, color)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    new("Frame", { Size = UDim2.new(0,11,0,1.6), Position = UDim2.new(0,1.5,0,6), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = 45, Parent = h })
    new("Frame", { Size = UDim2.new(0,11,0,1.6), Position = UDim2.new(0,1.5,0,6), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = -45, Parent = h })
    return h
end

function IconLib.Minimize(parent, color)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    new("Frame", { Size = UDim2.new(0,11,0,1.6), Position = UDim2.new(0,1.5,0,7), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    return h
end

function IconLib.Wing(parent, color)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    new("Frame", { Size = UDim2.new(0,16,0,2.5), Position = UDim2.new(0,1,0,4), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = -22, Parent = h })
    corner(2, h:FindFirstChildOfClass("Frame"))
    local l2 = new("Frame", { Size = UDim2.new(0,13,0,2.5), Position = UDim2.new(0,1,0,9), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = -12, Parent = h })
    corner(2, l2)
    local l3 = new("Frame", { Size = UDim2.new(0,9,0,2.5), Position = UDim2.new(0,1,0,14), BackgroundColor3 = color, BorderSizePixel = 0, Rotation = 4, Parent = h })
    corner(2, l3)
    return h
end

function IconLib.Speed(parent, color)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    new("Frame", { Size = UDim2.new(0,15,0,2), Position = UDim2.new(0,1,0,4), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    new("Frame", { Size = UDim2.new(0,11,0,2), Position = UDim2.new(0,1,0,9), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    new("Frame", { Size = UDim2.new(0,15,0,2), Position = UDim2.new(0,1,0,14), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    return h
end

function IconLib.Key(parent, color)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    local head = new("Frame", { Size = UDim2.new(0,9,0,9), Position = UDim2.new(0,1,0,3), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    corner(100, head)
    local hole = new("Frame", { Size = UDim2.new(0,3,0,3), Position = UDim2.new(0.5,-1.5,0.5,-1.5), BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = head })
    corner(100, hole)
    new("Frame", { Size = UDim2.new(0,8,0,2), Position = UDim2.new(0,9,0,7), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    new("Frame", { Size = UDim2.new(0,2,0,3), Position = UDim2.new(0,12,0,7), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    new("Frame", { Size = UDim2.new(0,2,0,3), Position = UDim2.new(0,15,0,7), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    return h
end

function IconLib.Info(parent, color)
    local h = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Parent = parent })
    local outer = new("Frame", { Size = UDim2.new(1,0,1,0), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    corner(100, outer)
    local inner = new("Frame", { Size = UDim2.new(1,-4,1,-4), Position = UDim2.new(0,2,0,2), BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = h })
    corner(100, inner)
    new("Frame", { Size = UDim2.new(0,2,0,2), Position = UDim2.new(0.5,-1,0,3), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    new("Frame", { Size = UDim2.new(0,2,0,6), Position = UDim2.new(0.5,-1,0,7), BackgroundColor3 = color, BorderSizePixel = 0, Parent = h })
    return h
end

-- Logo (Hallwayz parallelograms)
local function buildLogo(parent, size)
    size = size or 30
    local h = new("Frame", { Size = UDim2.new(0, size, 0, size), BackgroundTransparency = 1, Parent = parent })
    local sk = size / 32
    new("Frame", { Size = UDim2.new(0, 8*sk, 0, 13*sk), Position = UDim2.new(0, 6*sk, 0, 3*sk), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Rotation = 20, Parent = h })
    new("Frame", { Size = UDim2.new(0, 8*sk, 0, 13*sk), Position = UDim2.new(0, 6*sk, 0, 16*sk), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Rotation = 20, Parent = h })
    new("Frame", { Size = UDim2.new(0, 9*sk, 0, 26*sk), Position = UDim2.new(0, 17*sk, 0, 3*sk), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Rotation = 20, Parent = h })
    new("Frame", { Size = UDim2.new(0, 11*sk, 0, 2*sk), Position = UDim2.new(0, 7*sk, 0, 15*sk), BackgroundColor3 = Theme.AccentSoft, BorderSizePixel = 0, Rotation = -25, Parent = h })
    return h
end

-- ============================================================
-- FLY ENGINE (Infinite Yield)
-- ============================================================
FLYING = false
QEfly = true
iyflyspeed = 1

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
        if input.KeyCode == Enum.KeyCode.W then CONTROL.F = iyflyspeed
        elseif input.KeyCode == Enum.KeyCode.S then CONTROL.B = -iyflyspeed
        elseif input.KeyCode == Enum.KeyCode.A then CONTROL.L = -iyflyspeed
        elseif input.KeyCode == Enum.KeyCode.D then CONTROL.R = iyflyspeed
        elseif input.KeyCode == Enum.KeyCode.E and QEfly then CONTROL.Q = iyflyspeed * 2
        elseif input.KeyCode == Enum.KeyCode.Q and QEfly then CONTROL.E = -iyflyspeed * 2
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

local function doFly()
    if not isMobile then
        NOFLY()
        task.wait(0.05)
        sFLY()
    end
end

local function doUnfly()
    NOFLY()
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
    if not inputKey or inputKey == "" then return false, "Key required" end
    local vk = fetchValidKeys()
    if vk[inputKey:lower()] then return true, "Key valid" end
    return false, "Invalid key"
end

-- ============================================================
-- KEY UI (minimal, Rayfield style)
-- ============================================================
local function buildKeyUI(onSuccess)
    local Dim = new("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Parent = ScreenGui,
    })

    local Card = new("Frame", {
        Size = UDim2.new(0, 360, 0, 260),
        Position = UDim2.new(0.5, -180, 0.5, -130),
        BackgroundColor3 = Theme.BG,
        BorderSizePixel = 0,
        Parent = Dim,
    })
    corner(14, Card)
    stroke(Theme.Border, 1, Card)

    local glow = new("UIStroke", { Color = Theme.Accent, Thickness = 1.5, Transparency = 0.75, Parent = Card })
    task.spawn(function()
        while Card.Parent do
            tween(glow, 2, { Transparency = 0.2 }); task.wait(2)
            tween(glow, 2, { Transparency = 0.85 }); task.wait(2)
        end
    end)

    local uk = new("UIScale", { Scale = 1, Parent = Card })
    local function updScale()
        local cam = workspace.CurrentCamera
        if not cam then return end
        local vp = cam.ViewportSize
        uk.Scale = math.min((vp.X * 0.9) / 360, (vp.Y * 0.9) / 260, 1)
    end
    updScale()
    if workspace.CurrentCamera then
        workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updScale)
    end

    -- Header
    local Header = new("Frame", {
        Size = UDim2.new(1, 0, 0, 56),
        BackgroundColor3 = Theme.Header,
        BorderSizePixel = 0,
        Parent = Card,
    })
    corner(14, Header)
    new("Frame", { Size = UDim2.new(1, 0, 0, 12), Position = UDim2.new(0, 0, 1, -12), BackgroundColor3 = Theme.Header, BorderSizePixel = 0, Parent = Header })

    local logoHolder = new("Frame", { Size = UDim2.new(0, 26, 0, 26), Position = UDim2.new(0, 16, 0.5, -13), BackgroundTransparency = 1, Parent = Header })
    buildLogo(logoHolder, 26)

    new("TextLabel", {
        Size = UDim2.new(1, -70, 0, 18), Position = UDim2.new(0, 52, 0, 10),
        BackgroundTransparency = 1, Text = CONFIG.Name,
        TextColor3 = Theme.Text, TextSize = 14, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = Header,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -70, 0, 12), Position = UDim2.new(0, 52, 0, 30),
        BackgroundTransparency = 1, Text = CONFIG.Subtitle,
        TextColor3 = Theme.TextMuted, TextSize = 9, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = Header,
    })

    -- Body
    local Body = new("Frame", {
        Size = UDim2.new(1, -28, 1, -76),
        Position = UDim2.new(0, 14, 0, 70),
        BackgroundTransparency = 1,
        Parent = Card,
    })

    new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 14), BackgroundTransparency = 1,
        Text = "Enter Key",
        TextColor3 = Theme.TextMuted, TextSize = 10, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = Body,
    })

    local InputFrame = new("Frame", {
        Size = UDim2.new(1, 0, 0, 38), Position = UDim2.new(0, 0, 0, 22),
        BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = Body,
    })
    corner(8, InputFrame)
    local inputStroke = stroke(Theme.Border, 1, InputFrame)

    local keyIconHolder = new("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 12, 0.5, -7), BackgroundTransparency = 1, Parent = InputFrame })
    IconLib.Key(keyIconHolder, Theme.TextMuted)

    local KeyInput = new("TextBox", {
        Size = UDim2.new(1, -90, 1, 0), Position = UDim2.new(0, 34, 0, 0),
        BackgroundTransparency = 1, Text = "",
        PlaceholderText = "FREE_XXXX-XXXX",
        PlaceholderColor3 = Theme.TextMuted, TextColor3 = Theme.Text,
        TextSize = 12, Font = Enum.Font.Code, ClearTextOnFocus = false,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = InputFrame,
    })

    local pasteBtn = new("TextButton", {
        Size = UDim2.new(0, 46, 0, 24), Position = UDim2.new(1, -52, 0.5, -12),
        BackgroundColor3 = Theme.CardHover, BorderSizePixel = 0,
        Text = "Paste", TextColor3 = Theme.Text, TextSize = 10,
        Font = Enum.Font.GothamMedium, Parent = InputFrame,
    })
    corner(6, pasteBtn)
    pasteBtn.MouseButton1Click:Connect(function()
        local ok, clip = pcall(function() return game:GetService("GuiService"):GetClipboard() end)
        if ok and clip and clip ~= "" then KeyInput.Text = clip end
    end)

    local StatusLbl = new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 0, 68),
        BackgroundTransparency = 1, Text = "", TextColor3 = Theme.TextMuted,
        TextSize = 10, Font = Enum.Font.Gotham, Parent = Body,
    })

    local verifyBtn = new("TextButton", {
        Size = UDim2.new(1, 0, 0, 40), Position = UDim2.new(0, 0, 0, 88),
        BackgroundColor3 = Theme.Accent, BorderSizePixel = 0,
        Text = "VERIFY", TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 12, Font = Enum.Font.GothamBold, Parent = Body,
    })
    corner(8, verifyBtn)
    verifyBtn.MouseEnter:Connect(function() tween(verifyBtn, 0.12, { BackgroundColor3 = Theme.AccentDark }) end)
    verifyBtn.MouseLeave:Connect(function() tween(verifyBtn, 0.12, { BackgroundColor3 = Theme.Accent }) end)

    local function submit()
        local key = KeyInput.Text
        if key == "" then
            StatusLbl.Text = "Key cannot be empty"
            StatusLbl.TextColor3 = Theme.Error
            return
        end
        StatusLbl.Text = "Verifying..."
        StatusLbl.TextColor3 = Theme.Warning
        verifyBtn.Text = "..."
        task.wait(0.4)
        local valid, msg = validateKey(key)
        if valid then
            StatusLbl.Text = msg
            StatusLbl.TextColor3 = Theme.Success
            task.wait(0.35)
            tween(Dim, 0.3, { BackgroundTransparency = 1 })
            tween(Card, 0.3, { BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0) })
            task.wait(0.3)
            Dim:Destroy()
            onSuccess()
        else
            StatusLbl.Text = msg
            StatusLbl.TextColor3 = Theme.Error
            verifyBtn.Text = "VERIFY"
        end
    end
    verifyBtn.MouseButton1Click:Connect(submit)
    KeyInput.FocusLost:Connect(function(enter) if enter then submit() end end)
end

-- ============================================================
-- MAIN UI (Modern Rayfield-style, single feature)
-- ============================================================
local function buildMainUI()
    local Main = new("Frame", {
        Size = UDim2.new(0, 480, 0, 380),
        Position = UDim2.new(0.5, -240, 0.5, -190),
        BackgroundColor3 = Theme.BG,
        BorderSizePixel = 0,
        Parent = ScreenGui,
    })
    corner(14, Main)
    stroke(Theme.Border, 1, Main)

    local mScale = new("UIScale", { Scale = 1, Parent = Main })
    local function upd()
        local cam = workspace.CurrentCamera
        if not cam then return end
        local vp = cam.ViewportSize
        mScale.Scale = math.min((vp.X * 0.9) / 480, (vp.Y * 0.9) / 380, 1)
    end
    upd()
    if workspace.CurrentCamera then
        workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(upd)
    end

    -- Entrance animation
    Main.Size = UDim2.new(0, 480, 0, 380)
    Main.BackgroundTransparency = 1
    local entranceScale = new("UIScale", { Scale = 0.85, Parent = Main })
    tween(Main, 0.35, { BackgroundTransparency = 0 })
    tween(entranceScale, 0.4, { Scale = 1 }, Enum.EasingStyle.Back)
    task.delay(0.4, function() if entranceScale then entranceScale:Destroy() end end)

    -- Drag
    local dragging, dragStart, startPos = false, nil, nil
    local dragArea = new("Frame", { Size = UDim2.new(1, 0, 0, 56), BackgroundTransparency = 1, Parent = Main })
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
    -- HEADER
    -- ============================================================
    local Header = new("Frame", {
        Size = UDim2.new(1, 0, 0, 58),
        BackgroundColor3 = Theme.Header,
        BorderSizePixel = 0,
        Parent = Main,
    })
    corner(14, Header)
    new("Frame", { Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 1, -14), BackgroundColor3 = Theme.Header, BorderSizePixel = 0, Parent = Header })

    -- Accent line under header
    new("Frame", {
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Theme.Divider,
        BorderSizePixel = 0,
        Parent = Header,
    })

    local logoHolder = new("Frame", { Size = UDim2.new(0, 30, 0, 30), Position = UDim2.new(0, 16, 0.5, -15), BackgroundTransparency = 1, Parent = Header })
    buildLogo(logoHolder, 30)

    new("TextLabel", {
        Size = UDim2.new(1, -150, 0, 18), Position = UDim2.new(0, 58, 0, 14),
        BackgroundTransparency = 1, Text = CONFIG.Name,
        TextColor3 = Theme.Text, TextSize = 14, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = Header,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -150, 0, 13), Position = UDim2.new(0, 58, 0, 33),
        BackgroundTransparency = 1, Text = CONFIG.Subtitle .. " • " .. CONFIG.Version,
        TextColor3 = Theme.TextMuted, TextSize = 9, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = Header,
    })

    local function winBtn(iconFn, xOffset)
        local b = new("TextButton", {
            Size = UDim2.new(0, 26, 0, 26), Position = UDim2.new(1, xOffset, 0, 16),
            BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Text = "", Parent = Header,
        })
        corner(7, b)
        local holder = new("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0.5, -7, 0.5, -7), BackgroundTransparency = 1, Parent = b })
        IconLib[iconFn](holder, Theme.TextMuted)
        b.MouseEnter:Connect(function()
            tween(b, 0.12, { BackgroundColor3 = Theme.CardHover })
        end)
        b.MouseLeave:Connect(function()
            tween(b, 0.12, { BackgroundColor3 = Theme.Card })
        end)
        return b
    end

    local MinBtn = winBtn("Minimize", -68)
    local CloseBtn = winBtn("Close", -36)

    CloseBtn.MouseButton1Click:Connect(function()
        doUnfly()
        ScreenGui:Destroy()
    end)

    -- ============================================================
    -- BODY
    -- ============================================================
    local Body = new("Frame", {
        Size = UDim2.new(1, -28, 1, -78),
        Position = UDim2.new(0, 14, 0, 70),
        BackgroundTransparency = 1,
        Parent = Main,
    })

    -- ============================================================
    -- FLY TOGGLE CARD
    -- ============================================================
    local ToggleCard = new("Frame", {
        Size = UDim2.new(1, 0, 0, 68),
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        Parent = Body,
    })
    corner(12, ToggleCard)
    local toggleStroke = stroke(Theme.Border, 1, ToggleCard)

    local wingIconHolder = new("Frame", { Size = UDim2.new(0, 22, 0, 22), Position = UDim2.new(0, 18, 0.5, -11), BackgroundTransparency = 1, Parent = ToggleCard })
    IconLib.Wing(wingIconHolder, Theme.Accent)

    new("TextLabel", {
        Size = UDim2.new(1, -140, 0, 18), Position = UDim2.new(0, 52, 0, 16),
        BackgroundTransparency = 1, Text = "Fly",
        TextColor3 = Theme.Text, TextSize = 14, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = ToggleCard,
    })

    local stateLbl = new("TextLabel", {
        Size = UDim2.new(1, -140, 0, 14), Position = UDim2.new(0, 52, 0, 38),
        BackgroundTransparency = 1, Text = "Disabled",
        TextColor3 = Theme.TextMuted, TextSize = 10, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = ToggleCard,
    })

    local toggleBg = new("TextButton", {
        Size = UDim2.new(0, 56, 0, 30), Position = UDim2.new(1, -74, 0.5, -15),
        BackgroundColor3 = Theme.Header, BorderSizePixel = 0, Text = "", Parent = ToggleCard,
    })
    corner(100, toggleBg)
    local toggleDot = new("Frame", {
        Size = UDim2.new(0, 24, 0, 24), Position = UDim2.new(0, 3, 0.5, -12),
        BackgroundColor3 = Theme.TextMuted, BorderSizePixel = 0, Parent = toggleBg,
    })
    corner(100, toggleDot)

    local toggled = false
    local function updateToggle()
        if toggled then
            tween(toggleBg, 0.18, { BackgroundColor3 = Theme.Accent })
            tween(toggleDot, 0.18, { Position = UDim2.new(1, -27, 0.5, -12), BackgroundColor3 = Color3.fromRGB(255,255,255) })
            stateLbl.Text = "Enabled"
            stateLbl.TextColor3 = Theme.Success
            toggleStroke.Color = Theme.Accent
        else
            tween(toggleBg, 0.18, { BackgroundColor3 = Theme.Header })
            tween(toggleDot, 0.18, { Position = UDim2.new(0, 3, 0.5, -12), BackgroundColor3 = Theme.TextMuted })
            stateLbl.Text = "Disabled"
            stateLbl.TextColor3 = Theme.TextMuted
            toggleStroke.Color = Theme.Border
        end
    end

    toggleBg.MouseButton1Click:Connect(function()
        toggled = not toggled
        updateToggle()
        if toggled then doFly() else doUnfly() end
    end)

    -- ============================================================
    -- SPEED CARD
    -- ============================================================
    local SpeedCard = new("Frame", {
        Size = UDim2.new(1, 0, 0, 110),
        Position = UDim2.new(0, 0, 0, 80),
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        Parent = Body,
    })
    corner(12, SpeedCard)
    stroke(Theme.Border, 1, SpeedCard)

    local speedIconHolder = new("Frame", { Size = UDim2.new(0, 22, 0, 22), Position = UDim2.new(0, 18, 0, 16), BackgroundTransparency = 1, Parent = SpeedCard })
    IconLib.Speed(speedIconHolder, Theme.Text)

    new("TextLabel", {
        Size = UDim2.new(1, -140, 0, 18), Position = UDim2.new(0, 52, 0, 18),
        BackgroundTransparency = 1, Text = "Fly Speed",
        TextColor3 = Theme.Text, TextSize = 13, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = SpeedCard,
    })

    local speedValLbl = new("TextLabel", {
        Size = UDim2.new(0, 90, 0, 18), Position = UDim2.new(1, -108, 0, 18),
        BackgroundTransparency = 1, Text = "5",
        TextColor3 = Theme.Accent, TextSize = 13, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Right, Parent = SpeedCard,
    })

    local bar = new("Frame", {
        Size = UDim2.new(1, -36, 0, 8),
        Position = UDim2.new(0, 18, 0, 74),
        BackgroundColor3 = Theme.Header,
        BorderSizePixel = 0,
        Parent = SpeedCard,
    })
    corner(100, bar)
    local initFrac = (5 - 1) / (50 - 1)
    local fill = new("Frame", {
        Size = UDim2.new(initFrac, 0, 1, 0),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        Parent = bar,
    })
    corner(100, fill)
    local dot = new("Frame", {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(initFrac, -8, 0.5, -8),
        BackgroundColor3 = Color3.fromRGB(255,255,255),
        BorderSizePixel = 0,
        Parent = bar,
    })
    corner(100, dot)

    local dragging_s = false
    local MIN_SPD, MAX_SPD = 1, 50

    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local val = math.floor(MIN_SPD + (MAX_SPD - MIN_SPD) * pos)
        iyflyspeed = val
        fill.Size = UDim2.new(pos, 0, 1, 0)
        dot.Position = UDim2.new(pos, -8, 0.5, -8)
        speedValLbl.Text = tostring(val)
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging_s = true
            updateSlider(input)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging_s and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging_s = false
        end
    end)

    -- Min / Max labels
    new("TextLabel", {
        Size = UDim2.new(0, 30, 0, 12), Position = UDim2.new(0, 18, 0, 88),
        BackgroundTransparency = 1, Text = "1",
        TextColor3 = Theme.TextMuted, TextSize = 9, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = SpeedCard,
    })
    new("TextLabel", {
        Size = UDim2.new(0, 30, 0, 12), Position = UDim2.new(1, -48, 0, 88),
        BackgroundTransparency = 1, Text = "50",
        TextColor3 = Theme.TextMuted, TextSize = 9, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Right, Parent = SpeedCard,
    })

    -- ============================================================
    -- PRESET CARD
    -- ============================================================
    local PresetCard = new("Frame", {
        Size = UDim2.new(1, 0, 0, 62),
        Position = UDim2.new(0, 0, 0, 200),
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        Parent = Body,
    })
    corner(12, PresetCard)
    stroke(Theme.Border, 1, PresetCard)

    new("TextLabel", {
        Size = UDim2.new(1, -30, 0, 16), Position = UDim2.new(0, 18, 0, 10),
        BackgroundTransparency = 1, Text = "Quick Speed",
        TextColor3 = Theme.TextMuted, TextSize = 10, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = PresetCard,
    })

    local presetRow = new("Frame", {
        Size = UDim2.new(1, -36, 0, 30),
        Position = UDim2.new(0, 18, 0, 28),
        BackgroundTransparency = 1,
        Parent = PresetCard,
    })
    new("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = presetRow,
    })

    for _, preset in ipairs({1, 3, 5, 10, 20}) do
        local pb = new("TextButton", {
            Size = UDim2.new(0, 76, 0, 30),
            BackgroundColor3 = Theme.Header,
            BorderSizePixel = 0,
            Text = tostring(preset),
            TextColor3 = Theme.Text,
            TextSize = 11,
            Font = Enum.Font.GothamBold,
            LayoutOrder = preset,
            Parent = presetRow,
        })
        corner(7, pb)
        local pbs = stroke(Theme.Border, 1, pb)
        pb.MouseButton1Click:Connect(function()
            iyflyspeed = preset
            local pos = (preset - MIN_SPD) / (MAX_SPD - MIN_SPD)
            fill.Size = UDim2.new(pos, 0, 1, 0)
            dot.Position = UDim2.new(pos, -8, 0.5, -8)
            speedValLbl.Text = tostring(preset)
        end)
        pb.MouseEnter:Connect(function()
            tween(pb, 0.12, { BackgroundColor3 = Theme.CardHover })
            tween(pbs, 0.12, { Color = Theme.BorderHover })
        end)
        pb.MouseLeave:Connect(function()
            tween(pb, 0.12, { BackgroundColor3 = Theme.Header })
            tween(pbs, 0.12, { Color = Theme.Border })
        end)
    end

    -- ============================================================
    -- INFO CARD
    -- ============================================================
    local InfoCard = new("Frame", {
        Size = UDim2.new(1, 0, 0, 44),
        Position = UDim2.new(0, 0, 0, 272),
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        Parent = Body,
    })
    corner(12, InfoCard)
    stroke(Theme.Border, 1, InfoCard)

    local infoIconHolder = new("Frame", { Size = UDim2.new(0, 16, 0, 16), Position = UDim2.new(0, 16, 0.5, -8), BackgroundTransparency = 1, Parent = InfoCard })
    IconLib.Info(infoIconHolder, Theme.TextMuted)

    new("TextLabel", {
        Size = UDim2.new(1, -50, 1, 0), Position = UDim2.new(0, 42, 0, 0),
        BackgroundTransparency = 1, Text = "W A S D • Q / E naik turun",
        TextColor3 = Theme.TextMuted, TextSize = 10, Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = InfoCard,
    })

    -- ============================================================
    -- MINIMIZE
    -- ============================================================
    local floatingIcon = nil
    local savedPos = UDim2.new(0, 20, 0.5, -26)
    local isMinimized = false

    local function restore()
        if not isMinimized then return end
        isMinimized = false
        Main.Visible = true
        tween(Main, 0.35, {
            Size = UDim2.new(0, 480, 0, 380),
            Position = UDim2.new(0.5, -240, 0.5, -190),
            BackgroundTransparency = 0,
        }, Enum.EasingStyle.Back)
        if floatingIcon then
            tween(floatingIcon, 0.25, { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 })
            task.wait(0.28)
            if floatingIcon then floatingIcon:Destroy() floatingIcon = nil end
        end
    end

    local function minimize()
        if isMinimized then return end
        isMinimized = true

        if floatingIcon then floatingIcon:Destroy() end

        floatingIcon = new("TextButton", {
            Size = UDim2.new(0, 0, 0, 0),
            Position = savedPos,
            BackgroundColor3 = Theme.Card,
            BorderSizePixel = 0,
            Text = "",
            ZIndex = 200,
            Parent = ScreenGui,
        })
        corner(26, floatingIcon)
        stroke(Theme.Border, 1, floatingIcon)
        local glowStroke = new("UIStroke", { Color = Theme.Accent, Thickness = 1.5, Transparency = 0.6, Parent = floatingIcon })
        task.spawn(function()
            while floatingIcon and floatingIcon.Parent do
                tween(glowStroke, 2, { Transparency = 0.15 }); task.wait(2)
                tween(glowStroke, 2, { Transparency = 0.85 }); task.wait(2)
            end
        end)

        local lh = new("Frame", { Size = UDim2.new(0, 28, 0, 28), Position = UDim2.new(0.5, -14, 0.5, -14), BackgroundTransparency = 1, Parent = floatingIcon })
        buildLogo(lh, 28)

        tween(floatingIcon, 0.35, { Size = UDim2.new(0, 50, 0, 50) }, Enum.EasingStyle.Back)

        local fDrag = false
        local fStart, fPos
        local dragHappened = false

        floatingIcon.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                fDrag = true
                dragHappened = false
                fStart = input.Position
                fPos = floatingIcon.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        fDrag = false
                    end
                end)
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if fDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local d = input.Position - fStart
                if math.abs(d.X) > 3 or math.abs(d.Y) > 3 then dragHappened = true end
                floatingIcon.Position = UDim2.new(fPos.X.Scale, fPos.X.Offset + d.X, fPos.Y.Scale, fPos.Y.Offset + d.Y)
                savedPos = floatingIcon.Position
            end
        end)

        floatingIcon.MouseButton1Click:Connect(function()
            if dragHappened then return end
            savedPos = floatingIcon.Position
            restore()
        end)

        tween(Main, 0.3, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1,
        }, Enum.EasingStyle.Back)

        task.wait(0.3)
        Main.Visible = false
    end

    MinBtn.MouseButton1Click:Connect(minimize)
end

-- ============================================================
-- START
-- ============================================================
buildKeyUI(function()
    buildMainUI()
end)

print("[Hallwayz] UI loaded.")
