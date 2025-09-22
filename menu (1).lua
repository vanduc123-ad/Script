-- VanDucModz Menu v5 (Black + Silver UI)
-- Không can thiệp gameplay, chỉ hiển thị thông tin server

local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanDucModz"
ScreenGui.Parent = game.CoreGui

-- Function bo góc
local function addCorner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
end

-- Function viền
local function addStroke(obj, color)
    local s = Instance.new("UIStroke")
    s.Thickness = 2
    s.Color = color
    s.Parent = obj
end

-- Nút toggle
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0,120,0,40)
ToggleButton.Position = UDim2.new(0,20,0,200)
ToggleButton.Text = "Modz"
ToggleButton.BackgroundColor3 = Color3.fromRGB(20,20,20)
ToggleButton.TextColor3 = Color3.fromRGB(220,220,220)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 20
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Parent = ScreenGui
addCorner(ToggleButton, 12)
addStroke(ToggleButton, Color3.fromRGB(180,180,180))

-- Frame chính
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0,0,0,0)
MainFrame.Position = UDim2.new(0.3,0,0.3,0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
addCorner(MainFrame, 15)
addStroke(MainFrame, Color3.fromRGB(180,180,180))

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "⚡ VanDucModz ⚡"
Title.BackgroundColor3 = Color3.fromRGB(25,25,25)
Title.TextColor3 = Color3.fromRGB(220,220,220)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.Parent = MainFrame
addCorner(Title, 12)
addStroke(Title, Color3.fromRGB(150,150,150))

-- TabFrame
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(0,120,1,-40)
TabFrame.Position = UDim2.new(0,0,0,40)
TabFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
TabFrame.Parent = MainFrame
addCorner(TabFrame, 12)
addStroke(TabFrame, Color3.fromRGB(100,100,100))

-- Content
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1,-120,1,-40)
ContentFrame.Position = UDim2.new(0,120,0,40)
ContentFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
ContentFrame.Parent = MainFrame
addCorner(ContentFrame, 12)
addStroke(ContentFrame, Color3.fromRGB(100,100,100))

-- label
local function createLabel(parent)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,-10,1,-10)
    lbl.Position = UDim2.new(0,5,0,5)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(220,220,220)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 18
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextYAlignment = Enum.TextYAlignment.Top
    lbl.Text = ""
    lbl.Parent = parent
    return lbl
end

-- Tabs
local TabContents = {}
for i=1,3 do
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,1,0)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    frame.Parent = ContentFrame
    TabContents[i] = {Frame = frame, Label = createLabel(frame)}
end
TabContents[1].Frame.Visible = true

local function createTabButton(name, index, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,40)
    btn.Position = UDim2.new(0,0,0,yPos)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.fromRGB(220,220,220)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 16
    btn.Parent = TabFrame
    addCorner(btn, 8)
    addStroke(btn, Color3.fromRGB(90,90,90))

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60,60,60)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40,40,40)}):Play()
    end)

    btn.MouseButton1Click:Connect(function()
        for i,tab in ipairs(TabContents) do
            tab.Frame.Visible = (i == index)
        end
    end)
end

createTabButton("Người chơi",1,0)
createTabButton("FPS / Ping",2,40)
createTabButton("Server Info",3,80)

-- Toggle animation
local menuVisible = false
ToggleButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    if menuVisible then
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0,450,0,300),
            BackgroundTransparency = 0
        }):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0,0,0,0),
            BackgroundTransparency = 1
        }):Play()
        task.delay(0.35, function() MainFrame.Visible = false end)
    end
end)

-- FPS
local fps = 0
game:GetService("RunService").RenderStepped:Connect(function(dt)
    fps = math.floor(1/dt)
end)

-- update nội dung
task.spawn(function()
    while true do
        task.wait(1)

        local player = game.Players.LocalPlayer
        if not player then continue end

        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos = player.Character.HumanoidRootPart.Position
            local playerList = ""
            for _, p in ipairs(game.Players:GetPlayers()) do
                playerList = playerList .. "👤 " .. p.Name .. " (ID:"..p.UserId..")\n"
            end
            TabContents[1].Label.Text = "📌 Người chơi trong server:\n"..playerList..
                "\n📍 Vị trí của bạn:\nX:"..math.floor(pos.X).." Y:"..math.floor(pos.Y).." Z:"..math.floor(pos.Z)
        end

        local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        TabContents[2].Label.Text = "⚡ Hiệu suất:\nFPS: "..fps.."\nPing: "..ping

        local placeName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
        TabContents[3].Label.Text = "🌍 Server Info:\nPlace Name: "..placeName..
            "\nGame ID: "..game.PlaceId..
            "\nNgười chơi: "..#game.Players:GetPlayers()
    end
end)
