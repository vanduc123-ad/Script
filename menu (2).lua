-- VanDucModz Menu v6 Tiếng Việt (Black + Silver UI, 6 Tabs)
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
TabFrame.Size = UDim2.new(0,140,1,-40)
TabFrame.Position = UDim2.new(0,0,0,40)
TabFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
TabFrame.Parent = MainFrame
addCorner(TabFrame, 12)
addStroke(TabFrame, Color3.fromRGB(100,100,100))

-- Content
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1,-140,1,-40)
ContentFrame.Position = UDim2.new(0,140,0,40)
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
for i=1,6 do
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
    btn.Size = UDim2.new(0.9,0,0,40)
    btn.Position = UDim2.new(0.05,0,0,yPos)
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

-- Tạo 6 tab tiếng Việt
createTabButton("👤 Người chơi",1,0)
createTabButton("⚡ FPS / Ping",2,45)
createTabButton("🌍 Server",3,90)
createTabButton("💪 Nhân vật",4,135)
createTabButton("⚙️ Cài đặt",5,180)
createTabButton("🗺️ Bản đồ",6,225)

-- Toggle animation
local menuVisible = false
ToggleButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    if menuVisible then
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0,520,0,350),
            BackgroundTransparency = 0
        }):Play()
    else
        for _,tab in ipairs(TabContents) do
            tab.Label.Visible = false
        end
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0,0,0,0),
            BackgroundTransparency = 1
        }):Play()
        task.delay(0.35, function()
            MainFrame.Visible = false
            for _,tab in ipairs(TabContents) do
                tab.Label.Visible = true
            end
        end)
    end
end)

-- FPS
local fps = 0
game:GetService("RunService").RenderStepped:Connect(function(dt)
    fps = math.floor(1/dt)
end)

-- Update nội dung
task.spawn(function()
    while true do
        task.wait(1)

        local player = game.Players.LocalPlayer
        if not player then continue end

        -- Tab 1: Người chơi + đảo
        local playerList = ""
        for _, p in ipairs(game.Players:GetPlayers()) do
            playerList = playerList .. "👤 " .. p.Name .. " (ID:"..p.UserId..")\n"
        end
        local islandName = "Không xác định"
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            for _, obj in ipairs(workspace:GetChildren()) do
                if (obj:IsA("Model") or obj:IsA("Folder")) and obj:FindFirstChildWhichIsA("BasePart") then
                    local part = obj:FindFirstChildWhichIsA("BasePart")
                    if part and (hrp.Position - part.Position).Magnitude < 600 then
                        islandName = obj.Name
                        break
                    end
                end
            end
        end
        TabContents[1].Label.Text = "📌 Danh sách người chơi:\n"..playerList.."\n🏝️ Đang ở đảo: "..islandName

        -- Tab 2: FPS / Ping
        local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        TabContents[2].Label.Text = "⚡ Hiệu suất:\nFPS: "..fps.."\nPing: "..ping

        -- Tab 3: Server Info
        local placeName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
        TabContents[3].Label.Text = "🌍 Thông tin Server:\nTên game: "..placeName..
            "\nID Game: "..game.PlaceId..
            "\nSố người chơi: "..#game.Players:GetPlayers()

        -- Tab 4: Player Stats
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local hp = player.Character.Humanoid.Health
            local maxhp = player.Character.Humanoid.MaxHealth
            local walkspeed = player.Character.Humanoid.WalkSpeed
            local jumppower = player.Character.Humanoid.JumpPower
            TabContents[4].Label.Text = "💪 Chỉ số nhân vật:\nMáu: "..math.floor(hp).."/"..math.floor(maxhp)..
                "\nTốc độ đi bộ: "..walkspeed..
                "\nSức bật: "..jumppower
        end

        -- Tab 5: Settings
        TabContents[5].Label.Text = "⚙️ Cài đặt:\nBạn có thể thêm chức năng chỉnh màu, reset UI tại đây."

        -- Tab 6: Map Info
        local mapName = workspace:FindFirstChild("Map") and workspace.Map.Name or "Không xác định"
        TabContents[6].Label.Text = "🗺️ Thông tin Bản đồ:\nTên Map: "..mapName..
            "\nVị trí Spawn: "..tostring(workspace:FindFirstChild("SpawnLocation"))
    end
end)
