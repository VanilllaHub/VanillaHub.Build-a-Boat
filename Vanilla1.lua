
if type(_G.VanillaHubCleanup) == "function" then
    pcall(_G.VanillaHubCleanup)
    _G.VanillaHubCleanup = nil
end

for _, name in pairs({"VanillaHub", "VanillaHubWarning"}) do
    if game.CoreGui:FindFirstChild(name) then
        game.CoreGui[name]:Destroy()
    end
end

if _G.VH then
    if _G.VH.vanilla and _G.VH.vanilla.running then
        _G.VH.vanilla.running = false
        if _G.VH.vanilla.thread then pcall(task.cancel, _G.VH.vanilla.thread) end
        _G.VH.vanilla.thread = nil
    end
    _G.VH = nil
end

if workspace:FindFirstChild("VanillaHubTpCircle") then
    workspace.VanillaHubTpCircle:Destroy()
end

if game.PlaceId ~= 537413528 then
    task.spawn(function()
        task.wait(0.4)
        local warnGui = Instance.new("ScreenGui")
        warnGui.Name = "VanillaHubWarning"
        warnGui.Parent = game.CoreGui
        warnGui.ResetOnSpawn = false
        local frame = Instance.new("Frame", warnGui)
        frame.Size = UDim2.new(0, 400, 0, 220)
        frame.Position = UDim2.new(0.5, -200, 0.5, -110)
        frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        frame.BackgroundTransparency = 0.15
        frame.BorderSizePixel = 0
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
        local uiStroke = Instance.new("UIStroke", frame)
        uiStroke.Color = Color3.fromRGB(80, 80, 80)
        uiStroke.Thickness = 1.5; uiStroke.Transparency = 0.3
        local icon = Instance.new("TextLabel", frame)
        icon.Size = UDim2.new(0, 48, 0, 48); icon.Position = UDim2.new(0, 24, 0, 24)
        icon.BackgroundTransparency = 1; icon.Font = Enum.Font.GothamBlack
        icon.TextSize = 42; icon.TextColor3 = Color3.fromRGB(200, 200, 200); icon.Text = "!"
        local msg = Instance.new("TextLabel", frame)
        msg.Size = UDim2.new(1, -100, 0, 120); msg.Position = UDim2.new(0, 90, 0, 30)
        msg.BackgroundTransparency = 1; msg.Font = Enum.Font.GothamSemibold; msg.TextSize = 15
        msg.TextColor3 = Color3.fromRGB(210, 210, 210); msg.TextXAlignment = Enum.TextXAlignment.Left
        msg.TextYAlignment = Enum.TextYAlignment.Top; msg.TextWrapped = true
        msg.Text = "VanillaHub is made exclusively for Build A Boat For Treasure (Place ID: 537413528).\n\nPlease join Build A Boat For Treasure and re-execute the script there."
        local okBtn = Instance.new("TextButton", frame)
        okBtn.Size = UDim2.new(0, 160, 0, 50); okBtn.Position = UDim2.new(0.5, -80, 1, -70)
        okBtn.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
        okBtn.BorderSizePixel = 0
        okBtn.Font = Enum.Font.GothamBold; okBtn.TextSize = 17
        okBtn.TextColor3 = Color3.fromRGB(255, 255, 255); okBtn.Text = "I Understand"
        Instance.new("UICorner", okBtn).CornerRadius = UDim.new(0, 12)
        local TS2 = game:GetService("TweenService")
        frame.BackgroundTransparency = 1; msg.TextTransparency = 1; icon.TextTransparency = 1
        okBtn.BackgroundTransparency = 1; okBtn.TextTransparency = 1
        TS2:Create(frame, TweenInfo.new(0.75, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.15}):Play()
        TS2:Create(msg,   TweenInfo.new(0.85, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
        TS2:Create(icon,  TweenInfo.new(0.85, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
        TS2:Create(okBtn, TweenInfo.new(0.95, Enum.EasingStyle.Quint), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
        okBtn.MouseButton1Click:Connect(function()
            local ot = TS2:Create(frame, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 1})
            ot:Play()
            TS2:Create(msg,   TweenInfo.new(0.8), {TextTransparency = 1}):Play()
            TS2:Create(icon,  TweenInfo.new(0.8), {TextTransparency = 1}):Play()
            TS2:Create(okBtn, TweenInfo.new(0.8), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
            ot.Completed:Connect(function() if warnGui and warnGui.Parent then warnGui:Destroy() end end)
        end)
    end)
    return
end

local TweenService      = game:GetService("TweenService")
local Players           = game:GetService("Players")
local UserInputService  = game:GetService("UserInputService")
local RunService        = game:GetService("RunService")
local TeleportService   = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Stats             = game:GetService("Stats")
local Lighting          = game:GetService("Lighting")
local player            = Players.LocalPlayer
local mouse             = player:GetMouse()

local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled

local THEME_TEXT   = Color3.fromRGB(220, 220, 220)
local BTN_COLOR    = Color3.fromRGB(14, 14, 14)
local BTN_HOVER    = Color3.fromRGB(32,  32,  32)
local ACCENT       = Color3.fromRGB(160, 160, 160)
local BG_DARK      = Color3.fromRGB(6,  6,  6 )
local BG_SIDE      = Color3.fromRGB(10, 10, 10)
local BG_TOP       = Color3.fromRGB(8,  8,  8 )
local BORDER_COLOR = Color3.fromRGB(60, 60, 60)
local SEP_COLOR    = Color3.fromRGB(50, 50, 50)
local SECTION_TEXT = Color3.fromRGB(130, 130, 130)
local OUTER_BG     = Color3.fromRGB(8,   8,   8 )

local SW_OFF      = Color3.fromRGB(55, 55, 55)
local SW_ON       = Color3.fromRGB(230, 230, 230)
local SW_KNOB_OFF = Color3.fromRGB(160, 160, 160)
local SW_KNOB_ON  = Color3.fromRGB(30, 30, 30)

local PB_BAR  = Color3.fromRGB(255, 255, 255)
local PB_TEXT = Color3.fromRGB(255, 255, 255)

local function detectExecutor()
    if syn and syn.request then return "Synapse X"
    elseif KRNL_LOADED then return "Krnl"
    elseif SENTINEL_V2 then return "Sentinel"
    elseif pebc_execute then return "ProtoSmasher"
    elseif getgenv and getgenv().Script_Builder then return "Script-Ware"
    elseif fluxus then return "Fluxus"
    elseif type(Drawing) == "table" then
        if identifyexecutor then
            local n = identifyexecutor()
            if n and n ~= "" then return n end
        end
        if typeof(gethui) == "function" then return "Electron / Generic" end
        return "Unknown Executor"
    elseif identifyexecutor then
        local n = identifyexecutor()
        if n and n ~= "" then return n end
        return "Unknown Executor"
    end
    return "Unknown / Studio"
end

local cleanupTasks = {}
local vanillaRunning = false
local vanillaThread  = nil

local function onExit()
    vanillaRunning = false
    if vanillaThread then pcall(task.cancel, vanillaThread); vanillaThread = nil end
    if _G.VH and _G.VH.vanilla then
        _G.VH.vanilla.running = false
        if _G.VH.vanilla.thread then pcall(task.cancel, _G.VH.vanilla.thread); _G.VH.vanilla.thread = nil end
    end
    for _, fn in ipairs(cleanupTasks) do pcall(fn) end
    cleanupTasks = {}
    pcall(function()
        local char = player.Character
        if not char then return end
        local hum = char:FindFirstChild("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hum then
            hum.PlatformStand = false
            hum.WalkSpeed = 16
            hum.JumpPower = 50
        end
        if hrp then
            for _, obj in ipairs(hrp:GetChildren()) do
                if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") then
                    pcall(function() obj:Destroy() end)
                end
            end
        end
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then pcall(function() p.CanCollide = true end) end
        end
    end)
    pcall(function()
        if workspace:FindFirstChild("VanillaHubTpCircle") then
            workspace.VanillaHubTpCircle:Destroy()
        end
    end)
    pcall(function()
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj.Name == "WalkWaterPlane" then obj:Destroy() end
        end
    end)
    _G.VH = nil
    _G.VanillaHubCleanup = nil
end

local gui = Instance.new("ScreenGui")
gui.Name = "VanillaHub"; gui.Parent = game.CoreGui; gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
table.insert(cleanupTasks, function() if gui and gui.Parent then gui:Destroy() end end)

_G.VanillaHubCleanup = onExit

local wrapper = Instance.new("Frame", gui)
wrapper.Size = UDim2.new(0, 0, 0, 0)
wrapper.Position = UDim2.new(0.5, -265, 0.5, -175)
wrapper.BackgroundColor3 = OUTER_BG
wrapper.BackgroundTransparency = 0
wrapper.BorderSizePixel = 0
wrapper.ClipsDescendants = false
Instance.new("UICorner", wrapper).CornerRadius = UDim.new(0, 16)

local main = Instance.new("Frame", wrapper)
main.Size = UDim2.new(0, 0, 0, 0)
main.Position = UDim2.new(0, 0, 0, 0)
main.BackgroundColor3 = BG_DARK
main.BackgroundTransparency = 1
main.BorderSizePixel = 0
main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = BORDER_COLOR
mainStroke.Thickness = 1.2
mainStroke.Transparency = 0.3

TweenService:Create(wrapper, TweenInfo.new(0.65, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 540, 0, 360)
}):Play()
TweenService:Create(main, TweenInfo.new(0.65, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 540, 0, 360),
    BackgroundTransparency = 0
}):Play()

local topBar = Instance.new("Frame", main)
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundColor3 = BG_TOP
topBar.BorderSizePixel = 0
topBar.ZIndex = 4

local topBarSep = Instance.new("Frame", topBar)
topBarSep.Size = UDim2.new(1, 0, 0, 1)
topBarSep.Position = UDim2.new(0, 0, 1, -1)
topBarSep.BackgroundColor3 = SEP_COLOR
topBarSep.BorderSizePixel = 0
topBarSep.ZIndex = 5

local hubIcon = Instance.new("ImageLabel", topBar)
hubIcon.Size = UDim2.new(0, 26, 0, 26); hubIcon.Position = UDim2.new(0, 9, 0.5, -13)
hubIcon.BackgroundTransparency = 1; hubIcon.BorderSizePixel = 0
hubIcon.ScaleType = Enum.ScaleType.Fit; hubIcon.ZIndex = 6
hubIcon.Image = "rbxassetid://97128823316544"
Instance.new("UICorner", hubIcon).CornerRadius = UDim.new(0, 5)

local titleLbl = Instance.new("TextLabel", topBar)
titleLbl.Size = UDim2.new(1, -110, 1, 0); titleLbl.Position = UDim2.new(0, 44, 0, 0)
titleLbl.BackgroundTransparency = 1; titleLbl.Text = "VanillaHub | Build A Boat For Treasure"
titleLbl.Font = Enum.Font.GothamBold; titleLbl.TextSize = 15
titleLbl.TextColor3 = THEME_TEXT; titleLbl.TextXAlignment = Enum.TextXAlignment.Left; titleLbl.ZIndex = 5

local versionLbl = Instance.new("TextLabel", topBar)
versionLbl.Size = UDim2.new(0, 52, 0, 20); versionLbl.Position = UDim2.new(1, -96, 0.5, -10)
versionLbl.BackgroundTransparency = 1; versionLbl.Text = "v1.1.0"
versionLbl.Font = Enum.Font.Gotham; versionLbl.TextSize = 11
versionLbl.TextColor3 = Color3.fromRGB(130, 130, 130); versionLbl.TextXAlignment = Enum.TextXAlignment.Right
versionLbl.ZIndex = 5

local minimized = false
local minimizeBtn = Instance.new("TextButton", topBar)
minimizeBtn.Size = UDim2.new(0, 24, 0, 24)
minimizeBtn.Position = UDim2.new(1, -32, 0.5, -12)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 15
minimizeBtn.TextColor3 = Color3.fromRGB(120, 120, 120)
minimizeBtn.Text = "−"
minimizeBtn.AutoButtonColor = false
minimizeBtn.ZIndex = 6
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 6)
local minBtnStroke = Instance.new("UIStroke", minimizeBtn)
minBtnStroke.Color = BORDER_COLOR
minBtnStroke.Thickness = 1
minBtnStroke.Transparency = 0.3

minimizeBtn.MouseEnter:Connect(function()
    TweenService:Create(minimizeBtn, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        TextColor3 = Color3.fromRGB(180, 180, 180)
    }):Play()
end)
minimizeBtn.MouseLeave:Connect(function()
    TweenService:Create(minimizeBtn, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(18, 18, 18),
        TextColor3 = Color3.fromRGB(120, 120, 120)
    }):Play()
end)
minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    minimizeBtn.Text = minimized and "+" or "−"
    if minimized then
        TweenService:Create(wrapper, TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 540, 0, 40)
        }):Play()
        TweenService:Create(main, TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 540, 0, 40)
        }):Play()
    else
        TweenService:Create(wrapper, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 540, 0, 360)
        }):Play()
        TweenService:Create(main, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 540, 0, 360)
        }):Play()
    end
