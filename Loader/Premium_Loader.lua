local scripts = {
    [126884695634066] = "7a953911595e67e8494c3d3446b8be5b", 
    [126509999114328] = "c67687e7d7ae30e2e9fd5658f34e8292",
    [137925884276740] = "2729679a8bec2bdc0cf738bc9be2610c",
}
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "NoLagUI"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local api = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()
local colors = {
    background = Color3.fromRGB(20, 20, 25),
    header = Color3.fromRGB(15, 15, 20),
    primary = Color3.fromRGB(40, 40, 50),
    accent = Color3.fromRGB(255, 255, 255),
    text = Color3.fromRGB(240, 240, 240),
    error = Color3.fromRGB(255, 85, 85),
    success = Color3.fromRGB(85, 255, 85),
    discord = Color3.fromRGB(88, 101, 242)
}
local function showNotification(text, color)
    color = color or colors.text
    local screenGui = gui:FindFirstChild("NotificationGui") or Instance.new("ScreenGui")
    screenGui.Name = "NotificationGui"
    screenGui.Parent = gui
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.BackgroundColor3 = colors.background
    notification.BackgroundTransparency = 0.2
    notification.BorderSizePixel = 0
    notification.Size = UDim2.new(0.25, 0, 0.06, 0)
    notification.Position = UDim2.new(0.85, 0, 0.85, 0)
    notification.AnchorPoint = Vector2.new(0.5, 0.5)
    notification.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = notification

    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.Image = "rbxassetid://5028857084"
    glow.ImageColor3 = color
    glow.ImageTransparency = 0.8
    glow.ScaleType = Enum.ScaleType.Slice
    glow.SliceCenter = Rect.new(24, 24, 24, 24)
    glow.Size = UDim2.new(1, 20, 1, 20)
    glow.Position = UDim2.new(0, -10, 0, -10)
    glow.BackgroundTransparency = 1
    glow.Parent = notification
    glow.ZIndex = -1

    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "Text"
    textLabel.Text = text
    textLabel.TextColor3 = color
    textLabel.TextSize = 14
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(0.9, 0, 0.8, 0)
    textLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
    textLabel.Font = Enum.Font.GothamMedium
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = notification

    notification.BackgroundTransparency = 1
    textLabel.TextTransparency = 1

    local appearTween = TweenService:Create(
        notification,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0.2}
    )

    local textAppearTween = TweenService:Create(
        textLabel,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {TextTransparency = 0}
    )

    appearTween:Play()
    textAppearTween:Play()

    wait(3)

    local disappearTween = TweenService:Create(
        notification,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 1}
    )

    local textDisappearTween = TweenService:Create(
        textLabel,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {TextTransparency = 1}
    )

    disappearTween:Play()
    textDisappearTween:Play()

    disappearTween.Completed:Connect(function()
        notification:Destroy()
        if #screenGui:GetChildren() == 0 then
            screenGui:Destroy()
        end
    end)
end

if script_key and script_key ~= "" and script_key ~= "your_key" then
    local url = scripts[game.PlaceId]
    if url then
       api.script_id = url
       local status = api.check_key(script_key)

    if (status.code == "KEY_VALID") then
        showNotification("Premium Key is valid")
        api.load_script()
        return
    elseif (status.code == "KEY_HWID_LOCKED") then
        showNotification("Key linked to a different HWID. Please reset it using our bot")
    elseif (status.code == "KEY_INCORRECT") then
        showNotification("Key is wrong, please input valid key or get new key!")
    else
        showNotification("Key check failed:" .. status.message .. " Code: " .. status.code)
        end
    end
end
