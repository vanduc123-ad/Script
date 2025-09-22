
-- Gui.lua - VanDucModz UI Full Version

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "VanDucModz"
gui.Parent = game.CoreGui

-- Draggable Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

-- UICorner
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 80, 0, 30)
toggleButton.Position = UDim2.new(0.5, -40, 0, -40)
toggleButton.Text = "Modz"
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Parent = gui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 12)
toggleCorner.Parent = toggleButton

-- Tab Buttons Frame
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(0, 100, 1, 0)
tabFrame.BackgroundTransparency = 0.2
tabFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
tabFrame.BorderSizePixel = 0
tabFrame.Parent = mainFrame

local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 12)
tabCorner.Parent = tabFrame

-- Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -100, 1, 0)
contentFrame.Position = UDim2.new(0, 100, 0, 0)
contentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 12)
contentCorner.Parent = contentFrame

-- Utility function: create tab button
local function createTabButton(name, icon, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, (order-1)*45)
    btn.Text = icon .. " " .. name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.BorderSizePixel = 0
    btn.Parent = tabFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    return btn
end

-- Utility function: create content page
local function createPage()
    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = contentFrame
    return page
end

-- Tabs
local gameTabBtn = createTabButton("Thông tin Game", "🎮", 1)
local hotTabBtn = createTabButton("Thông tin Hot", "📰", 2)
local islandTabBtn = createTabButton("Thông tin Đảo", "🏝️", 3)
local settingsTabBtn = createTabButton("Cài đặt", "⚙️", 4)
local textTabBtn = createTabButton("Thay Chữ", "✍️", 5)

-- Pages
local gamePage = createPage()
local hotPage = createPage()
local islandPage = createPage()
local settingsPage = createPage()
local textPage = createPage()

-- Game Page
local gameLabel = Instance.new("TextLabel")
gameLabel.Size = UDim2.new(1, -20, 0, 40)
gameLabel.Position = UDim2.new(0, 10, 0, 20)
gameLabel.Text = "Tên Game: " .. game.Name
gameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
gameLabel.BackgroundTransparency = 1
gameLabel.TextScaled = true
gameLabel.Parent = gamePage

-- Hot Page
local hotLabel = Instance.new("TextLabel")
hotLabel.Size = UDim2.new(1, -20, 0, 200)
hotLabel.Position = UDim2.new(0, 10, 0, 20)
hotLabel.Text = "Sự kiện Hot 📰: Chưa có dữ liệu..."
hotLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
hotLabel.BackgroundTransparency = 1
hotLabel.TextWrapped = true
hotLabel.TextScaled = true
hotLabel.Parent = hotPage

-- Island Page
local islandLabel = Instance.new("TextLabel")
islandLabel.Size = UDim2.new(1, -20, 0, 40)
islandLabel.Position = UDim2.new(0, 10, 0, 20)
islandLabel.Text = "Bạn đang ở: Đang xác định..."
islandLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
islandLabel.BackgroundTransparency = 1
islandLabel.TextScaled = true
islandLabel.Parent = islandPage

-- Settings Page (Change Colors)
local colors = {
    {name="Đen", bg=Color3.fromRGB(0,0,0), text=Color3.fromRGB(255,255,255)},
    {name="Trắng", bg=Color3.fromRGB(255,255,255), text=Color3.fromRGB(0,0,0)},
    {name="Hồng", bg=Color3.fromRGB(255,182,193), text=Color3.fromRGB(0,0,0)},
    {name="Đỏ", bg=Color3.fromRGB(255,0,0), text=Color3.fromRGB(255,255,255)},
    {name="Xanh lá", bg=Color3.fromRGB(0,255,0), text=Color3.fromRGB(0,0,0)}
}

for i, color in ipairs(colors) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 30)
    btn.Position = UDim2.new(0, 20, 0, (i-1)*40 + 20)
    btn.Text = "Màu " .. color.name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.Parent = settingsPage

    btn.MouseButton1Click:Connect(function()
        mainFrame.BackgroundColor3 = color.bg
        contentFrame.BackgroundColor3 = color.bg
        gameLabel.TextColor3 = color.text
        hotLabel.TextColor3 = color.text
        islandLabel.TextColor3 = color.text
    end)
end

-- Text Page (Change Font)
local input = Instance.new("TextBox")
input.Size = UDim2.new(0, 200, 0, 40)
input.Position = UDim2.new(0, 20, 0, 20)
input.PlaceholderText = "Nhập chữ ở đây..."
input.TextColor3 = Color3.fromRGB(255,255,255)
input.BackgroundColor3 = Color3.fromRGB(40,40,40)
input.Parent = textPage

local preview = Instance.new("TextLabel")
preview.Size = UDim2.new(0, 300, 0, 60)
preview.Position = UDim2.new(0, 20, 0, 80)
preview.Text = "Xem trước..."
preview.TextColor3 = Color3.fromRGB(255,255,255)
preview.BackgroundTransparency = 1
preview.TextScaled = true
preview.Parent = textPage

local fonts = {"Legacy", "SourceSans", "Arial", "Fantasy", "Antique", "Gotham"}
for i, f in ipairs(fonts) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 30)
    btn.Position = UDim2.new(0, 20, 0, (i-1)*40 + 160)
    btn.Text = "Font: " .. f
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.Parent = textPage

    btn.MouseButton1Click:Connect(function()
        preview.Font = Enum.Font[f]
        preview.Text = input.Text ~= "" and input.Text or "Xem trước..."
    end)
end

input:GetPropertyChangedSignal("Text"):Connect(function()
    preview.Text = input.Text ~= "" and input.Text or "Xem trước..."
end)

-- Show Pages Function
local function showPage(page)
    for _, p in pairs(contentFrame:GetChildren()) do
        if p:IsA("Frame") then
            p.Visible = false
        end
    end
    page.Visible = true
end

-- Tab Button Events
gameTabBtn.MouseButton1Click:Connect(function() showPage(gamePage) end)
hotTabBtn.MouseButton1Click:Connect(function() showPage(hotPage) end)
islandTabBtn.MouseButton1Click:Connect(function() showPage(islandPage) end)
settingsTabBtn.MouseButton1Click:Connect(function() showPage(settingsPage) end)
textTabBtn.MouseButton1Click:Connect(function() showPage(textPage) end)

-- Default page
showPage(gamePage)

-- Toggle Menu
local menuVisible = true
toggleButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    if menuVisible then
        TweenService:Create(mainFrame, TweenInfo.new(0.5), {Size = UDim2.new(0, 400, 0, 300)}):Play()
        mainFrame.Visible = true
    else
        TweenService:Create(mainFrame, TweenInfo.new(0.5), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        wait(0.5)
        mainFrame.Visible = false
    end
end)