end)

local dragging, dragStart, startPos = false, nil, nil
topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = wrapper.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        wrapper.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

local side = Instance.new("ScrollingFrame", main)
side.Size = UDim2.new(0, 155, 1, -40)
side.Position = UDim2.new(0, 0, 0, 40)
side.BackgroundColor3 = BG_SIDE
side.BorderSizePixel = 0
side.ScrollBarThickness = 3
side.ScrollBarImageColor3 = Color3.fromRGB(90, 90, 90)
side.CanvasSize = UDim2.new(0, 0, 0, 0)
side.ZIndex = 2

local sidePad = Instance.new("UIPadding", side)
sidePad.PaddingTop = UDim.new(0, 10)
sidePad.PaddingBottom = UDim.new(0, 10)
sidePad.PaddingLeft = UDim.new(0, 8)
sidePad.PaddingRight = UDim.new(0, 8)

local sideLayout = Instance.new("UIListLayout", side)
sideLayout.Padding = UDim.new(0, 5)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    side.CanvasSize = UDim2.new(0, 0, 0, sideLayout.AbsoluteContentSize.Y + 20)
end)

local sideSep = Instance.new("Frame", main)
sideSep.Size = UDim2.new(0, 1, 1, -40)
sideSep.Position = UDim2.new(0, 155, 0, 40)
sideSep.BackgroundColor3 = SEP_COLOR
sideSep.BorderSizePixel = 0
sideSep.ZIndex = 3

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -156, 1, -40)
content.Position = UDim2.new(0, 156, 0, 40)
content.BackgroundColor3 = BG_DARK
content.BorderSizePixel = 0

