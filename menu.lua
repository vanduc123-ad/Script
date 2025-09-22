-- VanDucModz Menu v2 (Executor/KRNL version)
-- Không can thiệp gameplay, chỉ hiển thị thông tin server

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanDucModz"
ScreenGui.Parent = game.CoreGui

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0,120,0,40)
ToggleButton.Position = UDim2.new(0,20,0,200)
ToggleButton.Text = "Bật/Tắt Menu"
ToggleButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
ToggleButton.Parent = ScreenGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0,450,0,300)
MainFrame.Position = UDim2.new(0.3,0,0.3,0)
MainFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "⚡ VanDucModz ⚡"
Title.BackgroundColor3 = Color3.fromRGB(70,70,70)
Title.TextColor3 = Color3.fromRGB(0,255,0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 24
Title.Parent = MainFrame

local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(0,120,1,-40)
TabFrame.Position = UDim2.new(0,0,0,40)
TabFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
TabFrame.Parent = MainFrame

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1,-120,1,-40)
ContentFrame.Position = UDim2.new(0,120,0,40)
ContentFrame.BackgroundColor3 = Color3.fromRGB(60,60,60)
ContentFrame.Parent = MainFrame

local function createLabel(parent)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,-10,1,-10)
    lbl.Position = UDim2.new(0,5,0,5)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
    lbl.Font = Enum.Font.SourceSans
    lbl.TextSize = 18
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextYAlignment = Enum.TextYAlignment.Top
    lbl.Text = ""
    lbl.Parent = parent
    return lbl
end

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
    btn.BackgroundColor3 = Color3.fromRGB(80,80,80)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Parent = TabFrame

    btn.MouseButton1Click:Connect(function()
        for i,tab in ipairs(TabContents) do
            tab.Frame.Visible = (i == index)
        end
    end)
end

createTabButton("Người chơi",1,0)
createTabButton("FPS / Ping",2,40)
createTabButton("Server Info",3,80)

local menuVisible = false
ToggleButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    MainFrame.Visible = menuVisible
end)

local fps = 0
game:GetService("RunService").RenderStepped:Connect(function(dt)
    fps = math.floor(1/dt)
end)

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