task.spawn(function()
    task.wait(0.8)
    if not (gui and gui.Parent) then return end
    local wf = Instance.new("Frame", gui)
    wf.Size = UDim2.new(0, 380, 0, 90); wf.Position = UDim2.new(0.5, -190, 1, -110)
    wf.BackgroundColor3 = Color3.fromRGB(20, 20, 20); wf.BackgroundTransparency = 1; wf.BorderSizePixel = 0
    Instance.new("UICorner", wf).CornerRadius = UDim.new(0, 14)
    local ws = Instance.new("UIStroke", wf)
    ws.Color = BORDER_COLOR; ws.Thickness = 1.2; ws.Transparency = 0.4
    local pfp = Instance.new("ImageLabel", wf)
    pfp.Size = UDim2.new(0, 64, 0, 64); pfp.Position = UDim2.new(0, 20, 0.5, -32)
    pfp.BackgroundTransparency = 1; pfp.ImageTransparency = 1
    pfp.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
    Instance.new("UICorner", pfp).CornerRadius = UDim.new(1, 0)
    local wt = Instance.new("TextLabel", wf)
    wt.Size = UDim2.new(1, -110, 1, -20); wt.Position = UDim2.new(0, 100, 0, 10)
    wt.BackgroundTransparency = 1; wt.Font = Enum.Font.GothamSemibold; wt.TextSize = 18
    wt.TextColor3 = THEME_TEXT; wt.TextXAlignment = Enum.TextXAlignment.Left
    wt.TextYAlignment = Enum.TextYAlignment.Center; wt.TextWrapped = true; wt.TextTransparency = 1
    wt.Text = "You're back, " .. player.DisplayName .. ".\nVanillaHub is ready to use."
    TweenService:Create(wf, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.2}):Play()
    TweenService:Create(wt, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
    TweenService:Create(pfp, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
    task.delay(7, function()
        if not (wf and wf.Parent) then return end
        local ot = TweenService:Create(wf, TweenInfo.new(1.2, Enum.EasingStyle.Quint), {BackgroundTransparency = 1})
        ot:Play()
        TweenService:Create(wt, TweenInfo.new(1.2), {TextTransparency = 1}):Play()
        TweenService:Create(pfp, TweenInfo.new(1.2), {ImageTransparency = 1}):Play()
        ot.Completed:Connect(function() if wf and wf.Parent then wf:Destroy() end end)
    end)
end)

local tabs = {"Home","Player","World","Search","Settings"}
local pages = {}

for _, name in ipairs(tabs) do
    local page = Instance.new("ScrollingFrame", content)
    page.Name = name .. "Tab"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(90, 90, 90)
    page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 0, 0)

    local list = Instance.new("UIListLayout", page)
    list.Padding = UDim.new(0, 10)
    list.HorizontalAlignment = Enum.HorizontalAlignment.Center
    list.SortOrder = Enum.SortOrder.LayoutOrder

    local pad = Instance.new("UIPadding", page)
    pad.PaddingTop = UDim.new(0, 14)
    pad.PaddingBottom = UDim.new(0, 14)
    pad.PaddingLeft = UDim.new(0, 12)
    pad.PaddingRight = UDim.new(0, 12)

    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 32)
    end)

    pages[name .. "Tab"] = page
end

local activeTabButton = nil
local function switchTab(targetName)
    for _, page in pairs(pages) do
        page.Visible = (page.Name == targetName)
    end
    if activeTabButton then
        local oldLbl  = activeTabButton:FindFirstChild("TabLabel")
        local oldIcon = activeTabButton:FindFirstChild("TabIcon")
        TweenService:Create(activeTabButton, TweenInfo.new(0.22), {BackgroundColor3 = Color3.fromRGB(0, 0, 0)}):Play()
        if oldLbl  then TweenService:Create(oldLbl,  TweenInfo.new(0.22), {TextColor3  = Color3.fromRGB(110, 110, 110)}):Play() end
        if oldIcon then TweenService:Create(oldIcon, TweenInfo.new(0.22), {ImageColor3 = Color3.fromRGB(110, 110, 110)}):Play() end
    end
    local frame = side:FindFirstChild(targetName:gsub("Tab",""))
    if frame then
        activeTabButton = frame
        local newLbl  = frame:FindFirstChild("TabLabel")
        local newIcon = frame:FindFirstChild("TabIcon")
        TweenService:Create(frame, TweenInfo.new(0.22), {BackgroundColor3 = Color3.fromRGB(38, 38, 38)}):Play()
        if newLbl  then TweenService:Create(newLbl,  TweenInfo.new(0.22), {TextColor3  = THEME_TEXT}):Play() end
        if newIcon then TweenService:Create(newIcon, TweenInfo.new(0.22), {ImageColor3 = THEME_TEXT}):Play() end
    end
end

local TAB_ICON_SIZE = {
    ["Home"]      = 25,
    ["Player"]    = 25,
    ["World"]     = 18,
    ["Search"]    = 20,
    ["Settings"]  = 20,
}

local tabIcons = {
    ["Home"]      = "103808960525817",
    ["Player"]    = "124010641391821",
    ["World"]     = "126582208494394",
    ["Search"]    = "75885588738364",
    ["Settings"]  = "116984423831131",
}

local function getIcon(id)
    return "rbxthumb://type=Asset&id=" .. id .. "&w=150&h=150"
end

for _, name in ipairs(tabs) do
    local frame = Instance.new("Frame", side)
    frame.Name = name
    frame.Size = UDim2.new(1, 0, 0, 34)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BorderSizePixel = 0
    frame.ZIndex = 1
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 7)

    local icon = Instance.new("ImageLabel", frame)
    icon.Name = "TabIcon"
    icon.Size = UDim2.new(0, 20, 0, 20)
    icon.Position = UDim2.new(0, 8, 0.5, -10)
    icon.BackgroundTransparency = 1
    icon.BorderSizePixel = 0
    icon.ScaleType = Enum.ScaleType.Fit
    icon.Image = getIcon(tabIcons[name])
    icon.ImageColor3 = Color3.fromRGB(110, 110, 110)
    icon.ZIndex = 3

    local nameLbl = Instance.new("TextLabel", frame)
    nameLbl.Name = "TabLabel"
    nameLbl.Size = UDim2.new(1, -34, 1, 0)
    nameLbl.Position = UDim2.new(0, 34, 0, 0)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Font = Enum.Font.GothamSemibold
    nameLbl.TextSize = 13
    nameLbl.TextColor3 = Color3.fromRGB(110, 110, 110)
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.Text = name
    nameLbl.ZIndex = 3

    local btn = Instance.new("TextButton", frame)
    btn.Name = name .. "_Btn"
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.ZIndex = 2
    btn.AutoButtonColor = false

    btn.MouseEnter:Connect(function()
        if activeTabButton ~= frame then
            TweenService:Create(frame,   TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(22, 22, 22)}):Play()
            TweenService:Create(nameLbl, TweenInfo.new(0.18), {TextColor3       = Color3.fromRGB(180, 180, 180)}):Play()
            TweenService:Create(icon,    TweenInfo.new(0.18), {ImageColor3      = Color3.fromRGB(180, 180, 180)}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if activeTabButton ~= frame then
            TweenService:Create(frame,   TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(0, 0, 0)}):Play()
            TweenService:Create(nameLbl, TweenInfo.new(0.18), {TextColor3       = Color3.fromRGB(110, 110, 110)}):Play()
            TweenService:Create(icon,    TweenInfo.new(0.18), {ImageColor3      = Color3.fromRGB(110, 110, 110)}):Play()
        end
    end)
    btn.MouseButton1Click:Connect(function()
        switchTab(name.."Tab")
    end)
end

switchTab("HomeTab")

task.spawn(function()
    task.wait(0.05)

    local overlay = Instance.new("Frame", main)
    overlay.Name              = "VHLoadingOverlay"
    overlay.Size              = UDim2.new(1, 0, 1, -40)
    overlay.Position          = UDim2.new(0, 0, 0, 40)
    overlay.BackgroundColor3  = Color3.fromRGB(6, 6, 6)
    overlay.BackgroundTransparency = 0
    overlay.BorderSizePixel   = 0
    overlay.ZIndex            = 50
    overlay.ClipsDescendants  = true

    local logoImg = Instance.new("ImageLabel", overlay)
    logoImg.Size              = UDim2.new(0, 48, 0, 48)
    logoImg.AnchorPoint       = Vector2.new(0.5, 0)
    logoImg.Position          = UDim2.new(0.5, 0, 0, 80)
    logoImg.BackgroundColor3  = Color3.fromRGB(20, 20, 20)
    logoImg.BorderSizePixel   = 0
    logoImg.ScaleType         = Enum.ScaleType.Fit
    logoImg.Image             = "rbxassetid://97128823316544"
    logoImg.ZIndex            = 51
    Instance.new("UICorner", logoImg).CornerRadius = UDim.new(0, 10)
    local logoStroke = Instance.new("UIStroke", logoImg)
    logoStroke.Color       = Color3.fromRGB(60, 60, 60)
    logoStroke.Thickness   = 1.2
    logoStroke.Transparency = 0.3

    local titleLbl2 = Instance.new("TextLabel", overlay)
    titleLbl2.Size              = UDim2.new(1, -40, 0, 28)
    titleLbl2.AnchorPoint       = Vector2.new(0.5, 0)
    titleLbl2.Position          = UDim2.new(0.5, 0, 0, 140)
    titleLbl2.BackgroundTransparency = 1
    titleLbl2.Font              = Enum.Font.GothamBold
    titleLbl2.TextSize          = 18
    titleLbl2.TextColor3        = Color3.fromRGB(220, 220, 220)
    titleLbl2.TextXAlignment    = Enum.TextXAlignment.Center
    titleLbl2.Text              = "Loading VanillaHub"
    titleLbl2.ZIndex            = 51

    local subLbl = Instance.new("TextLabel", overlay)
    subLbl.Size              = UDim2.new(1, -40, 0, 18)
    subLbl.AnchorPoint       = Vector2.new(0.5, 0)
    subLbl.Position          = UDim2.new(0.5, 0, 0, 170)
    subLbl.BackgroundTransparency = 1
    subLbl.Font              = Enum.Font.Gotham
    subLbl.TextSize          = 12
    subLbl.TextColor3        = Color3.fromRGB(100, 100, 100)
    subLbl.TextXAlignment    = Enum.TextXAlignment.Center
    subLbl.Text              = "Please wait..."
    subLbl.ZIndex            = 51

    local barTrack = Instance.new("Frame", overlay)
    barTrack.Size             = UDim2.new(0, 260, 0, 5)
    barTrack.AnchorPoint      = Vector2.new(0.5, 0)
    barTrack.Position         = UDim2.new(0.5, 0, 0, 210)
    barTrack.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    barTrack.BorderSizePixel  = 0
    barTrack.ZIndex           = 51
    Instance.new("UICorner", barTrack).CornerRadius = UDim.new(1, 0)

    local barFill = Instance.new("Frame", barTrack)
    barFill.Size             = UDim2.new(0, 0, 1, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    barFill.BorderSizePixel  = 0
    barFill.ZIndex           = 52
    Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

    local pctLbl = Instance.new("TextLabel", overlay)
    pctLbl.Size              = UDim2.new(1, -40, 0, 18)
    pctLbl.AnchorPoint       = Vector2.new(0.5, 0)
    pctLbl.Position          = UDim2.new(0.5, 0, 0, 222)
    pctLbl.BackgroundTransparency = 1
    pctLbl.Font              = Enum.Font.GothamBold
    pctLbl.TextSize          = 11
    pctLbl.TextColor3        = Color3.fromRGB(130, 130, 130)
    pctLbl.TextXAlignment    = Enum.TextXAlignment.Center
    pctLbl.Text              = "0%"
    pctLbl.ZIndex            = 51

    local LOAD_TIME = 10
    local steps     = 80
    local interval  = LOAD_TIME / steps

    for step = 1, steps do
        if not (overlay and overlay.Parent) then break end
        local pct   = step / steps
        local eased = pct < 0.5
            and (2 * pct * pct)
            or (1 - (-2 * pct + 2)^2 / 2)
        TweenService:Create(barFill, TweenInfo.new(interval, Enum.EasingStyle.Linear), {
            Size = UDim2.new(eased, 0, 1, 0)
        }):Play()
        pctLbl.Text = math.floor(eased * 100) .. "%"
        task.wait(interval)
    end

    if overlay and overlay.Parent then
        pctLbl.Text = "100%"
        TweenService:Create(barFill, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            Size = UDim2.new(1, 0, 1, 0)
        }):Play()
        task.wait(0.35)
        local t = TweenService:Create(overlay, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
            BackgroundTransparency = 1
        })
        TweenService:Create(titleLbl2, TweenInfo.new(0.5), { TextTransparency    = 1 }):Play()
        TweenService:Create(subLbl,    TweenInfo.new(0.5), { TextTransparency    = 1 }):Play()
        TweenService:Create(pctLbl,    TweenInfo.new(0.5), { TextTransparency    = 1 }):Play()
        TweenService:Create(logoImg,   TweenInfo.new(0.5), { ImageTransparency   = 1 }):Play()
        TweenService:Create(barTrack,  TweenInfo.new(0.5), { BackgroundTransparency = 1 }):Play()
        TweenService:Create(barFill,   TweenInfo.new(0.5), { BackgroundTransparency = 1 }):Play()
        t:Play()
        t.Completed:Connect(function()
            if overlay and overlay.Parent then overlay:Destroy() end
        end)
    end
end)

local currentToggleKey = Enum.KeyCode.LeftAlt
local guiOpen = true
local isAnimatingGUI = false
local keybindButtonGUI

local function toggleGUI()
    if isAnimatingGUI then return end
    guiOpen = not guiOpen; isAnimatingGUI = true
    if guiOpen then
        main.Visible = true
        main.Size = UDim2.new(0, 0, 0, 0)
        main.BackgroundTransparency = 1
        wrapper.Size = UDim2.new(0, 0, 0, 0)
        local targetH = minimized and 40 or 360
        local t = TweenService:Create(main, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 540, 0, targetH), BackgroundTransparency = 0
        })
        TweenService:Create(wrapper, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 540, 0, targetH)
        }):Play()
        t:Play()
        t.Completed:Connect(function() isAnimatingGUI = false end)
    else
        local t = TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1
        })
        TweenService:Create(wrapper, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        t:Play()
        t.Completed:Connect(function() main.Visible = false; isAnimatingGUI = false end)
    end
end

local homePage = pages["HomeTab"]

local bubbleRow = Instance.new("Frame", homePage)
bubbleRow.Size = UDim2.new(1, 0, 0, 100); bubbleRow.BackgroundTransparency = 1; bubbleRow.LayoutOrder = 1

local bubbleIcon = Instance.new("ImageLabel", bubbleRow)
bubbleIcon.Size=UDim2.new(0,52,0,52); bubbleIcon.Position=UDim2.new(0,6,0.5,-26)
bubbleIcon.BackgroundColor3=Color3.fromRGB(30,30,30); bubbleIcon.BorderSizePixel=0
bubbleIcon.ScaleType=Enum.ScaleType.Fit; bubbleIcon.Image="rbxassetid://97128823316544"
Instance.new("UICorner", bubbleIcon).CornerRadius = UDim.new(1,0)
local iconStroke = Instance.new("UIStroke", bubbleIcon)
iconStroke.Color=THEME_TEXT; iconStroke.Thickness=1.5; iconStroke.Transparency=0.55

local iconName = Instance.new("TextLabel", bubbleRow)
iconName.Size=UDim2.new(0,64,0,16); iconName.Position=UDim2.new(0,0,0.5,28)
iconName.BackgroundTransparency=1; iconName.Font=Enum.Font.GothamBold; iconName.TextSize=10
iconName.TextColor3=THEME_TEXT; iconName.TextXAlignment=Enum.TextXAlignment.Center; iconName.Text="Vanilla"

local tailShape = Instance.new("Frame", bubbleRow)
tailShape.Size=UDim2.new(0,14,0,14); tailShape.Position=UDim2.new(0,64,0.5,-7)
tailShape.Rotation=45; tailShape.BackgroundColor3=Color3.fromRGB(25,25,25); tailShape.BorderSizePixel=0; tailShape.ZIndex=1

local bubbleBody = Instance.new("Frame", bubbleRow)
bubbleBody.Size=UDim2.new(1,-82,0,84); bubbleBody.Position=UDim2.new(0,72,0.5,-42)
bubbleBody.BackgroundColor3=Color3.fromRGB(25,25,25); bubbleBody.BorderSizePixel=0; bubbleBody.ZIndex=2
Instance.new("UICorner", bubbleBody).CornerRadius=UDim.new(0,14)
local bubbleStroke=Instance.new("UIStroke",bubbleBody)
bubbleStroke.Color=BORDER_COLOR; bubbleStroke.Thickness=1.2; bubbleStroke.Transparency=0.4
local bubbleGreeting=Instance.new("TextLabel",bubbleBody)
bubbleGreeting.Size=UDim2.new(1,-20,0,28); bubbleGreeting.Position=UDim2.new(0,14,0,10)
bubbleGreeting.BackgroundTransparency=1; bubbleGreeting.Font=Enum.Font.GothamBold; bubbleGreeting.TextSize=15
bubbleGreeting.TextColor3=THEME_TEXT; bubbleGreeting.TextXAlignment=Enum.TextXAlignment.Left
bubbleGreeting.TextTruncate=Enum.TextTruncate.AtEnd; bubbleGreeting.ClipsDescendants=false
bubbleGreeting.Text="Hey, "..player.DisplayName; bubbleGreeting.ZIndex=3
local bubbleMsg=Instance.new("TextLabel",bubbleBody)
bubbleMsg.Size=UDim2.new(1,-20,0,36); bubbleMsg.Position=UDim2.new(0,14,0,38)
bubbleMsg.BackgroundTransparency=1; bubbleMsg.Font=Enum.Font.Gotham; bubbleMsg.TextSize=13
bubbleMsg.TextColor3=Color3.fromRGB(160,160,160); bubbleMsg.TextXAlignment=Enum.TextXAlignment.Left
bubbleMsg.TextYAlignment=Enum.TextYAlignment.Top; bubbleMsg.TextWrapped=true
bubbleMsg.Text="Welcome back, "..player.DisplayName.."!\nSo glad you're here. Let's get to it."; bubbleMsg.ZIndex=3

local statsContainer = Instance.new("Frame", homePage)
statsContainer.Size = UDim2.new(1, 0, 0, 80)
statsContainer.BackgroundTransparency = 1
statsContainer.LayoutOrder = 2
local gridLayout = Instance.new("UIGridLayout", statsContainer)
gridLayout.CellSize = UDim2.new(0, 148, 0, 36)
gridLayout.CellPadding = UDim2.new(0, 8, 0, 8)
gridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
gridLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function createStatusBox(text, color)
    local box = Instance.new("Frame", statsContainer)
    box.BackgroundColor3 = Color3.fromRGB(20, 20, 20); box.BorderSizePixel = 0
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 7)
    local stroke = Instance.new("UIStroke", box)
    stroke.Color = SEP_COLOR; stroke.Thickness = 1; stroke.Transparency = 0.4
    local lbl = Instance.new("TextLabel", box)
    lbl.Size = UDim2.new(1, -10, 1, -4); lbl.Position = UDim2.new(0, 5, 0, 2)
    lbl.BackgroundTransparency = 1; lbl.Font = Enum.Font.Gotham; lbl.TextSize = 12
    lbl.TextColor3 = color or THEME_TEXT; lbl.Text = text; lbl.TextWrapped = true
    lbl.TextXAlignment = Enum.TextXAlignment.Center; lbl.TextTruncate = Enum.TextTruncate.AtEnd
    return lbl
end

local pingLabel  = createStatusBox("Ping: ...", PB_TEXT)
local lagLabel   = createStatusBox("Lag: ...", Color3.fromRGB(180, 180, 180))
createStatusBox("Acc Age: " .. player.AccountAge .. "d")
local execLabel  = createStatusBox("Exec: detecting...", Color3.fromRGB(200, 200, 200))

local pingConn = RunService.Heartbeat:Connect(function()
    local ok, ping = pcall(function() return math.round(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
    pingLabel.Text = ok and ("Ping: " .. ping .. " ms") or "Ping: N/A"
end)
table.insert(cleanupTasks, function() if pingConn then pingConn:Disconnect(); pingConn = nil end end)

task.delay(1, function()
    local execName = detectExecutor()
    if execLabel and execLabel.Parent then execLabel.Text = "Exec: " .. execName end
end)

local lagThread
lagThread = task.spawn(function()
    while gui and gui.Parent do
        local ok, ping = pcall(function() return math.round(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
        if lagLabel and lagLabel.Parent then
            if ok then
                if ping > 250 then
                    lagLabel.Text = "Bad Ping"; lagLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
                elseif ping > 120 then
                    lagLabel.Text = "High Ping"; lagLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
                else
                    lagLabel.Text = "Good Ping"; lagLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
                end
            else
                lagLabel.Text = "Lag: N/A"
            end
        end
        task.wait(5)
    end
end)
table.insert(cleanupTasks, function()
    if lagThread then pcall(task.cancel, lagThread); lagThread = nil end
end)

local serverInfoHeader = Instance.new("Frame", homePage)
serverInfoHeader.Size = UDim2.new(1, 0, 0, 22)
serverInfoHeader.BackgroundTransparency = 1
serverInfoHeader.LayoutOrder = 3
local serverInfoHeaderLbl = Instance.new("TextLabel", serverInfoHeader)
serverInfoHeaderLbl.Size = UDim2.new(1, -4, 1, 0)
serverInfoHeaderLbl.Position = UDim2.new(0, 4, 0, 0)
serverInfoHeaderLbl.BackgroundTransparency = 1
serverInfoHeaderLbl.Font = Enum.Font.GothamBold
serverInfoHeaderLbl.TextSize = 10
serverInfoHeaderLbl.TextColor3 = SECTION_TEXT
serverInfoHeaderLbl.TextXAlignment = Enum.TextXAlignment.Left
serverInfoHeaderLbl.Text = "  SERVER INFO"

local serverInfoGrid = Instance.new("Frame", homePage)
serverInfoGrid.Size = UDim2.new(1, 0, 0, 80)
serverInfoGrid.BackgroundTransparency = 1
serverInfoGrid.LayoutOrder = 4

local siGridLayout = Instance.new("UIGridLayout", serverInfoGrid)
siGridLayout.CellSize = UDim2.new(0, 148, 0, 36)
siGridLayout.CellPadding = UDim2.new(0, 8, 0, 8)
siGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
siGridLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function createServerInfoBox(text, color)
    local box = Instance.new("Frame", serverInfoGrid)
    box.BackgroundColor3 = Color3.fromRGB(20, 20, 20); box.BorderSizePixel = 0
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 7)
    local stroke = Instance.new("UIStroke", box)
    stroke.Color = SEP_COLOR; stroke.Thickness = 1; stroke.Transparency = 0.4
    local lbl = Instance.new("TextLabel", box)
    lbl.Size = UDim2.new(1, -10, 1, -4); lbl.Position = UDim2.new(0, 5, 0, 2)
    lbl.BackgroundTransparency = 1; lbl.Font = Enum.Font.Gotham; lbl.TextSize = 12
    lbl.TextColor3 = color or THEME_TEXT; lbl.Text = text; lbl.TextWrapped = true
    lbl.TextXAlignment = Enum.TextXAlignment.Center; lbl.TextTruncate = Enum.TextTruncate.AtEnd
    return lbl
end

local siUptimeLabel  = createServerInfoBox("Uptime: 00:00:00", Color3.fromRGB(210, 210, 210))
local siPlayersLabel = createServerInfoBox("Players: ...", Color3.fromRGB(200, 200, 200))

local rejoinBtn = Instance.new("TextButton", serverInfoGrid)
rejoinBtn.BackgroundColor3 = BTN_COLOR; rejoinBtn.BorderSizePixel = 0
rejoinBtn.Font = Enum.Font.GothamSemibold; rejoinBtn.TextSize = 12
rejoinBtn.TextColor3 = THEME_TEXT; rejoinBtn.Text = "Rejoin"
Instance.new("UICorner", rejoinBtn).CornerRadius = UDim.new(0, 7)
local rjStroke = Instance.new("UIStroke", rejoinBtn)
rjStroke.Color = SEP_COLOR; rjStroke.Thickness = 1; rjStroke.Transparency = 0.4
rejoinBtn.MouseEnter:Connect(function() TweenService:Create(rejoinBtn, TweenInfo.new(0.18), {BackgroundColor3 = BTN_HOVER}):Play() end)
rejoinBtn.MouseLeave:Connect(function() TweenService:Create(rejoinBtn, TweenInfo.new(0.18), {BackgroundColor3 = BTN_COLOR}):Play() end)
rejoinBtn.MouseButton1Click:Connect(function()
    pcall(function() TeleportService:Teleport(game.PlaceId, player) end)
end)

local serverHopBtn = Instance.new("TextButton", serverInfoGrid)
serverHopBtn.BackgroundColor3 = BTN_COLOR; serverHopBtn.BorderSizePixel = 0
serverHopBtn.Font = Enum.Font.GothamSemibold; serverHopBtn.TextSize = 12
serverHopBtn.TextColor3 = THEME_TEXT; serverHopBtn.Text = "Server Hop"
Instance.new("UICorner", serverHopBtn).CornerRadius = UDim.new(0, 7)
local shStroke = Instance.new("UIStroke", serverHopBtn)
shStroke.Color = SEP_COLOR; shStroke.Thickness = 1; shStroke.Transparency = 0.4
serverHopBtn.MouseEnter:Connect(function() TweenService:Create(serverHopBtn, TweenInfo.new(0.18), {BackgroundColor3 = BTN_HOVER}):Play() end)
serverHopBtn.MouseLeave:Connect(function() TweenService:Create(serverHopBtn, TweenInfo.new(0.18), {BackgroundColor3 = BTN_COLOR}):Play() end)
serverHopBtn.MouseButton1Click:Connect(function()
    serverHopBtn.Text = "Searching..."
    task.spawn(function()
        local success = false
        pcall(function()
            local HttpService = game:GetService("HttpService")
            local currentJobId = game.JobId
            local placeId = game.PlaceId
            local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
            local response = HttpService:JSONDecode(game:HttpGet(url))
            if response and response.data then
                for _, server in ipairs(response.data) do
                    if server.id ~= currentJobId and server.playing < server.maxPlayers then
                        TeleportService:TeleportToPlaceInstance(placeId, server.id, player)
                        success = true
                        break
                    end
                end
            end
        end)
        if not success then
            if serverHopBtn and serverHopBtn.Parent then
                serverHopBtn.Text = "No Server Found"
                task.delay(2.5, function()
                    if serverHopBtn and serverHopBtn.Parent then serverHopBtn.Text = "Server Hop" end
                end)
            end
        end
    end)
end)

local function formatServerUptime(seconds)
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = math.floor(seconds % 60)
    return string.format("%02d:%02d:%02d", h, m, s)
end

local uptimeConn
uptimeConn = RunService.Heartbeat:Connect(function()
    if not (siUptimeLabel and siUptimeLabel.Parent) then return end
    local uptime = workspace.DistributedGameTime
    siUptimeLabel.Text = "Uptime: " .. formatServerUptime(uptime)
    if siPlayersLabel and siPlayersLabel.Parent then
        siPlayersLabel.Text = "Players: " .. #Players:GetPlayers() .. " / " .. Players.MaxPlayers
    end
end)
table.insert(cleanupTasks, function()
    if uptimeConn then uptimeConn:Disconnect(); uptimeConn = nil end
end)

local discordFrame = Instance.new("Frame", homePage)
discordFrame.Size = UDim2.new(1, 0, 0, 44)
discordFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
discordFrame.BorderSizePixel = 0
discordFrame.LayoutOrder = 5
Instance.new("UICorner", discordFrame).CornerRadius = UDim.new(0, 8)
local discordStroke = Instance.new("UIStroke", discordFrame)
discordStroke.Color = SEP_COLOR; discordStroke.Thickness = 1; discordStroke.Transparency = 0.4

local discordLabel = Instance.new("TextLabel", discordFrame)
discordLabel.Size = UDim2.new(1, -130, 1, 0); discordLabel.Position = UDim2.new(0, 12, 0, 0)
discordLabel.BackgroundTransparency = 1; discordLabel.Font = Enum.Font.GothamSemibold; discordLabel.TextSize = 13
discordLabel.TextColor3 = Color3.fromRGB(160, 160, 160); discordLabel.TextXAlignment = Enum.TextXAlignment.Left
discordLabel.Text = "discord.gg/bpfjSze8VB"

local copyBtn = Instance.new("TextButton", discordFrame)
copyBtn.Size = UDim2.new(0, 110, 0, 28); copyBtn.Position = UDim2.new(1, -118, 0.5, -14)
copyBtn.BackgroundColor3 = BTN_COLOR; copyBtn.Font = Enum.Font.GothamSemibold; copyBtn.TextSize = 12
copyBtn.TextColor3 = THEME_TEXT; copyBtn.Text = "Copy Invite"; copyBtn.BorderSizePixel = 0
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 7)
local copyStroke = Instance.new("UIStroke", copyBtn)
copyStroke.Color = Color3.fromRGB(55, 55, 55); copyStroke.Thickness = 1; copyStroke.Transparency = 0
copyBtn.MouseEnter:Connect(function() TweenService:Create(copyBtn, TweenInfo.new(0.15), {BackgroundColor3 = BTN_HOVER}):Play() end)
copyBtn.MouseLeave:Connect(function() TweenService:Create(copyBtn, TweenInfo.new(0.15), {BackgroundColor3 = BTN_COLOR}):Play() end)
copyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://discord.gg/bpfjSze8VB")
        copyBtn.Text = "Copied"
        task.delay(2, function()
            if copyBtn and copyBtn.Parent then copyBtn.Text = "Copy Invite" end
        end)
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == currentToggleKey then toggleGUI() end
end)

_G.VH = {
    TweenService      = TweenService,
    Players           = Players,
    UserInputService  = UserInputService,
    RunService        = RunService,
    TeleportService   = TeleportService,
    Stats             = Stats,
    player            = player,
    cleanupTasks      = cleanupTasks,
    pages             = pages,
    tabs              = tabs,
    BTN_COLOR         = BTN_COLOR,
    BTN_HOVER         = BTN_HOVER,
    THEME_TEXT        = THEME_TEXT,
    ACCENT            = ACCENT,
    SEP_COLOR         = SEP_COLOR,
    SECTION_TEXT      = SECTION_TEXT,
    SW_ON             = SW_ON,
    SW_OFF            = SW_OFF,
    SW_KNOB_ON        = SW_KNOB_ON,
    SW_KNOB_OFF       = SW_KNOB_OFF,
    PB_BAR            = PB_BAR,
    PB_TEXT           = PB_TEXT,
    switchTab         = switchTab,
    toggleGUI         = toggleGUI,
    vanilla = { running = false, thread = nil },
    isMobile          = isMobile,
    isFlyActive       = false,
    flyEnabled        = true,
    currentFlyKey     = Enum.KeyCode.Q,
    waitingForFlyKey  = false,
    flyKeyBtn         = nil,
    currentToggleKey  = currentToggleKey,
    keybindButtonGUI  = nil,
}

_G.VanillaHubCleanup = onExit

print("[VanillaHub] Vanilla1 loaded — execute Vanilla2-Vanilla15 for remaining tabs")
